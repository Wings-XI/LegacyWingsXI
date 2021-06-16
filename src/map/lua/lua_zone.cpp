/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "../../common/showmsg.h"

#include "../region.h"

#include "lua_zone.h"
#include "lua_baseentity.h"
#include "../zone.h"
#include "../entities/charentity.h"
#include "../ai/helpers/event_handler.h"
#include "../packets/chat_message.h"


/************************************************************************
*                                                                       *
*  Конструктор                                                          *
*                                                                       *
************************************************************************/

CLuaZone::CLuaZone(lua_State *L)
{
    if (!lua_isnil(L, -1))
    {
        m_pLuaZone = (CZone*)(lua_touserdata(L, -1));
        lua_pop(L, 1);
    }
    else
    {
        m_pLuaZone = nullptr;
    }
}

/************************************************************************
*                                                                       *
*  Конструктор                                                          *
*                                                                       *
************************************************************************/

CLuaZone::CLuaZone(CZone* PZone)
{
    m_pLuaZone = PZone;
}

/************************************************************************
*                                                                       *
*  Регистрируем активную область в зоне                                 *
*  Формат входных данных: RegionID, x1, y1, z1, x2, y2, z2              *
*                                                                       *
************************************************************************/

inline int32 CLuaZone::registerRegion(lua_State *L)
{
    if (m_pLuaZone != nullptr)
    {
        if (!lua_isnil(L, 1) && lua_isnumber(L, 1) &&
            !lua_isnil(L, 2) && lua_isnumber(L, 2) &&
            !lua_isnil(L, 3) && lua_isnumber(L, 3) &&
            !lua_isnil(L, 4) && lua_isnumber(L, 4) &&
            !lua_isnil(L, 5) && lua_isnumber(L, 5) &&
            !lua_isnil(L, 6) && lua_isnumber(L, 6) &&
            !lua_isnil(L, 7) && lua_isnumber(L, 7))
        {
            bool circleRegion = false;
            if (lua_tointeger(L, 5) == 0 && lua_tointeger(L, 6) == 0 && lua_tointeger(L, 7) == 0)
                circleRegion = true; // Parameters were 0, we must be a circle.

            CRegion* Region = new CRegion((uint32)lua_tointeger(L, 1), circleRegion);

            // If this is a circle, parameter 3 (which would otherwise be vertical coordinate) will be the radius.
            Region->SetULCorner((float)lua_tointeger(L, 2), (float)lua_tointeger(L, 3), (float)lua_tointeger(L, 4));
            Region->SetLRCorner((float)lua_tointeger(L, 5), (float)lua_tointeger(L, 6), (float)lua_tointeger(L, 7));

            m_pLuaZone->InsertRegion(Region);
        }
        else
        {
            ShowWarning(CL_YELLOW"Region cannot be registered. Please check the parameters.\n" CL_RESET);
        }
    }
    lua_pushnil(L);
    return 1;
}

/************************************************************************
*                                                                       *
*  Устанавливаем ограничение уровня для зоны                            *
*                                                                       *
************************************************************************/

inline int32 CLuaZone::levelRestriction(lua_State *L)
{
    if (m_pLuaZone != nullptr)
    {

    }
    lua_pushnil(L);
    return 1;
}

inline int32 CLuaZone::getPlayers(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_newtable(L);
    int newTable = lua_gettop(L);

    m_pLuaZone->ForEachChar([&L, &newTable](CCharEntity* PChar) {
        lua_getglobal(L, CLuaBaseEntity::className);
        lua_pushstring(L, "new");
        lua_gettable(L, -2);
        lua_insert(L, -2);
        lua_pushlightuserdata(L, (void*)PChar);
        lua_pcall(L, 2, 1, 0);
        lua_setfield(L, newTable, (const char*)PChar->GetName());
    });

    return 1;
}

inline int32 CLuaZone::getID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushinteger(L, m_pLuaZone->GetID());

    return 1;
}

inline int32 CLuaZone::getName(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushstring(L, (const char*)m_pLuaZone->GetName());

    return 1;
}

inline int32 CLuaZone::getRegionID(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushinteger(L, m_pLuaZone->GetRegionID());

    return 1;
}

inline int32 CLuaZone::getType(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    lua_pushinteger(L, m_pLuaZone->GetType());
    return 1;
}

inline int32 CLuaZone::getBattlefieldByInitiator(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isnumber(L, 1));

    if (m_pLuaZone->m_BattlefieldHandler)
        lua_pushlightuserdata(L, (void*)m_pLuaZone->m_BattlefieldHandler->GetBattlefieldByInitiator((uint32)lua_tointeger(L, 1)));
    else
        lua_pushnil(L);
    return 1;
}

