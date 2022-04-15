/**
 *	@file FFXILoginPacket.cpp
 *	Implements the FFXI login packet header (for view server)
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "FFXILoginPacket.h"
#include "../new-common/Debugging.h"
#include <string.h>
#include <openssl/md5.h>
#include <stdexcept>

// Do not allocate more than this size per packet
#define MAX_PACKET_SIZE_ALLOWED 1048576

FFXILoginPacket::FFXILoginPacket(std::shared_ptr<TCPConnection> Connection) : FFXIPacket(Connection)
{
    LOG_DEBUG0("Called.");
}

FFXILoginPacket::~FFXILoginPacket()
{
    // Currently empty, intentionally not closing the connection because
    // ProtocolHandler does it for us.
    LOG_DEBUG0("Called.");
}

void FFXILoginPacket::SendPacket(FFXI_LOGIN_PACKET_TYPES eType, uint8_t* pData, uint32_t cbData)
{
    LOG_DEBUG0("Called.");
    if (cbData + sizeof(FFXI_LOGIN_PACKET_HEADER) > MAX_PACKET_SIZE_ALLOWED) {
        LOG_ERROR("Packet to send is too big.");
        throw std::runtime_error("Packet to send is too big.");
    }
    LOG_DEBUG0("Building packet.");
    // Allocate buffer for the packet including the header
    uint8_t* pPacket = new uint8_t[cbData + sizeof(FFXI_LOGIN_PACKET_HEADER)];
    FFXI_LOGIN_PACKET_HEADER* pHeader = reinterpret_cast<FFXI_LOGIN_PACKET_HEADER*>(pPacket);
    pHeader->PacketHeader.dwPacketSize = cbData + sizeof(FFXI_LOGIN_PACKET_HEADER);
    memcpy(pHeader->PacketHeader.bufMagic, mbufPacketMagic, sizeof(pHeader->PacketHeader.bufMagic));
    pHeader->PacketHeader.dwPacketType = static_cast<uint32_t>(eType);
    memcpy(pPacket + sizeof(FFXI_LOGIN_PACKET_HEADER), pData, cbData);
    memset(pHeader->bufMD5, 0, sizeof(pHeader->bufMD5));
    MD5(pPacket, cbData + sizeof(FFXI_LOGIN_PACKET_HEADER), pHeader->bufMD5);
    try {
        FFXIPacket::SendPacket(pPacket);
    }
    catch (...) {
        delete pPacket;
        throw;
    }
    delete pPacket;
}

void FFXILoginPacket::SendError(FFXI_ERROR_CODES ErrorCode)
{
    LOG_WARNING("Sending error %d to the client.", ErrorCode);
    FFXI_ERROR_PACKET ErrorPacket;
    ErrorPacket.dwErrorCode = static_cast<uint32_t>(ErrorCode);
    ErrorPacket.dwZero = 0;
    SendPacket(FFXI_LOGIN_TYPE_ERROR, reinterpret_cast<uint8_t*>(&ErrorPacket), sizeof(ErrorPacket));
}

void FFXILoginPacket::SendDone()
{
    LOG_DEBUG1("Sending done packet.");
    // Body is 4 bytes, meaning is unknown
    uint32_t dwBody = 0;
    SendPacket(FFXI_LOGIN_TYPE_DONE, reinterpret_cast<uint8_t*>(&dwBody), sizeof(dwBody));
}
