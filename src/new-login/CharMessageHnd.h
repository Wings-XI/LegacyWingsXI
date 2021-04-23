/**
 *	@file CharMessageHnd.h
 *	Stub for incoming messages to login server (currently none used)
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#ifndef FFXI_LOGIN_CHARMESSAGEHND_H
#define FFXI_LOGIN_CHARMESSAGEHND_H

#include "../new-common/MQHandler.h"
#include "../new-common/MQConnection.h"
#include "../new-common/CommonMessages.h"

/**
 *  Character message handler. Supports creation, login and update.
 */
class CharMessageHnd : public MQHandler
{
public:

    /**
     *  Default constructor, doesn't do much.
     */
    CharMessageHnd();

    /**
     *  Destructor
     */
    virtual ~CharMessageHnd();

    /**
     *  Handle a single character MQ request
     *  @param Request Request bytes to handle
     *  @param pOrigin MQ connection from which the message originated
     *  @param dwChannel The channel from which the message originated
     *  @return true if the message has been processed, false to proceed to next handler
     */
    virtual bool HandleRequest(amqp_bytes_t Request, MQConnection* pOrigin, uint32_t dwChannel);

};

#endif