inline int32 CLuaZone::battlefieldsFull(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    int battlefieldId = lua_isnil(L, 1) ? -1 : (int)lua_tointeger(L, 1);
    lua_pushboolean(L, (int)(m_pLuaZone->m_BattlefieldHandler && m_pLuaZone->m_BattlefieldHandler->ReachedMaxCapacity(battlefieldId)));
    return 1;
}

/************************************************************************
*  Function: getWeather()
*  Purpose : Returns the current weather status
************************************************************************/

inline int32 CLuaZone::getWeather(lua_State *L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    WEATHER weather = m_pLuaZone->GetWeather();
    lua_pushinteger(L, weather);
    return 1;
}

/************************************************************************
 *  Function: addListener()
 *  Purpose : Instructs the Event Handler to monitor for an Event, then
 *            execute a prepared Lua function once the Event has occurred
 *  Notes   : Function along with statements must be passed in L3
 ************************************************************************/

int32 CLuaZone::addListener(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isstring(L, 1));
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 2) || !lua_isstring(L, 2));
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 3) || !lua_isfunction(L, 3));

    auto eventName = lua_tostring(L, 1);
    auto identifier = lua_tostring(L, 2);

    m_pLuaZone->PEventHandler->addListener(eventName, luautils::register_fp(3), identifier);
    
    return 0;
}

/************************************************************************
 *  Function: removeListener()
 *  Purpose : Instructs the Event Handler to stop monitoring for an Event
 *  Example : zone:removeListener("TRANSPORTZONE_EVICT")
 *  Notes   : To be used if zones are destructed
 ************************************************************************/

int32 CLuaZone::removeListener(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isstring(L, 1));

    auto identifier = lua_tostring(L, 1);

    m_pLuaZone->PEventHandler->removeListener(identifier);

    return 0;
}

/************************************************************************
 *  Function: triggerListener()
 *  Purpose : Instructs Lua to execute an Event Function once a Trigger has
 *            been identified by the Event Handler
 *  Example : zone:triggerListener("TRANSPORTZONE_EVICT", zone)
 *  Notes   : Manually triggered through scripts if needed
 ************************************************************************/

int32 CLuaZone::triggerListener(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isstring(L, 1));

    auto eventName = lua_tostring(L, 1);
    auto top = lua_gettop(L);

    m_pLuaZone->PEventHandler->triggerListener(eventName, top - 1);

    return 0;
}

/************************************************************************
*  Function: printToZone()
*  Purpose : Sends a chat message to all players in the zone
************************************************************************/
int32 CLuaZone::printToZone(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    TPZ_DEBUG_BREAK_IF(lua_isnil(L, 1) || !lua_isstring(L, 1));

    // see scripts\globals\msg.lua or src\map\packets\chat_message.h for values
    CHAT_MESSAGE_TYPE messageLook = (lua_isnil(L, 2) || !lua_isnumber(L, 2)) ? MESSAGE_SYSTEM_1 : (CHAT_MESSAGE_TYPE)lua_tointeger(L, 2);
    uint8 messageRange = (lua_isnil(L, 3) || !lua_isnumber(L, 3)) ? 0 : (CHAT_MESSAGE_TYPE)lua_tointeger(L, 3);
    std::string name = (lua_isnil(L, 4) || !lua_isstring(L, 4)) ? std::string() : lua_tostring(L, 4);

    m_pLuaZone->PushPacket(nullptr, CHAR_INZONE, new CChatMessagePacket(nullptr, messageLook, (char*)lua_tostring(L, 1), name, m_pLuaZone->GetID()));

    return 0;
}

/************************************************************************
*  Function: getMusicBattleSolo()
*  Purpose : Returns the music of solo battles in the zone
************************************************************************/
int32 CLuaZone::getMusicBattleSolo(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushinteger(L, m_pLuaZone->GetSoloBattleMusic());

    return 1;
}

/************************************************************************
*  Function: getMusicBattleParty()
*  Purpose : Returns the music of party battles in the zone
************************************************************************/
int32 CLuaZone::getMusicBattleParty(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushinteger(L, m_pLuaZone->GetPartyBattleMusic());

    return 1;
}

/************************************************************************
*  Function: getMusicBackgroundDay()
*  Purpose : Returns the daytime background music in the zone
************************************************************************/
int32 CLuaZone::getMusicBackgroundDay(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushinteger(L, m_pLuaZone->GetBackgroundMusicDay());

    return 1;
}

/************************************************************************
*  Function: getMusicBackgroundNight()
*  Purpose : Returns the nighttime background music in the zone
************************************************************************/
int32 CLuaZone::getMusicBackgroundNight(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushinteger(L, m_pLuaZone->GetBackgroundMusicNight());

    return 1;
}

