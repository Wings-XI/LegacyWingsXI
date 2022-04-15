/**
 *	@file LoginSession.cpp
 *	Login session information and synchronization
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#include "LoginSession.h"
#include "../new-common/Debugging.h"
#include <mariadb++/connection.hpp>
#include "../new-common/Database.h"
#include "LoginGlobalConfig.h"
#include "../new-common/Utilities.h"
#include "WorldManager.h"
#include <string.h>
#include <time.h>
#include <algorithm>
#include <openssl/rand.h>

#define LOCK_SESSION std::lock_guard<std::recursive_mutex> l_session(*GetMutex())

LoginSession::LoginSession(uint32_t dwAccountId, uint32_t dwIpAddr, time_t tmTTL) :
    mdwAccountId(dwAccountId),
    mdwIpAddr(dwIpAddr),
    mbKeyInstalled(false),
    mbIgnoreOnIPLookup(false),
    mbNeverExpires(false),
    mcNumCharacters(0),
    mcNumCharsAllowed(0),
    mbCharListLoaded(false),
    mbCharListLoadedOnce(false),
    mdwExpansionsBitmask(0),
    mdwFeaturesBitmask(0),
    mRequestToData(DATA_SERVER_IDLE),
    mRequestToView(VIEW_SERVER_IDLE),
    mbDataServerFinished(false),
    mbViewServerFinished(false),
    mcMQMessageOriginatingWorld(0),
    mdwReservedCharID(0),
    mcReservedCharWorld(0),
    tmLastLookup(0)
{
    LOG_DEBUG0("Called.");
    memset(mbufInitialKey, 0, sizeof(mbufInitialKey));
    mtmExpires = time(NULL) + tmTTL;
    memset(mCharacters, 0, sizeof(mCharacters));
    RAND_bytes(mbufAuthToken, sizeof(mbufAuthToken));
}

LoginSession::~LoginSession()
{
    LOG_DEBUG0("Called.");
}

std::recursive_mutex* LoginSession::GetMutex()
{
    LOG_DEBUG0("Called.");
    return &mMutex;
}

uint32_t LoginSession::GetAccountID() const
{
    return mdwAccountId;
}

const uint8_t* LoginSession::GetAuthToken() const
{
    return mbufAuthToken;
}

uint32_t LoginSession::GetClientIPAddress() const
{
    return mdwIpAddr;
}

bool LoginSession::IsKeyInstalled() const
{
    return mbKeyInstalled;
}

const uint8_t* LoginSession::GetKey() const
{
    if (mbKeyInstalled == false) {
        LOG_ERROR("Attempted to get the session key before setting it.");
        throw std::runtime_error("Session key not installed.");
    }
    return mbufInitialKey;
}

time_t LoginSession::GetExpiryTime() const
{
    return mtmExpires;
}

bool LoginSession::HasExpired() const
{
    return ((!mbNeverExpires) && (mtmExpires <= time(NULL)));
}

void LoginSession::SetNeverExpire(bool bNeverExpires)
{
    mbNeverExpires = bNeverExpires;
}

bool LoginSession::GetIgnoreIPLookupFlag() const
{
    return mbIgnoreOnIPLookup;
}

uint8_t LoginSession::GetNumCharacters() const
{
    if (!mbCharListLoaded) {
        LOG_ERROR("Attempted to access character data before loading from DB.");
        throw std::runtime_error("Character data not available");
    }
    return mcNumCharacters;
}

uint8_t LoginSession::GetNumCharsAllowed() const
{
    if (!mbCharListLoaded) {
        LOG_ERROR("Attempted to access character data before loading from DB.");
        throw std::runtime_error("Character data not available");
    }
    return mcNumCharsAllowed;
}

CHARACTER_ENTRY* LoginSession::GetCharacter(uint8_t cOffset)
{
    if (!mbCharListLoaded) {
        LOG_ERROR("Attempted to access character data before loading from DB.");
        throw std::runtime_error("Character data not available");
    }
    return mCharacters + cOffset;
}

std::string LoginSession::GetClientVersion() const
{
    return mstrClientVersion;
}

void LoginSession::SetKey(const uint8_t* bufKey)
{
    memcpy(mbufInitialKey, bufKey, sizeof(mbufInitialKey));
    mbKeyInstalled = true;
}

void LoginSession::SetExpiryTimeAbsolute(time_t tmNewTime)
{
    mtmExpires = tmNewTime;
}

void LoginSession::SetExpiryTimeRelative(time_t tmNewTTL, bool bAllowDecrease)
{
    time_t tmNewExpiry = time(NULL) + tmNewTTL;
    if ((bAllowDecrease) || (tmNewExpiry > mtmExpires)) {
        mtmExpires = tmNewExpiry;
    }
}

void LoginSession::SetIgnoreIPLookupFlag(bool bNewFlag)
{
    mbIgnoreOnIPLookup = bNewFlag;
}

uint32_t LoginSession::GetExpansionsBitmask() const
{
    return mdwExpansionsBitmask;
}

uint32_t LoginSession::GetFeaturesBitmask() const
{
    return mdwFeaturesBitmask;
}

uint32_t LoginSession::GetPrivilegesBitmask() const
{
    return mdwPrivilegesBitmask;
}

void LoginSession::SetExpansionsBitmask(uint32_t dwExpansions)
{
    mdwExpansionsBitmask = dwExpansions;
}

void LoginSession::SetFeaturesBitmask(uint32_t dwFeatures)
{
    mdwFeaturesBitmask = dwFeatures;
}

void LoginSession::SetPrivilegesBitmask(uint32_t dwPrivileges)
{
    mdwPrivilegesBitmask = dwPrivileges;
}

void LoginSession::SetClientVersion(std::string& strClientVersion)
{
    mstrClientVersion = strClientVersion;
}

void LoginSession::LoadCharacterList()
{
    LOG_DEBUG0("Called.");
    if (mbCharListLoaded) {
        LOG_DEBUG1("Character list already loaded, will not load again.");
        return;
    }
    LOCK_SESSION;
    DBConnection DB = Database::GetDatabase();
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    std::string strSqlQueryFmt;
    std::string strSqlFinalQuery;
    mariadb::result_set_ref pResultSet;

    {
        LOCK_DB;

        // First, query all content ids, which should be in the table even if not
        // yet associated with a character.
        strSqlQueryFmt = "SELECT %scontents.content_id, enabled, character_id FROM %scontents LEFT JOIN %schars ON %scontents.content_id = %schars.content_id WHERE account_id=%d AND world_id <> 101 ORDER BY content_id LIMIT 16;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            mdwAccountId);
        pResultSet = DB->query(strSqlFinalQuery);
        mcNumCharsAllowed = static_cast<uint8_t>(pResultSet->row_count());
        if (mcNumCharsAllowed == 0) {
            LOG_ERROR("No Content IDs associated with the given account");
            mbCharListLoaded = true;
            return;
        }
    }
    memset(&mCharacters, 0, sizeof(mCharacters));
    uint32_t i = 0;
    std::vector<uint32_t> contentIds;
    std::vector<uint32_t> usedContentIds;
    std::vector<uint32_t> freeContentIds;
    std::string contentIdsStr = "(";
    char szThisContentId[16] = { 0 };
    bool firstCid = true;
    while (pResultSet->next()) {
        if (i >= 16) {
            LOG_WARNING("Too many content IDs associated with the account, ignoring extra content ids!");
            break;
        }
        mCharacters[i].dwContentID = pResultSet->get_unsigned32(0);
        mCharacters[i].bEnabled = pResultSet->get_boolean(1);
        // This tells the client that this content ID is not associated with a character
        // (if it is, it will be overwritten very soon).
        mCharacters[i].szCharName[0] = ' ';
        uint32_t ulThisContentId = pResultSet->get_unsigned32(0);
        contentIds.push_back(ulThisContentId);
        if (pResultSet->get_is_null(2)) {
            freeContentIds.push_back(ulThisContentId);
        }
        else {
            usedContentIds.push_back(ulThisContentId);
        }
        if (!firstCid) {
            contentIdsStr += ", ";
        }
        snprintf(szThisContentId, sizeof(szThisContentId) - 1, "%u", ulThisContentId);
        contentIdsStr += szThisContentId;
        firstCid = false;
        i++;
    }
    contentIdsStr += ")";
    if (!mbCharListLoadedOnce) {
        mvecUsedContentIDsConnect = usedContentIds;
        mbCharListLoadedOnce = true;
    }
    // Iterate connected worlds and update character data from the world DB
    WorldManager::WorldList* worlds = WorldManager::GetInstance()->GetWorldList();
    for (WorldManager::WorldList::iterator it = worlds->begin(); it != worlds->end(); it++) {
        std::string strDBPrefix = it->second.szDBPrefix;
        std::string strWorldSqlFmt = "SELECT chars.charid, content_id, accid, charname, nation, pos_zone, "
            "mjob, sjob, mlvl, slvl, race, face, size, head, body, hands, legs, feet, main, sub, goldworldpass "
            "FROM %schars, %schar_stats, %schar_look "
            "WHERE %schars.charid = %schar_stats.charid AND %schars.charid = %schar_look.charid "
            "AND content_id IN %s;";
        std::string strWorldSqlFinalQuery = FormatString(&strWorldSqlFmt,
            Database::RealEscapeString(strDBPrefix).c_str(),
            Database::RealEscapeString(strDBPrefix).c_str(),
            Database::RealEscapeString(strDBPrefix).c_str(),
            Database::RealEscapeString(strDBPrefix).c_str(),
            Database::RealEscapeString(strDBPrefix).c_str(),
            Database::RealEscapeString(strDBPrefix).c_str(),
            Database::RealEscapeString(strDBPrefix).c_str(),
            contentIdsStr.c_str());
        LOCK_DB;
        LOCK_PWORLDDB(it->second.pWorldDBConnection);
        mariadb::result_set_ref pWorldResultSet = it->second.pWorldDBConnection->GetDatabase()->query(strWorldSqlFinalQuery);
        while (pWorldResultSet->next()) {
            // Update out local cache
            uint32_t dwThisContentId = pWorldResultSet->get_unsigned32(1);
            if (std::find(usedContentIds.begin(), usedContentIds.end(), dwThisContentId) != usedContentIds.end()) {
                LOG_DEBUG0("Content ID already in local cache, updating: %u", dwThisContentId);
                strSqlQueryFmt = "UPDATE %schars SET character_id=%u, name='%s', goldworldpass='%s', "
                    "main_job=%u, main_job_lv=%u, zone=%u, race=%u, face=%u, head=%u, body=%u, hands=%u, "
                    "legs=%u, feet=%u, main=%u, sub=%u, size=%u, nation=%u "
                    "WHERE content_id = %u;";
                strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                    Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
                    pWorldResultSet->get_unsigned32(0),
                    Database::RealEscapeString(pWorldResultSet->get_string(3)).c_str(),
                    Database::RealEscapeString(pWorldResultSet->get_string(20)).c_str(),
                    pWorldResultSet->get_unsigned8(6),
                    pWorldResultSet->get_unsigned8(8),
                    pWorldResultSet->get_unsigned16(5),
                    pWorldResultSet->get_unsigned8(10),
                    pWorldResultSet->get_unsigned8(11),
                    pWorldResultSet->get_unsigned16(13),
                    pWorldResultSet->get_unsigned16(14),
                    pWorldResultSet->get_unsigned16(15),
                    pWorldResultSet->get_unsigned16(16),
                    pWorldResultSet->get_unsigned16(17),
                    pWorldResultSet->get_unsigned16(18),
                    pWorldResultSet->get_unsigned16(19),
                    pWorldResultSet->get_unsigned8(12),
                    pWorldResultSet->get_unsigned8(4),
                    pWorldResultSet->get_unsigned32(1));
            }
            else {
                // Resync missing row to remote
                LOG_DEBUG0("Content ID does not exist in local cache, adding: %u", dwThisContentId);
                strSqlQueryFmt = "INSERT INTO %schars (content_id, character_id, name, world_id, goldworldpass, main_job, main_job_lv, " \
                    "zone, race, face, hair, head, body, hands, legs, feet, main, sub, size, nation) VALUES " \
                    "(%u, %u, '%s', %u, '%s', %u, %u, %u, %u, %u, 0, %u, %u, %u, %u, %u, %u, %u, %u, %u);";
                strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                    Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
                    dwThisContentId,
                    pWorldResultSet->get_unsigned32(0),
                    Database::RealEscapeString(pWorldResultSet->get_string(3)).c_str(),
                    it->second.dwWorldId,
                    Database::RealEscapeString(pWorldResultSet->get_string(20)).c_str(),
                    pWorldResultSet->get_unsigned8(6),
                    pWorldResultSet->get_unsigned8(8),
                    pWorldResultSet->get_unsigned16(5),
                    pWorldResultSet->get_unsigned8(10),
                    pWorldResultSet->get_unsigned8(11),
                    pWorldResultSet->get_unsigned16(13),
                    pWorldResultSet->get_unsigned16(14),
                    pWorldResultSet->get_unsigned16(15),
                    pWorldResultSet->get_unsigned16(16),
                    pWorldResultSet->get_unsigned16(17),
                    pWorldResultSet->get_unsigned16(18),
                    pWorldResultSet->get_unsigned16(19),
                    pWorldResultSet->get_unsigned8(12),
                    pWorldResultSet->get_unsigned8(4),
                    pWorldResultSet->get_unsigned32(1));
            }
            //LOG_DEBUG0("SQL: %s", strSqlFinalQuery.c_str());
            //LOCK_DB;
            DB->execute(strSqlFinalQuery);
        }
    }
    LOCK_DB;
    DB->execute("COMMIT");
    // It's now time to get the actual list of characters
    strSqlQueryFmt = "SELECT content_id, character_id, name, world_id, main_job, main_job_lv, "
        "zone, race, face, hair, head, body, hands, legs, feet, main, sub, size, nation, goldworldpass "
        "FROM %schars WHERE content_id IN %s ORDER BY content_id;";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        contentIdsStr.c_str());
    pResultSet = DB->query(strSqlFinalQuery);
    i = 0;
    uint32_t dwCurrentContentID = 0;
    uint32_t j = 0;
    while (pResultSet->next()) {
        dwCurrentContentID = pResultSet->get_unsigned32(0);
        // The character's position in the list must match the content id which is already set-up
        // so we'll need to search for it.
        for (j = 0; j < mcNumCharsAllowed; j++) {
            if (mCharacters[j].dwContentID == dwCurrentContentID) {
                break;
            }
        }
        if (j >= mcNumCharsAllowed) {
            LOG_WARNING("Account has a character without a valid matching content ID, this character will be skipped.");
            continue;
        }
        mCharacters[j].dwCharacterID = pResultSet->get_unsigned32(1);
        strncpy(mCharacters[j].szCharName, pResultSet->get_string(2).c_str(), sizeof(mCharacters[i].szCharName));
        mCharacters[j].cWorldID = static_cast<uint8_t>(pResultSet->get_unsigned32(3));
        mCharacters[j].cMainJob = static_cast<uint8_t>(pResultSet->get_unsigned32(4));
        mCharacters[j].cMainJobLevel = static_cast<uint8_t>(pResultSet->get_unsigned32(5));
        mCharacters[j].wZone = static_cast<uint16_t>(pResultSet->get_unsigned32(6));
        mCharacters[j].cRace = static_cast<uint8_t>(pResultSet->get_unsigned32(7));
        mCharacters[j].cFace = static_cast<uint8_t>(pResultSet->get_unsigned32(8));
        mCharacters[j].cHair = static_cast<uint8_t>(pResultSet->get_unsigned32(9));
        mCharacters[j].wHead = static_cast<uint16_t>(pResultSet->get_unsigned32(10));
        mCharacters[j].wBody = static_cast<uint16_t>(pResultSet->get_unsigned32(11));
        mCharacters[j].wHands = static_cast<uint16_t>(pResultSet->get_unsigned32(12));
        mCharacters[j].wLegs = static_cast<uint16_t>(pResultSet->get_unsigned32(13));
        mCharacters[j].wFeet = static_cast<uint16_t>(pResultSet->get_unsigned32(14));
        mCharacters[j].wMain = static_cast<uint16_t>(pResultSet->get_unsigned32(15));
        mCharacters[j].wSub = static_cast<uint16_t>(pResultSet->get_unsigned32(16));
        mCharacters[j].cSize = static_cast<uint8_t>(pResultSet->get_unsigned32(17));
        mCharacters[j].cNation = static_cast<uint8_t>(pResultSet->get_unsigned32(18));
        strncpy(mCharacters[j].szGoldWorldPass, pResultSet->get_string(19).c_str(), sizeof(mCharacters[i].szCharName));
        i++;
        if (i > mcNumCharsAllowed) {
            // Safeguard just in case the DB has more chars than allowed
            break;
        }
        mcNumCharacters++;
    }
    mbCharListLoaded = true;
    LOG_DEBUG1("Character list loaded.");
}

void LoginSession::InvalidateCharacterList()
{
    mbCharListLoaded = false;
}

void LoginSession::SendRequestToDataServer(REQUESTS_TO_DATA_SERVER State)
{
    mRequestToData = State;
}

void LoginSession::SendRequestToViewServer(REQUESTS_TO_VIEW_SERVER State)
{
    mRequestToView = State;
}

LoginSession::REQUESTS_TO_VIEW_SERVER LoginSession::GetRequestFromDataServer()
{
    return mRequestToView;
}

LoginSession::REQUESTS_TO_DATA_SERVER LoginSession::GetRequestFromViewServer()
{
    return mRequestToData;
}

bool LoginSession::IsDataServerFinished() const
{
    return mbDataServerFinished;
}

bool LoginSession::IsViewServerFinished() const
{
    return mbViewServerFinished;
}

void LoginSession::SetDataServerFinished(bool bFinished)
{
    mbDataServerFinished = bFinished;
}

void LoginSession::SetViewServerFinished(bool bFinished)
{
    mbViewServerFinished = bFinished;
}

std::shared_ptr<uint8_t> LoginSession::GetMessageFromMQ(uint8_t* pSendingWorld)
{
    std::shared_ptr<uint8_t> pMessage(mpMessageFromMQ);
    if (pSendingWorld) {
        *pSendingWorld = mcMQMessageOriginatingWorld;
    }
    mpMessageFromMQ = NULL;
    return pMessage;
}

void LoginSession::SendMQMessageToViewServer(std::shared_ptr<uint8_t> pMQMessage, uint8_t cSendingWorld)
{
    LOCK_SESSION;
    if (mpMessageFromMQ != NULL) {
        LOG_ERROR("Message sent to session before the previous was read.");
        throw std::runtime_error("Message sent too quickly.");
    }
    mpMessageFromMQ = pMQMessage;
    mcMQMessageOriginatingWorld = cSendingWorld;
}

bool LoginSession::IsCharacterAssociatedWithSession(uint32_t dwCharacterID, uint8_t cWorldID)
{
    uint8_t i = 0;

    LOCK_SESSION;
    for (i = 0; i < mcNumCharsAllowed; i++) {
        if ((mCharacters[i].dwCharacterID == dwCharacterID) && (mCharacters[i].cWorldID == cWorldID)) {
            return true;
        }
    }
    return false;
}

bool LoginSession::IsContentIDAssociatedWithSession(uint32_t dwContentID)
{
    uint8_t i = 0;

    LOCK_SESSION;
    for (i = 0; i < mcNumCharsAllowed; i++) {
        if (mCharacters[i].dwContentID == dwContentID) {
            return true;
        }
    }
    return false;
}

CHARACTER_ENTRY* LoginSession::GetCharacterByContentID(uint32_t dwContentID)
{
    if (!mbCharListLoaded) {
        LOG_ERROR("Attempted to access character data before loading from DB.");
        throw std::runtime_error("Character data not available");
    }
    for (uint8_t i = 0; i < mcNumCharsAllowed; i++) {
        if (mCharacters[i].dwContentID == dwContentID) {
            return &mCharacters[i];
        }
    }
    LOG_ERROR("Content ID did not match any character.");
    throw std::runtime_error("No character matched content ID.");
}

uint32_t LoginSession::GetReservedCharID(uint8_t cWorldID)
{
    if (mcReservedCharWorld != cWorldID) {
        return 0;
    }
    return mdwReservedCharID;
}

void LoginSession::UnreserveCharacter()
{
    mdwReservedCharID = 0;
    mcReservedCharWorld = 0;
}

uint32_t LoginSession::GenerateNewCharID(uint8_t cWorldID)
{
    if ((mdwReservedCharID != 0) != (mcReservedCharWorld)) {
        // Should never happen
        LOG_ERROR("Character ID already reserved for this session: %d.", mdwReservedCharID);
        throw std::runtime_error("Character ID already reserved.");
    }
    // LOCK_WORLDMGR;
    LOCK_DB;
    uint32_t dwNewCharID = WorldManager::GetInstance()->GetNewCharIDForWorld(cWorldID);
    mdwReservedCharID = dwNewCharID;
    mcReservedCharWorld = cWorldID;
    return mdwReservedCharID;
}

time_t LoginSession::GetLastLookupTime() const
{
    return tmLastLookup;
}

time_t LoginSession::GetLastPacketTime() const
{
    return tmLastPacket;
}

void LoginSession::SetLastLookupNow()
{
    tmLastLookup = time(NULL);
}

void LoginSession::SetLastPacketNow()
{
    tmLastPacket = time(NULL);
}

const std::vector<uint32_t>* LoginSession::GetUsedContentIDsConnect() const
{
    return &mvecUsedContentIDsConnect;
}
