/**
 *	@file FFXIPacket.h
 *	Implements the FFXI login packet header (for view server)
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_FFXI_PACKET_H
#define FFXI_COMMON_FFXI_PACKET_H

#include "TCPConnection.h"
#include <stdint.h>
#include <memory>

/**
 *  This allows sending and receiving FFXI packets, implementing the
 *  global headers used for all traffic that goes to the actual game
 *  client. Sub-protocols are implemented by derived classes.
 */
class FFXIPacket {
public:

    /**
     *  Initialize a new object.
     *  @param Connection underlying TCP connection (login server uses TCP)
     */
    FFXIPacket(std::shared_ptr<TCPConnection> Connection);

    /**
     *  Destructor.
     *  Does not close the TCP connection.
     */
    virtual ~FFXIPacket();

#pragma pack(push, 1)
    /**
     *  FFXI Packet header and data
     */
    struct FFXI_PACKET_HEADER
    {
        // Length of the packet (including the header)
        uint32_t dwPacketSize;
        // Magic ("XIFF")
        uint8_t bufMagic[4];
        // Packet type (see enum)
        uint32_t dwPacketType;
    };
#pragma pack(pop)

    /**
     *  Receive a packet from the network.
     *  @return pointer to the received data, including header. The packet data follows the header.
     */
    virtual std::shared_ptr<uint8_t> ReceivePacket();

    /**
     *  Send a raw packet
     *  @param pPacket Packet to send, including the header. The packet data should follow the header
     */
    virtual void SendPacket(uint8_t* pPacket);

    /**
     *  Construct and sent a packet
     *  @param dwType Packet type
     *  @param pData Data to send (without header)
     *  @param cbData Size of the data (without header) in bytes
     */
    virtual void SendPacket(uint32_t dwType, uint8_t* pData, uint32_t cbData);

protected:

    /// Connected TCP socket
    std::shared_ptr<TCPConnection> mpConnection;
    /// Packet magic
    uint8_t mbufPacketMagic[4];

};

#endif
