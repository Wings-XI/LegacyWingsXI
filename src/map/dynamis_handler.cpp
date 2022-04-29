/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Caelic, Twilight

===========================================================================
*/

#include <string.h>
#include <algorithm>

#include "dynamis_handler.h"

#include "entities/battleentity.h"
#include "entities/charentity.h"
#include "entities/mobentity.h"

#include "lua/luautils.h"

#include "packets/message_basic.h"

#include "status_effect.h"
#include "status_effect_container.h"

#include "utils/charutils.h"
#include "utils/zoneutils.h"

#include "zone.h"
#include "rpcmapper.h"

CDynamisHandler::CDynamisHandler(CZone* PZone)
{
    m_PZone = PZone;
    m_zoneId = PZone->GetID();
    message::RPCMapper* mapper = message::RPCMapper::GetInstance();
    if (mapper) {
        mapper->RegisterIncomingRPC(RPC_DYNAMIS_BASE_INDEX + (m_zoneId << 2), DynamisZoneRPCCallback, this);
        mapper->RegisterIncomingRPC(RPC_DYNAMIS_BASE_INDEX + (m_zoneId << 2) + 2, DynamisPingRPCCallback, this);
    }
    CleanupDynamis();
}

void CDynamisHandler::HandleDynamis(time_point tick)
{
    if (!m_token)
        return;

    int32 timeRemaining = m_expiryTimePoint - (std::chrono::duration_cast<std::chrono::seconds>(tick.time_since_epoch())).count();

    if (!m_given10MinWarning && timeRemaining < 660)
    {
        m_given10MinWarning = true;
        m_PZone->ForEachChar([&](CCharEntity* PChar) { luautils::OnDynamisTimeWarning(this, PChar); });

    }
    if (!m_given3MinWarning && timeRemaining < 240)
    {
        m_given3MinWarning = true;
        m_PZone->ForEachChar([&](CCharEntity* PChar) { luautils::OnDynamisTimeWarning(this, PChar); });
    }
    if (!m_expirationRoutine && timeRemaining < 0)
    {
        m_PZone->ForEachChar([&](CCharEntity* PChar) { luautils::OnDynamisTimeWarning(this, PChar); });
        ExpireDynamis();
    }
    if (timeRemaining < -30)
    {
        CleanupDynamis();
        return;
    }

    //luautils::OnDynamisTick(this);
}

bool CDynamisHandler::LoadDynamis(uint32 charid, uint32 token, uint32 originalRegistrant)
{
    ShowDebug("LoadDynamis: %s\n", m_PZone ? m_PZone->GetName() : (const int8*)"<null>");
    ClearPlayerRegistry();
    EjectAllPlayers(true);
    RegisterPlayer(charid);
    DynamisSetToken(token);
    uint32 expiry = (std::chrono::duration_cast<std::chrono::seconds>(std::chrono::system_clock::now().time_since_epoch()) + 1h).count();
    DynamisSetExpiryTimepoint(expiry);
    m_originalRegistrantID = originalRegistrant;
    m_currencyAutoDistribute = true;
    m_given10MinWarning = false;
    m_given3MinWarning = false;
    m_expirationRoutine = false;
    luautils::OnDynamisNewInstance(this);
    return true;
}

uint32 CDynamisHandler::AddTimeToDynamis(int16 minutes)
{
    uint32 newExpiryTimePoint = m_expiryTimePoint;
    if (m_expirationRoutine == false)
    {
        newExpiryTimePoint += minutes * 60;
        if (newExpiryTimePoint >= 660)
            m_given10MinWarning = false;
        if (newExpiryTimePoint >= 240)
            m_given3MinWarning = false;

        DynamisSetExpiryTimepoint(newExpiryTimePoint);
    }
    return newExpiryTimePoint;
}

void CDynamisHandler::ExpireDynamis()
{
    ShowDebug("ExpireDynamis: %s\n", m_PZone ? m_PZone->GetName() : (const int8*)"<null>");
    m_expirationRoutine = true;
    EjectAllPlayers();
}

void CDynamisHandler::CleanupDynamis()
{
    //ShowDebug("CleanupDynamis: %s\n", m_PZone ? m_PZone->GetName() : (const int8*)"<null>");
    m_expirationRoutine = true;
    ClearPlayerRegistry();
    EjectAllPlayers(true);
    DynamisSetToken(0);
    DynamisSetExpiryTimepoint(0);
    m_originalRegistrantID = 0;
    m_currencyAutoDistribute = true;
    m_given10MinWarning = false;
    m_given3MinWarning = false;
    m_expirationRoutine = false;
    luautils::OnDynamisCleanup(this);
}

