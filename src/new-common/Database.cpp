/**
 *	@file Database.cpp
 *	Database access and synchronization
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "Database.h"
#include "Debugging.h"
#include <stdexcept>
#include <mariadb++/account.hpp>
#include <mariadb++/connection.hpp>

DatabasePtr Database::smpSingletonObj = NULL;
bool Database::sbBeingDestroyed = false;

DBConnection Database::GetDatabase()
{
    LOG_DEBUG0("Called.");
    if (smpSingletonObj == NULL) {
        LOG_CRITICAL("Attempted to access database before initialzing.");
        throw std::runtime_error("Database not initialized.");
    }
    return smpSingletonObj->mpConnection;
}

std::recursive_mutex* Database::GetMutex()
{
    LOG_DEBUG0("Called.");
    if (smpSingletonObj == NULL) {
        LOG_CRITICAL("Attempted to access database before initialzing.");
        throw std::runtime_error("Database not initialized.");
    }
    return &smpSingletonObj->mMutex;
}

DatabasePtr Database::GetInstance()
{
    LOG_DEBUG0("Called.");
    if (smpSingletonObj == NULL) {
        LOG_CRITICAL("Attempted to access database before initialzing.");
        throw std::runtime_error("Database not initialized.");
    }
    return smpSingletonObj;
}

DatabasePtr Database::Initialize(const char* pszServer,
    uint16_t    wPort,
    const char* pszUsername,
    const char* pszPassword,
    const char* pszDatabase,
    bool bUseSSL,
    bool bSSLVerifyPeer,
    const char* pszSSLCA,
    const char* pszSSLCert,
    const char* pszSSLKey)
{
    LOG_DEBUG0("Called.");
    if (smpSingletonObj != NULL) {
        LOG_CRITICAL("Attempted to initialize the database twice.");
        throw std::runtime_error("Database already initialized.");
    }
    LOG_DEBUG1("Connecting to database.");
    smpSingletonObj = new Database(pszServer,
        wPort,
        pszUsername,
        pszPassword,
        pszDatabase,
        bUseSSL,
        bSSLVerifyPeer,
        pszSSLCA,
        pszSSLCert,
        pszSSLKey);
    LOG_DEBUG1("Successfully connected.");
    return smpSingletonObj;
}

void Database::Destroy()
{
    LOG_DEBUG0("Called.");
    sbBeingDestroyed = true;
    if (smpSingletonObj != NULL) {
        LOG_DEBUG1("Disconnecting from database.");
        delete smpSingletonObj;
    }
}

Database::Database(const char* pszServer,
    uint16_t    wPort,
    const char* pszUsername,
    const char* pszPassword,
    const char* pszDatabase,
    bool bUseSSL,
    bool bSSLVerifyPeer,
    const char* pszSSLCA,
    const char* pszSSLCert,
    const char* pszSSLKey)
{
    LOG_DEBUG0("Called.");
    mpAccount = mariadb::account::create(std::string(pszServer), std::string(pszUsername), std::string(pszPassword), std::string(pszDatabase), wPort);
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
    if ((pszSSLCA) && (pszSSLCA[0] != '\0')) {
        mpAccount->set_connect_option(MYSQL_OPT_SSL_CA, std::string(pszSSLCA));
    }
    if (pszSSLCert && pszSSLCert[0] != '\0' &&
        pszSSLKey && pszSSLKey[0] != '\0') {
        mpAccount->set_connect_option(MYSQL_OPT_SSL_CERT, std::string(pszSSLCert));
        mpAccount->set_connect_option(MYSQL_OPT_SSL_KEY, std::string(pszSSLKey));
    }
    mpConnection = mariadb::connection::create(mpAccount);
    if (mpConnection == NULL) {
        LOG_CRITICAL("Could not connect to database.");
        throw std::runtime_error("Could not connect to database.");
    }
}

Database::~Database()
{
    if (sbBeingDestroyed == false) {
        Destroy();
    }
}

std::string Database::RealEscapeString(const std::string& strString)
{
    LOG_DEBUG0("Called.");
    size_t cchInput = strString.length();
    size_t i = 0;
    const char* pszString = strString.c_str();
    if (cchInput > 1024) {
        // Must be some cap here, the input is untrusted and we don't want
        // to allocate too much memory.
        LOG_ERROR("String to escape is too long.");
        throw std::overflow_error("Input size too large.");
    }
    char* pszResult = new char[cchInput * 2 + 1];
    size_t j = 0;

    for (i = 0; i < cchInput; i++) {
        if ((pszString[i] == '\0') ||
            (pszString[i] == '\\') ||
            (pszString[i] == '\n') ||
            (pszString[i] == '\r') ||
            (pszString[i] == '\'') ||
            (pszString[i] == '\"') ||
            (pszString[i] == 0x1A)) {
            pszResult[j] = '\\';
            j++;
        }
        pszResult[j] = pszString[i];
        j++;
    }
    pszResult[j] = '\0';
    std::string strResult(pszResult);
    delete pszResult;
    return strResult;
}