/************************************************************************
*  Function: setMusicBattleSolo()
*  Purpose : Changes the music of solo battles in the zone
************************************************************************/
int32 CLuaZone::setMusicBattleSolo(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    if (lua_isnil(L, 1) || !lua_isnumber(L, 1)) {
        return 0;
    }
    m_pLuaZone->SetSoloBattleMusic((uint8)lua_tointeger(L, 1));

    return 0;
}

/************************************************************************
*  Function: setMusicBattleParty()
*  Purpose : Changes the music of party battles in the zone
************************************************************************/
int32 CLuaZone::setMusicBattleParty(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    if (lua_isnil(L, 1) || !lua_isnumber(L, 1)) {
        return 0;
    }
    m_pLuaZone->SetPartyBattleMusic((uint8)lua_tointeger(L, 1));

    return 0;
}

/************************************************************************
*  Function: setMusicBackgroundDay()
*  Purpose : Changes the daytime background music in the zone
************************************************************************/
int32 CLuaZone::setMusicBackgroundDay(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    if (lua_isnil(L, 1) || !lua_isnumber(L, 1)) {
        return 0;
    }
    m_pLuaZone->SetBackgroundMusicDay((uint8)lua_tointeger(L, 1));

    return 0;
}

/************************************************************************
*  Function: setMusicBackgroundNight()
*  Purpose : Changes the nighttime background music in the zone
************************************************************************/
int32 CLuaZone::setMusicBackgroundNight(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    if (lua_isnil(L, 1) || !lua_isnumber(L, 1)) {
        return 0;
    }
    m_pLuaZone->SetBackgroundMusicNight((uint8)lua_tointeger(L, 1));

    return 0;
}

void CLuaZone::reloadNavmesh()
{
    m_pLuaZone->m_navMesh->reload();
}

/************************************************************************
*  Function: getPlayerAbilitiesState()
*  Purpose : Returns whether the zone checks for mobs that react to job abilities
************************************************************************/
int32 CLuaZone::getPlayerAbilitiesState(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);

    lua_pushboolean(L, m_pLuaZone->m_playerAbilityHandle);

    return 1;
}

/************************************************************************
*  Function: setPlayerAbilitiesState()
*  Purpose : Sets whether the zone checks for mobs that react to job abilities
************************************************************************/
int32 CLuaZone::setPlayerAbilitiesState(lua_State* L)
{
    TPZ_DEBUG_BREAK_IF(m_pLuaZone == nullptr);
    if (lua_isnil(L, 1) || !lua_isboolean(L, 1)) {
        return 0;
    }

    m_pLuaZone->m_playerAbilityHandle = lua_toboolean(L, 1);

    return 0;
}

/************************************************************************
*                                                                       *
*  Initializing Methods in LUA                                          *
*                                                                       *
************************************************************************/

const char CLuaZone::className[] = "CZone";
Lunar<CLuaZone>::Register_t CLuaZone::methods[] =
{
    LUNAR_DECLARE_METHOD(CLuaZone,registerRegion),
    LUNAR_DECLARE_METHOD(CLuaZone,levelRestriction),
    LUNAR_DECLARE_METHOD(CLuaZone,getPlayers),
    LUNAR_DECLARE_METHOD(CLuaZone,getID),
    LUNAR_DECLARE_METHOD(CLuaZone,getName),
    LUNAR_DECLARE_METHOD(CLuaZone,getRegionID),
    LUNAR_DECLARE_METHOD(CLuaZone,getType),
    LUNAR_DECLARE_METHOD(CLuaZone,getBattlefieldByInitiator),
    LUNAR_DECLARE_METHOD(CLuaZone,battlefieldsFull),
    LUNAR_DECLARE_METHOD(CLuaZone,getWeather),
    LUNAR_DECLARE_METHOD(CLuaZone, addListener),
    LUNAR_DECLARE_METHOD(CLuaZone, removeListener),
    LUNAR_DECLARE_METHOD(CLuaZone, triggerListener),
    LUNAR_DECLARE_METHOD(CLuaZone, printToZone),
    LUNAR_DECLARE_METHOD(CLuaZone, getMusicBattleSolo),
    LUNAR_DECLARE_METHOD(CLuaZone, getMusicBattleParty),
    LUNAR_DECLARE_METHOD(CLuaZone, getMusicBackgroundDay),
    LUNAR_DECLARE_METHOD(CLuaZone, getMusicBackgroundNight),
    LUNAR_DECLARE_METHOD(CLuaZone, setMusicBattleSolo),
    LUNAR_DECLARE_METHOD(CLuaZone, setMusicBattleParty),
    LUNAR_DECLARE_METHOD(CLuaZone, setMusicBackgroundDay),
    LUNAR_DECLARE_METHOD(CLuaZone, setMusicBackgroundNight),
    LUNAR_DECLARE_METHOD(CLuaZone, getPlayerAbilitiesState),
    LUNAR_DECLARE_METHOD(CLuaZone, setPlayerAbilitiesState),
{nullptr,nullptr}
};
