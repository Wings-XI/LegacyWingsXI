/**
 *	@file ProtocolHandler.cpp
 *	Interface to various protocols implemented by the login server.
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "ProtocolHandler.h"
#include "../new-common/Debugging.h"

ProtocolHandler::ProtocolHandler(std::shared_ptr<TCPConnection> connection) : mpConnection(connection)
{
    LOG_DEBUG0("Called.");
}

ProtocolHandler::~ProtocolHandler()
{
    LOG_DEBUG0("Called.");
}

void ProtocolHandler::Shutdown(bool bJoin)
{
    LOG_DEBUG0("Called.");
    bool bWasRunning = !mbShutdown;
    Thread::Shutdown(bJoin);
    if (bWasRunning) {
        mpConnection->Close();
    }
    LOG_DEBUG1("Handler ended successfully.");
}

const BoundSocket& ProtocolHandler::GetClientDetails() const
{
    return mpConnection->GetConnectionDetails();
}
