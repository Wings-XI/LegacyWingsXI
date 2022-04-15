/**
 *	@file SSLConnection.h
 *	TLS / SSL encrypted connection class.
 *	@author Twilight
 *	@copyright 2021, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_SSLCONNECTION_H
#define FFXI_COMMON_SSLCONNECTION_H

#include "TCPConnection.h"
#include <openssl/ssl.h>
#include <openssl/err.h>

class SSLConnection : public TCPConnection
{
public:

    /**
     *	Constructor.
     *	@param ConnectionDetails BoundSocket struct with connection socket and metadata
     *  @param pszCertificateFile Filename of a PEM file containing the server certificate
     *  @param pszKeyFile Filename of a PEM file containing the associated private key
     */
    SSLConnection(BoundSocket& ConnectionDetails, const char* pszCertificateFile, const char* pszKeyFile);

    /**
     *	Destructor will auto-close connections.
     */
    virtual ~SSLConnection();

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
     *  Initialize the OpenSSL library. This should be called before
     *  any SSLConnection objects are created.
     */
    static void InitSSL();

    /**
     *  Cleanup the OpenSSL library. No further calls to OpenSSL
     *  can be made after calling this.
     */
    static void CleanupSSL();

protected:
    /// Whether the SSL session had already been closed
    bool mbSSLClosed;
    /// See OpenSSL for details on those
    const SSL_METHOD* mpMethod;
    SSL_CTX* mpCtx;
    /// SSL wrapper around the TCP connection
    SSL* mpSSL;
};

#endif
