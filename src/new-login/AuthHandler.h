/**
 *	@file AuthHandler.h
 *	Implementation of the authentication protocol
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#ifndef FFXI_LOGIN_AUTHHANDLER_H
#define FFXI_LOGIN_AUTHHANDLER_H

#include "ProtocolHandler.h"
#include "../new-common/TCPConnection.h"

 /**
 *  Login handler class, create an object for each connecting client.
 */
class AuthHandler : public ProtocolHandler
{
public:
    /**
     *  Create a new handler.
     *  @param connection TCP connection to assign to this handler
     */
    AuthHandler(std::shared_ptr<TCPConnection> connection);

    /**
     *  Generally it's advisable to explicitly call Shutdown before
     *  destroying the object.
     */
    virtual ~AuthHandler();

    /**
     *  Run the handler. Should generally not be called directly,
     *  use StartThread() to run the handler in a separate thread.
     */
    void Run();

private:
    /// Number of failed request so far
    uint16_t mwFailedRequests;

#pragma pack(push, 1)
    /**
     *  Structure of a login packet as it is transferred on the wire.
     */
    struct LoginPacket
    {
        char szUserName[16];
        char szPassword[16];
        // See enum below
        uint8_t ucCommandType;
        // These are newly introduced values
        // Used when changing password
        char szNewPassword[16];
        char szEmail[50];
        // Used when 2FA is enabled for the account
        char szOTP[16];
        // Pad with some zeros because some modified bootloaders send more data
        // Note: It's only one char so do not change it to LOGIN_COMMANDS type.
        // Use a static cast as needed.
        char szZero[141];
    };
#pragma pack(pop)

    enum LOGIN_COMMANDS
    {
        // Login to existing account
        LOGIN_COMMAND_LOGIN = 0x10,
        // Create a new account
        LOGIN_COMMAND_CREATE = 0x20,
        // Below here these are new commands, unique to login-new
        // Change password
        LOGIN_COMMAND_CHANGE_PASSWORD = 0x80,
    };

#pragma pack(push, 1)
    /**
     *  Structure of the response packet sent from the server back
     *  to the client
     */
    struct LoginResponsePacket
    {
        // Response code (see enum below)
        uint8_t ucResponseType;
        // User account ID (for successful logins)
        uint32_t dwAccountId;
        // Reason for authentication failure
        uint16_t wFailureReason;
        // Authentication token (pass in data and view ports)
        char bufAuthToken[8];
        // Zero
        uint8_t ucZero;
    };
#pragma pack(pop)

    enum LOGIN_RESPONSES
    {
        LOGIN_SUCCESSFUL = 0x01,
        LOGIN_FAILED = 0x02,
        CREATE_SUCCESSFUL = 0x03,
        CREATE_FAILED = 0x04,
        PWCHANGE_SUCCESSFUL = 0x05,
        PWCHANGE_FAILED = 0x06,
        // Misc error codes
        MALFORMED_PACKET = 0x20
    };

    /**
     *  Verify the structure of a received login packet.
     *  @param Packet the packet to verify
     *  @return true if the packet has a correct structure, false if malformed
     */
    bool VerifyPacket(LoginPacket& Packet);

    /**
     *  Verify that a given string is properly NULL terminated.
     *  @param pszString String to verify
     *  @param dwMaxSize Maximum size of the string
     *  @return true if verified, false if no NULL terminator was found.
     */
    bool VerifyNullTerminatedString(const char* pszString, size_t dwMaxSize);
};

#endif