void CDynamisHandler::ClearPlayerRegistry()
{
    uint8 i = 0;
    while (i < 64)
    {
        m_registeredPlayers[i] = 0;
        i++;
    }
}

void CDynamisHandler::EjectAllPlayers(bool immediate)
{
    if (!m_PZone)
        return;
    m_PZone->ForEachChar([&](CCharEntity* PChar) { EjectPlayer(PChar, immediate); });
}

bool CDynamisHandler::IsRegistered(uint32 charid)
{
    uint8 i = 0;
    while (i < 64 && m_registeredPlayers[i] != 0)
    {
        if (m_registeredPlayers[i] == charid)
            return true;
        i++;
    }
    return false;
}

bool CDynamisHandler::RegisterPlayer(uint32 charid)
{
    ShowDebug("RegisterPlayer: %s, %u\n", m_PZone ? m_PZone->GetName() : (const int8*)"<null>", charid);
    uint8 i = 0;
    while (i < 64)
    {
        if (m_registeredPlayers[i] == 0);
        {
            m_registeredPlayers[i] = charid;
            return true;
        }
        if (m_registeredPlayers[i] == charid)
            return true;
        i++;
    }
    return false;
}

bool CDynamisHandler::EjectPlayer(CCharEntity* PChar, bool immediate)
{
    ShowDebug("EjectPlayer: %s, %s\n", m_PZone ? m_PZone->GetName() : (const int8*)"<null>", PChar ? PChar->GetName() : (const int8*)"<null>");
    luautils::OnDynamisEjectPlayer(this, PChar, immediate);
    return true;
}

uint32 CDynamisHandler::DynamisGetToken(uint16 zone)
{
    CZone* PZone = zoneutils::GetZone(zone);
    if (PZone) {
        if (PZone->m_DynamisHandler) {
            return PZone->m_DynamisHandler->m_token;
        }
        // Checking cross cluster will cause PZone to return nullptr.  But if we get a PZone and we dont have a handler, something odd has happened.
        return 0;
    }
    // Fallback to DB query
    std::string valstr("[DYNA]Token_" + std::to_string(zone));
    int32 ret = Sql_Query(SqlHandle, "SELECT value FROM server_variables WHERE name = '%s';", valstr);
    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS) {
        return Sql_GetUIntData(SqlHandle, 0);
    }

    return 0;
}

uint32 CDynamisHandler::DynamisGetToken() const
{
    return m_token;
}

void CDynamisHandler::DynamisSetToken(uint32 token)
{
    m_token = token;
    std::string valstr("[DYNA]Token_" + std::to_string(m_zoneId));
    Sql_Query(SqlHandle, "INSERT INTO server_variables (name, value) VALUES ('%s', %u) ON DUPLICATE KEY UPDATE value = %u;", valstr, token, token);
}

uint32 CDynamisHandler::DynamisGetExpiryTimepoint(uint16 zone)
{
    CZone* PZone = zoneutils::GetZone(zone);
    if (PZone) {
        if (PZone->m_DynamisHandler) {
            return PZone->m_DynamisHandler->m_expiryTimePoint;
        }
        // Checking cross cluster will cause PZone to return nullptr.  But if we get a PZone and we dont have a handler, something odd has happened.
        return 0;
    }

    // Fallback to DB query
    std::string valstr("[DYNA]Timepoint_" + std::to_string(zone));
    int32 ret = Sql_Query(SqlHandle, "SELECT value FROM server_variables WHERE name = '%s';", valstr);
    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS) {
        return Sql_GetUIntData(SqlHandle, 0);
    }

    return 0;
}

uint32 CDynamisHandler::DynamisGetExpiryTimepoint() const
{
    return m_expiryTimePoint;
}

void CDynamisHandler::DynamisSetExpiryTimepoint(uint32 tp)
{
    m_expiryTimePoint = tp;
    std::string valstr("[DYNA]Timepoint_" + std::to_string(m_zoneId));
    Sql_Query(SqlHandle, "INSERT INTO server_variables (name, value) VALUES ('%s', %u) ON DUPLICATE KEY UPDATE value = %u;", valstr, tp, tp);
}

bool CDynamisHandler::DynamisIsExpiring() const
{
    return m_expirationRoutine;
}

uint32 CDynamisHandler::DynamisGetOriginalRegistrant() const
{
    return m_originalRegistrantID;
}

bool CDynamisHandler::DynamisGetCurrencyAutoDistribute() const
{
    return m_currencyAutoDistribute;
}

void CDynamisHandler::DynamisSetCurrencyAutoDistribute(bool val)
{
    m_currencyAutoDistribute = val;
}

uint16 CDynamisHandler::DynamisGetZoneID() const
{
    return m_zoneId;
}

CZone* CDynamisHandler::DynamisGetZone()
{
    return m_PZone;
}

