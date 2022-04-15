/**
 *	@file ViewHandler.h
 *	Implementation of the view protocol
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include <mariadb++/connection.hpp>
#include "../new-common/Database.h"
#include "../new-common/WorldDBConnection.h"
#include "../new-common/TCPConnection.h"
#include "ViewHandler.h"
#include "../new-common/Debugging.h"
#include "SessionTracker.h"
#include "LoginGlobalConfig.h"
#include "WorldManager.h"
#include "../new-common/Utilities.h"
#include "Authentication.h"
#include <time.h>

// Timeout for key installation (milliseconds)
#define KEY_INSTALLATION_TIMEOUT 10000
// Timeout for character list installation by bootloader
#define CHAR_LIST_INSTALLATION_TIMEOUT 10000
// Timeout for response from world server (seconds)
#define WORLD_SERVER_REPLY_TIMEOUT 10

#define LOCK_SESSION std::lock_guard<std::recursive_mutex> l_session(*mpSession->GetMutex())

ViewHandler::ViewHandler(std::shared_ptr<TCPConnection> connection) : ProtocolHandler(connection),
    mParser(connection),
    mtmOperationTimeout(0)
{
    LOG_DEBUG0("Called.");
}

ViewHandler::~ViewHandler()
{
    LOG_DEBUG0("Called.");
}

void ViewHandler::Run()
{
    LOG_DEBUG0("Called.");
    mbRunning = true;

    // Packet pointers
    std::shared_ptr<uint8_t> pRawData;
    FFXILoginPacket::FFXI_LOGIN_PACKET_HEADER* pPacketHeader = NULL;
    uint8_t* pPayloadData = NULL;
    LoginSession::REQUESTS_TO_VIEW_SERVER RequestFromData = LoginSession::VIEW_SERVER_IDLE;
    std::shared_ptr<uint8_t> pMessageFromMQ;

    try {
        while (mbShutdown == false) {

            // Do we have a packet from the client?
            if (mpConnection->CanRead(200)) {
                try {
                    pRawData = mParser.ReceivePacket();
                }
                catch (std::runtime_error) {
                    LOG_INFO("Connection closed.");
                    break;
                }
                if (mpSession != NULL) {
                    mpSession->SetLastPacketNow();
                }

                pPacketHeader = reinterpret_cast<FFXILoginPacket::FFXI_LOGIN_PACKET_HEADER*>(pRawData.get());
                pPayloadData = pRawData.get() + sizeof(FFXILoginPacket::FFXI_LOGIN_PACKET_HEADER);

                if (mpSession == NULL && pPacketHeader->PacketHeader.dwPacketType != FFXILoginPacket::FFXI_LOGIN_TYPE_GET_FEATURES) {
                    // The FFXI_LOGIN_TYPE_GET_FEATURES packet is always the first
                    // packet the client sends, and also contains any identification
                    // information. If authentication token is enabled, we cannot
                    // tell which user is connecting before this packet is received
                    // so any other request is an error.
                    LOG_ERROR("Client did not send a proper initial packet.");
                    throw std::runtime_error("Invalid initial packet.");
                }
                switch (pPacketHeader->PacketHeader.dwPacketType) {
                case FFXILoginPacket::FFXI_LOGIN_TYPE_GET_FEATURES:
                    if (mpSession == NULL) {
                        if ((!GetSessionFromFirstPacket(pPayloadData)) || (mpSession == NULL)) {
                            throw std::runtime_error("Session lookup failed.");
                        }
                        mpSession->SetLastPacketNow();
                    }
                    CheckVersionAndSendFeatures(pPayloadData);
                    break;
                case FFXILoginPacket::FFXI_LOGIN_TYPE_GET_CHARACTER_LIST:
                    // The loader needs to install the character list through
                    // the data channel before we can send the list in the
                    // view channel.
                    mpSession->SendRequestToDataServer(LoginSession::DATA_SERVER_SEND_CHARACTER_LIST);
                    break;
                case FFXILoginPacket::FFXI_LOGIN_TYPE_GET_WORLD_LIST:
                    SendWorldList();
                    break;
                case FFXILoginPacket::FFXI_LOGIN_TYPE_LOGIN_REQUEST:
                    HandleLoginRequest(reinterpret_cast<LOGIN_REQUEST_PACKET*>(pPayloadData));
                    break;
                case FFXILoginPacket::FFXI_LOGIN_TYPE_CREATE_CHARACTER:
                    PrepareNewCharacter(reinterpret_cast<CREATE_REQUEST_PACKET*>(pPayloadData));
                    break;
                case FFXILoginPacket::FFXI_LOGIN_TYPE_CREATE_CHAR_CONFIRM:
                    ConfirmNewCharacter(reinterpret_cast<CONFIRM_CREATE_REQUEST_PACKET*>(pPayloadData));
                    break;
                case FFXILoginPacket::FFXI_LOGIN_TYPE_DELETE_CHARACTER:
                    DeleteCharacter(reinterpret_cast<DELETE_REQUEST_PACKET*>(pPayloadData));
                    break;
                default:
                    LOG_WARNING("Received an unknown packet type from client, ignoring.");
                }
            }

            if (mpSession != NULL) {
                // Check if the data server wants us to do something
                RequestFromData = mpSession->GetRequestFromDataServer();
                if (RequestFromData != LoginSession::VIEW_SERVER_IDLE) {
                    switch (RequestFromData) {
                    case LoginSession::VIEW_SERVER_SEND_CHARACTER_LIST:
                        // The loader doesn't send any confirmation after it installs the character list
                        // so we'll need to sleep a little to be sure it did its job.
                        std::this_thread::sleep_for(std::chrono::milliseconds(500));
                        SendCharacterList();
                        break;
                    case LoginSession::VIEW_SERVER_PROCEED_LOGIN:
                        HandleLoginRequest(&mLastLoginRequestPacket);
                        break;
                    default:
                        LOG_ERROR("View server in invalid state.");
                        throw std::runtime_error("View server in invalid state.");
                    }
                    mpSession->SendRequestToViewServer(LoginSession::VIEW_SERVER_IDLE);
                }

                // Maybe we have a message waiting from MQ
                // Even though we don't support any incoming messages (for now at least)
                // we still want to clear them from the queue.
                uint8_t cOrigin = 0;
                pMessageFromMQ = mpSession->GetMessageFromMQ(&cOrigin);
                if (pMessageFromMQ != NULL) {
                    LOG_WARNING("Ignoring unknown MQ message.");
                }
            }

            // Maybe we've timed out
            if ((mtmOperationTimeout != 0) && (time(NULL) >= mtmOperationTimeout)) {
                LOG_ERROR("Operation timed out.");
                mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
                throw std::runtime_error("World server response timeout.");
            }
        }
    }
    catch (...) {
        LOG_ERROR("Exception thown by view server, disconnecting client.");
    }

    if (mpSession != NULL) {
        mpSession->SetViewServerFinished();
        if (mpSession->IsDataServerFinished()) {
            mpSession->SetNeverExpire(false);
            mpSession->SetExpiryTimeAbsolute(0);
        }
        else {
            mpSession->SetIgnoreIPLookupFlag(false);
        }
    }
    if (mpConnection != NULL) {
        mpConnection->Close();
    }
}

bool ViewHandler::GetSessionFromFirstPacket(const uint8_t* pRequestPacket)
{
    auto pSessionTracker = SessionTracker::GetInstance();
    bool bUseAuthToken = LoginGlobalConfig::GetInstance()->GetConfigUInt("ip_lookup_identification") ? false : true;
    try {
        if (bUseAuthToken) {
            mpSession = pSessionTracker->LookupSessionByAuth(*(uint32_t*)(pRequestPacket + 24),
                pRequestPacket + 28,
                mpConnection->GetConnectionDetails().BindDetails.sin_addr.s_addr);
        }
        else {
            mpSession = pSessionTracker->LookupSessionByIP(mpConnection->GetConnectionDetails().BindDetails.sin_addr.s_addr);
        }
    }
    catch (...) {
        LOG_WARNING("Unknown user attempted to connect to view port.");
        mpConnection->Close();
        return false;
    }
    if (!mpSession) {
        LOG_ERROR("Session lookup returned a NULL value.");
        mpConnection->Close();
        return false;
    }
    mpSession->SetViewServerFinished(false);
    mpSession->SetNeverExpire(false);
    // Don't catch this session again when performing IP lookups
    mpSession->SetIgnoreIPLookupFlag(true);
    // Add more time to the user, if creating a new character they may stay
    // connected to the view server for a while.
    mpSession->SetExpiryTimeRelative(600);
    LOG_INFO("Account ID connected: %u", mpSession->GetAccountID());
    return true;
}

void ViewHandler::CheckVersionAndSendFeatures(const uint8_t* pRequestPacket)
{
    LOG_DEBUG0("Called.");
    // The packet has a lot of unidentified garbage, the only thing that is of
    // interest to us is the version number, which is at offset 88
    std::string strClientVersion(reinterpret_cast<const char*>(pRequestPacket + 88), 10);
    LOG_DEBUG1("Client version: %s", strClientVersion.c_str());
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    uint32_t dwVersionLock = Config->GetConfigUInt("version_lock");
    std::string strExpectedVersion(Config->GetConfigString("expected_client_version"));
    if ((dwVersionLock == 1) && (strClientVersion != strExpectedVersion)) {
        LOG_WARNING("Received connection from a client with a wrong version.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_VERSION_MISMATCH);
        throw std::runtime_error("Client version mismatch.");
    }
    if (dwVersionLock == 2) {
        // Only the first six digits are of relevance here
        uint32_t dwClientVer = std::stoul(strClientVersion.substr(0, 6));
        uint32_t dwExpectedVer = std::stoul(strExpectedVersion.substr(0, 6));
        if (dwClientVer < dwExpectedVer) {
            LOG_WARNING("Received connection from a client with a version too old.");
            mParser.SendError(FFXILoginPacket::FFXI_ERROR_VERSION_MISMATCH);
            throw std::runtime_error("Client too old.");
        }
    }

    LOG_DEBUG0("Fetching expansion and features.");
    DBConnection DB = Database::GetDatabase();
    LOCK_DB;
    LOCK_SESSION;
    mpSession->SetClientVersion(strClientVersion);
    // Pull features and expansions bitmask from DB
    std::string strSqlQueryFmt("SELECT expansions, features FROM %saccounts WHERE id=%d;");
    std::string strSqlFinalQuery(FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        mpSession->GetAccountID()));
    mariadb::result_set_ref pResultSet = DB->query(strSqlFinalQuery);
    if (pResultSet->row_count() == 0) {
        LOG_ERROR("Query for expansions and features failed.");
        throw std::runtime_error("DB query failed.");
    }
    pResultSet->next();
    VIEW_PACKET_EXPANSION_AND_FEATURES ExpFeatures;
    ExpFeatures.dwExpansions = pResultSet->get_unsigned32(0);
    ExpFeatures.dwFeatures = pResultSet->get_unsigned32(1);
    LOG_DEBUG1("Expansions=0x%04X, Features=0x%04X.", ExpFeatures.dwExpansions, ExpFeatures.dwFeatures);
    // No documentation on what this means
    ExpFeatures.dwUnknown = 0xAD5DE04F;
    // Also save the data to session because we'll need to send it to MQ later on
    mpSession->SetExpansionsBitmask(ExpFeatures.dwExpansions);
    mpSession->SetFeaturesBitmask(ExpFeatures.dwFeatures);
    mParser.SendPacket(FFXILoginPacket::FFXI_LOGIN_TYPE_FEATURES_LIST, reinterpret_cast<uint8_t*>(&ExpFeatures), sizeof(ExpFeatures));
}

void ViewHandler::SendCharacterList()
{
    LOG_DEBUG0("Called.");

    LOCK_SESSION;
    VIEW_PACKET_CHARACTER_LIST CharListPacket = { 0 };
    // Clear any previously reserved but not created characters
    CleanHalfCreatedCharacters();
    // Load character list from DB into session
    mpSession->LoadCharacterList();
    uint8_t cNumCharsAllowed = ffxi_min(mpSession->GetNumCharsAllowed(), 16);
    const CHARACTER_ENTRY* pCurrentChar;
    WorldManagerPtr WorldMgr = WorldManager::GetInstance();

    CharListPacket.dwContentIds = mpSession->GetNumCharsAllowed();
    for (uint8_t i = 0; i < CharListPacket.dwContentIds; i++) {
        pCurrentChar = mpSession->GetCharacter(i);
        CharListPacket.CharList[i].dwContentID = pCurrentChar->dwContentID;
        CharListPacket.CharList[i].dwEnabled = pCurrentChar->bEnabled;
        if (pCurrentChar->szCharName[0] == ' ') {
            // This content ID is not associated with a character so don't do meaningless work
            CharListPacket.CharList[i].szCharacterName[0] = ' ';
            continue;
        }
        CharListPacket.CharList[i].dwCharacterID = pCurrentChar->dwCharacterID;
        strncpy(CharListPacket.CharList[i].szCharacterName, pCurrentChar->szCharName, sizeof(CharListPacket.CharList[i].szCharacterName) - 1);
        strncpy(CharListPacket.CharList[i].szWorldName, WorldMgr->GetWorldName(pCurrentChar->cWorldID).c_str(), sizeof(CharListPacket.CharList[i].szWorldName));
        CharListPacket.CharList[i].Details.cRace = pCurrentChar->cRace;
        CharListPacket.CharList[i].Details.cMainJob = pCurrentChar->cMainJob;
        CharListPacket.CharList[i].Details.cNation = pCurrentChar->cNation;
        CharListPacket.CharList[i].Details.cSize = pCurrentChar->cSize;
        CharListPacket.CharList[i].Details.cFace = pCurrentChar->cFace;
        CharListPacket.CharList[i].Details.cHair = pCurrentChar->cHair;
        CharListPacket.CharList[i].Details.wHead = pCurrentChar->wHead;
        CharListPacket.CharList[i].Details.wBody = pCurrentChar->wBody;
        CharListPacket.CharList[i].Details.wHands = pCurrentChar->wHands;
        CharListPacket.CharList[i].Details.wLegs = pCurrentChar->wLegs;
        CharListPacket.CharList[i].Details.wFeet = pCurrentChar->wFeet;
        CharListPacket.CharList[i].Details.wMain = pCurrentChar->wMain;
        CharListPacket.CharList[i].Details.wSub = pCurrentChar->wSub;
        CharListPacket.CharList[i].Details.cZone1 = static_cast<uint8_t>(pCurrentChar->wZone);
        CharListPacket.CharList[i].Details.cMainJobLevel = pCurrentChar->cMainJobLevel;
        CharListPacket.CharList[i].Details.bufUnknown5[0] = 1;
        CharListPacket.CharList[i].Details.bufUnknown5[1] = 0;
        CharListPacket.CharList[i].Details.bufUnknown5[2] = 2;
        CharListPacket.CharList[i].Details.bufUnknown5[3] = 0;
        CharListPacket.CharList[i].Details.wZone2 = pCurrentChar->wZone;
    }
    LOG_DEBUG1("Sending character list.");
    mParser.SendPacket(FFXILoginPacket::FFXI_LOGIN_TYPE_CHARACTER_LIST, reinterpret_cast<uint8_t*>(&CharListPacket), sizeof(CharListPacket));
    LOG_DEBUG1("Character list sent.");
}

void ViewHandler::SendWorldList()
{
    LOG_DEBUG0("Called.");
    WorldManagerPtr WorldMgr = WorldManager::GetInstance();

    std::shared_ptr<uint8_t> pWorldListPacket;
    uint32_t dwWorldListPacketSize = 0;

    if ((mpSession->GetPrivilegesBitmask() & Authentication::ACCT_PRIV_HAS_TEST_ACCESS) != 0) {
        // User has test server access so they get the admin packet
        LOG_DEBUG1("User has test server access.");
        pWorldListPacket = WorldMgr->GetAdminWorldsPacket();
        dwWorldListPacketSize = WorldMgr->GetAdminWorldsPacketSize();
    }
    else {
        // Just a regular boring user
        LOG_DEBUG1("User does not have test server access.");
        pWorldListPacket = WorldMgr->GetUserWorldsPacket();
        dwWorldListPacketSize = WorldMgr->GetUserWorldsPacketSize();
    }
    LOG_DEBUG1("Sending world list.");
    mParser.SendPacket(FFXILoginPacket::FFXI_LOGIN_TYPE_WORLD_LIST, pWorldListPacket.get(), dwWorldListPacketSize);
    LOG_DEBUG1("World list sent.");
}

void ViewHandler::HandleLoginRequest(const LOGIN_REQUEST_PACKET* pRequestPacket)
{
    // Session key
    uint8_t bufKey[20] = { 0 };

    LOG_DEBUG0("Called.");
    // Backup the packet, as it will be needed in the second phase
    memcpy(&mLastLoginRequestPacket, pRequestPacket, sizeof(mLastLoginRequestPacket));

    LOCK_DB;
    LOCK_SESSION;
    mpSession->UnreserveCharacter();
    // Notify the world server that a character wants to log in
    MESSAGE_LOGIN_REQUEST LoginMessage;
    LoginMessage.Header.dwMagic = LOGIN_MQ_MSG_MAGIC;
    LoginMessage.Header.eType = MQConnection::MQ_MESSAGE_CHAR_LOGIN;
    LoginMessage.Header.dwContentID = pRequestPacket->dwContentID;
    LoginMessage.Header.dwCharacterID = pRequestPacket->dwCharacterID;
    LoginMessage.Header.dwAccountID = mpSession->GetAccountID();
    LoginMessage.dwIPAddress = mpConnection->GetConnectionDetails().BindDetails.sin_addr.s_addr;
    LoginMessage.dwExpansions = mpSession->GetExpansionsBitmask();
    LoginMessage.dwFeatures = mpSession->GetFeaturesBitmask();
    memset(LoginMessage.szClientVesion, 0, sizeof(LoginMessage.szClientVesion));
    strncpy(LoginMessage.szClientVesion, mpSession->GetClientVersion().c_str(), sizeof(LoginMessage.szClientVesion) - 1);
    // The client chops the character ID to uint16 (apparently this also happens on retail)
    // so we'll need to iterate the account characters and look for the complete character ID.
    // this should work unless the user has two characters in two different worlds with the
    // same name and that somehow share the same 2 lower level bytes of their character ID
    // (extremely unlikely).
    LOG_DEBUG0("Validating Content ID and retrieving full Character ID.");
    uint8_t cNumChars = mpSession->GetNumCharsAllowed();
    const CHARACTER_ENTRY* pCurrentChar = NULL;
    uint8_t i = 0;
    for (i = 0; i < cNumChars; i++) {
        pCurrentChar = mpSession->GetCharacter(i);
        if (pCurrentChar == NULL) {
            LOG_ERROR("Get character returned NULL pointer.");
            mParser.SendError(FFXILoginPacket::FFXI_ERROR_LOGIN_DENIED);
            return;
        }
        if ((pCurrentChar->dwCharacterID % 0x10000 == pRequestPacket->dwCharacterID) &&
            (pCurrentChar->dwContentID == pRequestPacket->dwContentID) &&
            (strncmp(pCurrentChar->szCharName, pRequestPacket->szCharacterName, sizeof(pCurrentChar->szCharName)) == 0)) {
            if (!pCurrentChar->bEnabled) {
                LOG_ERROR("Attempted to login into a disabled content ID.");
                mParser.SendError(FFXILoginPacket::FFXI_ERROR_LOGIN_DENIED);
                return;
            }
            if (pCurrentChar->dwCharacterID == 0) {
                LOG_ERROR("Attempted to login to an empty slot.");
                mParser.SendError(FFXILoginPacket::FFXI_ERROR_LOGIN_DENIED);
                return;
            }
            LoginMessage.Header.dwCharacterID = pCurrentChar->dwCharacterID;
            break;
        }
    }
    if ((pCurrentChar == NULL) || (i >= cNumChars)) {
        LOG_ERROR("Attempted to log in to an unknown or unassociated character ID.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_LOGIN_DENIED);
        return;
    }
    LOG_DEBUG0("Content ID: %u, Character ID: %u.", pCurrentChar->dwContentID, pCurrentChar->dwCharacterID);
    LOG_DEBUG0("Accessing world database of world %u.", pCurrentChar->cWorldID);
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    // LOCK_WORLDMGR;
    std::shared_ptr<WorldDBConnection> WorldDB = WorldManager::GetInstance()->GetWorldDBConnection(pCurrentChar->cWorldID);
    const char* pcszWorldPrefix = WorldManager::GetInstance()->GetWorldDBPrefix(pCurrentChar->cWorldID);
    LOCK_PWORLDDB(WorldDB);
    // Verify they're not already logged-in
    // Delete any sessions unacknowledged by map
    LOG_DEBUG0("Dropping unacknowledged sessions.");
    std::string strSqlQueryFmt = "DELETE FROM %saccounts_sessions WHERE accid = %u AND last_updated IS NULL;";
    std::string strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        mpSession->GetAccountID());
    WorldDB->GetDatabase()->query(strSqlFinalQuery);
    WorldDB->GetDatabase()->query("COMMIT");
    LOG_DEBUG0("Checking whether character %u is already logged-in.", pCurrentChar->dwCharacterID);
    strSqlQueryFmt = "SELECT charid FROM %saccounts_sessions WHERE charid = %u OR content_id = %u;";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        pCurrentChar->dwCharacterID,
        pCurrentChar->dwContentID);
    mariadb::result_set_ref pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() != 0) {
        // They're already logged in
        LOG_ERROR("Content ID %u is already logged-in.", pCurrentChar->dwContentID);
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
        return;
    }
    if (Config->GetConfigUInt("allow_concurrent_logins") == 0) {
        LOG_DEBUG0("Checking whether another character from the same account is logged-in.");
        strSqlQueryFmt = "SELECT charid FROM %saccounts_sessions WHERE accid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            mpSession->GetAccountID());
        mariadb::result_set_ref pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
        if (pResultSet->row_count() != 0) {
            // They're already logged in
            LOG_ERROR("Another character from account ID %u is already logged-in.", mpSession->GetAccountID());
            mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
            return;
        }
    }
    // Check if they're banned on that specific server
    LOG_DEBUG0("Checking whether the account is banned.");
    strSqlQueryFmt = "SELECT accid FROM %saccounts_banned WHERE accid = %u AND (timeunbann IS NULL or timeunbann > NOW());";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        mpSession->GetAccountID());
    pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() != 0) {
        LOG_ERROR("The account is banned from the target world.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_LOGIN_DENIED);
        return;
    }
    // Query some data we will need regarding the character
    LOG_DEBUG0("Updating map server details for character.");
    strSqlQueryFmt = "SELECT pos_zone, pos_prevzone FROM %schars WHERE charid = %u AND content_id = %u;";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        pCurrentChar->dwCharacterID,
        pCurrentChar->dwContentID);
    pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() == 0) {
        LOG_ERROR("Character with Content ID %u not found in World DB.", pCurrentChar->dwContentID);
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
        return;
    }
    pResultSet->next();
    uint16_t wZone = pResultSet->get_unsigned16(0);
    uint16_t wPrevZone = pResultSet->get_unsigned16(1);
    strSqlQueryFmt = "SELECT zoneip, zoneport FROM %szone_settings WHERE zoneid = %u;";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        wZone);
    pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() == 0) {
        LOG_ERROR("Character is in an invalid zone.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
        return;
    }
    pResultSet->next();
    uint32_t dwZoneIP = 0;
    std::string strIpAddr = pResultSet->get_string(0);
    inet_pton(AF_INET, strIpAddr.c_str(), &dwZoneIP);
    uint16_t wZonePort = pResultSet->get_unsigned16(1);
    LOG_DEBUG0("Checking whether key is installed.");
    if (!mpSession->IsKeyInstalled()) {
        // Signal the data server to have the bootloader install the encryption key.
        // At this point we terminate. This function will be called again with the
        // same login packet once the key has been installed.
        LOG_DEBUG0("Key is not installed yet, sending request to data server.");
        mpSession->SendRequestToDataServer(LoginSession::DATA_SERVER_ASK_FOR_KEY);
        return;
    }
    memcpy(bufKey, mpSession->GetKey(), sizeof(bufKey));
    bufKey[16] -= 2;
    LOG_DEBUG0("Key is installed.");
    if (wPrevZone == 0) {
        LOG_DEBUG1("Character %u logging in for the first time.", pCurrentChar->dwCharacterID);
        // First time this character is logging-in after being created
        //const std::vector<uint32_t>* pvecAlreadyUsed = mpSession->GetUsedContentIDsConnect();
        //if (std::find(pvecAlreadyUsed->begin(), pvecAlreadyUsed->end(), pCurrentChar->dwContentID) != pvecAlreadyUsed->end()) {
        //    bufKey[16] += 2;
        //}
        bufKey[16] += 6;
        strSqlQueryFmt = "UPDATE %schars SET pos_prevzone = pos_zone WHERE charid = %u AND content_id = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pCurrentChar->dwCharacterID,
            pCurrentChar->dwContentID);
        WorldDB->GetDatabase()->execute(strSqlFinalQuery);
    }
    memcpy(&LoginMessage.bufInitialKey, bufKey, sizeof(LoginMessage.bufInitialKey));
    // Log the login into the map server's records
    LOG_DEBUG0("Recording transaction in log.");
    struct in_addr ClientIP = { 0 };
    ClientIP.s_addr = mpSession->GetClientIPAddress();
    strSqlQueryFmt = "INSERT INTO %saccount_ip_record (login_time, accid, charid, client_ip) VALUES (NOW(), %d, %d, '%s');";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        mpSession->GetAccountID(),
        pCurrentChar->dwCharacterID,
        Database::RealEscapeString(inet_ntoa(ClientIP)).c_str());
    WorldDB->GetDatabase()->insert(strSqlFinalQuery);
    // Create the new session
    LOG_DEBUG0("Creating new session for character %u.", pCurrentChar->dwCharacterID);
    std::string strExpectedVersion(Config->GetConfigString("expected_client_version"));
    bool bVersionMismatch = mpSession->GetClientVersion() != strExpectedVersion;
    strSqlQueryFmt = "INSERT INTO %saccounts_sessions "
        "(accid, content_id, charid, session_key, server_addr, server_port, client_addr, version_mismatch, client_version, expansions, features) "
        "VALUES (%u, %u, %u, x'%s', %u, %u, %u, %u, '%s', %u, %u);";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        mpSession->GetAccountID(),
        pCurrentChar->dwContentID,
        pCurrentChar->dwCharacterID,
        BinaryToHex(bufKey, sizeof(bufKey)).c_str(),
        dwZoneIP,
        wZonePort,
        // TODO: Need to check why we need the htonl here since it should've been
        // network-byte order to begin with.
        htonl(mpSession->GetClientIPAddress()),
        bVersionMismatch ? 1 : 0,
        Database::RealEscapeString(mpSession->GetClientVersion()).c_str(),
        mpSession->GetExpansionsBitmask(),
        mpSession->GetFeaturesBitmask());
    WorldDB->GetDatabase()->insert(strSqlFinalQuery);
    // Tonberry-Style Friend List
    if (WorldManager::GetInstance()->HasFriendList(pCurrentChar->cWorldID)) {
        LOG_DEBUG0("Updating friend list status.");
        strSqlQueryFmt = "SELECT visible FROM %sflist_settings WHERE callingchar = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pCurrentChar->dwCharacterID);
        pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
        if (pResultSet->row_count() != 0) {
            pResultSet->next();
            if (pResultSet->get_signed32(0)) {
                // User is visible in friend list so notify all friends
                strSqlQueryFmt = "UPDATE %sflist SET status = 1 WHERE listedchar = %u;";
                strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                    pcszWorldPrefix,
                    pCurrentChar->dwCharacterID);
                WorldDB->GetDatabase()->execute(strSqlFinalQuery);
            }
        }
    }
    // Final step is set the character to zoning status, since logging-in
    // is considered zoning.
    LOG_DEBUG0("Setting zoning flag.");
    strSqlQueryFmt = "UPDATE %schar_stats SET zoning = 2 WHERE charid = %u;";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        pCurrentChar->dwCharacterID);
    WorldDB->GetDatabase()->execute(strSqlFinalQuery);
    WorldDB->GetDatabase()->execute("COMMIT;");
    LOG_DEBUG0("Sending notification to map server.");
    // Send notification to the world server in case it needs to do something on its side
    WorldManager::GetInstance()->SendMessageToWorld(pCurrentChar->cWorldID, reinterpret_cast<uint8_t*>(&LoginMessage), sizeof(LoginMessage));
    // Send the map server details to client
    std::pair<std::string, uint16_t> SearchDetails = WorldManager::GetInstance()->GetSearchServer(pCurrentChar->cWorldID);
    uint32_t dwSearchIP = 0;
    inet_pton(AF_INET, SearchDetails.first.c_str(), &dwSearchIP);
    LOGIN_CONFIRM_PACKET ConfirmPacket = { 0 };
    ConfirmPacket.dwContentID = pCurrentChar->dwContentID;
    ConfirmPacket.dwCharacterID = pCurrentChar->dwCharacterID;
    strncpy(ConfirmPacket.szCharacterName, pRequestPacket->szCharacterName, sizeof(ConfirmPacket.szCharacterName)-1);
    ConfirmPacket.dwUnknown = 2;
    ConfirmPacket.dwZoneIP = dwZoneIP;
    ConfirmPacket.wZonePort = wZonePort;
    ConfirmPacket.wZero1 = 0;
    ConfirmPacket.dwSearchIP = dwSearchIP;
    ConfirmPacket.wSearchPort = SearchDetails.second;
    ConfirmPacket.wZero2 = 0;
    mParser.SendPacket(FFXILoginPacket::FFXI_LOGIN_TYPE_LOGIN_RESPONSE, reinterpret_cast<uint8_t*>(&ConfirmPacket), sizeof(ConfirmPacket));
    LOG_INFO("Character %s (%d) successfully logged-in.", ConfirmPacket.szCharacterName, ConfirmPacket.dwCharacterID);
    // At this point the client should switch to the zone server, our job's
    // done so drop the connection.
    mpSession->SetNeverExpire(true);
    mtmOperationTimeout = 0;
    mbShutdown = true;
}

void ViewHandler::PrepareNewCharacter(const CREATE_REQUEST_PACKET* pRequestPacket)
{
    LOG_DEBUG0("Called.");
    mpSession->UnreserveCharacter();
    // This will throw if the client attempts to use a content ID not associated with its account
    LOG_DEBUG0("Validating content ID.");
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    CHARACTER_ENTRY* pNewChar = mpSession->GetCharacterByContentID(pRequestPacket->dwContentID);
    // Do some sanity checks on the content
    if (!pNewChar->bEnabled) {
        LOG_ERROR("Cannot create a new character using a disabled content ID.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
        return;
    }
    if (pNewChar->dwCharacterID != 0) {
        LOG_ERROR("Content ID already associated with a character.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
        return;
    }
    // The client sends the world name rather than world ID so look it up
    LOG_DEBUG0("Looking up world ID.");
    WorldManagerPtr WorldMgr = WorldManager::GetInstance();
    uint32_t dwWorldID = WorldMgr->GetWorldIDByName(pRequestPacket->szWorldName);
    LOCK_DB;
    LOCK_SESSION;
    DBConnection DB = Database::GetDatabase();
    // Prevent unprivileged users from creating characters in test worlds by editing
    // the world name in memory.
    LOG_DEBUG0("Verifying privileges.");
    if ((WorldMgr->IsTestWorld(dwWorldID)) && ((mpSession->GetPrivilegesBitmask() & Authentication::ACCT_PRIV_HAS_TEST_ACCESS) == 0)) {
        LOG_ERROR("Unprivileged user attempted to create a character on a test world.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
        return;
    }
    // Verify that the character name is not already taken
    // LOCK_WORLDMGR;
    LOG_DEBUG0("Accessing map server database.");
    std::shared_ptr<WorldDBConnection> WorldDB = WorldManager::GetInstance()->GetWorldDBConnection(dwWorldID);
    const char* pcszWorldPrefix = WorldManager::GetInstance()->GetWorldDBPrefix(dwWorldID);
    LOCK_PWORLDDB(WorldDB);
    LOG_DEBUG0("Verifying uniqueness of character name: %s.", pRequestPacket->szCharacterName);
    std::string strSqlQueryFmt = "SELECT charid FROM %schars WHERE charname = '%s';";
    std::string strSqlFinalQuery = FormatString(&strSqlQueryFmt, pcszWorldPrefix, Database::RealEscapeString(pRequestPacket->szCharacterName).c_str());
    mariadb::result_set_ref pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() != 0) {
        LOG_INFO("Character name %s is already taken.", pRequestPacket->szCharacterName);
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_NAME_ALREADY_TAKEN);
        throw std::runtime_error("Name already taken.");
    }
    // Verify the name is not disallowed
    strSqlQueryFmt = "SELECT GREATEST((SELECT EXISTS (SELECT name FROM %sdisallowed_names WHERE name = '%s' AND match_type = 1)), (SELECT MAX(INSTR('%s', name)) FROM %sdisallowed_names WHERE match_type = 2));";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        Database::RealEscapeString(pRequestPacket->szCharacterName).c_str(),
        Database::RealEscapeString(pRequestPacket->szCharacterName).c_str(),
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str());
    pResultSet = DB->query(strSqlFinalQuery);
    if (pResultSet->row_count() != 0) {
        pResultSet->next();
        int64_t namePos = pResultSet->get_signed64(0);
        if (namePos != 0) {
            LOG_INFO("Character name %s is forbidden.", pRequestPacket->szCharacterName);
            // Not sure there's an error value for that so we'll use
            // the "name already taken" error because that should
            // hint the user they need to pick another name.
            mParser.SendError(FFXILoginPacket::FFXI_ERROR_NAME_ALREADY_TAKEN);
            throw std::runtime_error("Forbidden name.");
        }
    }
    // Check if they're banned on that specific server
    LOG_DEBUG0("Checking whether the account is banned.");
    strSqlQueryFmt = "SELECT accid FROM %saccounts_banned WHERE accid = %u AND (timeunbann IS NULL or timeunbann > NOW());";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        mpSession->GetAccountID());
    pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() != 0) {
        LOG_ERROR("The account is banned from the target world.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
        return;
    }
    LOG_DEBUG0("Generating new character ID.");
    uint32_t dwNewCharID = mpSession->GenerateNewCharID(dwWorldID);
    LOG_DEBUG1("New character ID: %u.", dwNewCharID);
    // Verify the target server has registrations enabled
    LOG_DEBUG0("Checking whether the target world allows registrations.");
    strSqlQueryFmt = "SELECT value FROM %sserver_variables WHERE name = '[SRV]DisableRegistration';";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt, pcszWorldPrefix);
    pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    bool bRegistrationDisabled = false;
    if (pResultSet->row_count() != 0) {
        pResultSet->next();
        bRegistrationDisabled = (pResultSet->get_unsigned32(0) != 0);
    }
    if (bRegistrationDisabled) {
        // However they may still be able to create a char if they have
        // a valid gold world pass
        LOG_DEBUG0("Registrations disabled, checking gold world pass.");
        bool bGoldWorldPassValid = false;
        if (pRequestPacket->szGoldWorldPass[0] != '\0') {
            strSqlQueryFmt = "SELECT passid FROM %sgoldworldpass WHERE passid = '%s' AND "
                "(expiry_time IS NULL OR expiry_time > NOW()) AND usage_time IS NULL AND "
                "passid NOT IN (SELECT goldworldpass FROM %schars);";
            strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                pcszWorldPrefix,
                Database::RealEscapeString(pRequestPacket->szGoldWorldPass).c_str(),
                pcszWorldPrefix);
            pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
            if (pResultSet->row_count() != 0) {
                LOG_DEBUG0("Gold world pass is valid, proceeding with registration.");
                bGoldWorldPassValid = true;
            }
        }
        if (!bGoldWorldPassValid) {
            LOG_ERROR("Server does not accept new character registration.");
            mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
            return;
        }
    }
    LOG_DEBUG0("All checks passed, sending success notification.");
    // Save a stub (all zeros) to the database to reserve the character ID but don't do much more
    pNewChar->bEnabled = true;
    pNewChar->cFace = 0;
    pNewChar->cHair = 0;
    pNewChar->cMainJob = 0;
    pNewChar->cMainJobLevel = 0;
    pNewChar->cNation = 0;
    pNewChar->cRace = 0;
    pNewChar->cSize = 0;
    pNewChar->cWorldID = static_cast<uint8_t>(dwWorldID);
    pNewChar->dwCharacterID = dwNewCharID;
    pNewChar->dwContentID = pRequestPacket->dwContentID;
    strncpy(pNewChar->szCharName, pRequestPacket->szCharacterName, sizeof(pNewChar->szCharName));
    pNewChar->wBody = 0;
    pNewChar->wFeet = 0;
    pNewChar->wHands = 0;
    pNewChar->wHead = 0;
    pNewChar->wLegs = 0;
    pNewChar->wMain = 0;
    pNewChar->wSub = 0;
    pNewChar->wZone = 0;
    strncpy(pNewChar->szGoldWorldPass, pRequestPacket->szGoldWorldPass, sizeof(pNewChar->szGoldWorldPass));
    LOG_INFO("Character %s (%d) successfully prepared.", pNewChar->szCharName, pNewChar->dwCharacterID);
    mParser.SendDone();
    mtmOperationTimeout = 0;
}

void ViewHandler::ConfirmNewCharacter(const CONFIRM_CREATE_REQUEST_PACKET* pRequestPacket)
{
    LOG_DEBUG0("Called.");

    LOG_DEBUG0("Verifying content ID.");
    CHARACTER_ENTRY* pNewChar = mpSession->GetCharacterByContentID(pRequestPacket->dwContentID);
    if ((!pNewChar) || (!pNewChar->bEnabled) || (pNewChar->cNation != 0)) {
        LOG_ERROR("Character slot invalid or already taken.");
        CleanHalfCreatedCharacters();
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
        return;
    }
    LOG_DEBUG0("Checking whether the character has already been prepared.");
    if (mpSession->GetReservedCharID(pNewChar->cWorldID) != pNewChar->dwCharacterID) {
        LOG_ERROR("Reserved character ID mismatch.");
        CleanHalfCreatedCharacters();
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
        return;
    }
    // Fill in all character data. The gear data is purely used for login screen visuals so we
    // don't mind taking it from whatever the client sent us (won't affect other people).
    LOG_DEBUG0("Filling character information.");
    pNewChar->cFace = pRequestPacket->Details.cFace;
    pNewChar->cHair = pRequestPacket->Details.cHair;
    pNewChar->cSize = pRequestPacket->Details.cSize;
    pNewChar->wBody = pRequestPacket->Details.wBody;
    pNewChar->wFeet = pRequestPacket->Details.wFeet;
    pNewChar->wHands = pRequestPacket->Details.wHands;
    pNewChar->wHead = pRequestPacket->Details.wHead;
    pNewChar->wLegs = pRequestPacket->Details.wLegs;
    pNewChar->wMain = pRequestPacket->Details.wMain;
    pNewChar->wSub = pRequestPacket->Details.wSub;
    if ((pRequestPacket->Details.cMainJob < 1) || (pRequestPacket->Details.cMainJob > 6)) {
        // Prevent the user from using packet injection in order to select an advanced
        // job as the starting job.
        LOG_WARNING("User attempted to select a non-basic job as a start job.");
        // Just force is to a default value (WAR)
        pNewChar->cMainJob = 1;
    }
    else {
        pNewChar->cMainJob = pRequestPacket->Details.cMainJob;
    }
    // We don't care about what level you say you are, you always start as level 1
    pNewChar->cMainJobLevel = 1;
    pNewChar->cRace = pRequestPacket->Details.cRace;
    pNewChar->cNation = pRequestPacket->Details.cNation;
    // Decide zone according to selected nation
    LOG_DEBUG0("Calculating starting zone.");
    switch (pNewChar->cNation) {
    case 0:
        // San d'Oria
        pNewChar->wZone = 230 + (rand() % 3);
        break;
    case 1:
        // Bastok
        pNewChar->wZone = 234 + (rand() % 3);
        break;
    case 2:
        // Windurst
        // Special case - Has 4 zones but Windurst Walls is not allowed
        pNewChar->wZone = 238 + (rand() % 3);
        if (pNewChar->wZone == 239) {
            pNewChar->wZone = 241;
        }
        break;
    default:
        LOG_ERROR("Selected nation is invalid.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
        return;
    }
    LOG_DEBUG0("Starting zone: %u.", pNewChar->wZone);
    std::string strSqlQueryFmt;
    std::string strSqlFinalQuery;
    // Add to world server's char table
    {
        LOG_DEBUG0("Accessing map server database.");
        std::shared_ptr<WorldDBConnection> WorldDB = WorldManager::GetInstance()->GetWorldDBConnection(pNewChar->cWorldID);
        const char* pcszWorldPrefix = WorldManager::GetInstance()->GetWorldDBPrefix(pNewChar->cWorldID);
        // LOCK_WORLDMGR;
        LOCK_DB;
        LOCK_PWORLDDB(WorldDB);
        DBConnection WorldDBObj = WorldDB->GetDatabase();
        // Double check that they're not banned
        LOG_DEBUG0("Checking whether the account is banned.");
        strSqlQueryFmt = "SELECT accid FROM %saccounts_banned WHERE accid = %u AND (timeunbann IS NULL or timeunbann > NOW());";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            mpSession->GetAccountID());
        mariadb::result_set_ref pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
        if (pResultSet->row_count() != 0) {
            LOG_ERROR("The account is banned from the target world.");
            mParser.SendError(FFXILoginPacket::FFXI_ERROR_CREATE_DENIED);
            return;
        }
        LOG_DEBUG0("Saving character data to map server database.");
        strSqlQueryFmt = "INSERT INTO %schars (charid, content_id, accid, goldworldpass, charname, pos_zone, nation) "
            "VALUES (%u, %u, %u, '%s', '%s', %u, %u);";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID,
            pNewChar->dwContentID,
            mpSession->GetAccountID(),
            Database::RealEscapeString(pNewChar->szGoldWorldPass).c_str(),
            Database::RealEscapeString(pNewChar->szCharName).c_str(),
            pNewChar->wZone,
            pNewChar->cNation);
        //LOG_DEBUG0("SQL: %s", strSqlFinalQuery.c_str());
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character look.");
        strSqlQueryFmt = "INSERT INTO %schar_look (charid, face, race, size) VALUES (%u, %u, %u, %u);";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID,
            pNewChar->cFace,
            pNewChar->cRace,
            pNewChar->cSize);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character stats.");
        strSqlQueryFmt = "INSERT INTO %schar_stats (charid, mjob) VALUES (%u, %u);";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID,
            pNewChar->cMainJob);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character exp.");
        strSqlQueryFmt = "INSERT INTO %schar_exp (charid) VALUES (%u) ON DUPLICATE KEY UPDATE charid = charid;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character jobs.");
        strSqlQueryFmt = "INSERT INTO %schar_jobs (charid) VALUES (%u) ON DUPLICATE KEY UPDATE charid = charid;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character points.");
        strSqlQueryFmt = "INSERT INTO %schar_points (charid) VALUES (%u) ON DUPLICATE KEY UPDATE charid = charid;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character unlocks.");
        strSqlQueryFmt = "INSERT INTO %schar_unlocks (charid) VALUES (%u) ON DUPLICATE KEY UPDATE charid = charid;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character profile.");
        strSqlQueryFmt = "INSERT INTO %schar_profile (charid) VALUES (%u) ON DUPLICATE KEY UPDATE charid = charid;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Saving character storage.");
        strSqlQueryFmt = "INSERT INTO %schar_storage (charid) VALUES (%u) ON DUPLICATE KEY UPDATE charid = charid;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->insert(strSqlFinalQuery);
        LOG_DEBUG0("Removing possible leftover inventory.");
        strSqlQueryFmt = "DELETE FROM %schar_inventory WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Saving character inventory.");
        strSqlQueryFmt = "INSERT INTO %schar_inventory (charid) VALUES (%u) ON DUPLICATE KEY UPDATE charid = charid;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            pNewChar->dwCharacterID);
        WorldDBObj->insert(strSqlFinalQuery);
        if (WorldManager::GetInstance()->HasFriendList(pNewChar->cWorldID)) {
            LOG_DEBUG0("Saving character friend list settings.");
            strSqlQueryFmt = "INSERT INTO %sflist_settings (callingchar, visible, notifications, channel, size, lastcall, lastonline) "
                "VALUES (%u, 1, 3, 29, 3, 0, %u);";
            strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                pcszWorldPrefix,
                pNewChar->dwCharacterID,
                time(NULL));
            WorldDBObj->insert(strSqlFinalQuery);
        }
        // If a gold world pass was specified, mark it as used
        if (pNewChar->szGoldWorldPass[0] != '\0') {
            LOG_DEBUG0("Marking gold world pass as used.");
            strSqlQueryFmt = "UPDATE %sgoldworldpass SET user_contentid = %u, user_charid = %u, usage_time = NOW() where passid = '%s';";
            strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                pcszWorldPrefix,
                pRequestPacket->dwContentID,
                pNewChar->dwCharacterID,
                Database::RealEscapeString(pNewChar->szGoldWorldPass).c_str());
            WorldDBObj->execute(strSqlFinalQuery);
        }
        WorldDBObj->execute("COMMIT;");
    }
    LOCK_DB;
    LOCK_SESSION;
    DBConnection DB = Database::GetDatabase();
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    // Update our local copy too
    LOG_DEBUG0("Removing old characters from local cache.");
    strSqlQueryFmt = "DELETE FROM %schars WHERE content_id = %u;";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        pNewChar->dwContentID);
    DB->execute(strSqlFinalQuery);
    LOG_DEBUG0("Saving character to local cache.");
    strSqlQueryFmt = "INSERT INTO %schars (character_id, content_id, name, world_id, goldworldpass, main_job, "
        "main_job_lv, zone, race, face, hair, head, body, hands, legs, feet, main, sub, size, nation) "
        "VALUES (%u, %u, '%s', %u, '%s', %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u, %u);";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        pNewChar->dwCharacterID,
        pNewChar->dwContentID,
        Database::RealEscapeString(pNewChar->szCharName).c_str(),
        pNewChar->cWorldID,
        Database::RealEscapeString(pNewChar->szGoldWorldPass).c_str(),
        pNewChar->cMainJob,
        pNewChar->cMainJobLevel,
        pNewChar->wZone,
        pNewChar->cRace,
        pNewChar->cFace,
        pNewChar->cHair,
        pNewChar->wHead,
        pNewChar->wBody,
        pNewChar->wHands,
        pNewChar->wLegs,
        pNewChar->wFeet,
        pNewChar->wMain,
        pNewChar->wSub,
        pNewChar->cSize,
        pNewChar->cNation);
    //LOG_DEBUG0("SQL: %s", strSqlFinalQuery.c_str());
    DB->insert(strSqlFinalQuery);
    DB->execute("COMMIT;");
    LOG_DEBUG0("All checks passed, sending notification to map server.");
    MESSAGE_CONFIRM_CREATE_REQUEST ConfirmRequest;
    ConfirmRequest.Header.dwMagic = LOGIN_MQ_MSG_MAGIC;
    ConfirmRequest.Header.eType = MQConnection::MQ_MESSAGE_CHAR_CREATE;
    ConfirmRequest.Header.dwAccountID = mpSession->GetAccountID();
    ConfirmRequest.Header.dwContentID = pNewChar->dwContentID;
    ConfirmRequest.Header.dwCharacterID = pNewChar->dwCharacterID;
    mpSession->InvalidateCharacterList();
    // Notify the world server in case it wants to do something too
    // LOCK_WORLDMGR;
    WorldManager::GetInstance()->SendMessageToWorld(pNewChar->cWorldID, reinterpret_cast<uint8_t*>(&ConfirmRequest), sizeof(ConfirmRequest));
    LOG_INFO("Character %s (%d) successfully created.", pNewChar->szCharName, pNewChar->dwCharacterID);
    mParser.SendDone();
    mtmOperationTimeout = 0;
}

void ViewHandler::DeleteCharacter(const DELETE_REQUEST_PACKET* pRequestPacket)
{
    LOG_DEBUG0("Called.");
    mpSession->UnreserveCharacter();
    LOG_DEBUG0("Validating Content ID.");
    CHARACTER_ENTRY* pCharEntry = mpSession->GetCharacterByContentID(pRequestPacket->dwContentID);
    if (pCharEntry->dwCharacterID != pRequestPacket->dwCharacterID) {
        LOG_ERROR("Character ID / Content ID mismatch.");
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
        return;
    }
    // Remove the character from DB and session
    uint32_t dwCharacterID = pCharEntry->dwCharacterID;
    char cWorldID = pCharEntry->cWorldID;
    LOCK_DB;
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    DBConnection DB = Database::GetDatabase();
    bool bRealDelete = Config->GetConfigUInt("real_delete_char");
    std::string strDeletedName(" ");
    strDeletedName += pCharEntry->szCharName;
    std::string strSqlQueryFmt;
    std::string strSqlFinalQuery;
    LOG_DEBUG0("Accessing map server database.");
    std::shared_ptr<WorldDBConnection> WorldDB = WorldManager::GetInstance()->GetWorldDBConnection(cWorldID);
    const char* pcszWorldPrefix = WorldManager::GetInstance()->GetWorldDBPrefix(cWorldID);
    LOCK_PWORLDDB(WorldDB);
    DBConnection WorldDBObj = WorldDB->GetDatabase();
    // Check if they're banned on that specific server
    LOG_DEBUG0("Checking whether the account is banned.");
    strSqlQueryFmt = "SELECT accid FROM %saccounts_banned WHERE accid = %u AND (timeunbann IS NULL or timeunbann > NOW());";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        pcszWorldPrefix,
        mpSession->GetAccountID());
    mariadb::result_set_ref pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
    if (pResultSet->row_count() != 0) {
        LOG_ERROR("The account is banned from the target world.");
        // Need to find the specific error
        mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
        return;
    }
    // Check whether the character has been created too recently
    // (in order to avoid character create-delete spam)
    uint32_t deleteCooldown = Config->GetConfigUInt("delete_char_cooldown");
    if (deleteCooldown != 0) {
        strSqlQueryFmt = "SELECT TIMESTAMPDIFF(MINUTE, timecreated, NOW()) FROM %schars WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        mariadb::result_set_ref pResultSet = WorldDB->GetDatabase()->query(strSqlFinalQuery);
        if (pResultSet->row_count() != 0) {
            pResultSet->next();
            int64_t createDiff = pResultSet->get_signed64(0);
            if (createDiff >= 0 && (unsigned)createDiff < deleteCooldown) {
                LOG_ERROR("The character has been created too recently and cannot be deleted.");
                // Probably no specific error in the client so send a generic error
                mParser.SendError(FFXILoginPacket::FFXI_ERROR_MAP_CONNECT_FAILED);
                return;
            }
        }
    }
    if (bRealDelete) {
        LOG_DEBUG0("Deleting character from local cahce.");
        strSqlQueryFmt = "DELETE FROM %schars WHERE content_id=%u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            pRequestPacket->dwContentID);
    }
    else {
        // Mark the character as deleted by disassociating it from the content id and
        // changing the character name so it's no longer in use.
        LOG_DEBUG0("Marking character as deleted in local cache.");
        strSqlQueryFmt = "UPDATE %schars SET content_id = NULL, name='%s' WHERE content_id=%u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(strDeletedName).c_str(),
            pRequestPacket->dwContentID);
    }
    DB->execute(strSqlFinalQuery);
    DB->execute("COMMIT;");
    // Also remove from session so the client will see this entry as free on the next character list update
    LOG_DEBUG0("Resetting character information.");
    pCharEntry->cFace = 0;
    pCharEntry->cHair = 0;
    pCharEntry->cMainJob = 0;
    pCharEntry->cMainJobLevel = 0;
    pCharEntry->cNation = 0;
    pCharEntry->cRace = 0;
    pCharEntry->cSize = 0;
    pCharEntry->cWorldID = 0;
    pCharEntry->dwCharacterID = 0;
    memset(pCharEntry->szCharName, 0, sizeof(pCharEntry->szCharName));
    pCharEntry->szCharName[0] = ' ';
    pCharEntry->wBody = 0;
    pCharEntry->wFeet = 0;
    pCharEntry->wHands = 0;
    pCharEntry->wHead = 0;
    pCharEntry->wLegs = 0;
    pCharEntry->wMain = 0;
    pCharEntry->wSub = 0;
    pCharEntry->wZone = 0;
    if (bRealDelete) {
        LOG_DEBUG0("Deleting character from map server.");
        strSqlQueryFmt = "DELETE FROM %schars WHERE charid = %u AND content_id = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID,
            pRequestPacket->dwContentID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character blacklist.");
        strSqlQueryFmt = "DELETE FROM %schar_blacklist WHERE charid_target = %u OR charid_owner = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character effects.");
        strSqlQueryFmt = "DELETE FROM %schar_effects WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character vars.");
        strSqlQueryFmt = "DELETE FROM %schar_vars WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character unlocks.");
        strSqlQueryFmt = "DELETE FROM %schar_unlocks WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character style.");
        strSqlQueryFmt = "DELETE FROM %schar_style WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character storage.");
        strSqlQueryFmt = "DELETE FROM %schar_storage WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character stats.");
        strSqlQueryFmt = "DELETE FROM %schar_stats WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character spells.");
        strSqlQueryFmt = "DELETE FROM %schar_spells WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character skills.");
        strSqlQueryFmt = "DELETE FROM %schar_skills WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character recast.");
        strSqlQueryFmt = "DELETE FROM %schar_recast WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character profile.");
        strSqlQueryFmt = "DELETE FROM %schar_profile WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character points.");
        strSqlQueryFmt = "DELETE FROM %schar_points WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character pet.");
        strSqlQueryFmt = "DELETE FROM %schar_pet WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character merit.");
        strSqlQueryFmt = "DELETE FROM %schar_merit WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character look.");
        strSqlQueryFmt = "DELETE FROM %schar_look WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character jobs.");
        strSqlQueryFmt = "DELETE FROM %schar_jobs WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character job sets.");
        strSqlQueryFmt = "DELETE FROM %schar_job_sets WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character inventory.");
        strSqlQueryFmt = "DELETE FROM %schar_inventory WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character GM messages.");
        strSqlQueryFmt = "DELETE FROM %schar_gmmessage WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character exp.");
        strSqlQueryFmt = "DELETE FROM %schar_exp WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        strSqlQueryFmt = "DELETE FROM %schar_equip WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character delivery box.");
        strSqlQueryFmt = "DELETE FROM %sdelivery_box WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character cheating incidents.");
        strSqlQueryFmt = "DELETE FROM %scheat_incidents WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character fishing log.");
        strSqlQueryFmt = "DELETE FROM %sfishing_log WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character gold world pass.");
        strSqlQueryFmt = "DELETE FROM %sgoldworldpass WHERE creator_charid = %u OR user_charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character GM calls.");
        strSqlQueryFmt = "DELETE FROM %sserver_gmcalls WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        LOG_DEBUG0("Deleting character login record.");
        strSqlQueryFmt = "DELETE FROM %saccount_ip_record WHERE charid = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            dwCharacterID);
        WorldDBObj->execute(strSqlFinalQuery);
        if (WorldManager::GetInstance()->HasFriendList(cWorldID)) {
            LOG_DEBUG0("Deleting character friend list.");
            strSqlQueryFmt = "DELETE FROM %sflist WHERE callingchar = %u OR listedchar = %u;";
            strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                pcszWorldPrefix,
                dwCharacterID,
                dwCharacterID);
            WorldDBObj->execute(strSqlFinalQuery);
            LOG_DEBUG0("Deleting character friend list settings.");
            strSqlQueryFmt = "DELETE FROM %sflist_settings WHERE callingchar = %u;";
            strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                pcszWorldPrefix,
                dwCharacterID);
            WorldDBObj->execute(strSqlFinalQuery);
        }
    }
    else {
    LOG_DEBUG0("Marking character as deleted in map server.");
    strSqlQueryFmt = "UPDATE %schars SET content_id = NULL, accid = 0, charname = '%s' WHERE charid = %u AND content_id = %u;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            pcszWorldPrefix,
            Database::RealEscapeString(strDeletedName).c_str(),
            dwCharacterID,
            pRequestPacket->dwContentID);
        WorldDBObj->execute(strSqlFinalQuery);
    }
    WorldDBObj->execute("COMMIT;");
    // Send a message to the world server in case it needs to do something
    LOG_DEBUG0("Sending notification to map server.");
    CHAR_MQ_MESSAGE_HEADER DeleteRequest;
    DeleteRequest.dwMagic = LOGIN_MQ_MSG_MAGIC;
    DeleteRequest.eType = MQConnection::MQ_MESSAGE_CHAR_DELETE;
    DeleteRequest.dwAccountID = mpSession->GetAccountID();
    DeleteRequest.dwContentID = pRequestPacket->dwContentID;
    DeleteRequest.dwCharacterID = dwCharacterID;
    mpSession->InvalidateCharacterList();
    // LOCK_WORLDMGR;
    WorldManager::GetInstance()->SendMessageToWorld(cWorldID, reinterpret_cast<uint8_t*>(&DeleteRequest), sizeof(DeleteRequest));
    LOG_INFO("Character %d successfully created.", DeleteRequest.dwCharacterID);
    mParser.SendDone();
    mtmOperationTimeout = 0;
}

void ViewHandler::CleanHalfCreatedCharacters()
{
    LOG_DEBUG0("Called.");
    /*
    // DISABLED: nation 0 is actually valid (San d'Oria)....
    LOCK_DB;
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    DBConnection DB = Database::GetDatabase();
    std::string strSqlQueryFmt("DELETE FROM %schars WHERE nation=0 AND content_id IN (SELECT content_id FROM %scontents WHERE account_id=%d);");
    std::string strSqlFinalQuery(FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        mpSession->GetAccountID()));
    DB->execute(strSqlFinalQuery);
    */
}
