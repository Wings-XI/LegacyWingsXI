/**
 *	@file ProtocolFactory.h
 *	Creates instances of protocol handlers by given type
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_LOGIN_PROTOCOLFACTORY_H
#define FFXI_LOGIN_PROTOCOLFACTORY_H

#include "ProtocolHandler.h"

/**
 *  Use this to generate protocol handler by a given enum.
 *  Everything is static here, therefore no need to create instances
 *  of this class.
 */
class ProtocolFactory
{
public:
    /**
     *  Different protocols supported by the factory
     */
    enum LOGIN_PROTOCOLS
    {
        // Used for connected sockets, where this value has no meaning
        PROTOCOL_STUB = 0,
        // Authentication and account creation
        PROTOCOL_AUTH,
        // Key management, character list
        PROTOCOL_DATA,
        PROTOCOL_VIEW,
        PROTOCOL_LAST
    };

    /**
     *  Build a new protocol handler object.
     *  @param protocol The requested protocol
     *  @param connection Bound connected socket
     *  @return Pointer to a new handler object
     */
    static ProtocolHandler* BuildHandler(LOGIN_PROTOCOLS protocol, std::shared_ptr<TCPConnection> connection);
};

#endif
