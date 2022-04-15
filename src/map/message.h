/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _MESSAGE_H
#define _MESSAGE_H

#include "../common/socket.h"
#include "../common/sql.h"
#include "../common/mmo.h"
#include "../common/cbasetypes.h"

#include <amqp.h>
#include "../new-common/MQHandler.h"

class CBasicPacket;

namespace message
{
    void init(const char* chatIp, uint16 chatPort);
    void send(MSGSERVTYPE type, void* data, size_t datalen, CBasicPacket* packet);
    void close();


    /**
     *  Message handler of the new RabbitMQ-based messages
     *  @author Twilight
     *  @license GPLv3
     */
    class MapMQHandler : public MQHandler
    {
    public:

        /**
        *  Default constructor, doesn't do much.
        */
        MapMQHandler();

        /**
        *  Destructor
        */
        virtual ~MapMQHandler();

        /**
        *  Handle a single MQ request
        *  @param Request Request bytes to handle
        *  @param pOrigin MQ connection from which the message originated
        *  @param dwChannel The channel from which the message originated
        *  @return true if the message has been processed, false to proceed to next handler
        */
        virtual bool HandleRequest(amqp_bytes_t Request, MQConnection* pOrigin, uint32_t dwChannel);

        virtual bool OnStartup();
        virtual void OnShutdown();

        void parse(MSGSERVTYPE type, uint8* extra, size_t extra_size, uint8* packet, size_t packet_size, bool from_self);
    };

}

#endif
