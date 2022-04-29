/**
 *	@file DataHandler.h
 *	Implementation of the data protocol
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_LOGIN_DATAHANDLER_H
#define FFXI_LOGIN_DATAHANDLER_H

#include "ProtocolHandler.h"
#include "../new-common/TCPConnection.h"
#include "LoginSession.h"
#include <stdint.h>

/**
 *  Data handler class, create an object for each connecting client.
 *  The data protocol is between the server and the bootloader, designed
 *  to emulate certain traffic that on retail is apparently done by
 *  POL. On retail POL seems to request the server to send certain packets
 *  on the view port to the client (as well as the other way). Since we
 *  don't use POL, the data port is used to negotiate when these packets
 *  are sent.
 */
class DataHandler : public ProtocolHandler
{
public:
    /**
     *  Create a new handler.
     *  @param connection TCP connection to assign to this handler
     */
    DataHandler(std::shared_ptr<TCPConnection> connection);

    /**
     *  Generally it's advisable to explicitly call Shutdown before
     *  destroying the object.
     */
    virtual ~DataHandler();

    /**
     *  Run the handler. Should generally not be called directly,
     *  use StartThread() to run the handler in a separate thread.
     */
    void Run();

private:
    /// Account ID of the connected user
    uint32_t mdwAccountID;
    /// Session object for the connection
    std::shared_ptr<LoginSession> mpSession;

    /**
     *  Packet types that the server sends to the client
     */
    enum SERVER_TO_CLIENT_PACKET_TYPES
    {
        // Request that the client sends its account id
        S2C_PACKET_SEND_ACCOUNT_ID = 1,
        // Request that the client sends an initial encryption key
        S2C_PACKET_SEND_KEY = 2,
        // Provides the client with the character list associated with the account
        S2C_PACKET_CHARACTER_LIST = 3,
        // Request that the client sends its account id and authentication token
        S2C_PACKET_SEND_ACCOUNT_ID_EX = 4
    };

    /**
     *  Packet types that the client sends to the server
     */
    enum CLIENT_TO_SERVER_PACKET_TYPES
    {
        // Client sends its account ID
        C2S_PACKET_ACCOUNT_ID = 0xA1,
        // Client sends an initial encryption key
        C2S_PACKET_KEY = 0xA2,
        // Client sends its account ID and authentication token
        C2S_PACKET_ACCOUNT_ID_EX = 0xA3
    };

#pragma pack(push, 1)
    /**
     *  Account ID packet sent by the client
     */
    struct ACCOUNT_ID_PACKET
    {
        uint32_t dwAccountID;
        uint32_t dwServerAddress;
    };

    /**
     *  Account ID packet sent by the client
     *  Extended version with authentication token
     */
    struct ACCOUNT_ID_PACKET_EX
    {
        uint32_t dwAccountID;
        uint32_t dwServerAddress;
        uint8_t bufAuthToken[8];
        uint8_t bufReserved[16];
    };

    /**
     *  A single entry in the character list sent to the client
     */
    struct DATA_PACKET_CHARACTER_ENTRY
    {
        uint32_t dwContentID;
        uint32_t dwCharacterID;
        // Always zero, doesn't seem to have any meaning
        uint8_t ucZero[8];
    };

    struct DATA_PACKET_CHARACTER_LIST
    {
        uint8_t cPacketType;
        uint8_t cNumCharacters;
        uint8_t ucZero[14];
        DATA_PACKET_CHARACTER_ENTRY Characters[16];
    };

#pragma pack(pop)

    /**
     *  Send the character list packet to the client
     */
    void SendCharacterList();

};

#endif
