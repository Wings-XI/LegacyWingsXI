/**
 *	@file LoginServer.cpp
 *	TCP server routines
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#include "LoginServer.h"
#include "AuthHandler.h"
#include "../new-common/Debugging.h"
#include "LoginGlobalConfig.h"
#include "ProtocolFactory.h"
#include "SessionTracker.h"
#include "WorldManager.h"
#include "../new-common/TCPConnection.h"
#include "../new-common/SSLConnection.h"

#include <string.h>
#include <stdexcept>
#include <thread>
#include <chrono>

#include <sys/types.h>
#ifdef _WIN32
#include <WinSock2.h>
#include <WS2tcpip.h>
#else
#include <sys/time.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#endif

// Number of allowed pending connections
#define LISTEN_ALLOWED_BACKLOG 10

LoginServer::LoginServer()
{
	LOG_DEBUG0("Called.");
#ifdef _WIN32
	WSADATA WsaData = { 0 };
	if (WSAStartup(MAKEWORD(2, 2), &WsaData) != 0) {
		LOG_CRITICAL("WSAStartup failed.");
		throw std::runtime_error("WSAStartup failed.");
	}
#endif
}

LoginServer::~LoginServer()
{
	LOG_DEBUG0("Called.");
#ifdef _WIN32
	WSACleanup();
#endif
}

void LoginServer::AddBind(ProtocolFactory::LOGIN_PROTOCOLS eProtocol, uint16_t wPortNum, const char* szIpAddress, bool bSecure)
{
	struct BoundSocket NewBind = { 0 };

	LOG_DEBUG0("Called.");
	if (wPortNum == 0) {
		LOG_ERROR("Called with port set to zero.");
		throw std::invalid_argument("Port number cannot be zero.");
	}
	NewBind.BindDetails.sin_family = AF_INET;
	if (szIpAddress) {
		NewBind.BindDetails.sin_addr.s_addr = inet_addr(szIpAddress);
	}
	NewBind.BindDetails.sin_port = htons(wPortNum);
	NewBind.bSecure = bSecure;
    NewBind.iAssociatedProtocol = static_cast<int>(eProtocol);

	NewBind.iSock = socket(AF_INET, SOCK_STREAM, 0);
	if (NewBind.iSock == -1) {
		LOG_ERROR("socket function failed.");
		throw std::runtime_error("socket function failed.");
	}
	if (bind(NewBind.iSock, (sockaddr*)&NewBind.BindDetails, sizeof(NewBind.BindDetails)) != 0) {
		LOG_ERROR("bind function failed.");
		throw std::runtime_error("bind function failed.");
	}
	if (listen(NewBind.iSock, LISTEN_ALLOWED_BACKLOG) != 0) {
		LOG_ERROR("listen function failed.");
		throw std::runtime_error("listen function failed.");
	}
	LOG_INFO("Attached to %s:%d", inet_ntoa(NewBind.BindDetails.sin_addr), wPortNum);
	mvecListeningSockets.push_back(NewBind);
}

void LoginServer::Run()
{
	// Socket descriptors used for select call
	fd_set SocketDescriptors;
	// Max socket descriptor used for select call
	int nfds = 0;
	// Iterator
	size_t i = 0;
    size_t j = 0;
	// Number of listening sockets
	size_t iNumListeningSocks = 0;
    // Number of working handlers
    size_t dwNumWorkingHandlers = 0;
	// Current socket being iterated
	SOCKET sockCurrentSocket = 0;
	// Timeout for select calls
	struct timeval tv, tv_orig = { 0, 1000 };
	// Size of saddrNewConnection
	socklen_t cbsaddrNewConnection = 0;
	// New bound socket for incoming connections
	BoundSocket NewConnection = { 0 };
    // Counter of existing connections of connecting IP
    uint32_t dwNumConcurrent = 0;
    // Max number of concurrent connections a single client can have
    uint32_t dwMaxConcurrent = LoginGlobalConfig::GetInstance()->GetConfigUInt("max_client_connections");
    // Session tracker
    SessionTrackerPtr Sessions = SessionTracker::GetInstance();
    // Whether to reject the latest connection
    bool bReject = false;
    // Value for setsockopt
    int lOptVal = 1;
    // Timeout for recv (socket option) - Linux
    struct timeval tvRecvTimeout = { 300, 0 };
    // Timeout for recv (socket option) - Windows
    uint32_t dwRecvTimeout = (tvRecvTimeout.tv_sec * 1000) + (tvRecvTimeout.tv_usec / 1000);
    // SSL files
    std::string SSLCertificate = LoginGlobalConfig::GetInstance()->GetConfigString("ssl_certificate_file");
    std::string SSLKey = LoginGlobalConfig::GetInstance()->GetConfigString("ssl_private_key_file");
    int iSecurityLevel = LoginGlobalConfig::GetInstance()->GetConfigInt("ssl_security_level");
#ifdef _WIN32
    char* pTimeout = reinterpret_cast<char*>(&dwRecvTimeout);
    uint32_t cbTimeout = sizeof(dwRecvTimeout);
#else
    void* pTimeout = &tvRecvTimeout;
    uint32_t cbTimeout = sizeof(tvRecvTimeout);
#endif

	LOG_DEBUG0("Called.");
    mbRunning = true;
    if (mvecListeningSockets.empty()) {
		LOG_CRITICAL("Called without any listening socket.");
		throw std::logic_error("Cannot run server without listening sockets.");
	}
    WorldManagerPtr WorldMgr = WorldManager::GetInstance();
    WorldMgr->LoadWorlds();
	LOG_INFO("Server running.");
	while (mbShutdown == false) {
		// Check if a new connnection has arrived
		iNumListeningSocks = mvecListeningSockets.size();
		nfds = 0;
		FD_ZERO(&SocketDescriptors);
		for (i = 0; i < iNumListeningSocks; i++) {
			sockCurrentSocket = mvecListeningSockets[i].iSock;
			FD_SET(sockCurrentSocket, &SocketDescriptors);
			if (sockCurrentSocket > nfds) {
				nfds = static_cast<int>(sockCurrentSocket);
			}
		}

		tv.tv_sec = tv_orig.tv_sec;
		tv.tv_usec = tv_orig.tv_usec;
		if (select(nfds+1, &SocketDescriptors, NULL, NULL, &tv) < 0) {
			LOG_CRITICAL("select function failed.");
			throw std::runtime_error("select function failed.");
		}
		for (i = 0; i < iNumListeningSocks; i++) {
			sockCurrentSocket = mvecListeningSockets[i].iSock;
			if (FD_ISSET(sockCurrentSocket, &SocketDescriptors)) {
				// New connection has arrived
				memset(&NewConnection, 0, sizeof(NewConnection));
				cbsaddrNewConnection = static_cast<int>(sizeof(NewConnection.BindDetails));
				NewConnection.iSock = accept(sockCurrentSocket, reinterpret_cast<struct sockaddr*>(&NewConnection.BindDetails), &cbsaddrNewConnection);
				if (NewConnection.iSock < 0) {
					// Call failed but it's not determinal to the overall server
					LOG_ERROR("Attempted to accept new connection but accept function failed.");
					continue;
				}
				LOG_INFO("Accepted connection from %s", inet_ntoa(NewConnection.BindDetails.sin_addr));
                lOptVal = 1;
                if (setsockopt(NewConnection.iSock, SOL_SOCKET, SO_KEEPALIVE, reinterpret_cast<char*>(&lOptVal), sizeof(lOptVal)) != 0) {
                    LOG_WARNING("Unable to enable keepalives for new connection.");
                }
                if (setsockopt(NewConnection.iSock, SOL_SOCKET, SO_RCVTIMEO, pTimeout, cbTimeout) != 0) {
                    LOG_WARNING("Unable to set read timeout for new connection.");
                }
                std::shared_ptr<TCPConnection> NewTCPConnection = nullptr;
                try {
                    NewConnection.bSecure = mvecListeningSockets[i].bSecure;
                    NewConnection.iAssociatedProtocol = static_cast<int>(ProtocolFactory::PROTOCOL_STUB);
                    if (NewConnection.bSecure) {
                        NewTCPConnection = std::shared_ptr<TCPConnection>(new SSLConnection(NewConnection, SSLCertificate.c_str(), SSLKey.c_str(), iSecurityLevel));
                    }
                    else {
                        NewTCPConnection = std::shared_ptr<TCPConnection>(new TCPConnection(NewConnection));
                    }
                    // Simple DoS protection - do not allow clients to open too many concurrent connections
                    dwNumConcurrent = 0;
                    dwNumWorkingHandlers = mvecWorkingHandlers.size();
                    bReject = false;
                    for (j = 0; j < dwNumWorkingHandlers; j++) {
                        if (mvecWorkingHandlers[j]->GetClientDetails().BindDetails.sin_addr.s_addr == NewConnection.BindDetails.sin_addr.s_addr) {
                            dwNumConcurrent++;
                            if (dwNumConcurrent >= dwMaxConcurrent) {
                                LOG_WARNING("Too many concurrent connections from this client, dropping connection.");
                                bReject = true;
                            }
                        }
                    }
                }
                catch (std::runtime_error) {
                    bReject = true;
                    if (!NewTCPConnection) {
                        closesocket(NewConnection.iSock);
                    }
                }
                if (bReject == false) {
                    // Launch login handler for this connection
                    ProtocolHandler* pNewHandler = ProtocolFactory::BuildHandler(
                        static_cast<ProtocolFactory::LOGIN_PROTOCOLS>(mvecListeningSockets[i].iAssociatedProtocol),
                        NewTCPConnection);
                    pNewHandler->StartThread();
                    time_t tmStartWait = time(NULL);
                    time_t tmNow = tmStartWait;
                    bool bErrorStarting = false;
                    while ((pNewHandler->IsRunning() == false) && (pNewHandler->IsFinished() == false)) {
                        std::this_thread::sleep_for(std::chrono::milliseconds(1));
                        tmNow = time(NULL);
                        if (tmNow - tmStartWait > 5) {
                            bErrorStarting = true;
                            break;
                        }
                    }
                    if (bErrorStarting || pNewHandler->IsFinished()) {
                        LOG_ERROR("Thread exited prematurely, discarding.");
                        delete pNewHandler;
                    }
                    else {
                        mvecWorkingHandlers.push_back(std::shared_ptr<ProtocolHandler>(pNewHandler));
                    }
                }
                else {
                    if (NewTCPConnection) {
                        NewTCPConnection->Close();
                    }
                }
            }
        }
        // Clean up already finished threads from the vector
        i = 0;
        while (i < mvecWorkingHandlers.size()) {
            if (mvecWorkingHandlers[i]->IsFinished()) {
                mvecWorkingHandlers[i]->Shutdown();
                mvecWorkingHandlers.erase(mvecWorkingHandlers.begin()+i);
            }
            else {
                i++;
            }
        }
        // Clean up any expired sessions
        Sessions->DeleteExpiredSessions();
	}
	mbRunning = false;
}

void LoginServer::Shutdown(bool bJoin)
{
	LOG_DEBUG0("Called.");
	if (mbShutdown == false) {
		mbShutdown = true;
		// Wait for server process to end
		while (mbRunning) {
			std::this_thread::sleep_for(std::chrono::milliseconds(1));
		}
		LOG_INFO("All running threads stopped.");
		while (mvecWorkingHandlers.empty() == false) {
			// Since the server is no longer running we can assume these
			// non-atomic operations are safe.
			mvecWorkingHandlers.back()->Shutdown();
			mvecWorkingHandlers.pop_back();
		}
        if ((bJoin) && (mpThreadObj) && (mpThreadObj->joinable())) {
            mpThreadObj->join();
            mpThreadObj = NULL;
            LOG_DEBUG0("Thread joined.");
        }
    }
	LOG_INFO("Server successfully shut down.");
}
