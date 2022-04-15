/**
 *	@file AuthHandler.cpp
 *	Implementation of the authentication protocol
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "AuthHandler.h"
#include "../new-common/Debugging.h"
#include "Authentication.h"
#include "LoginGlobalConfig.h"
#include <string.h>
#include <thread>
#include <chrono>

AuthHandler::AuthHandler(std::shared_ptr<TCPConnection> connection) : ProtocolHandler(connection),
    mwFailedRequests(0)
{
    LOG_DEBUG0("Called.");
}

AuthHandler::~AuthHandler()
{
    LOG_DEBUG0("Called.");
}

void AuthHandler::Run()
{
    // Contains the latest received login request
    LoginPacket LoginRequest = { 0 };
    // Number of bytes received in the last call
    int32_t iReceivedBytes = 0;
    // UserID as received by the authentication call
    uint32_t dwAccountId = 0;
    // Response packet to send back to the client
    LoginResponsePacket LoginResponse = { 0 };
    // Authenticator object
    Authentication Authenticator(mpConnection);
    // Whether authentication has succeeded
    bool bSuccess = false;
    // Number of allowed login attempts before the user is disconnected
    uint32_t dwMaxLoginAttempts = LoginGlobalConfig::GetInstance()->GetConfigUInt("max_login_attempts");
    // Authentication token (for successful logins)
    uint8_t bufAuthToken[8] = { 0 };

    LOG_DEBUG0("Called.");
    mbRunning = true;

    // Read a minimum of 33 bytes, which is what the stock xiloader sents
    // up to the size of the struct because some modified bootloaders send more data.
    iReceivedBytes = mpConnection->ReadAll(reinterpret_cast<uint8_t*>(&LoginRequest), 33, sizeof(LoginRequest));
    while ((iReceivedBytes > 0) && (mbShutdown == false)) {
        LOG_DEBUG0("Packet received.");
        memset(&LoginResponse, 0, sizeof(LoginResponse));
        if (!VerifyPacket(LoginRequest)) {
            LOG_WARNING("Received malformed login packet.");
            LoginResponse.ucResponseType = static_cast<uint8_t>(MALFORMED_PACKET);
            mwFailedRequests++;
        }
        switch (static_cast<LOGIN_COMMANDS>(LoginRequest.ucCommandType)) {
        case LOGIN_COMMAND_LOGIN:
            LOG_DEBUG1("Received login packet, username=%s", LoginRequest.szUserName);
            dwAccountId = Authenticator.AuthenticateUser(LoginRequest.szUserName, LoginRequest.szPassword, bufAuthToken);
            if (dwAccountId) {
                // Login successful
                LOG_INFO("User %s successfully logged in.", LoginRequest.szUserName);
                LoginResponse.ucResponseType = static_cast<uint8_t>(LOGIN_SUCCESSFUL);
                LoginResponse.dwAccountId = dwAccountId;
                memcpy(LoginResponse.bufAuthToken, bufAuthToken, sizeof(LoginResponse.bufAuthToken));
                bSuccess = true;
            }
            else {
                // Login failed
                LOG_INFO("Login failed for user %s.", LoginRequest.szUserName);
                LoginResponse.ucResponseType = static_cast<uint8_t>(LOGIN_FAILED);
                LoginResponse.wFailureReason = static_cast<uint16_t>(Authenticator.GetLastAuthenticationError());
                mwFailedRequests++;
            }
            break;
        case LOGIN_COMMAND_CREATE:
            LOG_DEBUG1("Received account creation packet, username=%s", LoginRequest.szUserName);
            dwAccountId = Authenticator.CreateUser(LoginRequest.szUserName,
                LoginRequest.szPassword,
                LoginRequest.szEmail[0] != '\0' ? LoginRequest.szEmail : NULL);
            if (dwAccountId) {
                // Creation successful
                LOG_INFO("User %s successfully created.", LoginRequest.szUserName);
                LoginResponse.ucResponseType = static_cast<uint8_t>(CREATE_SUCCESSFUL);
                LoginResponse.dwAccountId = dwAccountId;
                memcpy(LoginResponse.bufAuthToken, bufAuthToken, sizeof(LoginResponse.bufAuthToken));
                bSuccess = true;
            }
            else {
                // Login failed
                LOG_INFO("Account creation failed for user %s.", LoginRequest.szUserName);
                LoginResponse.ucResponseType = static_cast<uint8_t>(CREATE_FAILED);
                LoginResponse.wFailureReason = static_cast<uint16_t>(Authenticator.GetLastAuthenticationError());
                mwFailedRequests++;
            }
            break;
        case LOGIN_COMMAND_CHANGE_PASSWORD:
            LOG_DEBUG1("Received password change packet, username=%s", LoginRequest.szUserName);
            if (Authenticator.ChangePassword(LoginRequest.szUserName, LoginRequest.szPassword, LoginRequest.szNewPassword))
            {
                LOG_INFO("Successfully changed the password of user %s.", LoginRequest.szUserName);
                LoginResponse.ucResponseType = static_cast<uint8_t>(PWCHANGE_SUCCESSFUL);
                // Note - Password change does not auto-login the user so not setting bSuccess here
            }
            else {
                LOG_INFO("Password change failed for user %s.", LoginRequest.szUserName);
                LoginResponse.ucResponseType = static_cast<uint8_t>(PWCHANGE_FAILED);
                LoginResponse.wFailureReason = static_cast<uint16_t>(Authenticator.GetLastAuthenticationError());
                mwFailedRequests++;
            }
            break;
        default:
            // Should not reach here
            LOG_ERROR("Malformed packet not caught by VerifyPacket.");
            LoginResponse.ucResponseType = static_cast<uint8_t>(MALFORMED_PACKET);
            mwFailedRequests++;
        }
        // Send the response packet
        mpConnection->WriteAll(reinterpret_cast<uint8_t*>(&LoginResponse), sizeof(LoginResponse));
        if ((dwMaxLoginAttempts > 0) && (mwFailedRequests > dwMaxLoginAttempts)) {
            // Too many failed login attempts
            LOG_WARNING("Too many failed login attempts, disconnecting client.");
            break;
        }
        if (bSuccess) {
            LOG_INFO("Client authenticated successfully.");
            // TODO: Add user to lobby session object
            break;
        }
        // Read next packet
        memset(&LoginRequest, 0, sizeof(LoginRequest));
        iReceivedBytes = mpConnection->ReadAll(reinterpret_cast<uint8_t*>(&LoginRequest), 33, sizeof(LoginRequest));
    }

    LOG_DEBUG0("AuthHandler ended.");
    mbRunning = false;
    mpConnection->Close();
}

bool AuthHandler::VerifyNullTerminatedString(const char* pszString, size_t dwMaxSize)
{
    size_t i = 0;
    for (i = 0; i < dwMaxSize; i++) {
        if (pszString[i] == '\0') {
            break;
        }
    }
    if ((i == 0) || (i >= dwMaxSize)) {
        return false;
    }
    return true;
}

bool AuthHandler::VerifyPacket(LoginPacket& Packet)
{

    if ((Packet.ucCommandType != LOGIN_COMMAND_LOGIN) &&
        (Packet.ucCommandType != LOGIN_COMMAND_CREATE) &&
        (Packet.ucCommandType != LOGIN_COMMAND_CHANGE_PASSWORD)) {
        // Unrecognized command
        return false;
    }
    // Since all packets begin with username and password and they
    // must be NULL terminated, verify that.
    if (!VerifyNullTerminatedString(Packet.szUserName, sizeof(Packet.szUserName))) {
        return false;
    }
    if (!VerifyNullTerminatedString(Packet.szPassword, sizeof(Packet.szPassword))) {
        return false;
    }
    // Email is optional but if given needs to be valid too
    if ((Packet.szEmail[0] != '\0') && (!VerifyNullTerminatedString(Packet.szEmail, sizeof(Packet.szEmail)))) {
        return false;
    }
    // Change password must have a new password field as well
    if ((Packet.ucCommandType == LOGIN_COMMAND_CHANGE_PASSWORD) &&
        (!VerifyNullTerminatedString(Packet.szNewPassword, sizeof(Packet.szNewPassword)))) {
        return false;
    }
    return true;
}