int32 CDynamisHandler::DynamisHandleNewPlayer(uint32 charid, bool canLoadNewDynamis)
{
    uint8 zoneid = charutils::GetCharVar(charid, "DynaPrep_zoneid");
    uint32 registrationStartTime = charutils::GetCharVar(charid, "DynaPrep_registrationStartTime");
    uint32 token = charutils::GetCharVar(charid, "DynaPrep_token");
    uint32 originalRegistrant = charutils::GetCharVar(charid, "DynaPrep_originalRegistrant");
    CZone* PZone = m_PZone;
    if (PZone && PZone->GetType() == ZONETYPE_DYNAMIS && PZone->m_DynamisHandler)
    {
        bool success = false;
        uint32 zoneToken = DynamisGetToken();
        if (zoneToken == 0)
        {
            if (canLoadNewDynamis)
                success = LoadDynamis(charid, token, originalRegistrant);
        }
        else
        {
            if (token != zoneToken) {
                return 3;
            }
            success = RegisterPlayer(charid);
        }

        if (success)
        {
            charutils::SetCharVar(charid, "DynaReservationStart", registrationStartTime);
            if (charutils::GetCharVar(charid, "DynaPrep_inflictWeakness") == 1)
                charutils::SetCharVar(charid, "DynaInflictWeakness", 1);
        }
        return success ? 1 : 0;
    }
    return 0;
}

uint32 CDynamisHandler::DynamisZoneRPCCallback(void* arg,
    uint16 zone,
    uint16 origin,
    const uint8* indata,
    uint32 inlen,
    uint8* outdata,
    uint32 outlen,
    uint32* outwritten)
{
    CDynamisHandler* thisptr = reinterpret_cast<CDynamisHandler*>(arg);
    if (!thisptr) {
        return 0;
    }
    if (zone != thisptr->m_zoneId) {
        return 0;
    }
    if (inlen < 5) {
        return 0;
    }
    uint32 charid = *reinterpret_cast<const uint32*>(indata);
    bool canLoadNewDynamis = indata[4];
    int32 success = thisptr->DynamisHandleNewPlayer(charid, canLoadNewDynamis) ? 1 : 0;
    // Send response using a reverse direction RPC call
    message::RPCMapper* mapper = message::RPCMapper::GetInstance();
    if (!mapper) {
        return 0;
    }
    uint8 rpcbuf[8] = { 0 };
    *reinterpret_cast<uint32*>(rpcbuf) = charid;
    *reinterpret_cast<int32*>(rpcbuf + 4) = success;
    mapper->CallRPCAsync(origin, zone, RPC_DYNAMIS_BASE_INDEX + (origin << 2) + 1, rpcbuf, sizeof(rpcbuf), 0, false);
    return (uint32)success;
}

uint32 CDynamisHandler::DynamisTrailMarkingRPCCallback(void* arg,
    uint16 zone,
    uint16 origin,
    const uint8* indata,
    uint32 inlen,
    uint8* outdata,
    uint32 outlen,
    uint32* outwritten)
{
    CZone* PZone = reinterpret_cast<CZone*>(arg);
    if (!PZone) {
        return 0;
    }
    if (inlen < 4) {
        return 0;
    }
    uint32 charid = *reinterpret_cast<const uint32*>(indata);
    CCharEntity* PChar = zoneutils::GetChar(charid);
    if (!PChar) {
        return 0;
    }
    int32 result = *reinterpret_cast<const int32*>(indata + 4);
    int32 response = luautils::OnDynamisServerReply(PZone, PChar, result);
    if (response == 0) {
        return 1;
    }
    return 0;
}

uint32 CDynamisHandler::DynamisPingRPCCallback(void* arg,
    uint16 zone,
    uint16 origin,
    const uint8* indata,
    uint32 inlen,
    uint8* outdata,
    uint32 outlen,
    uint32* outwritten)
{
    CDynamisHandler* thisptr = reinterpret_cast<CDynamisHandler*>(arg);
    if (!thisptr) {
        return 0;
    }
    if (zone != thisptr->m_zoneId) {
        return 0;
    }
    if (inlen < 4) {
        return 0;
    }
    uint32 charid = *reinterpret_cast<const uint32*>(indata);
    message::RPCMapper* mapper = message::RPCMapper::GetInstance();
    if (!mapper) {
        return 0;
    }
    uint8 rpcbuf[8] = { 0 };
    *reinterpret_cast<uint32*>(rpcbuf) = charid;
    *reinterpret_cast<int32*>(rpcbuf + 4) = 2;
    mapper->CallRPCAsync(origin, zone, RPC_DYNAMIS_BASE_INDEX + (origin << 2) + 1, rpcbuf, sizeof(rpcbuf), 0, false);
    return 1;
}
