/**
 *	@file WorldManager.h
 *	Manages world list and MQ connections to world servers
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_LOGIN_WORLDMANAGER_H
#define FFXI_LOGIN_WORLDMANAGER_H

#include <stdint.h>
#include <mutex>
#include <unordered_map>
#include <memory>
#include "../new-common/MQConnection.h"
#include "../new-common/WorldDBConnection.h"
#include "CharMessageHnd.h"

// Easy way to lock the config mutex
// Disabled for now due to too many deadlocks. Use LOCK_DB instead.
// #define LOCK_WORLDMGR std::lock_guard<std::recursive_mutex> l_worldmgr(*WorldManager::GetMutex())

class WorldManager;
typedef WorldManager* WorldManagerPtr;

/**
 *  Singleton class for accessing the world manager.
 */
class WorldManager
{
public:

    /**
    *  Single world detail record.
    */
    struct WORLD_ENTRY
    {
        uint32_t dwWorldId;
        char szWorldName[16];
        char szDBIP[40];
        uint16_t wDBPort;
        char szDBUsername[128];
        char szDBPassword[128];
        char szDBDatabase[128];
        char szDBPrefix[128];
        bool bDBUseSSL;
        bool bDBSSLVerifyCA;
        char szDBCACertFile[128];
        char szDBClientCertFile[128];
        char szDBClientKeyFile[128];
        char szMQIP[40];
        uint16_t wMQPort;
        bool bMQUseSSL;
        bool bMQSSLVerifyCA;
        char szMQCACertFile[128];
        char szMQClientCertFile[128];
        char szMQClientKeyFile[128];
        char szMQUsername[128];
        char szMQPassword[128];
        char szMQVhost[128];
        char szSearchIP[40];
        uint16_t wSearchPort;
        bool bHasFlist;
        bool bIsTestWorld;
        std::shared_ptr<MQConnection> pMQConn;
        std::shared_ptr<WorldDBConnection> pWorldDBConnection;
    };

    typedef std::unordered_map<uint32_t, WORLD_ENTRY> WorldList;



    /**
     *  Get the name of a world given its ID
     *  @param dwWorldID World ID to look up
     *  @return World name
     */
    std::string GetWorldName(uint32_t dwWorldID);

    /**
     *  Return the World ID matching a given world name
     *  @param szWorldName World name to look up
     *  @return World ID
     */
    uint32_t GetWorldIDByName(const char* szWorldName);

    /**
     *  Check if a given world is marked as a test world
     *  @param dwWorldID World ID to look up
     *  @return true if world is test, false if not
     */
    bool IsTestWorld(uint32_t dwWorldID);

    /**
     *  Check whether a given world supports a Tonberry-Style
     *  friend list.
     *  @param dwWorldID World ID to look up
     *  @return true if world supports friend list, false if not
     */
    bool HasFriendList(uint32_t dwWorldID);

    /**
     *  Get the public search server details of a given world.
     *  @param dwWorldID World ID to look up
     *  @return A pair containing the world's IP address and port number
     */
    std::pair<std::string, uint16_t> GetSearchServer(uint32_t dwWorldID);

    /**
     *  Send a message to the MQ server of a world given its ID
     *  @param dwWorldID World ID of the target world
     *  @param bufMessage Message to send
     *  @param cbMessage Message size in bytes
     *  @return True if sent successfully, false on failure. Throws only if World ID not found.
     */
    bool SendMessageToWorld(uint32_t dwWorldID, const uint8_t* bufMessage, uint32_t cbMessage);

    /**
     *  Get a world's DB connection object
     *  @param dwWorldID World ID of the target world
     *  @return The world's DB connection
     */
    std::shared_ptr<WorldDBConnection> GetWorldDBConnection(uint32_t dwWorldID);

    /**
     * Get a world's DB table prefix
     * @param dwWorldID World ID of the target world
     * @return DB prefix of the target world
     */
    const char* GetWorldDBPrefix(uint32_t dwWorldID);

    /**
     *  Get a precompiled world list packet for administrators and
     *  testers (which contains worlds marked as test).
     *  @return Precompiled packet excluding FFXI headers
     */
    std::shared_ptr<uint8_t> GetAdminWorldsPacket();

    /**
     *  Get the size of the world list packet for administrators.
     */
    uint32_t GetAdminWorldsPacketSize();

    /**
     *  Get a precompiled world list packet for regular users.
     *  This does not include any worlds marked at test.
     *  @return Precompiled packet excluding FFXI headers
     */
    std::shared_ptr<uint8_t> GetUserWorldsPacket();

    /**
     *  Get the size of the world list packet for users.
     */
    uint32_t GetUserWorldsPacketSize();

    /**
     *  Load the world list from the DB
     */
    void LoadWorlds();

    /**
     *  Get an instance of the object. The object is created
     *  on the first call.
     */
    static WorldManagerPtr GetInstance();

    /**
     *  Gets the global data Mutex object. Lock this before
     *  any database access.
     *  @return Database mutex object.
     */
    static std::recursive_mutex* GetMutex();

    /**
     *  Return the full world list.
     */
    WorldList* GetWorldList();

    /**
     *  Get a new free character ID for a given world
     *  @param dwWorldID World ID to generate a character ID for
     *  @return New character ID
     */
    uint32_t GetNewCharIDForWorld(uint32_t dwWorldID);

    /**
     *  Destroy and remove the current instance. Allows reloading of
     *  the configuration file. Should generally be called only before
     *  the server ends execution.
     */
    static void Destroy();

    /**
     *  Destructor. Generally calling Destroy explicitly is much safer.
     */
    ~WorldManager();

#pragma pack(push, 1)
    /**
     *  World entry as it appears in the FFXI view packet
     */
    struct WORLD_PACKET_ENTRY
    {
        uint32_t dwWorldID;
        char szWorldName[16];
    };
#pragma pack(pop)

private:
    /**
     *  Private constructor
     */
    WorldManager();

    /**
     *  Get a given world object given its ID.
     *  If the list of worlds is not loaded yet, will load it
     *  @param dwWorldID World ID of the world to get
     *  @return World object
     */
    WORLD_ENTRY* GetWorldByID(uint32_t dwWorldID);

    /// World list packet for admins (contains test servers)
    std::shared_ptr<uint8_t> mbufWorldsPacketAdmin;
    /// Size of the admin world list packet
    uint32_t mdwWorldsPacketAdminSize;
    /// World list packet for users (does not contain test servers)
    std::shared_ptr<uint8_t> mbufWorldsPacketUser;
    /// Size of the user world list packet
    uint32_t mdwWorldsPacketUserSize;
    /// List of worlds known to this server
    WorldList mmapWorldList;
    /// Have we already loaded the world list
    bool mbWorldListLoaded = false;
    /// Character handler for dealing with incoming MQ messages
    std::shared_ptr<CharMessageHnd> mCharHandler;

    /// Current singleton object
    static WorldManagerPtr smpSingletonObj;
    /// Current object is already being destroyed
    static bool sbBeingDestroyed;
    /// Config access mutex
    std::recursive_mutex mMutex;
};

#endif
