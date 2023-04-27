/**
 *	@file DataHandler.cpp
 *	Implementation of the data protocol
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#include <mariadb++/connection.hpp>
#include "DataHandler.h"
#include "LoginGlobalConfig.h"
#include "../new-common/Debugging.h"
#include "../new-common/Database.h"
#include "SessionTracker.h"
#include "../new-common/Utilities.h"
#include <time.h>
#include <stdexcept>
#include <memory>

DataHandler::DataHandler(std::shared_ptr<TCPConnection> connection) : ProtocolHandler(connection), mdwAccountID(0)
{
    LOG_DEBUG0("Called.");
}

DataHandler::~DataHandler()
{
    LOG_DEBUG0("Called.");
}

void DataHandler::Run()
{
    // Outgoing request packets are a single byte in size
    uint8_t cOutgoingBytePacket = 0;
    // Type of the incoming packet
    uint8_t cIncomingPacketType = 0;
    // Have we already received an account ID?
    bool bGotAccountID = false;
    // Have we already received a key?
    bool bGotKey = false;
    // Error has occurred
    bool bError = false;
    // Session is authenticated with token
    bool bAuthenticated = false;
    // Request from view server
    LoginSession::REQUESTS_TO_DATA_SERVER RequestFromView;
    // Time now
    time_t tmNow = time(NULL);
    // Last packet receive time (initialize to now so they don't get disconnected immediately)
    time_t tmLastPacket = tmNow;
    // Time when we last sent a ping request
    time_t tmLastPing = 0;

    LOG_DEBUG0("Called.");
    mbRunning = true;
    bool bUseAuthToken = LoginGlobalConfig::GetInstance()->GetConfigUInt("ip_lookup_identification") ? false : true;

    // When the client connects, immediately ask for account ID
    cOutgoingBytePacket = static_cast<uint8_t>(bUseAuthToken ? S2C_PACKET_SEND_ACCOUNT_ID_EX : S2C_PACKET_SEND_ACCOUNT_ID);
    if (mpConnection->WriteAll(&cOutgoingBytePacket, sizeof(cOutgoingBytePacket)) != sizeof(cOutgoingBytePacket)) {
        // Shouldn't really happen unless the client immediately dropped the connection
        LOG_WARNING("Connection dropped before account ID request was sent.");
        mpConnection->Close();
        return;
    }

    while ((mbShutdown == false) && (bError == false)) {

        // Maybe we have a request from the view server
        if (mpSession.get() != NULL) {
            RequestFromView = mpSession->GetRequestFromViewServer();
            if (RequestFromView != LoginSession::DATA_SERVER_IDLE) {
                if (RequestFromView == LoginSession::DATA_SERVER_ASK_FOR_KEY) {
                    cOutgoingBytePacket = static_cast<uint8_t>(S2C_PACKET_SEND_KEY);
                    if (mpConnection->WriteAll(&cOutgoingBytePacket, sizeof(cOutgoingBytePacket)) != sizeof(cOutgoingBytePacket)) {
                        LOG_WARNING("Client dropped the connection.");
                        break;
                    }
                }
                else if (RequestFromView == LoginSession::DATA_SERVER_SEND_CHARACTER_LIST) {
                    LOG_DEBUG1("Resending character list.");
                    SendCharacterList();
                    mpSession->SendRequestToViewServer(LoginSession::VIEW_SERVER_SEND_CHARACTER_LIST);
                }
                else {
                    LOG_ERROR("Unknown data server state.");
                    break;
                }
                // Clear our own state machine
                mpSession->SendRequestToDataServer(LoginSession::DATA_SERVER_IDLE);
            }
        }

        // Check for response from the client
        if (!mpConnection->CanRead(200)) {
            // No data from client
            if (mpSession) {
                tmLastPacket = ffxi_max(mpSession->GetLastPacketTime(), tmLastPacket);
            }
            tmNow = time(NULL);
            if (tmLastPacket + 300 < tmNow) {
                // Timed out
                LOG_WARNING("Ping timed out, closing data connection.");
                mbShutdown = true;
                break;
            }
            else if ((tmLastPacket + 120 < tmNow) && (tmLastPing + 5 < tmNow)) {
                // Since the bootloader doesn't support pings we just
                // send an account ID request just to trigger it to
                // send something (we ignore the actual answer content)
                LOG_DEBUG0("Sending ping packet to client.");
                cOutgoingBytePacket = static_cast<uint8_t>(bUseAuthToken ? S2C_PACKET_SEND_ACCOUNT_ID_EX : S2C_PACKET_SEND_ACCOUNT_ID);
                if (mpConnection->WriteAll(&cOutgoingBytePacket, sizeof(cOutgoingBytePacket)) != sizeof(cOutgoingBytePacket)) {
                    // Connection dropped apparently
                    LOG_WARNING("Connection to data server dropped.");
                    mbShutdown = true;
                    break;
                }
                tmLastPing = tmNow;
            }
            // Keep on waiting
            continue;
        }
        // First byte indicates which type of packet it is
        if (mpConnection->Read(&cIncomingPacketType, sizeof(cIncomingPacketType)) != sizeof(cIncomingPacketType)) {
            LOG_WARNING("Client dropped the connection.");
            bError = true;
            break;
        }
        LOG_DEBUG1("Received data from client, packet type=0x%02X", cIncomingPacketType);
        if ((!bGotAccountID) &&
            ((static_cast<CLIENT_TO_SERVER_PACKET_TYPES>(cIncomingPacketType) != C2S_PACKET_ACCOUNT_ID) &&
            (static_cast<CLIENT_TO_SERVER_PACKET_TYPES>(cIncomingPacketType) != C2S_PACKET_ACCOUNT_ID_EX))) {
            // We're not willing to do anything before the client identifies itself, so this is an error.
            LOG_WARNING("Client sent data before sending its account ID, dropping connection.");
            bError = true;
            break;
        }
        if (mpSession) {
            mpSession->SetLastPacketNow();
        }
        time_t now = time(NULL);
        tmLastPacket = now;
        bAuthenticated = false;
        switch (static_cast<CLIENT_TO_SERVER_PACKET_TYPES>(cIncomingPacketType)) {
        case C2S_PACKET_ACCOUNT_ID_EX:
            bAuthenticated = true;
            // Fallthrough
        case C2S_PACKET_ACCOUNT_ID:
            // Packet is 2 32-bit uints with account ID and server address
            ACCOUNT_ID_PACKET AccountPacket;
            ACCOUNT_ID_PACKET_EX AccountPacketEx;
            if (bAuthenticated) {
                if (mpConnection->ReadAll(reinterpret_cast<uint8_t*>(&AccountPacketEx), sizeof(AccountPacketEx)) != sizeof(AccountPacketEx)) {
                    LOG_WARNING("Client sent an incomplete authenticated account ID packet.");
                    bError = true;
                    break;
                }
                // AccountPacketEx is an expansion of AccountPacket and they share the same header
                memcpy(&AccountPacket, &AccountPacketEx, sizeof(AccountPacket));
            }
            else {
                if (bUseAuthToken) {
                    LOG_WARNING("Client sent an unauthenticated accout ID packet but authentication token is required in configuration.");
                    bError = true;
                    break;
                }
                if (mpConnection->ReadAll(reinterpret_cast<uint8_t*>(&AccountPacket), sizeof(AccountPacket)) != sizeof(AccountPacket)) {
                    LOG_WARNING("Client sent an incomplete account ID packet.");
                    bError = true;
                    break;
                }
            }
            if (!bGotAccountID || !mpSession) {
                LOG_DEBUG1("Client claims account ID: %d", AccountPacket.dwAccountID);
                // Verify we have it in the session tracker (meaning it passed through the authentication server)
                try {
                    mpSession = SessionTracker::GetInstance()->GetSessionDetails(AccountPacket.dwAccountID);
                }
                catch (std::runtime_error) {
                    LOG_WARNING("Client tried to connect to data server before authenticating.");
                    bError = true;
                    break;
                }
                if (!mpSession) {
                    LOG_ERROR("Session lookup returned NULL value.");
                    bError = true;
                    break;
                }
                mpSession->SetLastPacketNow();
                tmLastPacket = time(NULL);
                // Also verify that it's the same client that authenticated and that the session has not expired
                if (mpSession->GetClientIPAddress() != mpConnection->GetConnectionDetails().BindDetails.sin_addr.s_addr) {
                    LOG_WARNING("Account ID / IP address mismatch.");
                    bError = true;
                    break;
                }
                if (mpSession->HasExpired()) {
                    LOG_WARNING("Client session has expired.");
                    bError = true;
                    break;
                }
                if (bUseAuthToken && !bAuthenticated) {
                    LOG_WARNING("Authentication token was required but not provided");
                    bError = true;
                    break;
                }
                if (bAuthenticated) {
                    if (memcmp(AccountPacketEx.bufAuthToken, mpSession->GetAuthToken(), sizeof(AccountPacketEx.bufAuthToken)) != 0) {
                        LOG_WARNING("Authentication token mismatch.");
                        bError = true;
                        break;
                    }
                }
                LOG_DEBUG1("Account ID check passed.");
                // Client passed account ID check
                mdwAccountID = AccountPacket.dwAccountID;
                bGotAccountID = true;
            }
            else {
                if (AccountPacket.dwAccountID != mdwAccountID) {
                    LOG_WARNING("Client attempted to switch account ID.");
                }
                else {
                    LOG_DEBUG0("Received pong packet (do nothing).");
                }
            }
            break;
        case C2S_PACKET_KEY:
            // Packet is a 24-byte key. Add to session data. Note - Since we only accept this packet after
            // the account ID packet has been processed, we know that SessionData is already initialied so
            // no need to do that again.
            uint8_t bufNewKey[24];
            if (mpConnection->ReadAll(bufNewKey, sizeof(bufNewKey)) != sizeof(bufNewKey)) {
                LOG_WARNING("Client sent an incomplete key packet.");
                bError = true;
                break;
            }
            if (mpSession) {
                mpSession->SetKey(bufNewKey);
                // Update the key in the session tracker, add some time to the TTL if needed
                LOG_DEBUG1("Receving key from client.");
                mpSession->SetExpiryTimeRelative(30);
                bGotKey = true;
                mpSession->SendRequestToViewServer(LoginSession::VIEW_SERVER_PROCEED_LOGIN);
                LOG_DEBUG1("Key updated.");

            }
            else {
                LOG_ERROR("Client sent a key before creating session.");
                bError = true;
            }
            break;
        default:
            LOG_WARNING("Client sent an unrecognized packet type.");
            bError = true;
        }

        // Don't answer on error, drop the connection immediately
        if (bError) {
            break;
        }
    }
    LOG_INFO("Closing data connection for account ID: %d", mdwAccountID);
    mpConnection->Close();
    if (mpSession) {
        mpSession->SetDataServerFinished();
        if (mpSession->IsViewServerFinished()) {
            // Both servers have finished so mark the session as expired
            // so it gets cleaned up immediately.
            mpSession->SetNeverExpire(false);
            mpSession->SetExpiryTimeAbsolute(0);
        }
    }
    mbRunning = false;
}

void DataHandler::SendCharacterList()
{
    LOG_DEBUG0("Called.");

    DATA_PACKET_CHARACTER_LIST CharList = { 0 };
    // Load character list from DB into session
    mpSession->LoadCharacterList();
    uint8_t cNumCharsAllowed = ffxi_min(mpSession->GetNumCharsAllowed(), 16);
    //uint8_t cNumChars = ffxi_min(mpSession->GetNumCharacters(), cNumCharsAllowed);
    const CHARACTER_ENTRY* pCurrentChar;

    for (uint8_t i = 0; i < cNumCharsAllowed; i++) {
        pCurrentChar = mpSession->GetCharacter(i);
        CharList.Characters[i].dwContentID = pCurrentChar->dwContentID;
        CharList.Characters[i].dwCharacterID = pCurrentChar->dwCharacterID;
    }
    CharList.cPacketType = static_cast<uint8_t>(S2C_PACKET_CHARACTER_LIST);
    CharList.cNumCharacters = cNumCharsAllowed;
    LOG_DEBUG1("Sending character list.");
    if (mpConnection->WriteAll(reinterpret_cast<uint8_t*>(&CharList), sizeof(CharList)) <= 0) {
        LOG_ERROR("Connection error when sending character ID list.");
        throw std::runtime_error("Connection dropped.");
    }
    LOG_DEBUG1("Character list sent.");
}
