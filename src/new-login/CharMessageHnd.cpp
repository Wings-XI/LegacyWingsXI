/**
 *	@file CharMessageHnd.cpp
 *	Stub for incoming messages to login server (currently none used)
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#include "CharMessageHnd.h"
#include "../new-common/Debugging.h"

#define MAX_CHAR_MESSAGE_SIZE 1048576

CharMessageHnd::CharMessageHnd()
{
    LOG_DEBUG0("Called.");
}

CharMessageHnd::~CharMessageHnd()
{
    LOG_DEBUG0("Called.");
}

bool CharMessageHnd::HandleRequest(amqp_bytes_t Request, MQConnection* pOrigin, uint32_t dwChannel)
{
    LOG_DEBUG0("Called.");

    if (Request.len < sizeof(uint32_t) + sizeof(MQConnection::MQ_MESSAGE_TYPES)) {
        LOG_ERROR("Received message is too small.");
        throw std::runtime_error("Message too small.");
    }
    // Sanity, don't allocate too much memory
    if (Request.len > MAX_CHAR_MESSAGE_SIZE) {
        LOG_ERROR("Message size too big.");
        throw std::runtime_error("Message too big.");
    }
    if (*reinterpret_cast<uint32_t*>(Request.bytes) != LOGIN_MQ_MSG_MAGIC) {
        LOG_DEBUG0("Not a login server message, passing.");
        return false;
    }
    MQConnection::MQ_MESSAGE_TYPES eMessageType = *reinterpret_cast<MQConnection::MQ_MESSAGE_TYPES*>
        (reinterpret_cast<uint8_t*>(Request.bytes) + 4);
    if ((eMessageType < MQConnection::MQ_MESSAGE_CHARHND_FIRST) || (eMessageType > MQConnection::MQ_MESSAGE_CHARHND_LAST)) {
        // This is not a message we're handling so pass on to next handler
        LOG_DEBUG0("Not a message for this handler, passing.");
        return false;
    }
    // This handler expects every message to begin with a fixed header containing
    // the target content id, account id etc. so make sure we have it
    if (Request.len < sizeof(CHAR_MQ_MESSAGE_HEADER)) {
        LOG_ERROR("Received message too small for character message header.");
        throw std::runtime_error("Message too small for header.");
    }
    CHAR_MQ_MESSAGE_HEADER* pHeader = reinterpret_cast<CHAR_MQ_MESSAGE_HEADER*>(Request.bytes);
    LOG_WARNING("Got an incoming message to login server (currently unsupported).");
    return true;
}
