/**
*	@file WorldDBConnection.h
*	Handles connections to world DB servers
*	@author Twilight
*	@copyright 2021, all rights reserved. Licensed under GPLv3
*/

#ifndef FFXI_COMMON_WORLDDBCONNECTION_H
#define FFXI_COMMON_WORLDDBCONNECTION_H

#include <stdint.h>
#include "Database.h"

// Easy way to lock the DB mutex
#define LOCK_WORLDDB(x) std::lock_guard<std::recursive_mutex> l_worlddb(*x.GetMutex())
#define LOCK_PWORLDDB(x) std::lock_guard<std::recursive_mutex> l_worlddb(*x->GetMutex())

/**
 *  Represents a connection to the database of a world (map)
 *  server.
 */
class WorldDBConnection
{

public:
    /**
     *  Constructor. Establish a new connection to a world
     *  DB server.
     */
    WorldDBConnection(const char* pszDBServer,
        uint16_t wDBPort,
        const char* pszUsername,
        const char* pszPassword,
        const char* pszDatabase,
        bool bUseSSL=false,
        bool bSSLVerifyPeer=false,
        char* pszSSLCACertFile=NULL,
        char* pszSSLClientCertFile=NULL,
        char* pszSSLClientKeyFile=NULL);

    /**
     *  Destructor. Disconnects from the database.
     */
    ~WorldDBConnection();

    /**
     *  Return the connected DB object.
     */
    DBConnection GetDatabase();

    /**
    *  Gets the world database Mutex object. Lock this before
    *  any database access.
    *  @return Database mutex object.
    */
    std::recursive_mutex* GetMutex();

    /**
    *  Basically same as mysql_real_escape_string but doesn't need
    *  a connection handle, which MariaDB++ doesn't expose.
    *  @param strString string to escape
    *  @return Escaped string
    */
    static inline std::string RealEscapeString(const std::string& strString)
    {
        return Database::RealEscapeString(strString);
    }

private:
    /// MariaDB++ connection handle
    DBConnection mpConnection;
    /// MariaDB++ account handle
    DBAccount mpAccount;
    // Mutex associated with this connection
    std::recursive_mutex mMutex;
};

#endif