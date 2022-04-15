/**
 *	@file ProtocolFactory.cpp
 *	Creates instances of protocol handlers by given type
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "ProtocolFactory.h"
#include "AuthHandler.h"
#include "DataHandler.h"
#include "ViewHandler.h"
#include "../new-common/Debugging.h"
#include <stdexcept>

ProtocolHandler* ProtocolFactory::BuildHandler(LOGIN_PROTOCOLS protocol, std::shared_ptr<TCPConnection> connection)
{
    LOG_DEBUG0("Called.");
    switch (protocol)
    {
    case PROTOCOL_AUTH:
        LOG_DEBUG0("Constructing authentication handler.");
        return new AuthHandler(connection);
    case PROTOCOL_DATA:
        LOG_DEBUG0("Constructing data handler.");
        return new DataHandler(connection);
    case PROTOCOL_VIEW:
        LOG_DEBUG0("Constructing view handler.");
        return new ViewHandler(connection);
    }
    LOG_CRITICAL("Protocol factory called with unknown or unsupported protocol.");
    throw std::logic_error("Invalid or unsupported protocol");
}
