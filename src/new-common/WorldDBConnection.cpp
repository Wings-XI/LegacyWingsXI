/**
*	@file WorldDBConnection.cpp
*	Handles connections to world DB servers
*	@author Twilight
*	@copyright 2021, all rights reserved. Licensed under GPLv3
*/

#include "WorldDBConnection.h"
#include "Debugging.h"
#include <stdexcept>
#include <mariadb++/account.hpp>
#include <mariadb++/connection.hpp>

WorldDBConnection::WorldDBConnection(const char* pszDBServer,
    uint16_t wDBPort,
    const char* pszUsername,
    const char* pszPassword,
    const char* pszDatabase,
    bool bUseSSL,
    bool bSSLVerifyPeer,
    char* pszSSLCACertFile,
    char* pszSSLClientCertFile,
    char* pszSSLClientKeyFile)
{
    LOG_DEBUG0("Called.");
    mpAccount = mariadb::account::create(std::string(pszDBServer), std::string(pszUsername), std::string(pszPassword), std::string(pszDatabase), wDBPort);
    if (mpAccount == NULL) {
        LOG_CRITICAL("Unable to create account object.");
        throw std::runtime_error("Account object creation failed.");
    }
    mpAccount->set_auto_commit(true);
    if (bUseSSL) {
        if (bSSLVerifyPeer) {
            mpAccount->set_connect_option(MYSQL_OPT_SSL_VERIFY_SERVER_CERT, true);
        }
        mpAccount->set_connect_option(MYSQL_OPT_SSL_ENFORCE, true);
    }
    if ((pszSSLCACertFile) && (pszSSLCACertFile[0] != '\0')) {
        mpAccount->set_connect_option(MYSQL_OPT_SSL_CA, std::string(pszSSLCACertFile));
    }
    if (pszSSLClientCertFile && pszSSLClientCertFile[0] != '\0' &&
        pszSSLClientKeyFile && pszSSLClientKeyFile[0] != '\0') {
        mpAccount->set_connect_option(MYSQL_OPT_SSL_CERT, std::string(pszSSLClientCertFile));
        mpAccount->set_connect_option(MYSQL_OPT_SSL_KEY, std::string(pszSSLClientKeyFile));
    }
    mpConnection = mariadb::connection::create(mpAccount);
    mpConnection->connect();
    if (mpConnection == NULL) {
        LOG_CRITICAL("Could not connect to database.");
        throw std::runtime_error("Could not connect to database.");
    }
    LOG_DEBUG0("Connected to world DB.");
}

WorldDBConnection::~WorldDBConnection()
{
    // Currently does nothing.
}

DBConnection WorldDBConnection::GetDatabase()
{
    return mpConnection;
}

std::recursive_mutex* WorldDBConnection::GetMutex()
{
    return &mMutex;
}
