/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under AGPLv3, see LICENSE file.
  
  Author: Caelic

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

CDynamisHandler::CDynamisHandler(CZone* PZone)
{
    m_PZone = PZone;
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

bool CDynamisHandler::LoadDynamis(CCharEntity* PChar, uint32 token, uint32 originalRegistrant)
{
    ClearPlayerRegistry();
    EjectAllPlayers(true);
    RegisterPlayer(PChar);
    m_token = token;
    m_expiryTimePoint = (std::chrono::duration_cast<std::chrono::seconds>(std::chrono::system_clock::now().time_since_epoch()) + 1h).count();
    m_originalRegistrantID = originalRegistrant;
    m_currencyAutoDistribute = true;
    m_given10MinWarning = false;
    m_given3MinWarning = false;
    m_expirationRoutine = false;
    luautils::OnDynamisNewInstance(this);
    return true;
}

void CDynamisHandler::ExpireDynamis()
{
    m_expirationRoutine = true;
    EjectAllPlayers();
}

void CDynamisHandler::CleanupDynamis()
{
    ClearPlayerRegistry();
    EjectAllPlayers(true);
    m_token = 0;
    m_expiryTimePoint = 0;
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
        m_registeredPlayers[i] = nullptr;
        i++;
    }
}

void CDynamisHandler::EjectAllPlayers(bool immediate)
{
    if (!m_PZone)
        return;
    m_PZone->ForEachChar([&](CCharEntity* PChar) { EjectPlayer(PChar, immediate); });
}

bool CDynamisHandler::IsRegistered(CCharEntity* PChar)
{
    uint8 i = 0;
    while (i < 64 && m_registeredPlayers[i] != nullptr)
    {
        if (m_registeredPlayers[i]->id == PChar->id)
            return true;
        i++;
    }
    return false;
}

bool CDynamisHandler::RegisterPlayer(CCharEntity* PChar)
{
    uint8 i = 0;
    while (i < 64)
    {
        if (m_registeredPlayers[i] == nullptr);
        {
            m_registeredPlayers[i] = PChar;
            return true;
        }
        if (m_registeredPlayers[i]->id == PChar->id)
            return true;
        i++;
    }
    return false;
}

bool CDynamisHandler::EjectPlayer(CCharEntity* PChar, bool immediate)
{
    luautils::OnDynamisEjectPlayer(this, PChar, immediate);
    return true;
}
