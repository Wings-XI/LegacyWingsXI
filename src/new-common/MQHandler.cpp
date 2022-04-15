/**
 *	@file MQHandler.cpp
 *	Abstract class that handles and parses incoming MQ messages
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "MQHandler.h"

MQHandler::MQHandler()
{

}

MQHandler::~MQHandler()
{

}

bool MQHandler::OnStartup()
{
    return true;
}

void MQHandler::OnShutdown()
{
}
