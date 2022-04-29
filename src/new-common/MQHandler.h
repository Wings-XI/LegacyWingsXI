/**
 *	@file MQHandler.h
 *	Abstract class that handles and parses incoming MQ messages
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_MQHANDLER_H
#define FFXI_COMMON_MQHANDLER_H

#include <amqp.h>

class MQConnection;

/**
 *  Abstract MQ message handler. Derive a class to implement parsing and
 *  handling of messages.
 */
class MQHandler
{
public:

    /**
     *  Default constructor, doesn't do much.
     */
    MQHandler();

    /**
     *  Destructor
     */
    virtual ~MQHandler();

    /**
     *  Called once when the MQ thread starts.
     *  @return true if allowed to continue, false to stop the thread
     */
    virtual bool OnStartup();

    /**
     *  Called once when the MQ thread is about to stop.
     */
    virtual void OnShutdown();

    /**
     *  Handle a single MQ request
     *  @param Request Request bytes to handle
     *  @param pOrigin MQ connection from which the message originated
     *  @param dwChannel The channel from which the message originated
     *  @return true if the message has been processed, false to proceed to next handler
     */
    virtual bool HandleRequest(amqp_bytes_t Request, MQConnection* pOrigin, uint32_t dwChannel) = 0;
};

#endif
