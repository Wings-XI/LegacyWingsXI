/**
 *	@file WorldManager.cpp
 *	Manages world list and MQ connections to world servers
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "WorldManager.h"
#include "../new-common/Debugging.h"
#include <mariadb++/connection.hpp>
#include "../new-common/Database.h"
#include "LoginGlobalConfig.h"
#include "../new-common/Utilities.h"
#include "../new-common/CommonMessages.h"
#include "SessionTracker.h"
#include <utility>

WorldManagerPtr WorldManager::smpSingletonObj = NULL;
bool WorldManager::sbBeingDestroyed = false;

WorldManager::WorldManager() : mbWorldListLoaded(false)
{
    LOG_DEBUG0("Called.");
    mCharHandler = std::shared_ptr<CharMessageHnd>(new CharMessageHnd());
}

WorldManager::~WorldManager()
{
    if (sbBeingDestroyed == false) {
        Destroy();
    }
}

WorldManagerPtr WorldManager::GetInstance()
{
    if (smpSingletonObj == NULL) {
        smpSingletonObj = new WorldManager();
    }
    return smpSingletonObj;
}


std::recursive_mutex* WorldManager::GetMutex()
{
    LOG_DEBUG0("Called.");
    if (smpSingletonObj == NULL) {
        LOG_CRITICAL("Attempted to access config before initialzing.");
        throw std::runtime_error("Config not initialized.");
    }
    return &smpSingletonObj->mMutex;
}

void WorldManager::Destroy()
{
    LOG_DEBUG0("Called.");
    sbBeingDestroyed = true;
    if (smpSingletonObj == NULL) {
        return;
    }
    // Disconnect from all MQ servers
    while (smpSingletonObj->mmapWorldList.size()) {
        std::unordered_map<uint32_t, WORLD_ENTRY>::iterator it = smpSingletonObj->mmapWorldList.begin();
        it->second.pMQConn->Shutdown();
        smpSingletonObj->mmapWorldList.erase(it->first);
    }
    delete smpSingletonObj;
    smpSingletonObj = NULL;
}

WorldManager::WORLD_ENTRY* WorldManager::GetWorldByID(uint32_t dwWorldID)
{
    if (!mbWorldListLoaded) {
        LOG_INFO("World list not loaded yet, trying to load now.");
        LoadWorlds();
    }
    // LOCK_WORLDMGR;
    LOCK_DB;
    auto pWorldEnt = mmapWorldList.find(dwWorldID);
    if (pWorldEnt == mmapWorldList.end()) {
        LOG_ERROR("World ID not found in list.");
        throw std::runtime_error("World ID not found.");
    }
    return &pWorldEnt->second;
}

std::string WorldManager::GetWorldName(uint32_t dwWorldID)
{
    return std::string(GetWorldByID(dwWorldID)->szWorldName);
}

uint32_t WorldManager::GetWorldIDByName(const char* szWorldName)
{
    // Note - Can't use GetWorldByID here because we're looking
    // by name instead.
    if (!mbWorldListLoaded) {
        LOG_INFO("World list not loaded yet, trying to load now.");
        LoadWorlds();
    }
    // LOCK_WORLDMGR;
    LOCK_DB;
    for (auto it = mmapWorldList.begin(); it != mmapWorldList.end(); it++) {
        if (strcmp(it->second.szWorldName, szWorldName) == 0) {
            return it->first;
        }
    }
    LOG_ERROR("World name did not match any known world.");
    throw std::runtime_error("World name not found.");
}

bool WorldManager::IsTestWorld(uint32_t dwWorldID)
{
    return GetWorldByID(dwWorldID)->bIsTestWorld;
}

bool WorldManager::HasFriendList(uint32_t dwWorldID)
{
    return GetWorldByID(dwWorldID)->bHasFlist;
}

std::shared_ptr<uint8_t> WorldManager::GetAdminWorldsPacket()
{
    if (!mbWorldListLoaded) {
        LOG_INFO("World list not loaded yet, trying to load now.");
        LoadWorlds();
    }
    // LOCK_WORLDMGR;
    return mbufWorldsPacketAdmin;
}

uint32_t WorldManager::GetAdminWorldsPacketSize()
{
    if (!mbWorldListLoaded) {
        LOG_INFO("World list not loaded yet, trying to load now.");
        LoadWorlds();
    }
    // LOCK_WORLDMGR;
    return mdwWorldsPacketAdminSize;
}

std::shared_ptr<uint8_t> WorldManager::GetUserWorldsPacket()
{
    if (!mbWorldListLoaded) {
        LOG_INFO("World list not loaded yet, trying to load now.");
        LoadWorlds();
    }
    // LOCK_WORLDMGR;
    return mbufWorldsPacketUser;
}

uint32_t WorldManager::GetUserWorldsPacketSize()
{
    if (!mbWorldListLoaded) {
        LOG_INFO("World list not loaded yet, trying to load now.");
        LoadWorlds();
    }
    // LOCK_WORLDMGR;
    return mdwWorldsPacketUserSize;
}

void WorldManager::LoadWorlds()
{
    LOG_DEBUG0("Called.");
    if (mbWorldListLoaded) {
        LOG_DEBUG1("World list already loaded, not loading again.");
        return;
    }

    // LOCK_WORLDMGR;

    DBConnection DB = Database::GetDatabase();
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    LOCK_DB;

    std::string strSqlQueryFmt("SELECT id, name, db_server_ip, db_server_port, "
        "db_use_ssl, db_ssl_verify_cert, db_ssl_ca_cert, db_ssl_client_cert, "
        "db_ssl_client_key, db_username, db_password, db_database, db_prefix, "
        "mq_server_ip, mq_server_port, mq_use_ssl, mq_ssl_verify_cert, mq_ssl_ca_cert, "
        "mq_ssl_client_cert, mq_ssl_client_key, mq_username, mq_password, "
        "mq_vhost, search_ip, search_port, has_flist, is_test FROM %sworlds WHERE is_active=1;");
    std::string strSqlFinalQuery(FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str()));
    mariadb::result_set_ref pResultSet = DB->query(strSqlFinalQuery);
    uint32_t dwNumWorlds = static_cast<uint32_t>(pResultSet->row_count());
    if (dwNumWorlds == 0) {
        LOG_CRITICAL("Failed to query the world list.");
        throw std::runtime_error("world list query failed.");
    }
    WORLD_ENTRY NewWorld = { 0 };
    // Build the world packets as well, since they are static we might as well do it only once
    // Note that packet size is dynamic (according to the number of worlds). The world list packet
    // consists of one unknown 4 byte header and then world list (4 byte world id, 15 byte world
    // name and 1 byte null terminator).
    mbufWorldsPacketAdmin = std::shared_ptr<uint8_t>(new uint8_t[sizeof(WORLD_PACKET_ENTRY) * dwNumWorlds + 4]);
    *reinterpret_cast<uint32_t*>(mbufWorldsPacketAdmin.get()) = 0x20;
    WORLD_PACKET_ENTRY* pWorldsAdmin = reinterpret_cast<WORLD_PACKET_ENTRY*>((mbufWorldsPacketAdmin.get()) + 4);
    mdwWorldsPacketAdminSize = 4;
    // We don't know what will be the final size of this but it's guaranteed not to be longer
    // than the admin packet.
    mbufWorldsPacketUser = std::shared_ptr<uint8_t>(new uint8_t[sizeof(WORLD_PACKET_ENTRY) * dwNumWorlds + 4]);
    *reinterpret_cast<uint32_t*>(mbufWorldsPacketUser.get()) = 0x20;
    WORLD_PACKET_ENTRY* pWorldsUser = reinterpret_cast<WORLD_PACKET_ENTRY*>(mbufWorldsPacketUser.get() + 4);
    mdwWorldsPacketUserSize = 4;
    uint32_t dwAdminWorlds = 0;
    uint32_t dwUserWorlds = 0;
    while (pResultSet->next()) {
        memset(&NewWorld, 0, sizeof(NewWorld));
        NewWorld.dwWorldId = pResultSet->get_unsigned32(0);
        strncpy(NewWorld.szWorldName, pResultSet->get_string(1).c_str(), sizeof(NewWorld.szWorldName) - 1);
        strncpy(NewWorld.szDBIP, pResultSet->get_string(2).c_str(), sizeof(NewWorld.szDBIP) - 1);
        NewWorld.wDBPort = static_cast<uint16_t>(pResultSet->get_unsigned32(3));
        NewWorld.bDBUseSSL = pResultSet->get_boolean(4);
        NewWorld.bDBSSLVerifyCA = pResultSet->get_boolean(5);
        strncpy(NewWorld.szDBCACertFile, pResultSet->get_string(6).c_str(), sizeof(NewWorld.szDBUsername) - 1);
        strncpy(NewWorld.szDBClientCertFile, pResultSet->get_string(7).c_str(), sizeof(NewWorld.szDBUsername) - 1);
        strncpy(NewWorld.szDBClientKeyFile, pResultSet->get_string(8).c_str(), sizeof(NewWorld.szDBUsername) - 1);
        strncpy(NewWorld.szDBUsername, pResultSet->get_string(9).c_str(), sizeof(NewWorld.szDBUsername) - 1);
        strncpy(NewWorld.szDBPassword, pResultSet->get_string(10).c_str(), sizeof(NewWorld.szDBPassword) - 1);
        strncpy(NewWorld.szDBDatabase, pResultSet->get_string(11).c_str(), sizeof(NewWorld.szDBDatabase) - 1);
        strncpy(NewWorld.szDBPrefix, pResultSet->get_string(12).c_str(), sizeof(NewWorld.szDBPrefix) - 1);
        strncpy(NewWorld.szMQIP, pResultSet->get_string(13).c_str(), sizeof(NewWorld.szMQIP) - 1);
        NewWorld.wMQPort = static_cast<uint16_t>(pResultSet->get_unsigned32(14));
        NewWorld.bMQUseSSL = pResultSet->get_boolean(15);
        NewWorld.bMQSSLVerifyCA = pResultSet->get_boolean(16);
        // 100KB for certs is way more than enough
        strncpy(NewWorld.szMQCACertFile, pResultSet->get_string(17).c_str(), sizeof(NewWorld.szMQCACertFile) - 1);
        strncpy(NewWorld.szMQClientCertFile, pResultSet->get_string(18).c_str(), sizeof(NewWorld.szMQClientCertFile) - 1);
        strncpy(NewWorld.szMQClientKeyFile, pResultSet->get_string(19).c_str(), sizeof(NewWorld.szMQClientKeyFile) - 1);
        strncpy(NewWorld.szMQUsername, pResultSet->get_string(20).c_str(), sizeof(NewWorld.szMQUsername) - 1);
        strncpy(NewWorld.szMQPassword, pResultSet->get_string(21).c_str(), sizeof(NewWorld.szMQPassword) - 1);
        strncpy(NewWorld.szMQVhost, pResultSet->get_string(22).c_str(), sizeof(NewWorld.szMQVhost) - 1);
        strncpy(NewWorld.szSearchIP, pResultSet->get_string(23).c_str(), sizeof(NewWorld.szSearchIP) - 1);
        NewWorld.wSearchPort = static_cast<uint16_t>(pResultSet->get_unsigned32(24));
        NewWorld.bHasFlist = pResultSet->get_boolean(25);
        NewWorld.bIsTestWorld = pResultSet->get_boolean(26);
        // Attempt to connect to the World database
        try {
            NewWorld.pWorldDBConnection = std::shared_ptr<WorldDBConnection>(new WorldDBConnection(
                NewWorld.szDBIP,
                NewWorld.wDBPort,
                NewWorld.szDBUsername,
                NewWorld.szDBPassword,
                NewWorld.szDBDatabase,
                NewWorld.bDBUseSSL,
                NewWorld.bDBSSLVerifyCA,
                NewWorld.szDBCACertFile,
                NewWorld.szDBClientCertFile,
                NewWorld.szDBClientKeyFile
            ));
        }
        catch (std::exception&) {
            LOG_ERROR("Connection to world DB failed, this world will be disabled.");
            continue;
        }
        // Attempt to connect to MQ server
        try {
            NewWorld.pMQConn = std::shared_ptr<MQConnection>(new MQConnection(NewWorld.dwWorldId,
                std::string(NewWorld.szMQIP),
                NewWorld.wMQPort,
                std::string(NewWorld.szMQUsername),
                std::string(NewWorld.szMQPassword),
                std::string(NewWorld.szMQVhost),
                1,
                std::string("amq.fanout"),
                std::string(LOGIN_MQ_NAME),
                std::string(LOGIN_MQ_NAME),
                NewWorld.bMQUseSSL,
                NewWorld.bMQSSLVerifyCA,
                std::string(NewWorld.szMQCACertFile),
                std::string(NewWorld.szMQClientCertFile),
                std::string(NewWorld.szMQClientKeyFile)));
        }
        catch (std::exception&) {
            LOG_ERROR("Connection to world MQ failed, this world will be disabled.");
            continue;
        }
        NewWorld.pMQConn->AssignHandler(1, mCharHandler);
        NewWorld.pMQConn->StartThread();
        mmapWorldList[NewWorld.dwWorldId] = NewWorld;
        // Add to packets
        memset(pWorldsAdmin + dwAdminWorlds, 0, sizeof(WORLD_PACKET_ENTRY));
        pWorldsAdmin[dwAdminWorlds].dwWorldID = NewWorld.dwWorldId;
        strncpy(pWorldsAdmin[dwAdminWorlds].szWorldName, NewWorld.szWorldName, sizeof(pWorldsAdmin[dwAdminWorlds].szWorldName) - 1);
        mdwWorldsPacketAdminSize += sizeof(WORLD_PACKET_ENTRY);
        dwAdminWorlds += 1;
        if (!NewWorld.bIsTestWorld) {
            // Not a test world so add to user packet as well
            memset(pWorldsUser + dwUserWorlds, 0, sizeof(WORLD_PACKET_ENTRY));
            pWorldsUser[dwUserWorlds].dwWorldID = NewWorld.dwWorldId;
            strncpy(pWorldsUser[dwUserWorlds].szWorldName, NewWorld.szWorldName, sizeof(pWorldsUser[dwUserWorlds].szWorldName) - 1);
            mdwWorldsPacketUserSize += sizeof(WORLD_PACKET_ENTRY);
            dwUserWorlds += 1;
        }
    }
    // Make sure we have at least one world that users can connect to
    if ((dwAdminWorlds == 0) || (dwUserWorlds == 0)) {
        LOG_CRITICAL("World list is empty or all worlds marked as test.");
        throw std::runtime_error("No user worlds");
    }
    mbWorldListLoaded = true;
}

void WorldManager::SendMessageToWorld(uint32_t dwWorldID, const uint8_t* bufMessage, uint32_t cbMessage)
{
    if (!mbWorldListLoaded) {
        LOG_INFO("World list not loaded yet, trying to load now.");
        LoadWorlds();
    }
    // LOCK_WORLDMGR;
    LOCK_DB;
    auto WorldEnt = mmapWorldList.find(dwWorldID);
    if (WorldEnt == mmapWorldList.end()) {
        LOG_ERROR("World ID not found in list.");
        throw std::runtime_error("World ID not found.");
    }
    mmapWorldList[dwWorldID].pMQConn->Send(1, bufMessage, cbMessage);
}

std::shared_ptr<WorldDBConnection> WorldManager::GetWorldDBConnection(uint32_t dwWorldID)
{
    return GetWorldByID(dwWorldID)->pWorldDBConnection;
}

const char* WorldManager::GetWorldDBPrefix(uint32_t dwWorldID)
{
    return GetWorldByID(dwWorldID)->szDBPrefix;
}

std::pair<std::string, uint16_t> WorldManager::GetSearchServer(uint32_t dwWorldID)
{
    WORLD_ENTRY* pWorld = GetWorldByID(dwWorldID);
    return std::make_pair(std::string(pWorld->szSearchIP), pWorld->wSearchPort);
}

WorldManager::WorldList* WorldManager::GetWorldList()
{
    if (!mbWorldListLoaded) {
        LoadWorlds();
    }
    return &mmapWorldList;
}

uint32_t WorldManager::GetNewCharIDForWorld(uint32_t dwWorldID)
{
    DBConnection DB = Database::GetDatabase();
    LOCK_DB;
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    // We will need a unique character ID (for the given world), so just pick the existing
    // max charid + 1
    // In case of sync issues we query both the map and the login databases and verify that
    // the character ID does not exist on either one.
    uint32_t dwNewCharIDFromLogin = 0;
    uint32_t dwNewCharIDFromMap = 0;
    uint32_t dwNewCharID = 0;
    std::string strSqlQueryFmt("SELECT MAX(character_id) FROM %schars WHERE world_id=%d;");
    std::string strSqlFinalQuery(FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        dwWorldID));
    mariadb::result_set_ref pResultSet = DB->query(strSqlFinalQuery);
    if (pResultSet->row_count() == 0) {
        // First character being created in this world. Use "1" since we use zero as
        // an indication of an invalid character ID.
        // Note: Seems that on retail the higher word of the char ID is actually the world id,
        // giving some sort of uniqueness, however this does not seem to be technicaly
        // required. Only the content ID needs to be globally unique.
        dwNewCharIDFromLogin = 1;
    }
    else {
        pResultSet->next();
        if (!pResultSet->get_is_null(0)) {
            dwNewCharIDFromLogin = pResultSet->get_unsigned32(0) + 1;
        }
        else {
            dwNewCharIDFromLogin = 1;
        }
    }
    std::shared_ptr<WorldDBConnection> WorldDB = WorldManager::GetInstance()->GetWorldDBConnection(dwWorldID);
    const char* pcszWorldPrefix = WorldManager::GetInstance()->GetWorldDBPrefix(dwWorldID);
    LOCK_PWORLDDB(WorldDB);
    strSqlQueryFmt = "SELECT MAX(charid) FROM %schars";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt, pcszWorldPrefix);
    pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() == 0) {
        dwNewCharIDFromMap = 1;
    }
    else {
        pResultSet->next();
        if (!pResultSet->get_is_null(0)) {
            dwNewCharIDFromMap = pResultSet->get_unsigned32(0) + 1;
        }
        else {
            dwNewCharIDFromMap = 1;
        }
    }
    dwNewCharID = ((dwNewCharIDFromMap > dwNewCharIDFromLogin) ? dwNewCharIDFromMap : dwNewCharIDFromLogin);
    // We now have a candidate ID but we need to make sure it's not reserved in
    // any session.
    std::vector<uint32_t> ReservedCharIDs = SessionTracker::GetInstance()->GetReservedCharIDList(dwWorldID);
    while (std::find(ReservedCharIDs.begin(), ReservedCharIDs.end(), dwNewCharID) != ReservedCharIDs.end()) {
        dwNewCharID++;
    }
    return dwNewCharID;
}