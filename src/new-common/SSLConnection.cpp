/**
 *	@file SSLConnection.cpp
 *	TLS / SSL encrypted connection class.
 *	@author Twilight
 *	@copyright 2021, all rights reserved. Licensed under GPLv3
 */

#include "SSLConnection.h"
#include "Debugging.h"
#include <chrono>
#include <thread>
#include <stdexcept>

void SSLConnection::InitSSL()
{
    SSL_load_error_strings();
    OpenSSL_add_ssl_algorithms();
}

void SSLConnection::CleanupSSL()
{
    EVP_cleanup();
}

SSLConnection::SSLConnection(BoundSocket& ConnectionDetails, const char* pszCertificateFile, const char* pszKeyFile, int iSecurityLevel) :
    TCPConnection(ConnectionDetails), mbSSLClosed(false)
{
    LOG_DEBUG0("Called.");
    // Forbid old SSLv2
    mpMethod = TLS_method();
    mpCtx = SSL_CTX_new(mpMethod);
    if (!mpCtx) {
        LOG_ERROR("Unable to create new SSL context.");
        throw std::runtime_error("SSL context creation failed.");
    }
    // Deprecated, enabled by default
    // SSL_CTX_set_ecdh_auto(mpCtx, 1);
    // allow older clients to connect: https://www.openssl.org/docs/man1.1.1/man3/SSL_CTX_set_security_level.html
    if(!SSL_CTX_set_security_level(mpCtx, 1))
        LOG_ERROR("Unable to enable legacy TLS support.");
    if (iSecurityLevel >= 0) {
        SSL_CTX_set_security_level(mpCtx, iSecurityLevel);
    }
    if (SSL_CTX_use_certificate_file(mpCtx, pszCertificateFile, SSL_FILETYPE_PEM) <= 0) {
        LOG_ERROR("Unable to open certificate file (%s).", ERR_error_string(ERR_get_error(), NULL));
        throw std::runtime_error("Certificate file error.");
    }
    if (SSL_CTX_use_PrivateKey_file(mpCtx, pszKeyFile, SSL_FILETYPE_PEM) <= 0) {
        LOG_ERROR("Unable to open private key file (%s).", ERR_error_string(ERR_get_error(), NULL));
        throw std::runtime_error("Key file error.");
    }
    mpSSL = SSL_new(mpCtx);
    if (!mpSSL) {
        LOG_ERROR("Unable to create SSL wrapper object (%s).", ERR_error_string(ERR_get_error(), NULL));
        throw std::runtime_error("SSL_new failed.");
    }
    SSL_set_fd(mpSSL, ConnectionDetails.iSock);
    if (SSL_accept(mpSSL) <= 0) {
        LOG_ERROR("Initialization of SSL connection failed (%s).", ERR_error_string(ERR_get_error(), NULL));
        throw std::runtime_error("SSL handshake failed.");
    }
}

SSLConnection::~SSLConnection()
{
    LOG_DEBUG0("Called.");
    if (!mbSSLClosed) {
        Close();
    }
}

void SSLConnection::Close()
{
    LOG_DEBUG0("Called.");
    if (!mbSSLClosed) {
        LOG_DEBUG0("Closing SSL session.");
        SSL_shutdown(mpSSL);
        SSL_free(mpSSL);
        mbSSLClosed = true;
    }
    TCPConnection::Close();
}

int32_t SSLConnection::Read(uint8_t* bufReceived, int32_t cbBuffer)
{
    // Bytes read
    int32_t cbRead = 0;

    LOG_DEBUG0("Called.");
    if (mbSSLClosed) {
        // Connection already closed, won't read
        LOG_ERROR("Attempted to read from closed connection.");
        return -1;
    }
    cbRead = SSL_read(mpSSL, bufReceived, cbBuffer);
    if (cbRead <= 0) {
        int iLastErr = SSL_get_error(mpSSL, cbRead);
        if (iLastErr == SSL_ERROR_WANT_READ) {
            LOG_DEBUG0("Received WANT_READ, keeping connection open");
            return 0;
        }
        LOG_ERROR("Error duing read, connection may have been closed.");
        Close();
        if (cbRead == 0) {
            // Make sure we never confuse WANT_READ with an actual error
            cbRead = -1;
        }
    }
    LOG_DEBUG0("Read %d bytes", cbRead);
    return cbRead;
}

int32_t SSLConnection::ReadAll(uint8_t* bufReceived, int32_t cbMinRead, int32_t cbMaxRead)
{
    // Bytes received so far
    int32_t cbReceived = 0;
    // Bytes received this iteration
    int32_t cbReceivedNow = 0;

    LOG_DEBUG0("Called.");
    if (cbMaxRead < cbMinRead) {
        cbMaxRead = cbMinRead;
    }
    while (cbReceived < cbMinRead) {
        cbReceivedNow = Read(bufReceived + cbReceived, cbMaxRead - cbReceived);
        if (cbReceivedNow == 0) {
            // Connection closed so return what we have
            LOG_DEBUG0("Waiting and trying again.");
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }
        if (cbReceivedNow < 0) {
            // An error is an error
            LOG_ERROR("Socket read error.");
            return cbReceivedNow;
        }
        cbReceived += cbReceivedNow;
    }
    LOG_DEBUG0("Total read %d bytes", cbReceived);
    return cbReceived;
}

bool SSLConnection::CanRead(int32_t iTimeout)
{
    if (!TCPConnection::CanRead(iTimeout)) {
        return false;
    }
    // Also need to check the upper layer
    return ((SSL_pending(mpSSL) > 0) ? true : false);
}

int32_t SSLConnection::Write(const uint8_t* bufSend, int32_t cbData)
{
    // Bytes written
    int32_t cbWritten = 0;

    LOG_DEBUG0("Called.");
    if (mbSSLClosed) {
        // Connection already closed, won't write
        return -1;
    }
    cbWritten = SSL_write(mpSSL, bufSend, cbData);
    if (cbWritten <= 0) {
        int iLastErr = SSL_get_error(mpSSL, cbWritten);
        if (iLastErr == SSL_ERROR_WANT_WRITE) {
            LOG_DEBUG0("Received WANT_WRITE, keeping connection open");
            return 0;
        }
        LOG_ERROR("Error duing write, connection may have been closed.");
        Close();
        if (cbWritten == 0) {
            // Make sure we never confuse WANT_READ with an actual error
            cbWritten = -1;
        }
    }
    return cbWritten;
}

int32_t SSLConnection::WriteAll(const uint8_t* bufSend, int32_t cbData)
{
    // Bytes received so far
    int32_t cbSent = 0;
    // Bytes received this iteration
    int32_t cbSentNow = 0;

    LOG_DEBUG0("Called.");
    while (cbSent < cbData) {
        cbSentNow = Write(bufSend + cbSent, cbData - cbSent);
        if (cbSentNow == 0) {
            // Connection closed so return what we have
            LOG_DEBUG0("Waiting and trying again.");
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        }
        if (cbSentNow < 0) {
            // An error is an error
            LOG_ERROR("Socket write error.");
            return cbSentNow;
        }
        cbSent += cbSentNow;
    }
    LOG_DEBUG0("Total written %d bytes", cbSent);
    return cbSent;
}

