/**
 *	@file FFXILoginPacket.h
 *	Implements the FFXI login packet header (for view server)
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_LOGIN_FFXI_LOGIN_PACKET_H
#define FFXI_LOGIN_FFXI_LOGIN_PACKET_H

#include "../new-common/FFXIPacket.h"
#include "../new-common/TCPConnection.h"
#include <stdint.h>
#include <memory>

/**
 *  This allows sending and receiving FFXI login packets. These packets
 *  are used by the view server, which directly communicates with the
 *  game client (rather than the bootloader) so it needs to speak the
 *  FFXI protocol.
 */
class FFXILoginPacket : public FFXIPacket {
public:

    /**
     *  Initialize a new object.
     *  @param Connection underlying TCP connection (login server uses TCP)
     */
    FFXILoginPacket(std::shared_ptr<TCPConnection> Connection);

    /**
     *  Destructor.
     *  Does not close the TCP connection.
     */
    virtual ~FFXILoginPacket();

#pragma pack(push, 1)
    /**
     *  FFXI Packet header and data
     */
    struct FFXI_LOGIN_PACKET_HEADER
    {
        // Standard packet header
        FFXI_PACKET_HEADER PacketHeader;
        // Packet MD5 hash (on everything, including header)
        uint8_t bufMD5[16];
    };
#pragma pack(pop)

    /**
     *  Known packet types. There may be other packet types that are
     *  currently unknown but these are all that are documented.
     */
    enum FFXI_LOGIN_PACKET_TYPES
    {
        // Your business with the server completes successfully (server will then disconnect)
        FFXI_LOGIN_TYPE_DONE = 0x03,
        // An error has occured (error code attached)
        FFXI_LOGIN_TYPE_ERROR = 0x04,
        // Server sends the expansions and features list associated with the account
        FFXI_LOGIN_TYPE_FEATURES_LIST = 0x05,
        // Request to log-in with an existing character
        FFXI_LOGIN_TYPE_LOGIN_REQUEST = 0x07,
        // Server provides details on the map server when logging in
        FFXI_LOGIN_TYPE_LOGIN_RESPONSE = 0x0B,
        // Client requests to delete a character
        FFXI_LOGIN_TYPE_DELETE_CHARACTER = 0x14,
        // Client requests the list of characters associated with the account
        FFXI_LOGIN_TYPE_GET_CHARACTER_LIST = 0x1F,
        // Server sends the account character list
        FFXI_LOGIN_TYPE_CHARACTER_LIST = 0x20,
        // User just approved the final confirmation of character creation
        FFXI_LOGIN_TYPE_CREATE_CHAR_CONFIRM = 0x21,
        // Client requests to create a new character
        FFXI_LOGIN_TYPE_CREATE_CHARACTER = 0x22,
        // Server sends the world list
        FFXI_LOGIN_TYPE_WORLD_LIST = 0x23,
        // Client requests the world list
        FFXI_LOGIN_TYPE_GET_WORLD_LIST = 0x24,
        // Client reports its version and requests the account expansion and features available
        FFXI_LOGIN_TYPE_GET_FEATURES = 0x26
    };

    /**
     *  Error codes sent in FFXI_TYPE_ERROR messages
     */
    enum FFXI_ERROR_CODES
    {
        // Unable to connect to world server
        FFXI_ERROR_MAP_CONNECT_FAILED = 305,
        // Character name already taken
        FFXI_ERROR_NAME_ALREADY_TAKEN = 313,
        // Character creation not allowed
        FFXI_ERROR_CREATE_DENIED = 314,
        // Log-in not allowed (maintenance mode)
        FFXI_ERROR_LOGIN_DENIED = 321,
        // The server does not support this client version
        FFXI_ERROR_VERSION_MISMATCH = 331
    };

    /**
     *  Construct and sent a packet
     *  @param eType Packet type (see enum)
     *  @param pData Data to send (without header)
     *  @param cbData Size of the data (without header) in bytes
     */
    virtual void SendPacket(FFXI_LOGIN_PACKET_TYPES eType, uint8_t* pData, uint32_t cbData);

    /**
     *  Sends an error packet to the client
     *  @param ErrorCode Error code to send (from FFXI_ERROR_CODES enum)
     */
    virtual void SendError(FFXI_ERROR_CODES ErrorCode);

    /**
     *  Send a success message
     */
    virtual void SendDone();

#pragma pack(push, 1)
    /**
     *  Structure of an error packet payload
     */
    struct FFXI_ERROR_PACKET
    {
        uint32_t dwZero;
        uint32_t dwErrorCode;
    };
#pragma pack(pop)

};

#endif
