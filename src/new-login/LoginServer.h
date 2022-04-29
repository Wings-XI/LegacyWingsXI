/**
 *	@file LoginServer.h
 *	TCP server routines
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_LOGIN_SERVER_H
#define FFXI_LOGIN_SERVER_H

#include <vector>
#include <memory>

#include <stdint.h>

#include "../new-common/TCPConnection.h"
#include "ProtocolHandler.h"
#include "ProtocolFactory.h"
#include "../new-common/Thread.h"

/**
 *	Main login server class.
 */
class LoginServer : public Thread
{
public:

	/**
	 *	Create new instance, does some OS level initialization.
	 */
	LoginServer();

	/**
	 *	Destructor.
	 */
	~LoginServer();

	/**
	 *	Add a new listening port.
     *  @param eProtocol The protocol associated with this binding
	 *	@param wPortNum Port number to listen on
	 *	@param szIpAddress IP address to listen all (defaults to all interfaces)
	 *	@param bSecure Set to true for SSL interfaces (if supported)
	 *	@note This actually starts listening on the port
	 */
	void AddBind(ProtocolFactory::LOGIN_PROTOCOLS eProtocol, uint16_t wPortNum, const char* szIpAddress = NULL, bool bSecure = false);

	/**
	 *	Run the server and serve connections until Shutdown() is called
	 *	from a different thread.
	 */
	void Run();

	/**
	 *	Shut down the server and close all connections and listening sockets.
	 */
	void Shutdown(bool bJoin = true);

private:
	/// Current listening sockets
	std::vector<BoundSocket> mvecListeningSockets;
	/// Currently working handlers
	std::vector<std::shared_ptr<ProtocolHandler>> mvecWorkingHandlers;
};

#endif
