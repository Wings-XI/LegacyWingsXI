/**
 *	@file TCPConnection.h
 *	Low level TCP connection classes.
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_TCPCONNECTION_H
#define FFXI_COMMON_TCPCONNECTION_H

#include <string>
#include <stdint.h>
#include <sys/types.h>

#ifdef _WIN32
#include <WinSock2.h>
#include <WS2tcpip.h>
#else
#define _BSD_SOURCE
#include <unistd.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/select.h>
#define closesocket close
#define SOCKET int
#endif

 /**
  *	Connection details. Plain simple data, stored in a vector to
  *	keep track of listening and connected sockets.
  */
struct BoundSocket
{
	/// Socket fd of the listening socket
	SOCKET iSock;
	/// Bind details
	struct sockaddr_in BindDetails;
	/// SSL flag, listening sockets only
	bool bSecure;
    /// Associated protocol, listening sockets only
    int iAssociatedProtocol;
};

class TCPConnection
{
public:

	/**
	 *	Constructor.
	 *	@param ConnectionDetails BoundSocket struct with connection socket and metadata
	 */
	TCPConnection(BoundSocket& ConnectionDetails);

	/**
	 *	Destructor will auto-close connections.
	 */
	virtual ~TCPConnection();

	/**
	 *	Read up to cbBytes bytes from the connection. Will generally block until
	 *	a packet has arrived.
	 *	@param bufReceived Buffer to receive the data into
	 *	@param cbBuffer Size of the buffer in bytes
	 *	@return Number of bytes received, 0 if connection closed, -1 on error
	 */
	virtual int32_t Read(uint8_t* bufReceived, int32_t cbBuffer);

	/**
	 *	Read exactly cbBytes bytes from the connection. Will call read repeadedly
	 *	until the requested number of bytes have been read.
	 *	@param bufReceived Buffer to receive the data into
	 *	@param cbMinRead Minumum number of bytes to read
	 *	@param cbMaxRead Optional maximum number of bytes to read (if not specified will read exactly cbMinRead)
	 *	@return Number of bytes received, 0 if connection closed, -1 on error
	 */
	virtual int32_t ReadAll(uint8_t* bufReceived, int32_t cbMinRead, int32_t cbMaxRead = 0);

    /**
     *  Checks if there's data available to read. If it returns true if means
     *  a call to Read will not block (note that a call to ReadAll may still block
     *  if there's less than cbMinRead bytes to read.
     *  @param iTimeout Optional parameter specifying time to wait in milliseconds, if omitted, wait forever. Can be zero.
     */
    virtual bool CanRead(int32_t iTimeout = -1);

	/**
	 *	Send data to the connection.
	 *	@param bufSend The buffer to send
	 *	@param cbData The size of the data
	 *	@return Number of bytes send or -1 on error.
	 */
	virtual int32_t Write(const uint8_t* bufSend, int32_t cbData);

	/**
	 *	Send data to the connection. Will send the entire buffer, may block
	 *	until all data has been sent.
	 *	@param bufSend The buffer to send
	 *	@param cbData The size of the data
	 *	@return Number of bytes send or -1 on error.
	 */
	virtual int32_t WriteAll(const uint8_t* bufSend, int32_t cbData);

	/**
	 *	Close the connection. Will interrupt any pending reads / writes.
	 */
	virtual void Close();

    /**
     *  Gets the bound socket details associated with this connection.
     *  @return BoundSocket struct associated with the connection.
     */
    const BoundSocket& GetConnectionDetails() const;

protected:
	/// Connection socket and details
	BoundSocket mConnectionDetails;

private:
	/// Whether the connection has already been closed
	bool mbClosed;
};

#endif
