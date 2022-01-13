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

#include "../common/blowfish.h"
#include "../common/md52.h"
#include "../common/showmsg.h"
#include "../common/timer.h"
#include "../common/utils.h"
#include "../common/version.h"
#include "../common/zlib.h"

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <thread>
#include <random>

#include "alliance.h"
#include "ability.h"
#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "utils/fishingutils.h"
#include "utils/gardenutils.h"
#include "utils/guildutils.h"
#include "utils/instanceutils.h"
#include "utils/itemutils.h"
#include "linkshell.h"
#include "map.h"
#include "mob_spell_list.h"
#include "packet_guard.h"
#include "packet_system.h"
#include "party.h"
#include "utils/petutils.h"
#include "utils/trustutils.h"
#include "roe.h"
#include "spell.h"
#include "time_server.h"
#include "transport.h"
#include "vana_time.h"
#include "status_effect_container.h"
#include "utils/zoneutils.h"
#include "conquest_system.h"
#include "daily_system.h"
#include "utils/mobutils.h"
#include "ai/controllers/automaton_controller.h"

#include "lua/luautils.h"

#include "packets/action.h"
#include "packets/basic.h"
#include "packets/char.h"
#include "packets/char_update.h"
#include "packets/entity_update.h"
#include "message.h"

#include "entities/trustentity.h"

#include "utils/flistutils.h"
#include "pruned_session.h"

#ifdef TRACY_ENABLE
void* operator new(std::size_t count)
{
    auto ptr = malloc(count);
    TracyAlloc(ptr, count);
    return ptr;
}

void operator delete(void* ptr) noexcept
{
    TracyFree(ptr);
    free(ptr);
}
#endif // TRACY_ENABLE

const char* MAP_CONF_FILENAME = nullptr;

int8*  g_PBuff = nullptr;                // global packet clipboard
int8*  PTempBuff = nullptr;              // temporary packet clipboard
int8*  PTempBuff2 = nullptr;             // another temporary packet clipboard

thread_local Sql_t* SqlHandle = nullptr;

int32  map_fd = 0;                      // main socket
uint32 map_amntplayers = 0;             // map amnt unique players

bool map_doing_final = false;

in_addr map_ip;
uint16 map_port = 0;

map_config_t map_config;                // map server settings
map_session_list_t map_session_list;
CCommandHandler CmdHandler;

std::thread messageThread;

bool inCrashRecoveryLoop;
bool isForceCreateSessionEnabled;
std::vector<pruned_session> prunedSessionsList;

/************************************************************************
*                                                                       *
*  mapsession_getbyipp                                                  *
*                                                                       *
************************************************************************/

map_session_data_t* mapsession_getbyipp(uint64 ipp)
{
    map_session_list_t::iterator i = map_session_list.begin();
    while (i != map_session_list.end())
    {
        if ((*i).first == ipp)
            return (*i).second;
        i++;
    }
    return nullptr;
}

/************************************************************************
*                                                                       *
*  mapsession_createsession                                             *
*                                                                       *
************************************************************************/

map_session_data_t* mapsession_createsession(uint32 ip, uint16 port, bool force)
{
    TracyZoneScoped;
    map_session_data_t* map_session_data = new map_session_data_t;
    memset(map_session_data, 0, sizeof(map_session_data_t));

    map_session_data->server_packet_data = new int8[map_config.buffer_size + 20];

    map_session_data->last_update = time(nullptr);
    map_session_data->client_addr = ip;
    map_session_data->client_port = port;

    uint64 port64 = port;
    uint64 ipp = ip;
    ipp |= port64 << 32;
    map_session_list[ipp] = map_session_data;

    if (force)
    {
        //ShowDebug("mapsession_createsession force detected\n");
        int32 it = 0;
        int32 at = -1;
        bool doReturn = false;
        std::for_each(std::begin(prunedSessionsList), std::end(prunedSessionsList), [&ip, &doReturn, &it, &at](pruned_session const session)
        {
            if (ip == session.m_5_client_addr && session.m_recoveryQueued == true)
            {
                at = it;
                doReturn = true;
                //ShowDebug("mapsession_createsession force detected AND doReturn is true\n");
            }
            it++;
        });
        if (doReturn)
        {
            prunedSessionsList.at(at).m_recoveryQueued = false;

            const char* fmtQuery = "INSERT INTO accounts_sessions(accid,charid,session_key,server_addr,server_port,client_addr, version_mismatch, client_version) VALUES(%u,%u,x'%s',%u,%u,%u,%u,'%s')";

            char client_ver_esc[32] = { 0 };
            Sql_EscapeString(SqlHandle, client_ver_esc, prunedSessionsList.at(at).m_7_client_version);
            
            uint8 temp[20];
            memcpy(temp, prunedSessionsList.at(at).m_2_session_key, 20);
            char session_key[20 * 2 + 1];
            bin2hex(session_key, temp, sizeof(temp));
            Sql_Query(SqlHandle, fmtQuery, prunedSessionsList.at(at).m_0_accid, prunedSessionsList.at(at).m_1_charid, session_key, prunedSessionsList.at(at).m_3_ZoneIP,
                prunedSessionsList.at(at).m_4_ZonePort, prunedSessionsList.at(at).m_5_client_addr, prunedSessionsList.at(at).m_6_version_mismatch, client_ver_esc);
            return map_session_data;
        }
    }

    bool showError = true;

    const char* fmtQuery = "SELECT charid FROM accounts_sessions WHERE inet_ntoa(client_addr) = '%s' LIMIT 1;";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, ip2str(map_session_data->client_addr));

    if (ret == SQL_ERROR ||
        Sql_NumRows(SqlHandle) == 0)
    {
        if (inCrashRecoveryLoop)
        {
            int32 it = 0;
            int32 at = -1;
            std::for_each(std::begin(prunedSessionsList), std::end(prunedSessionsList), [&ip, &showError, &it, &at](pruned_session const session)
            {
                    //ShowDebug("Input IP %u checked against pruned IP %u\n",ip, session.m_5_client_addr);
                if (ip == session.m_5_client_addr)
                {
                    at = it;
                    showError = false;
                }
                it++;
            });
            if (at != -1)
                prunedSessionsList.at(at).m_recoveryQueued = true;
        }
        if (showError)
            ShowError(CL_RED"recv_parse: Invalid login attempt from %s\n" CL_RESET, ip2str(map_session_data->client_addr));
        return nullptr;
    }
    return map_session_data;
}

/************************************************************************
*                                                                       *
*  do_init                                                              *
*                                                                       *
************************************************************************/

int32 do_init(int32 argc, char** argv)
{
    TracyZoneScoped;
    ShowStatus("do_init: begin server initialization...");
    map_ip.s_addr = 0;
    uint32 debug_ip = 0;

    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--ip") == 0)
        {
            uint32 ip;
            inet_pton(AF_INET, argv[i + 1], &ip);
            map_ip.s_addr = ip;
        }
        else if (strcmp(argv[i], "--port") == 0)
            map_port = std::stoi(argv[i + 1]);
        else if (strcmp(argv[i], "--debugip") == 0)
            inet_pton(AF_INET, argv[i + 1], &debug_ip);
    }

    MAP_CONF_FILENAME = "./conf/map.conf";

    srand((uint32)time(nullptr));
    tpzrand::seed();

    map_config_default();
    map_config_read((const int8*)MAP_CONF_FILENAME);
    map_config_from_env();
    if (debug_ip) {
        map_config.debug_client_ip = debug_ip;
    }
    ShowMessage("\t\t - " CL_GREEN"[OK]" CL_RESET"\n");
    ShowStatus("do_init: map_config is reading");
    ShowMessage("\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    luautils::init();
    CmdHandler.init(luautils::LuaHandle);
    PacketParserInitialize();
    SqlHandle = Sql_Malloc();

    ShowStatus("do_init: sqlhandle is allocating");
    if (map_config.mysql_ssl) {
        if (Sql_SSL(SqlHandle,
            true,
            map_config.mysql_ssl_verify,
            map_config.mysql_ssl_ca.c_str(),
            map_config.mysql_ssl_cert.c_str(),
            map_config.mysql_ssl_key.c_str()) == SQL_ERROR) {
            do_final(EXIT_FAILURE);
        }
    }

    if (Sql_Connect(SqlHandle, map_config.mysql_login.c_str(),
        map_config.mysql_password.c_str(),
        map_config.mysql_host.c_str(),
        map_config.mysql_port,
        map_config.mysql_database.c_str()) == SQL_ERROR)
    {
        do_final(EXIT_FAILURE);
    }
    Sql_Keepalive(SqlHandle);

    // crash recovery, save pruned sessions to RAM before clearing SQL
    inCrashRecoveryLoop = false;
    isForceCreateSessionEnabled = false;
    prunedSessionsList.clear();
    Sql_Query(SqlHandle, "SELECT accid,charid,session_key,server_addr,server_port,client_addr,version_mismatch,client_version FROM accounts_sessions WHERE IF(%u = 0 AND %u = 0, true, server_addr = %u AND server_port = %u);", map_ip.s_addr, map_port, map_ip.s_addr, map_port);
    while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        uint32 v0 = Sql_GetUIntData(SqlHandle, 0);
        uint32 v1 = Sql_GetUIntData(SqlHandle, 1);
        uint32 v2[5];
        char* c_str = nullptr;
        Sql_GetData(SqlHandle, 2, &c_str, nullptr);
        memcpy(v2, c_str, 20);
        uint32 v3 = Sql_GetUIntData(SqlHandle, 3);
        uint16 v4 = Sql_GetUIntData(SqlHandle, 4);
        uint32 v5 = Sql_GetUIntData(SqlHandle, 5);
        uint8  v6 = Sql_GetUIntData(SqlHandle, 6);
        char   v7[32];
        char* c_str2 = nullptr;
        Sql_GetData(SqlHandle, 7, &c_str2, nullptr);
        memcpy(v7, c_str2, 32);
        
        prunedSessionsList.push_back(pruned_session(v0, v1, &(v2[0]), v3, v4, v5, v6, v7));
    }

    // отчищаем таблицу сессий при старте сервера (временное решение, т.к. в кластере это не будет работать)
    Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE IF(%u = 0 AND %u = 0, true, server_addr = %u AND server_port = %u);", map_ip.s_addr, map_port, map_ip.s_addr, map_port);

    // suspending this operation until more work can be done on this
    // definitely need to get more info on the storage of P and S on client blowkey
    // may need to add these into accounts_sessions in order for this recovery system to work
    prunedSessionsList.clear();

    ShowMessage("\t\t - " CL_GREEN"[OK]" CL_RESET"\n");
    ShowStatus("do_init: zlib is reading");
    zlib_init();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    messageThread = std::thread(message::init, map_config.msg_server_ip.c_str(), map_config.msg_server_port);

    ShowStatus("do_init: loading items");
    itemutils::Initialize();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    ShowStatus("do_init: loading plants");
    gardenutils::Initialize();
    ShowMessage("\t\t\t - " CL_GREEN "[OK]" CL_RESET "\n");

    // нужно будет написать один метод для инициализации всех данных в battleutils
    // и один метод для освобождения этих данных

    ShowStatus("do_init: loading spells");
    spell::LoadSpellList();
    mobSpellList::LoadMobSpellList();
    autoSpell::LoadAutomatonSpellList();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    guildutils::Initialize();
    charutils::LoadExpTable();
    traits::LoadTraitsList();
    effects::LoadEffectsParameters();
    battleutils::LoadSkillTable();
    meritNameSpace::LoadMeritsList();
    ability::LoadAbilitiesList();
    battleutils::LoadWeaponSkillsList();
    battleutils::LoadMobSkillsList();
    battleutils::LoadSkillChainDamageModifiers();
    petutils::LoadPetList();
    trustutils::LoadTrustList();
    mobutils::LoadCustomMods();
    daily::LoadDailyItems();
    roeutils::init();

    ShowStatus("do_init: loading zones");
    zoneutils::LoadZoneList();
    ShowMessage("\t\t\t - " CL_GREEN"[OK]" CL_RESET"\n");

    fishingutils::LoadFishingMessages();

    ShowStatus("do_init: server is binding with port %u", map_port == 0 ? map_config.usMapPort : map_port);
    map_fd = makeBind_udp(map_config.uiMapIp, map_port == 0 ? map_config.usMapPort : map_port);
    ShowMessage("\t - " CL_GREEN"[OK]" CL_RESET"\n");

    CVanaTime::getInstance()->setCustomEpoch(map_config.vanadiel_time_epoch);

    zoneutils::InitializeWeather(); // Need VanaTime initialized
    zoneutils::InitializeDigAreaTimer();

    CTransportHandler::getInstance()->InitializeTransport();

    CTaskMgr::getInstance()->AddTask("time_server", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, time_server, 2400ms);
    CTaskMgr::getInstance()->AddTask("map_cleanup", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, map_cleanup, 5s);
    CTaskMgr::getInstance()->AddTask("garbage_collect", server_clock::now(), nullptr, CTaskMgr::TASK_INTERVAL, map_garbage_collect, 15min);
    CTaskMgr::getInstance()->AddTask("crash_recovery_end", server_clock::now() + 2s, nullptr, CTaskMgr::TASK_ONCE, crash_recovery_end);
    CTaskMgr::getInstance()->AddTask("disableForceCreateSession", server_clock::now() + 4s, nullptr, CTaskMgr::TASK_ONCE, disableForceCreateSession);

    //ShowDebug("prunedSessionsList size is %u\n", (uint32)prunedSessionsList.size());
    if (prunedSessionsList.size() >= map_config.zone_crash_recovery_min_players)
        inCrashRecoveryLoop = true;

    g_PBuff = new int8[map_config.buffer_size + 20];
    PTempBuff = new int8[map_config.buffer_size + 20];
    PTempBuff2 = new int8[map_config.buffer_size + 20];

    PacketGuard::Init();

    ShowStatus("The map-server is " CL_GREEN"ready" CL_RESET" to work...\n");
    ShowMessage("=======================================================================\n");
    //ShowInfo("Crash recovery running, checking for pruned connections...\n");
    return 0;
}

/************************************************************************
*                                                                       *
*  do_final                                                             *
*                                                                       *
************************************************************************/

void do_final(int code)
{
    map_doing_final = true;

    delete[] g_PBuff;
    g_PBuff = nullptr;
    delete[] PTempBuff;
    PTempBuff = nullptr;
    delete[] PTempBuff2;
    PTempBuff2 = nullptr;

    itemutils::FreeItemList();
    battleutils::FreeWeaponSkillsList();
    battleutils::FreeMobSkillList();

    petutils::FreePetList();
    trustutils::FreeTrustList();
    zoneutils::FreeZoneList();
    luautils::free();
    message::close();
    if (messageThread.joinable())
    {
        messageThread.join();
    }

    CTaskMgr::delInstance();
    CVanaTime::delInstance();

    Sql_Free(SqlHandle);
    SqlHandle = nullptr;

    timer_final();
    socket_final();

    exit(code);
}

/************************************************************************
*                                                                       *
*  do_abort                                                             *
*                                                                       *
************************************************************************/

void do_abort(void)
{
    do_final(EXIT_FAILURE);
}

/************************************************************************
*                                                                       *
*  set_server_type                                                      *
*                                                                       *
************************************************************************/

void set_server_type()
{
    SERVER_TYPE = TOPAZ_SERVER_MAP;
    SOCKET_TYPE = socket_type::UDP;
}

/************************************************************************
*                                                                       *
*  do_sockets                                                           *
*                                                                       *
************************************************************************/

int32 do_sockets(fd_set* rfd, duration next)
{
    struct timeval timeout;
    int32 ret;
    memcpy(rfd, &readfds, sizeof(*rfd));

    timeout.tv_sec = (long)std::chrono::duration_cast<std::chrono::seconds>(next).count();
    timeout.tv_usec = (long)std::chrono::duration_cast<std::chrono::microseconds>(next - std::chrono::duration_cast<std::chrono::seconds>(next)).count();

    ret = sSelect(fd_max, rfd, nullptr, nullptr, &timeout);

    if (ret == SOCKET_ERROR)
    {
        if (sErrno != S_EINTR)
        {
            ShowFatalError("do_sockets: select() failed, error code %d!\n", sErrno);
            do_final(EXIT_FAILURE);
        }
        return 0; // interrupted by a signal, just loop and try again
    }

    last_tick = time(nullptr);

    // Check that we still have a DB connection, attempt to recover if needed
    if (!SqlHandle) {
        SqlHandle = Sql_Malloc();

        if (map_config.mysql_ssl) {
            if (Sql_SSL(SqlHandle,
                true,
                map_config.mysql_ssl_verify,
                map_config.mysql_ssl_ca.c_str(),
                map_config.mysql_ssl_cert.c_str(),
                map_config.mysql_ssl_key.c_str()) == SQL_ERROR) {
                exit(EXIT_FAILURE);
            }
        }

        if (Sql_Connect(SqlHandle, map_config.mysql_login.c_str(),
            map_config.mysql_password.c_str(),
            map_config.mysql_host.c_str(),
            map_config.mysql_port,
            map_config.mysql_database.c_str()) == SQL_ERROR)
        {
            exit(EXIT_FAILURE);
        }
        Sql_Keepalive(SqlHandle);
    }

    if (sFD_ISSET(map_fd, rfd))
    {
        struct sockaddr_in from;
        socklen_t fromlen = sizeof(from);

        int32 ret = recvudp(map_fd, g_PBuff, map_config.buffer_size, 0, (struct sockaddr*)&from, &fromlen);
        if (ret != -1)
        {
            if (from.sin_addr.s_addr == map_config.debug_client_ip) {
                ShowDebug(CL_CYAN"do_sockets: Packet from debug IP.\n");
            }
            // find player char
#   ifdef WIN32
            uint32 ip = ntohl(from.sin_addr.S_un.S_addr);
#   else
            uint32 ip = ntohl(from.sin_addr.s_addr);
#   endif

            uint64 port = ntohs(from.sin_port);
            uint64 ipp = ip;
            ipp |= port << 32;
            map_session_data_t* map_session_data = mapsession_getbyipp(ipp);

            if (map_session_data == nullptr)
            {
                map_session_data = mapsession_createsession(ip, ntohs(from.sin_port), isForceCreateSessionEnabled);
                if (map_session_data == nullptr)
                {
                    map_session_list.erase(ipp);
                    return -1;
                }
                //ShowDebug("map_session_data created successfully\n");
            }

            map_session_data->last_update = time(nullptr);
            size_t size = ret;

            if (recv_parse(g_PBuff, &size, &from, map_session_data) != -1)
            {
                // если предыдущий пакет был потерян, то мы не собираем новый,
                // а отправляем предыдущий пакет повторно
                if (!parse(g_PBuff, &size, &from, map_session_data))
                {
                    send_parse(g_PBuff, &size, &from, map_session_data);
                }

                ret = sendudp(map_fd, g_PBuff, size, 0, (const struct sockaddr*)&from, fromlen);

                int8* data = g_PBuff;
                g_PBuff = map_session_data->server_packet_data;

                map_session_data->server_packet_data = data;
                map_session_data->server_packet_size = size;
            }
            if (map_session_data->shuttingDown > 0)
            {
                map_close_session(server_clock::now(), map_session_data);
            }
        }
    }

    TracyReportLuaMemory(luautils::LuaHandle);

    return 0;
}

/************************************************************************
*                                                                       *
*  parse_console                                                        *
*                                                                       *
************************************************************************/

int32 parse_console(int8* buf)
{
    return 0;
}

/************************************************************************
*                                                                       *
*  map_decipher_packet                                                  *
*                                                                       *
************************************************************************/

int32 map_decipher_packet(int8* buff, size_t size, sockaddr_in* from, map_session_data_t* map_session_data)
{
    uint16 tmp, i;

    // counting blocks whose size = 4 byte
    tmp = (uint16)((size - FFXI_HEADER_SIZE) / 4);
    tmp -= tmp % 2;

#   ifdef WIN32
    uint32 ip = ntohl(from->sin_addr.S_un.S_addr);
#   else
    uint32 ip = ntohl(from->sin_addr.s_addr);
#   endif

    blowfish_t *pbfkey = &map_session_data->blowfish;

    int32 at = -1;
    int32 it = 0;

    if (isForceCreateSessionEnabled)
    {
        std::for_each(std::begin(prunedSessionsList), std::end(prunedSessionsList), [&ip, &it, &at](pruned_session const session)
            {
                if (ip == session.m_5_client_addr)
                {
                    at = it;
                }
                it++;
            });
    }

    if (at != -1)
    {
        //ShowDebug("map_encipher_packet: attempting pruned key %u\n", prunedSessionsList.at(at).m_2_session_key[4]);

        memcpy(map_session_data->blowfish.key, &(prunedSessionsList.at(at).m_2_session_key[0]), 20);
        blowfish_init((int8*)&(map_session_data->blowfish.key), 20, (uint32*)&(map_session_data->blowfish.P), (uint32*)&(map_session_data->blowfish.S));

        pbfkey = &map_session_data->blowfish;

        // todo: drop the above stuff, it's not working
        // instead, reinterpret packet as a login packet (0x0a)
        // and use a different return code in this if statement (return code 1) that skips decipher and checksum
        // that return code will tell the calling function to skip zlib compression and immediately interpret the packet
        // the argument "size" for this function must be changed to a pointer so that it is a modifiable value for the reinterpretation
    }

    for (i = 0; i < tmp; i += 2)
    {
        blowfish_decipher((uint32*)buff + i + 7, (uint32*)buff + i + 8, pbfkey->P, pbfkey->S[0]);
    }

    if (checksum((uint8*)(buff + FFXI_HEADER_SIZE), (uint32)(size - (FFXI_HEADER_SIZE + 16)), (char*)(buff + size - 16)) == 0)
    {
        return 0;
    }

    ShowError("map_encipher_packet: bad packet from <%s>\n", ip2str(ip));
    return -1;
}

/************************************************************************
*                                                                       *
*  main function to parse recv packets                                  *
*                                                                       *
************************************************************************/

int32 recv_parse(int8* buff, size_t* buffsize, sockaddr_in* from, map_session_data_t* map_session_data)
{
    size_t size = *buffsize;
    int32 checksumResult = -1;
    int8* packetDataBuffer = (int8*)alloca(map_config.buffer_size);

#ifdef WIN32
    try
    {
        checksumResult = checksum((uint8*)(buff + FFXI_HEADER_SIZE), (uint32)(size - (FFXI_HEADER_SIZE + 16)), (char*)(buff + size - 16));
    }
    catch (...)
    {
        ShowError(CL_RED"Possible crash attempt from: %s\n" CL_RESET, ip2str(map_session_data->client_addr));
        return -1;
    }
#else
    checksumResult = checksum((uint8*)(buff + FFXI_HEADER_SIZE), size - (FFXI_HEADER_SIZE + 16), (char*)(buff + size - 16));
#endif

    if (checksumResult == 0)
    {
        if (map_session_data->PChar == nullptr)
        {
            uint32 CharID = ref<uint32>(buff, FFXI_HEADER_SIZE + 0x0C);

            const char* fmtQuery = "SELECT charid FROM chars WHERE charid = %u LIMIT 1;";

            int32 ret = Sql_Query(SqlHandle, fmtQuery, CharID);

            if (ret == SQL_ERROR ||
                Sql_NumRows(SqlHandle) == 0 ||
                Sql_NextRow(SqlHandle) != SQL_SUCCESS)
            {
                ShowError(CL_RED"recv_parse: Cannot load charid %u" CL_RESET, CharID);
                return -1;
            }

            fmtQuery = "SELECT session_key FROM accounts_sessions WHERE charid = %u LIMIT 1;";

            ret = Sql_Query(SqlHandle, fmtQuery, CharID);

            if (ret == SQL_ERROR ||
                Sql_NumRows(SqlHandle) == 0 ||
                Sql_NextRow(SqlHandle) != SQL_SUCCESS)
            {
                ShowError(CL_RED"recv_parse: Cannot load session_key for charid %u" CL_RESET, CharID);
            }
            else
            {
                char* strSessionKey = nullptr;
                Sql_GetData(SqlHandle, 0, &strSessionKey, nullptr);

                memcpy(map_session_data->blowfish.key, strSessionKey, 20);
            }

            // наверное создание персонажа лучше вынести в метод charutils::LoadChar() и загрузку инвентаря туда же сунуть
            CCharEntity* PChar = new CCharEntity();
            PChar->id = CharID;

            charutils::LoadChar(PChar);
            if (PChar->loc.prevzone == 0) {
                // New chars must wait one cooldown before they can yell
                charutils::SetCharUVar(PChar->id, "NextYell", gettick() + (map_config.yell_cooldown * 1000));
            }

            if (map_config.mission_storage_recovery) {
                charutils::UpdateMissionStorage(PChar, true);
            }

            PChar->status = STATUS_DISAPPEAR;

            map_session_data->PChar = PChar;
        }
        map_session_data->client_packet_id = 0;
        map_session_data->server_packet_id = 0;
        return 0;
    }
    else
    {
        //char packets

        if (map_decipher_packet(buff, *buffsize, from, map_session_data) == -1)
        {
            *buffsize = 0;
            return -1;
        }
        // reading data size
        uint32 PacketDataSize = ref<uint32>(buff, *buffsize - sizeof(int32) - 16);
        // it's decompressing data and getting new size
        PacketDataSize = zlib_decompress(buff + FFXI_HEADER_SIZE,
            PacketDataSize,
            packetDataBuffer,
            map_config.buffer_size);

        // it's making result buff
        // don't need memcpy header
        memcpy(buff + FFXI_HEADER_SIZE, packetDataBuffer, PacketDataSize);
        *buffsize = FFXI_HEADER_SIZE + PacketDataSize;

        return 0;
    }
    return -1;
}

/************************************************************************
*                                                                       *
*  main function parsing the packets                                    *
*                                                                       *
************************************************************************/

int32 parse(int8* buff, size_t* buffsize, sockaddr_in* from, map_session_data_t* map_session_data)
{
    TracyZoneScoped;
    // начало обработки входящего пакета

    int8* PacketData_Begin = &buff[FFXI_HEADER_SIZE];
    int8* PacketData_End = &buff[*buffsize];

    CCharEntity* PChar = map_session_data->PChar;

    TracyZoneIString(PChar->GetName());

    time_t timeNow = time(NULL);
    if (timeNow > PChar->m_lastPacketTime + 3) {
        PChar->m_gracePeriodEnd = timeNow + 3;
    }
    PChar->m_lastPacketTime = timeNow;

    uint16 SmallPD_Size = 0;
    uint16 SmallPD_Type = 0;
    uint16 SmallPD_Code = ref<uint16>(buff, 0);

    for (int8* SmallPD_ptr = PacketData_Begin;
        SmallPD_ptr + (ref<uint8>(SmallPD_ptr, 1) & 0xFE) * 2 <= PacketData_End && (ref<uint8>(SmallPD_ptr, 1) & 0xFE);
        SmallPD_ptr = SmallPD_ptr + SmallPD_Size * 2)
    {
        SmallPD_Size = (ref<uint8>(SmallPD_ptr, 1) & 0x0FE);
        SmallPD_Type = (ref<uint16>(SmallPD_ptr, 0) & 0x1FF);

        if (PacketSize[SmallPD_Type] == SmallPD_Size || PacketSize[SmallPD_Type] == 0) // Tests incoming packets for the correct size prior to processing
        {
            // if the sequence of the current packet is less than or equal to the last received
            // or more than global then ignore the packet

            if ((ref<uint16>(SmallPD_ptr, 2) <= map_session_data->client_packet_id) ||
                (ref<uint16>(SmallPD_ptr, 2) > SmallPD_Code))
            {
                continue;
            }

            if (SmallPD_Type != 0x15)
            {
                ShowInfo("parse: %03hX | %04hX %04hX %02hX from user: %s\n", SmallPD_Type, ref<uint16>(SmallPD_ptr, 2), ref<uint16>(buff, 2), SmallPD_Size, PChar->GetName());
            }

            if (map_config.packetguard_enabled && PacketGuard::IsRateLimitedPacket(PChar, SmallPD_Type))
            {
                ShowExploit(CL_RED "[PacketGuard] Rate-limiting packet: Player: %s - Packet: %03hX\n" CL_RESET, PChar->GetName(), SmallPD_Type);
                continue; // skip this packet
            }

            if (map_config.packetguard_enabled && !PacketGuard::PacketIsValidForPlayerState(PChar, SmallPD_Type))
            {
                ShowExploit(CL_RED "[PacketGuard] Caught mismatch between player substate and recieved packet: Player: %s - Packet: %03hX\n" CL_RESET, PChar->GetName(), SmallPD_Type);
                // TODO: Plug in optional jailutils usage
                continue; // skip this packet
            }

            if (PChar->loc.zone == nullptr && SmallPD_Type != 0x0A)
            {
                ShowWarning("This packet is unexpected from %s - Received %03hX earlier without matching 0x0A\n", PChar->GetName(), SmallPD_Type);
            }
            else
            {
                PacketParser[SmallPD_Type](map_session_data, PChar, std::move(CBasicPacket(reinterpret_cast<uint8*>(SmallPD_ptr))));
            }
        }
        else
        {
            ShowWarning("Bad packet size %03hX | %04hX %04hX %02hX from user: %s\n", SmallPD_Type, ref<uint16>(SmallPD_ptr, 2), ref<uint16>(buff, 2), SmallPD_Size, PChar->GetName());
        }
    }
    map_session_data->client_packet_id = SmallPD_Code;

    // Google Translate:
    // here we check if the client received the previous package
    // if not received, then we do not create a new one, but send the previous one

    if (ref<uint16>(buff, 2) != map_session_data->server_packet_id)
    {
        ref<uint16>(map_session_data->server_packet_data, 2) = SmallPD_Code;
        ref<uint16>(map_session_data->server_packet_data, 8) = (uint32)time(nullptr);

        g_PBuff = map_session_data->server_packet_data;
        *buffsize = map_session_data->server_packet_size;

        map_session_data->server_packet_data = buff;
        return -1;
    }

    // GT: increase the number of the sent packet only if new data is sent

    map_session_data->server_packet_id += 1;

    return 0;
}

/************************************************************************
 *                                                                       *
 * generate packetlist within size constraints for bigpacket(send_parse) *
 *                                                                       *
 ************************************************************************/

PacketList_t generate_priority_packet_list(CCharEntity* PChar, map_session_data_t* map_session_data)
{
    auto getBufferSize = [](PacketList_t list) {
        size_t size = FFXI_HEADER_SIZE; // include header here
        while (!list.empty())
        {
            size += list.front()->length();
            list.pop_front();
        }
        return (uint32)size;
    };
    auto getCompressedBufferSize = [&map_session_data](PacketList_t list) {
        PacketList_t listcopy = list;
        size_t size = 0;
        CBasicPacket* PSmallPacket;
        while (!list.empty())
        {
            PSmallPacket = list.front();
            PSmallPacket->sequence(map_session_data->server_packet_id);
            memcpy(PTempBuff + size, PSmallPacket->getData(), PSmallPacket->length());
            size += PSmallPacket->length();
            list.pop_front();
        }
        TPZ_DEBUG_BREAK_IF(size > map_config.buffer_size); // should never happen with the help of logic short-circuiting
        //ShowDebug("Doing zlib_compress with size %u...\n", size);
        int32 zlibBits = zlib_compress(PTempBuff, (uint32)size, PTempBuff2, map_config.buffer_size);
        if (zlibBits == static_cast<uint32>(-1))
            return (uint32)0xFFFFFFFF;
        return (uint32)zlib_compressed_size(zlibBits);
    };

    PacketList_t priorityList;
    if (!PChar || !PChar->getPacketCount())
        return priorityList;
    priorityList = PChar->getPacketList();
    PacketList_t charPacketList = priorityList;
    
    if (getBufferSize(priorityList) < map_config.buffer_size && getCompressedBufferSize(priorityList) + 4 <= 1300 - FFXI_HEADER_SIZE - 16)
    { // no prioritization needed. optimization: just return the list.
        // finalization: all packets in priorityList will be sent, so do cleanup for what will be recycled and what will not
        for (auto it = priorityList.begin(); it != priorityList.end(); it++)
            (*it)->selectedForThisNetworkCycle = true;
        return priorityList;
    }

    bool isOrdered = false;
    auto orderPacketList = [&isOrdered, &PChar](PacketList_t list) {
        if (isOrdered)
            return list;

        PacketList_t orderedList;
        // front = least priority (higher value)
        // back = highest priority (lower value)

        // order matters on some packet types. they are placed before priority0 and will retain order
        // these deque are simply interims for the pointers. they do not manage the memory to the pointed objects.
        std::deque<CBasicPacket*> ordered;
        // for non-ordered, they will be randomized so that entities update somewhat uniformly
        std::deque<CBasicPacket*> priority0;   // char's own actions
        std::deque<CBasicPacket*> priority1;   // actions performed on char by enemies/party/alliance, tells/party chat
        std::deque<CBasicPacket*> priority2;   // party's/alliance's actions on other entities, party list updates
        std::deque<CBasicPacket*> priority3;   // positional updates of party/alliance (chance to hop to prio1)
        std::deque<CBasicPacket*> priority4;   // actions performed on party/alliance by enemies
        std::deque<CBasicPacket*> priority5;   // 
        std::deque<CBasicPacket*> priority6;   // linkshell chat
        std::deque<CBasicPacket*> priority7;   // position updates for mob entities (chance to hop to prio3, if ANIMATION_ATTACK and dist high enough, go prio2)
        std::deque<CBasicPacket*> priority8;   // non-partied players actions performed on you
        std::deque<CBasicPacket*> priority9;   // position updates for non-party players (chance to hop to prio5)
        std::deque<CBasicPacket*> priority10;  // non-partied players actions performed on party/alliance
        std::deque<CBasicPacket*> priority11;  // enemy actions on non-party targets
        std::deque<CBasicPacket*> priority12;  // non-partied players actions performed on anything else
        std::deque<CBasicPacket*> priority13;  // unsorted, default to lowest prio. remember to add new packets to the prioritization algorithm.

        CBaseEntity* PCursorTarget = PChar->GetEntity(PChar->m_TargID); // selecting someone with the cursor will give them highest priority
        uint32 CursorTargetID = PCursorTarget ? PCursorTarget->id : 0xFFFFFFFF;
        uint32 CursorTargetPetID = PCursorTarget && (PCursorTarget->objtype == TYPE_PC || PCursorTarget->objtype == TYPE_MOB) && ((CBattleEntity*)PCursorTarget)->PPet
                                        ? ((CBattleEntity*)PCursorTarget)->PPet->id : 0xFFFFFFFF;

        while (!list.empty())
        {
            CBasicPacket* PSmallPacket = list.front();
            if (!PSmallPacket)
            {
                list.pop_front();
                continue;
            }
            int priorityNum = 13;

            if (PSmallPacket->priorityNumOverride != 0xFF)
            {
                priorityNum = PSmallPacket->priorityNumOverride;
            }
            else
            {
                //ShowDebug("Packet Type is 0x%02hx and first 9 bits of data is 0x%03hx\n", PSmallPacket->getType(), ref<uint16>(PSmallPacket->getData(), 0) & 0x01FF);
                switch (PSmallPacket->getType()) // let's assume first 8 bits is packet id
                {
                    case 0x28: // action
                    {
                        uint32 OwnerID = ref<uint32>(PSmallPacket->getData(), 0x05);
                        if (OwnerID == PChar->id || (PChar->PPet && PChar->PPet->id == OwnerID))
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }

                        if (OwnerID == CursorTargetID || OwnerID == CursorTargetPetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }

                        // who all does this action target? let's extract the IDs.
                        // numtargs = uint8 0x09
                        // targ[index] = 150bits + 123bits * index
                        std::vector<uint32> AffectedIDs;
                        uint8 numtargs = ref<uint8>(PSmallPacket->getData(), 0x09);
                        uint8 i = 0;

                        while (i < numtargs)
                        {
                            uint32 location_in_bits = 150 + 123 * i;
                            uint32 location_in_bytes = location_in_bits / 8;
                            uint32 bit_offset = location_in_bits - (location_in_bytes * 8);
                            uint32 targ = (ref<uint64>(PSmallPacket->getData(), location_in_bytes) >> bit_offset) & 0x00000000FFFFFFFF;
                            AffectedIDs.push_back(targ);
                            i++;
                        }

                        priorityNum = 12;

                        for (auto i = AffectedIDs.begin(); i != AffectedIDs.end(); i++)
                        {
                            CBaseEntity* PTarget = zoneutils::GetEntity(*i);
                            PTarget = PTarget ? PTarget : zoneutils::GetChar(*i);
                            CBaseEntity* POwner = zoneutils::GetEntity(OwnerID);
                            POwner = POwner ? POwner : zoneutils::GetChar(OwnerID);
                            if (!PTarget || !POwner)
                                continue;
                            if ((POwner->objtype == TYPE_MOB || POwner->objtype == TYPE_PET) && ((CBattleEntity*)POwner)->PMaster)
                            {
                                POwner = ((CBattleEntity*)POwner)->PMaster; // same priority as my master
                            }
                            if ((PTarget->objtype == TYPE_MOB || PTarget->objtype == TYPE_PET) && ((CBattleEntity*)PTarget)->PMaster)
                            {
                                PTarget = ((CBattleEntity*)PTarget)->PMaster; // same priority as my master
                            }

                            if (PTarget->id == CursorTargetID || PTarget->id == CursorTargetPetID)
                            {
                                priorityNum = 1;
                                PSmallPacket->priorityNumOverride = 1;
                                break;
                            }

                            if (PTarget->id == PChar->id)
                            {
                                if (POwner->objtype != TYPE_PC || ((CCharEntity*)POwner)->IsPartiedWith(PChar))
                                {
                                    priorityNum = 1;
                                    PSmallPacket->priorityNumOverride = 1;
                                    break;
                                }
                                else // action on me is from player that is outside my party
                                {
                                    priorityNum = std::min(8, priorityNum);
                                    continue;
                                }
                            }
                            // past this point, the action is not me and the action is not performed on me

                            if (POwner->objtype == TYPE_PC && ((CCharEntity*)POwner)->IsPartiedWith(PChar))
                            {
                                priorityNum = std::min(2, priorityNum);
                                continue;
                            }

                            if (PTarget->objtype == TYPE_PC && ((CCharEntity*)POwner)->IsPartiedWith(PChar))
                            {
                                if (POwner->objtype != TYPE_PC)
                                {
                                    priorityNum = std::min(4, priorityNum);
                                    continue;
                                }
                                else // we just checked party-on-party actions, so the owner of the action *must* be a player outside the party
                                {
                                    priorityNum = std::min(10, priorityNum);
                                    continue;
                                }
                            }
                            // past this point, the action has nothing to do with me or my party

                            if (POwner->objtype != TYPE_PC)
                            {
                                priorityNum = std::min(11, priorityNum);
                                continue;
                            }
                            priorityNum = std::min(12, priorityNum);
                        }

                        if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnMOBList.size() + PChar->SpawnPCList.size() + PChar->SpawnPETList.size() +
                                                             PChar->SpawnTRUSTList.size())/5 + 4) && AffectedIDs.size() < 2)
                        {
                            priorityNum = std::min(2, priorityNum);
                        }

                        break;
                    }
                    case 0x2D: // message combat
                    {
                        CBaseEntity* POwner = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x04));
                        POwner = POwner ? POwner : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        CBaseEntity* PTarget = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x08));
                        PTarget = PTarget ? PTarget : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x08));
                        POwner = (POwner->objtype == TYPE_PET || POwner->objtype == TYPE_MOB) && ((CBattleEntity*)POwner)->PMaster
                                     ? ((CBattleEntity*)POwner)->PMaster
                                     : POwner; // inheret my master's prio
                        PTarget = (PTarget->objtype == TYPE_PET || PTarget->objtype == TYPE_MOB) && ((CBattleEntity*)PTarget)->PMaster
                                      ? ((CBattleEntity*)POwner)->PMaster
                                      : PTarget; // inheret my master's prio
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || (PChar->PPet && POwner->id == PChar->PPet->id) || POwner->id == CursorTargetID ||
                            POwner->id == CursorTargetPetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if (!PTarget)
                        {
                            priorityNum = 11;
                            PSmallPacket->priorityNumOverride = 11;
                            break;
                        }
                        if (PTarget->id == PChar->id || (PChar->PPet && PTarget->id == PChar->PPet->id) || PTarget->id == CursorTargetID ||
                            PTarget->id == CursorTargetPetID)
                        {
                            priorityNum = 1;
                            PSmallPacket->priorityNumOverride = 1;
                            break;
                        }
                        if (POwner->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)POwner))
                        {
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        if (PTarget->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)PTarget))
                        {
                            priorityNum = 4;
                            PSmallPacket->priorityNumOverride = 4;
                            break;
                        }
                        if (POwner->objtype == TYPE_PC)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            break;
                        }
                        priorityNum = 11;
                        PSmallPacket->priorityNumOverride = 11;
                        break;
                    }
                    case 0x70: // message synthesis result
                    {
                        CCharEntity* POwner = zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x1A));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || POwner->id == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if (PChar->IsPartiedWith(POwner))
                        {
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        priorityNum = 12; // PC outside our pt
                        PSmallPacket->priorityNumOverride = 12;
                        break;
                    }
                    case 0x38: // animation
                    {
                        CBaseEntity* POwner = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x04));
                        POwner = POwner ? POwner : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || (PChar->PPet && POwner->id == PChar->PPet->id))
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        if (POwner->id == CursorTargetID || POwner->id == CursorTargetPetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if ((POwner->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)POwner)) ||
                            ((POwner->objtype == TYPE_MOB || POwner->objtype == TYPE_PET) && ((CBattleEntity*)POwner)->PMaster &&
                             ((CBattleEntity*)POwner)->PMaster->objtype == TYPE_PC && PChar->IsPartiedWith(((CCharEntity*)((CBattleEntity*)POwner)->PMaster))))
                        { // animation user is my party member or a party member's pet
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        if (POwner->objtype == TYPE_MOB ||
                            (POwner->objtype == TYPE_PET && ((CBattleEntity*)POwner)->PMaster && ((CBattleEntity*)POwner)->PMaster->objtype == TYPE_MOB))
                        {
                            CBattleEntity* PMobTarget = (CBattleEntity*)(POwner->GetEntity(((CMobEntity*)POwner)->GetBattleTargetID()));
                            if (POwner->animation == ANIMATION_ATTACK && (PMobTarget->id == PChar->id || (PChar->PPet && PMobTarget->id == PChar->PPet->id)))
                            { // mob is targeting me or my pet
                                priorityNum = 1;
                                PSmallPacket->priorityNumOverride = 1;
                                break;
                            }
                            if (POwner->animation == ANIMATION_ATTACK &&
                                ((PMobTarget->objtype == TYPE_PC && PChar->IsPartiedWith(((CCharEntity*)PMobTarget))) ||
                                 ((PMobTarget->objtype == TYPE_MOB || PMobTarget->objtype == TYPE_PET) && PMobTarget->PMaster &&
                                  PMobTarget->PMaster->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)(PMobTarget->PMaster)))))
                            { // mob is targeting my party member or a party member's pet
                                priorityNum = 4;
                                PSmallPacket->priorityNumOverride = 4;
                                break;
                            }
                            priorityNum = 11;
                            PSmallPacket->priorityNumOverride = 11;
                            break;
                        }
                        priorityNum = 12; // probably is PC outside our pt
                        PSmallPacket->priorityNumOverride = 12;
                        break;
                    }
                    case 0x3A: // animation independant
                    {
                        // seems to just be anim packet, but can have a target entity
                        CBaseEntity* POwner = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x04));
                        POwner = POwner ? POwner : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || (PChar->PPet && POwner->id == PChar->PPet->id))
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        if (POwner->id == CursorTargetID || POwner->id == CursorTargetPetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if ((POwner->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)POwner)) ||
                            ((POwner->objtype == TYPE_MOB || POwner->objtype == TYPE_PET) && ((CBattleEntity*)POwner)->PMaster &&
                             ((CBattleEntity*)POwner)->PMaster->objtype == TYPE_PC && PChar->IsPartiedWith(((CCharEntity*)((CBattleEntity*)POwner)->PMaster))))
                        { // animation user is my party member or a party member's pet
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        CBaseEntity* PTarget = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x08));
                        PTarget = PTarget ? PTarget : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x08));
                        if (PTarget && PTarget->id != POwner->id)
                        {
                            if (PTarget->id == PChar->id || (PChar->PPet && PTarget->id == PChar->PPet->id) || PTarget->id == CursorTargetID ||
                                PTarget->id == CursorTargetPetID)
                            { // animation is targeting me or my pet
                                priorityNum = 1;
                                PSmallPacket->priorityNumOverride = 1;
                                break;
                            }
                            if ((PTarget->objtype == TYPE_PC && PChar->IsPartiedWith(((CCharEntity*)PTarget))) ||
                                ((PTarget->objtype == TYPE_MOB || PTarget->objtype == TYPE_PET) && ((CBattleEntity*)PTarget)->PMaster &&
                                 ((CBattleEntity*)PTarget)->PMaster->objtype == TYPE_PC &&
                                 PChar->IsPartiedWith((CCharEntity*)(((CBattleEntity*)PTarget)->PMaster))))
                            { // animation is targeting my party member or a party member's pet
                                priorityNum = 4;
                                PSmallPacket->priorityNumOverride = 4;
                                break;
                            }
                            priorityNum = 11;
                            PSmallPacket->priorityNumOverride = 11;
                            break;
                        }
                        priorityNum = 12;
                        PSmallPacket->priorityNumOverride = 12;
                        break;
                    }
                    case 0x30: // animation synthesis
                    {
                        CCharEntity* POwner = zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || POwner->id == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if (PChar->IsPartiedWith(POwner))
                        {
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        priorityNum = 12; // PC outside our pt
                        PSmallPacket->priorityNumOverride = 12;
                        break;
                    }
                    case 0x39: // visual
                    {
                        // if i'm not mistaken, this is very similar to anim packet
                        CBaseEntity* POwner = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x04));
                        POwner = POwner ? POwner : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || (PChar->PPet && POwner->id == PChar->PPet->id))
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        if (POwner->id == CursorTargetID || POwner->id == CursorTargetPetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if ((POwner->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)POwner)) ||
                            ((POwner->objtype == TYPE_MOB || POwner->objtype == TYPE_PET) && ((CBattleEntity*)POwner)->PMaster &&
                             ((CBattleEntity*)POwner)->PMaster->objtype == TYPE_PC && PChar->IsPartiedWith(((CCharEntity*)((CBattleEntity*)POwner)->PMaster))))
                        { // animation user is my party member or a party member's pet
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        if (POwner->objtype == TYPE_MOB ||
                            (POwner->objtype == TYPE_PET && ((CBattleEntity*)POwner)->PMaster && ((CBattleEntity*)POwner)->PMaster->objtype == TYPE_MOB))
                        {
                            CBattleEntity* PMobTarget = (CBattleEntity*)(POwner->GetEntity(((CMobEntity*)POwner)->GetBattleTargetID()));
                            if (POwner->animation == ANIMATION_ATTACK && (PMobTarget->id == PChar->id || (PChar->PPet && PMobTarget->id == PChar->PPet->id)))
                            { // mob is targeting me or my pet
                                priorityNum = 1;
                                PSmallPacket->priorityNumOverride = 1;
                                break;
                            }
                            if (POwner->animation == ANIMATION_ATTACK &&
                                ((PMobTarget->objtype == TYPE_PC && PChar->IsPartiedWith(((CCharEntity*)PMobTarget))) ||
                                 ((PMobTarget->objtype == TYPE_MOB || PMobTarget->objtype == TYPE_PET) && PMobTarget->PMaster &&
                                  PMobTarget->PMaster->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)(PMobTarget->PMaster)))))
                            { // mob is targeting my party member or a party member's pet
                                priorityNum = 4;
                                PSmallPacket->priorityNumOverride = 4;
                                break;
                            }
                            priorityNum = 11;
                            PSmallPacket->priorityNumOverride = 11;
                            break;
                        }
                        if (POwner->objtype == TYPE_PC)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            break;
                        }
                    }
                    case 0X0E: // entity update
                    {
                        CBaseEntity* POwner = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x04));
                        POwner = POwner ? POwner : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || (PChar->PPet && PChar->PPet->id == POwner->id))
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        if (POwner->id == CursorTargetID || POwner->id == CursorTargetPetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if (PSmallPacket->packetEntityUpdateType != ENTITY_NONE && PSmallPacket->packetEntityUpdateType != ENTITY_UPDATE)
                        { // high prio of despawn/spawn no matter who they are.
                            priorityNum = 1;
                            PSmallPacket->priorityNumOverride = 1;
                            PSmallPacket->overflowDropImmunity = true;
                            break;
                        }

                        if ((POwner->objtype == TYPE_MOB || POwner->objtype == TYPE_PET) && ((CBattleEntity*)POwner)->PMaster)
                            POwner = ((CBattleEntity*)POwner)->PMaster; // inherit my master's prio

                        if (PSmallPacket->packetUpdateMask == UPDATE_POS || PSmallPacket->packetUpdateMask == UPDATE_HP ||
                            PSmallPacket->packetUpdateMask == (UPDATE_POS | UPDATE_HP))
                        {
                            if (POwner->objtype == TYPE_PC)
                            {
                                if (PChar->IsPartiedWith((CCharEntity*)POwner))
                                {
                                    if (!tpzrand::GetRandomNumber(0, 6))
                                        priorityNum = 1;
                                    else
                                        priorityNum = 3;
                                    break;
                                }
                                if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnPCList.size())))
                                    priorityNum = 2;
                                else
                                    priorityNum = 9;
                                break;
                            }
                            else
                            {
                                if ((POwner->objtype == TYPE_MOB || POwner->objtype == TYPE_PET) && POwner->animation == ANIMATION_ATTACK)
                                {
                                    CBattleEntity* PMobTarget = (CBattleEntity*)(POwner->GetEntity(((CMobEntity*)POwner)->GetBattleTargetID()));
                                    PMobTarget = PMobTarget->PMaster ? PMobTarget->PMaster : PMobTarget; // inherit my master's prio
                                    if (PMobTarget->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)PMobTarget))
                                    {
                                        if (distanceSquared(POwner->loc.p, PChar->loc.p) < 30 * 30)
                                        {
                                            priorityNum = 2;
                                            break;
                                        }
                                        else
                                        {
                                            priorityNum = 4;
                                            break;
                                        }
                                    }

                                    if (!tpzrand::GetRandomNumber(0, ((int)PChar->SpawnMOBList.size()) / 2 + 2))
                                    {
                                        priorityNum = 2;
                                        break;
                                    }
                                    else
                                    {
                                        priorityNum = 6; // one level past the default since it is in attack_animation
                                        break;
                                    }
                                }
                                // not attacking, or this is an NPC
                                if (!tpzrand::GetRandomNumber(0, ((int)PChar->SpawnMOBList.size()) / 2 + 2))
                                {
                                    priorityNum = 3;
                                    break;
                                }
                                else
                                {
                                    priorityNum = 7;
                                    break;
                                }
                            }
                        }

                        // only updatemask options left are claim update and name update. we really want to know about these!!
                        priorityNum = 2;
                        break;
                    }
                    case 0x0D: // char packet
                    {
                        CCharEntity* POwner = zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id)
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        if (POwner->id == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }

                        if (PSmallPacket->packetEntityUpdateType != ENTITY_NONE && PSmallPacket->packetEntityUpdateType != ENTITY_UPDATE)
                        { // high prio of despawn/spawn no matter who they are.
                            priorityNum = 1;
                            PSmallPacket->priorityNumOverride = 1;
                            PSmallPacket->overflowDropImmunity = true;
                            break;
                        }

                        if (PSmallPacket->packetUpdateMask == UPDATE_POS)
                        {
                            if (PChar->IsPartiedWith(POwner))
                            {
                                if (!tpzrand::GetRandomNumber(0, 6))
                                    priorityNum = 1;
                                else
                                    priorityNum = 3;
                                break;
                            }
                            if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnPCList.size())/2 + 2))
                                priorityNum = 2;
                            else
                                priorityNum = 9;
                            break;
                        }
                        if (PSmallPacket->packetUpdateMask == UPDATE_LOOK || PSmallPacket->packetUpdateMask == (UPDATE_LOOK | UPDATE_POS))
                        {
                            if (PChar->IsPartiedWith(POwner))
                            {
                                if (!tpzrand::GetRandomNumber(0, 6))
                                    priorityNum = 1;
                                else
                                    priorityNum = 3;
                                break;
                            }
                            if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnPCList.size())/2 + 2))
                                priorityNum = 2;
                            else
                                priorityNum = 9;
                            break;
                        }

                        // all that's left is if we are updating something important like their hp, animation, name, nameflags, speed, invisibility, etc.
                        if (PChar->IsPartiedWith(POwner))
                        {
                            priorityNum = 2;
                        }
                        else
                        {
                            if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnPCList.size())/2 + 2))
                                priorityNum = 2;
                            else
                                priorityNum = 8;
                        }
                        break;
                    }
                    case 0x37: // char update packet
                    {
                        // this packet is very similar to char packet, but without an updatemask. thankfully, positions are not updated here so it's nbd
                        // update information: HP bar, some nameflags, snk/invis particles, speed, anim, LS1 colour, mount ID, homepoint timer (if self)
                        CCharEntity* POwner = zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x24));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id)
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        if (POwner->id == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if (PChar->IsPartiedWith(POwner))
                        {
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnPCList.size())/2 + 2))
                        {
                            priorityNum = 2;
                            break;
                        }
                        priorityNum = 12;
                        break;
                    }
                    case 0x67: // char sync
                    {
                        CCharEntity* POwner = zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x08));
                        if (!POwner)
                        {
                            // apparently this is also the same packet ID for trust sync. let's make sure it's not a trust before we give up
                            CBaseEntity* PTrust = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x08));
                            if (PTrust && PTrust->objtype == TYPE_TRUST)
                            {
                                priorityNum = 2; // same prio as party list updates.
                                PSmallPacket->priorityNumOverride = 2;
                                break;
                            }

                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }

                        if (POwner->id == PChar->id)
                        {
                            priorityNum = -1; // sent in response to self-information request packet. order matters
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }

                        if (POwner->id == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }

                        if (PChar->IsPartiedWith(POwner))
                        {
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }

                        if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnPCList.size())/2 + 2))
                        {
                            priorityNum = 2;
                            break;
                        }

                        priorityNum = 12;
                        break;
                    }
                    case 0x5A: // emote
                    {
                        CCharEntity* POwner = zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        CBaseEntity* PTarget = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x08));
                        PTarget = PTarget ? PTarget : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x08));

                        if (!POwner || !PTarget)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }

                        if (POwner->id == PChar->id || POwner->id == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }

                        if (PChar->IsPartiedWith(POwner))
                        {
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }

                        if (PTarget->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)PTarget))
                        {
                            priorityNum = 10;
                            PSmallPacket->priorityNumOverride = 10;
                            break;
                        }

                        priorityNum = 12;
                        PSmallPacket->priorityNumOverride = 12;
                        PSmallPacket->recyclePacket = false;
                        break;
                    }
                    case 0xDF: // party list HP/MP/TP update
                    {
                        uint32 OwnerID = ref<uint32>(PSmallPacket->getData(), 0x04);

                        if (OwnerID == PChar->id)
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }

                        if (OwnerID == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }

                        priorityNum = 2;
                        PSmallPacket->priorityNumOverride = 2;
                        break;
                    }
                    case 0x17: // chat message
                    {
                        // sender's ID is not included in the packet so we'll just be prioritizing mostly by channel
                        CHAT_MESSAGE_TYPE MessageType = (CHAT_MESSAGE_TYPE)(ref<uint8>(PSmallPacket->getData(), 0x04));
                        if ((ref<uint8>(PSmallPacket->getData(), 0x05) && MessageType != CHAT_MESSAGE_TYPE::MESSAGE_YELL) ||
                            MessageType == CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1)
                        { // non-yell GM message or global system messages get higher priority
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }
                        if (MessageType == CHAT_MESSAGE_TYPE::MESSAGE_TELL || MessageType == CHAT_MESSAGE_TYPE::MESSAGE_PARTY)
                        {
                            priorityNum = 1;
                            PSmallPacket->priorityNumOverride = 1;
                            break;
                        }
                        if (MessageType == CHAT_MESSAGE_TYPE::MESSAGE_LINKSHELL || MessageType == CHAT_MESSAGE_TYPE::MESSAGE_LINKSHELL2)
                        {
                            priorityNum = 6;
                            PSmallPacket->priorityNumOverride = 6;
                            break;
                        }
                        priorityNum = 12; // chat message in a public channel. we can safely discard it if it doesn't make it thru prio... string data can get big.
                        PSmallPacket->priorityNumOverride = 12;
                        PSmallPacket->recyclePacket = false;
                        break;
                    }
                    case 0x5B: // position
                    {
                        CBaseEntity* POwner = zoneutils::GetEntity(ref<uint32>(PSmallPacket->getData(), 0x10));
                        POwner = POwner ? POwner : zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x10));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || (PChar->PPet && POwner->id == PChar->PPet->id))
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        if (POwner->id == CursorTargetID || POwner->id == CursorTargetPetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        POwner = (POwner->objtype == TYPE_PC || POwner->objtype == TYPE_MOB) && ((CBattleEntity*)POwner)->PMaster
                                     ? ((CBattleEntity*)POwner)->PMaster
                                     : POwner; // inherit my master's prio
                        if (POwner->objtype == TYPE_PC)
                        {
                            if (PChar->IsPartiedWith((CCharEntity*)POwner))
                            {
                                if (!tpzrand::GetRandomNumber(0, 9))
                                    priorityNum = 2;
                                else
                                    priorityNum = 3;
                                break;
                            }
                            else
                            {
                                if (!tpzrand::GetRandomNumber(0, (int)(PChar->SpawnPCList.size())/2 + 2))
                                    priorityNum = 2;
                                else
                                    priorityNum = 9;
                                break;
                            }
                        }
                        if ((POwner->objtype == TYPE_MOB || POwner->objtype == TYPE_PET) && POwner->animation == ANIMATION_ATTACK)
                        {
                            CBattleEntity* PMobTarget = (CBattleEntity*)(POwner->GetEntity(((CMobEntity*)POwner)->GetBattleTargetID()));
                            PMobTarget = PMobTarget->PMaster ? PMobTarget->PMaster : PMobTarget; // inherit my master's prio
                            if (PMobTarget->objtype == TYPE_PC && PChar->IsPartiedWith((CCharEntity*)PMobTarget))
                            {
                                if (distanceSquared(POwner->loc.p, PChar->loc.p) > 30 * 30)
                                {
                                    priorityNum = 2;
                                    break;
                                }
                                else
                                {
                                    priorityNum = 4;
                                    break;
                                }
                            }

                            if (!tpzrand::GetRandomNumber(0, ((int)PChar->SpawnMOBList.size()) / 2 + 2))
                            {
                                priorityNum = 2;
                                break;
                            }
                            else
                            {
                                priorityNum = 6; // one level past the default since it is in attack_animation
                                break;
                            }
                        }
                        // not attacking, or this is an NPC
                        if (!tpzrand::GetRandomNumber(0, ((int)PChar->SpawnMOBList.size()) / 2 + 2))
                        {
                            priorityNum = 3;
                            break;
                        }
                        else
                        {
                            priorityNum = 7;
                            break;
                        }
                    }
                    case 0x4F: // DL data
                    case 0x41: // stop DL data
                    case 0x0B: // server ip
                    case 0x0A: // zone in. note: there are multiple packet.cpp files with this type number
                    case 0x08: // zones visited
                    case 0x4D: // servmes
                    case 0xF6: // widescan packets (status: finished MUST be last)
                    case 0xF4: // widescan packets (status: finished MUST be last)
                    case 0x59: // gold world pass
                    case 0x1F: // inventory packets
                    case 0x1D: // inventory packets
                    case 0x20: // inventory packets
                    case 0x1E: // inventory packets
                    case 0x1C: // inventory packets
                    case 0xE0: // inventory packets
                    case 0x56: // KI/quest log
                    case 0x55: // KI/quest log
                    case 0x18: // currency update
                    case 0x63: // map marker update (non-PC) / merit packet / status effects (self)
                    case 0x8C: // merit categories
                    case 0x71: // campaign
                    case 0x5E: // conquest
                    case 0xAA: // spells
                    case 0xAE: // mounts
                    case 0xAC: // abilities
                    case 0x50: // equip
                    case 0x16: // equipset
                    case 0xB4: // menu config
                    case 0x1B: // jobs
                    case 0x51: // self-appearance
                    case 0x19: // recast
                    case 0x61: // stats (self)
                    case 0x62: // skills
                    case 0x44: // job extra
                    case 0x32: // event
                    case 0x33: // event string
                    case 0x34: // event with parameters
                    case 0x5C: // event update
                    case 0x5D: // event string update
                    case 0x65: // self-position (on zone-in or on event finish)
                    case 0x52: // event release
                    {
                        // order matters for these.
                        // if the game client is crashing on specific packets, they should be added to this list.
                        priorityNum = -1;
                        PSmallPacket->priorityNumOverride = -1;
                        break;
                    }
                    case 0x4C: // AH
                    case 0x09: // message standard
                    case 0x29: // message basic
                    case 0x2A: // message special
                    case 0x53: // message system
                    case 0x36: // message text
                    case 0x6F: // message synthesis
                    case 0x05: // bazaar item
                    case 0x06: // bazaar purchase
                    case 0x42: // blacklist
                    case 0xC9: // check
                    case 0x4B: // delivery box
                    case 0x77: // entity enable list
                    case 0x15: // fishing
                    case 0xFA: // furniture interact
                    case 0x86: // guild menu
                    case 0x83: // guild menu buy
                    case 0x82: // guild menu buy update
                    case 0x85: // guild menu sell
                    case 0x84: // guild menu sell update
                    case 0xB5: // help desk
                    case 0xBF: // instance entry
                    case 0x48: // linkshell concierge
                    case 0x58: // lock on
                    case 0x2E: // mog menu
                    case 0xF9: // raise/tractor menu
                    case 0xDC: // party invite
                    case 0xE1: // party search
                    case 0x68: // synchronize pet with owner
                    case 0x3D: // shop appraise
                    case 0x3F: // shop buy
                    case 0x3C: // shop items
                    case 0x3E: // shop menu
                    case 0x31: // synth suggestion
                    case 0x75: // battlefield timer
                    case 0xF5: // widescan track
                    {
                        // these packets go straight to the character about their own actions/stats so they are prio0
                        priorityNum = 0;
                        PSmallPacket->priorityNumOverride = 0;
                        break;
                    }
                    case 0xD2: // treasure pool find item
                    case 0xD3: // treasure pool lot item
                    {
                        priorityNum = 2;
                        PSmallPacket->priorityNumOverride = 2;
                    }
                    case 0xCA:
                    {
                        // bazaar message can be a ton of text and not super important, so let's consider it below mob entitity position update
                        // if it's my message though, order matters as this is part of the player information request
                        // sadly, id is not saved on the packet data. gotta check the names.
                        bool isMatch = true;
                        char* myNamePtr = (char*)(PChar->GetName());
                        char* bazaarNamePtr = (char*)(PSmallPacket->getData() + 0x80);
                        uint16 i = 0;
                        while (isMatch && myNamePtr[i] != '\0' && bazaarNamePtr[i] != '\0')
                        {
                            if (myNamePtr[i] != bazaarNamePtr[i])
                                isMatch = false;
                            i++;
                        }
                        if (isMatch)
                        {
                            priorityNum = -1;
                            PSmallPacket->priorityNumOverride = -1;
                            break;
                        }
                        priorityNum = 8;
                        PSmallPacket->priorityNumOverride = 8;
                        break;
                    }
                    case 0x07:
                    {
                        // exits your bazaar
                        priorityNum = 6;
                        PSmallPacket->priorityNumOverride = 6;
                        break;
                    }
                    case 0x27:
                    case 0x43:
                    {
                        if (PSmallPacket->getType() == 0x27 && PSmallPacket->getSize() != 0x38)
                        {
                            // message name. i'm assuming this is scripted for ally NPCs in battlefields to say stuff, so setting same as linkshell chat message
                            // prio (not super important)
                            priorityNum = 6;
                            PSmallPacket->priorityNumOverride = 6;
                            break;
                        }
                        // catching fish/monster/item. if it's me, prio0. otherwise, lower prio.
                        if (PChar->id == ref<uint32>(PSmallPacket->getData(), 0x04) || CursorTargetID == ref<uint32>(PSmallPacket->getData(), 0x04))
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                        }
                        else
                        {
                            priorityNum = 8;
                            PSmallPacket->priorityNumOverride = 8;
                        }
                        break;
                    }
                    case 0x5F:
                    {
                        // music change packet, it's tiny.
                        priorityNum = 1;
                        PSmallPacket->priorityNumOverride = 1;
                        break;
                    }
                    case 0x2F:
                    {
                        // chocobo digging packet
                        CCharEntity* POwner = zoneutils::GetChar(ref<uint32>(PSmallPacket->getData(), 0x04));
                        if (!POwner)
                        {
                            priorityNum = 12;
                            PSmallPacket->priorityNumOverride = 12;
                            PSmallPacket->recyclePacket = false;
                            break;
                        }
                        if (POwner->id == PChar->id || POwner->id == CursorTargetID)
                        {
                            priorityNum = 0;
                            PSmallPacket->priorityNumOverride = 0;
                            break;
                        }
                        if (PChar->IsPartiedWith(POwner))
                        {
                            priorityNum = 2;
                            PSmallPacket->priorityNumOverride = 2;
                            break;
                        }

                        priorityNum = 12;
                        PSmallPacket->priorityNumOverride = 12;
                        PSmallPacket->recyclePacket = false; // do we really care if other more important stuff is happening
                        break;
                    }
                    case 0xB6:
                    {
                        // GM message packet, same prio as GM chat messages.
                        priorityNum = 2;
                        PSmallPacket->priorityNumOverride = 2;
                        break;
                    }
                    case 0xCC:
                    {
                        // lsmes packet. same prio as ls chat message
                        priorityNum = 6;
                        PSmallPacket->priorityNumOverride = 6;
                        break;
                    }
                    case 0xC8:
                    {
                        // party list reload packet. fixed size
                        priorityNum = 2;
                        PSmallPacket->priorityNumOverride = 2;
                        break;
                    }
                    case 0x76:
                    case 0xDD:
                    {
                        // party effect icons update
                        // this is a fairly large packet; sadly no way to optimize its prio since the client doesn't send a packet notifying server of /focustarget

                        // and: party member update packet (job,hp,mp,etc)
                        priorityNum = 2;
                        PSmallPacket->priorityNumOverride = 2;
                        break;
                    }
                    case 0xA0:
                    {
                        // party map positions
                        priorityNum = 3;
                        PSmallPacket->priorityNumOverride = 3;
                        break;
                    }
                    case 0x22:
                    case 0x25:
                    case 0x21:
                    case 0x23:
                    {
                        // trade-type packets are tiny and infrequent so we can just assign high prio without worry
                        priorityNum = 1;
                        PSmallPacket->priorityNumOverride = 1;
                        break;
                    }
                    case 0x057:
                    {
                        // weather update. same prio as party list updates.
                        priorityNum = 2;
                        PSmallPacket->priorityNumOverride = 2;
                        break;
                    }
                    default:
                    {
                        // couldn't find the packet. let's search again but assume first 9 bits is packet id
                        switch (ref<uint16>(PSmallPacket->getData(), 0) & 0x01FF)
                        {
                            case 0x110: // RoE quest log/sparks update
                            case 0x111: // RoE quest log/sparks update
                            case 0x112: // RoE quest log/sparks update
                            case 0x113: // currency update
                            case 0x10E: // release special
                            {
                                priorityNum = -1; // order matters
                                PSmallPacket->priorityNumOverride = -1;
                                break;
                            }
                            case 0x11E:
                            {
                                // jump packet. no idea what extra means so just gonna make this low prio.
                                priorityNum = 12;
                                PSmallPacket->priorityNumOverride = 12;
                                PSmallPacket->recyclePacket = false;
                                break;
                            }
                        }
                        break;
                    }
                }
            }

            if (priorityNum == -1 || priorityNum == 0)
                PSmallPacket->overflowDropImmunity = true;

            switch (priorityNum)
            {
                case -1:
                    ordered.push_back(PSmallPacket);
                    break;
                case 0:
                    priority0.push_back(PSmallPacket);
                    break;
                case 1:
                    priority1.push_back(PSmallPacket);
                    break;
                case 2:
                    priority2.push_back(PSmallPacket);
                    break;
                case 3:
                    priority3.push_back(PSmallPacket);
                    break;
                case 4:
                    priority4.push_back(PSmallPacket);
                    break;
                case 5:
                    priority5.push_back(PSmallPacket);
                    break;
                case 6:
                    priority6.push_back(PSmallPacket);
                    break;
                case 7:
                    priority7.push_back(PSmallPacket);
                    break;
                case 8:
                    priority8.push_back(PSmallPacket);
                    break;
                case 9:
                    priority9.push_back(PSmallPacket);
                    break;
                case 10:
                    priority10.push_back(PSmallPacket);
                    break;
                case 11:
                    priority11.push_back(PSmallPacket);
                    break;
                case 12:
                    priority12.push_back(PSmallPacket);
                    break;
                default:
                    priority13.push_back(PSmallPacket);
                    break;
            }

            list.pop_front();
        }

        std::random_device rd;
        std::mt19937 g(rd());
        std::shuffle(priority0.begin(), priority0.end(), g);
        std::shuffle(priority1.begin(), priority1.end(), g);
        std::shuffle(priority2.begin(), priority2.end(), g);
        std::shuffle(priority3.begin(), priority3.end(), g);
        std::shuffle(priority4.begin(), priority4.end(), g);
        std::shuffle(priority5.begin(), priority5.end(), g);
        std::shuffle(priority6.begin(), priority6.end(), g);
        std::shuffle(priority7.begin(), priority7.end(), g);
        std::shuffle(priority8.begin(), priority8.end(), g);
        std::shuffle(priority9.begin(), priority9.end(), g);
        std::shuffle(priority10.begin(), priority10.end(), g);
        std::shuffle(priority11.begin(), priority11.end(), g);
        std::shuffle(priority12.begin(), priority12.end(), g);
        std::shuffle(priority13.begin(), priority13.end(), g);
        

        // highest priority = front
        // lowest priority = back
        while (!ordered.empty())
        {
            orderedList.push_back(ordered.front());
            ordered.pop_front();
        }
        while (!priority0.empty())
        {
            orderedList.push_back(priority0.front());
            priority0.pop_front();
        }
        while (!priority1.empty())
        {
            orderedList.push_back(priority1.front());
            priority1.pop_front();
        }
        while (!priority2.empty())
        {
            orderedList.push_back(priority2.front());
            priority2.pop_front();
        }
        while (!priority3.empty())
        {
            orderedList.push_back(priority3.front());
            priority3.pop_front();
        }
        while (!priority4.empty())
        {
            orderedList.push_back(priority4.front());
            priority4.pop_front();
        }
        while (!priority5.empty())
        {
            orderedList.push_back(priority5.front());
            priority5.pop_front();
        }
        while (!priority6.empty())
        {
            orderedList.push_back(priority6.front());
            priority6.pop_front();
        }
        while (!priority7.empty())
        {
            orderedList.push_back(priority7.front());
            priority7.pop_front();
        }
        while (!priority8.empty())
        {
            orderedList.push_back(priority8.front());
            priority8.pop_front();
        }
        while (!priority9.empty())
        {
            orderedList.push_back(priority9.front());
            priority9.pop_front();
        }
        while (!priority10.empty())
        {
            orderedList.push_back(priority10.front());
            priority10.pop_front();
        }
        while (!priority11.empty())
        {
            orderedList.push_back(priority11.front());
            priority11.pop_front();
        }
        while (!priority12.empty())
        {
            orderedList.push_back(priority12.front());
            priority12.pop_front();
        }
        while (!priority13.empty())
        {
            orderedList.push_back(priority13.front());
            priority13.pop_front();
        }
        
        isOrdered = true;
        return orderedList;
    };
    
    uint32 bufferSize = getBufferSize(priorityList);
    if (bufferSize >= map_config.buffer_size)
    {
        priorityList = orderPacketList(priorityList);
        while (bufferSize >= map_config.buffer_size && !priorityList.empty())
        {
            bufferSize -= priorityList.back()->length();
            priorityList.pop_back();
        }
    }

    uint32 compressedBufferSize = getCompressedBufferSize(priorityList);
    if (compressedBufferSize + 4 > 1300 - FFXI_HEADER_SIZE - 16)
    { // 16 bytes ensures there is room for the md5 hash later on in send_parse. 4 bytes ensures there is room for compressed-size stamp on master packet in send_parse.
        priorityList = orderPacketList(priorityList);
        while (compressedBufferSize + 4 > 1300 - FFXI_HEADER_SIZE - 16)
        {
            priorityList.pop_back();
            if (!priorityList.empty())
                priorityList.pop_back(); // compression is CPU expensive, let's pop two at a time
            compressedBufferSize = getCompressedBufferSize(priorityList);
        }
    }

    // finalization: all packets in priorityList will be sent, so do cleanup for what will be recycled and what will not
    for (auto it = priorityList.begin(); it != priorityList.end(); it++)
        (*it)->selectedForThisNetworkCycle = true;
    
    // pointed objects will be deleted after the while loop that follows this function call in send_parse
    // will delete if object is selected for this cycle or if it wasn't selected + its recycle flag is turned off
    
    return priorityList;
}

/************************************************************************
*                                                                       *
*  main function is building big packet (master packet)                 *
*                                                                       *
************************************************************************/

int32 send_parse(int8 *buff, size_t* buffsize, sockaddr_in* from, map_session_data_t* map_session_data)
{
    // start the header of the outgoing master packet:
    ref<uint16>(buff, 0x00) = map_session_data->server_packet_id; // notify the client of the sequence number of the last packet we received from it
    ref<uint16>(buff, 0x02) = map_session_data->client_packet_id; // assign the sequence number to the outgoing master packet as the last sequence number sent +1
    ref<uint32>(buff, 0x08) = (uint32)time(nullptr); // write the current time of sending the packet

    // construct master packet (A.K.A. bigpacket) from the smallpackets
    // every network cycle to the client, we give it one master packet
    // which it will unfold to read the smallpackets in sequence
    CCharEntity* PChar = map_session_data->PChar;
    CBasicPacket* PSmallPacket;
    uint32 PacketSizeBits = 0xFFFFFFFF;
    uint32 PacketSizeBytes = 0xFFFFFFFF;
    uint16 DebugSendPacketCount = 0;

    uint32 packetsBeforePrio = PChar->getPacketCount();
    uint32 packetsAfterPrio = 0;
    PacketList_t packetList = generate_priority_packet_list(PChar, map_session_data);
    PacketList_t packetListBackup = packetList;

    while (true)
    {
        *buffsize = FFXI_HEADER_SIZE;
        packetsAfterPrio = packetList.size();

        while (!packetList.empty())
        {
            PSmallPacket = packetList.front();
            PSmallPacket->sequence(map_session_data->server_packet_id);
            memcpy(buff + *buffsize, PSmallPacket->getData(), PSmallPacket->length());
            *buffsize += PSmallPacket->length();
            //ShowDebug("Preparing packet of ID 0x%02hx...\n", PSmallPacket->getType());
            packetList.pop_front();
        }

        // error checking on buffer sizes. generate_priority_packet_list makes mistakes sometimes, not sure why.

        if (*buffsize > map_config.buffer_size)
        {
            ShowFatalError("generate_priority_packet_list failed to detect buffer overflow error for character %s on sequence %u! Size was %u\n",
                           PChar->GetName(), map_session_data->server_packet_id, *buffsize);
            // pop and retry is all we can do
            packetListBackup.back()->selectedForThisNetworkCycle = false;
            packetListBackup.pop_back();
            if (!packetListBackup.empty())
            {
                packetListBackup.back()->selectedForThisNetworkCycle = false;
                packetListBackup.pop_back();
            }
            packetList = packetListBackup;
            continue;
        }

        // Compress the data excluding the header
        PacketSizeBits = zlib_compress(buff + FFXI_HEADER_SIZE, (uint32)(*buffsize - FFXI_HEADER_SIZE), PTempBuff, map_config.buffer_size);
        if (PacketSizeBits == static_cast<uint32>(-1))
        {
            ShowFatalError("generate_priority_packet_list failed to detect a zlib compression error for character %s on sequence %u!\n", PChar->GetName(),
                           map_session_data->server_packet_id);
            // pop and retry is all we can do
            packetListBackup.back()->selectedForThisNetworkCycle = false;
            packetListBackup.pop_back();
            if (!packetListBackup.empty())
            {
                packetListBackup.back()->selectedForThisNetworkCycle = false;
                packetListBackup.pop_back();
            }
            packetList = packetListBackup;
            continue;
        }

        PacketSizeBytes = (uint32)zlib_compressed_size(PacketSizeBits);
        if (PacketSizeBytes + 4 > 1300 - FFXI_HEADER_SIZE - 16) // max for PacketSizeBytes is 1252
        {
            ShowFatalError("generate_priority_packet_list failed to detect COMPRESSED buffer overflow error for character %s on sequence %u! Size was %u\n",
                           PChar->GetName(), map_session_data->server_packet_id, PacketSizeBytes);
            // pop and retry is all we can do
            packetListBackup.back()->selectedForThisNetworkCycle = false;
            packetListBackup.pop_back();
            if (!packetListBackup.empty())
            {
                packetListBackup.back()->selectedForThisNetworkCycle = false;
                packetListBackup.pop_back();
            }
            packetList = packetListBackup;
            continue;
        }
        break;
    }

    uint16 packetsRemaining = PChar->getPacketCount();
    std::mutex* ptr = (PChar->getPacketListMutexPtr());
    std::lock_guard lk(*ptr);

    if (packetsBeforePrio)
    {
        // delete the packets we just copied into the buffer as well as any that are toggled to not recycle to the next network cycle

        PacketList_t* PPacketList = PChar->getPacketListPtr();
        auto it = PPacketList->cbegin();
        while (it != PPacketList->cend())
        {
            if ((*it)->selectedForThisNetworkCycle == true || (*it)->recyclePacket == false)
            {
                delete (*it);
                it = PPacketList->erase(it);
                packetsRemaining--;
            }
            else
            {
                it++;
            }
        }
    }

    if (!PChar->m_packetLimiterEnabled && std::chrono::system_clock::now() - PChar->m_objectCreationTime > 45s)
        PChar->m_packetLimiterEnabled = true;
    
    if (PChar->m_packetLimiterEnabled)
    {
        // delete packets over the limiter

        PacketList_t* PPacketList = PChar->getPacketListPtr();
        auto it = PPacketList->cbegin();
        while (packetsRemaining > 500 && it != PPacketList->cend())
        {
            if ((*it)->overflowDropImmunity == false)
            {
                delete (*it);
                it = PPacketList->erase(it);
                packetsRemaining--;
            }
            else
            {
                it++;
            }
        }
    }
    
    // 1800 buffer limit is on the uncompressed list of smallpackets (default, can be changed with map_config.buffer_size)
    // 1300 buffer limit is on the compressed list of smallpackets + compressed size indicator(4chars) + md5 hash(16chars)
    // if master packet size (after compress) exceeds 1400 bytes (payload + 42 bytes IP header),
    // then the client ignores the packet and returns a message about its loss
    // server doesn't handle a response to such a message as it shouldn't happen
    // since we are limiting to 1300 bytes just to be safe

    /*
    ShowDebug("SEQUENCE %u: Sending %u/%u packets to character %s (size %u/%u buffer, %u/1300 compressed).\n",
              map_session_data->server_packet_id, packetsAfterPrio, packetsBeforePrio, PChar->GetName(), (uint16)*buffsize,
              map_config.buffer_size, PacketSizeBytes + 20);
    */
    
    ref<uint32>(PTempBuff, (size_t)PacketSizeBytes) = PacketSizeBits; // client wants to know size in bits

    PacketSizeBytes += 4;
    PacketSizeBits += 32;

    // append MD5 hash to buffer
    uint8 hash[16];
    md5((uint8*)PTempBuff, hash, PacketSizeBytes);
    memcpy(PTempBuff + PacketSizeBytes, hash, 16);
    PacketSizeBytes += 16;

    if (PacketSizeBytes > map_config.buffer_size + 20)
    {
        ShowFatalError(CL_RED"%Memory manager: PTempBuff is overflowed (%u)\n" CL_RESET, PacketSize);
        return -1;
    }

    // making total packet. we made the header already so let's copy the PTempBuff (headerless buffer) in to complete our packet. then encipher.
    memcpy(buff + FFXI_HEADER_SIZE, PTempBuff, PacketSizeBytes);

    uint32 CypherSize = (PacketSizeBytes / 4) & -2;

    blowfish_t* pbfkey = &map_session_data->blowfish;

    for (uint32 j = 0; j < CypherSize; j += 2)
    {
        blowfish_encipher((uint32*)(buff)+j + 7, (uint32*)(buff)+j + 8, pbfkey->P, pbfkey->S[0]);
    }

    *buffsize = PacketSizeBytes + FFXI_HEADER_SIZE;

    return 0;
}

/************************************************************************
*                                                                       *
*  Таймер для завершения сессии (без таймера мы этого сделать не можем, *
*  т.к. сессия продолжает использоваться в do_sockets)                  *
*                                                                       *
************************************************************************/

int32 map_close_session(time_point tick, map_session_data_t* map_session_data)
{
    if (map_session_data != nullptr &&
        map_session_data->server_packet_data != nullptr &&
        map_session_data->PChar != nullptr)
    {
        charutils::SavePlayTime(map_session_data->PChar);
        charutils::RemoveGuestsFromMogHouse(map_session_data->PChar);

        //clear accounts_sessions if character is logging out (not when zoning)
        if (map_session_data->shuttingDown == 1)
        {
            map_session_data->PChar->m_disconnecting = true;
            Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE charid = %u", map_session_data->PChar->id);
            // flist stuff
            if (FLgetSetting(map_session_data->PChar, 2) == 1) { Sql_Query(SqlHandle, "UPDATE flist_settings SET lastonline = %u WHERE callingchar = %u;", (uint32)CVanaTime::getInstance()->getVanaTime(), map_session_data->PChar->id); }
            Sql_Query(SqlHandle, "UPDATE flist SET status = 0 WHERE listedchar = %u", map_session_data->PChar->id);
            FLnotify(map_session_data->PChar, true, false);
        }

        uint64 port64 = map_session_data->client_port;
        uint64 ipp = map_session_data->client_addr;
        ipp |= port64 << 32;

        map_session_data->PChar->StatusEffectContainer->SaveStatusEffects(map_session_data->shuttingDown == 1);

        delete[] map_session_data->server_packet_data;
        delete map_session_data->PChar;
        delete map_session_data;
        map_session_data = nullptr;

        map_session_list.erase(ipp);
        return 0;
    }

    ShowError(CL_RED"map_close_session: cannot close session, session not found\n" CL_RESET);
    return 1;
}

/************************************************************************
*                                                                       *
*  Timer function that clenup all timed out players                     *
*                                                                       *
************************************************************************/

int32 map_cleanup(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    map_session_list_t::iterator it = map_session_list.begin();

    while (it != map_session_list.end())
    {
        map_session_data_t* map_session_data = it->second;

        CCharEntity* PChar = map_session_data->PChar;

        if ((time(nullptr) - map_session_data->last_update) > 5)
        {
            if (PChar != nullptr && !(PChar->nameflags.flags & FLAG_DC))
            {

                PChar->nameflags.flags |= FLAG_DC;
                PChar->updatemask |= UPDATE_HP;
                if (PChar->status == STATUS_NORMAL)
                {
                    PChar->loc.zone->SpawnPCs(PChar);
                }
            }
            if ((time(nullptr) - map_session_data->last_update) > map_config.max_time_lastupdate)
            {
                if (PChar != nullptr)
                {
                    if (map_session_data->shuttingDown == 0)
                    {
                        //[Alliance] fix to stop server crashing:
                        //if a party within an alliance only has 1 char (that char will be party leader)
                        //if char then disconnects we need to tell the server about the alliance change
                        if (PChar->PParty != nullptr && PChar->PParty->m_PAlliance != nullptr && PChar->PParty->GetLeader() == PChar)
                        {
                            if (PChar->PParty->GetRealNumberOfPeople() == 1)
                            {
                                if (PChar->PParty->m_PAlliance->partyList.size() == 1)
                                {
                                    PChar->PParty->m_PAlliance->dissolveAlliance();
                                }
                                else
                                {
                                    PChar->PParty->m_PAlliance->removeParty(PChar->PParty);
                                }
                            }
                        }


                        // uncharm pet if player d/c
                        if (PChar->PPet != nullptr && PChar->PPet->objtype == TYPE_MOB)
                        {
                            petutils::DespawnPet(PChar);
                        }

                        PChar->StatusEffectContainer->SaveStatusEffects(true);
                        if (PChar->m_moghouseID && PChar->m_moghouseID != PChar->id) {
                            PChar->loc.boundary = 0;
                            PChar->loc.p.x = 0;
                            PChar->loc.p.y = 0;
                            PChar->loc.p.z = 0;
                            PChar->loc.p.rotation = 0;
                            PChar->m_moghouseID = 0;
                        }
                        charutils::SaveCharPosition(PChar);
                        charutils::RemoveGuestsFromMogHouse(PChar);

                        ShowDebug(CL_CYAN"map_cleanup: %s timed out, closing session\n" CL_RESET, PChar->GetName());

                        // flist stuff
                        if (FLgetSetting(map_session_data->PChar, 2) == 1) { Sql_Query(SqlHandle, "UPDATE flist_settings SET lastonline = %u WHERE callingchar = %u;", (uint32)CVanaTime::getInstance()->getVanaTime(), map_session_data->PChar->id); }
                        Sql_Query(SqlHandle, "UPDATE flist SET status = 0 WHERE listedchar = %u", map_session_data->PChar->id);
                        FLnotify(PChar, true, false);

                        PChar->status = STATUS_SHUTDOWN;
                        PacketParser[0x00D](map_session_data, PChar, std::move(CBasicPacket()));
                    }
                    map_session_data->PChar->m_disconnecting = true;
                    map_session_data->PChar->StatusEffectContainer->SaveStatusEffects(true);
                    Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE charid = %u;", map_session_data->PChar->id);

                    delete[] map_session_data->server_packet_data;
                    delete map_session_data->PChar;
                    delete map_session_data;
                    map_session_data = nullptr;

                    map_session_list.erase(it++);
                    continue;
                }
                else if (map_session_data->shuttingDown == 0)
                {

                    ShowWarning(CL_YELLOW"map_cleanup: WHITHOUT CHAR timed out, session closed\n" CL_RESET);

                    const char* Query = "DELETE FROM accounts_sessions WHERE client_addr = %u AND client_port = %u";
                    Sql_Query(SqlHandle, Query, map_session_data->client_addr, map_session_data->client_port);

                    delete[] map_session_data->server_packet_data;
                    map_session_list.erase(it++);
                    delete map_session_data;
                    continue;
                }
            }
        }
        else if (PChar != nullptr && (PChar->nameflags.flags & FLAG_DC))
        {
            PChar->nameflags.flags &= ~FLAG_DC;
            PChar->updatemask |= UPDATE_HP;

            if (PChar->status == STATUS_NORMAL)
            {
                PChar->loc.zone->SpawnPCs(PChar);
            }
            charutils::SaveCharStats(PChar);
        }
        ++it;
    }
    return 0;
}

/************************************************************************
*                                                                       *
*  Map-Server Version Screen [venom]                                    *
*                                                                       *
************************************************************************/

void map_helpscreen(int32 flag)
{
    ShowMessage("Usage: map-server [options]\n");
    ShowMessage("Options:\n");
    ShowMessage(CL_WHITE"  Commands\t\t\tDescription\n" CL_RESET);
    ShowMessage("-----------------------------------------------------------------------------\n");
    ShowMessage("  --help, --h, --?, /?     Displays this help screen\n");
    ShowMessage("  --map-config <file>      Load map-server configuration from <file>\n");
    ShowMessage("  --version, --v, -v, /v   Displays the server's version\n");
    ShowMessage("\n");
    if (flag)
    {
        exit(EXIT_FAILURE);
    }
}

/************************************************************************
*                                                                       *
*  Map-Server Version Screen [venom]                                    *
*                                                                       *
************************************************************************/

void map_versionscreen(int32 flag)
{
    ShowInfo(CL_WHITE "Topaz version %d.%02d.%02d" CL_RESET"\n",
        TOPAZ_MAJOR_VERSION, TOPAZ_MINOR_VERSION, TOPAZ_REVISION);
    if (flag)
    {
        exit(EXIT_FAILURE);
    }
}

/************************************************************************
*                                                                       *
*  map_config_default                                                   *
*                                                                       *
************************************************************************/

int32 map_config_default()
{
    map_config.uiMapIp = INADDR_ANY;
    map_config.usMapPort = 54230;
    map_config.mysql_host = "127.0.0.1";
    map_config.mysql_login = "root";
    map_config.mysql_password = "root";
    map_config.mysql_database = "tpzdb";
    map_config.mysql_port = 3306;
    map_config.mysql_ssl = false;
    map_config.mysql_ssl_verify = false;
    map_config.rabbitmq_host = "127.0.0.1";
    map_config.rabbitmq_port = 5672;
    map_config.rabbitmq_login = "topaz";
    map_config.rabbitmq_password = "topaz";
    map_config.rabbitmq_vhost = "TOPAZ_MAP";
    map_config.rabbitmq_ssl = false;
    map_config.rabbitmq_ssl_verify = false;
    map_config.world_id = 100;
    map_config.server_message = "";
    map_config.buffer_size = 1800;
    map_config.ah_base_fee_single = 1;
    map_config.ah_base_fee_stacks = 4;
    map_config.ah_tax_rate_single = 1.0;
    map_config.ah_tax_rate_stacks = 0.5;
    map_config.ah_max_fee = 10000;
    map_config.ah_list_limit = 7;
    map_config.exp_rate = 1.0f;
    map_config.exp_loss_rate = 1.0f;
    map_config.exp_retain = 0.0f;
    map_config.exp_loss_level = 4;
    map_config.level_sync_enable = 0;
    map_config.disable_gear_scaling = 0;
    map_config.all_jobs_widescan = 1;
    map_config.speed_mod = 0;
    map_config.mount_speed_mod = 0;
    map_config.mob_speed_mod = 0;
    map_config.skillup_chance_multiplier = 1.0f;
    map_config.craft_chance_multiplier = 1.0f;
    map_config.skillup_amount_multiplier = 1;
    map_config.craft_amount_multiplier = 1;
    map_config.garden_day_matters = false;
    map_config.garden_moonphase_matters = false;
    map_config.garden_pot_matters = false;
    map_config.garden_mh_aura_matters = false;
    map_config.craft_common_cap = 700;
    map_config.craft_specialization_points = 400;
    map_config.mob_tp_multiplier = 1.0f;
    map_config.player_tp_multiplier = 1.0f;
    map_config.nm_hp_multiplier = 1.0f;
    map_config.mob_hp_multiplier = 1.0f;
    map_config.player_hp_multiplier = 1.0f;
    map_config.alter_ego_hp_multiplier = 1.0f;
    map_config.nm_mp_multiplier = 1.0f;
    map_config.mob_mp_multiplier = 1.0f;
    map_config.player_mp_multiplier = 1.0f;
    map_config.alter_ego_mp_multiplier = 1.0f;
    map_config.sj_mp_divisor = 2.0f;
    map_config.subjob_ratio = 1;
    map_config.include_mob_sj = false;
    map_config.vana_hours_per_pos_update = 1;
    map_config.zone_sleep_timer = 240;
    map_config.zone_crash_recovery_min_players = 3;
    map_config.nm_stat_multiplier = 1.0f;
    map_config.mob_stat_multiplier = 1.0f;
    map_config.player_stat_multiplier = 1.0f;
    map_config.alter_ego_stat_multiplier = 1.0f;
    map_config.alter_ego_skill_multiplier = 1.0f;
    map_config.ability_recast_multiplier = 1.0f;
    map_config.blood_pact_shared_timer = 0;
    map_config.vanadiel_time_epoch = 0;
    map_config.jst_offset = 32400;
    map_config.lightluggage_block = 4;
    map_config.packetguard_enabled = false;
    map_config.max_time_lastupdate = 60000;
    map_config.newstyle_skillups = 0;
    map_config.drop_rate_multiplier = 1.0f;
    map_config.mob_gil_multiplier = 1.0f;
    map_config.all_mobs_gil_bonus = 0;
    map_config.max_gil_bonus = 9999;
    map_config.Battle_cap_tweak = 0;
    map_config.lv_cap_mission_bcnm = 0;
    map_config.max_merit_points = 30;
    map_config.yell_cooldown = 30;
    map_config.yell_min_level = 5;
    map_config.audit_gm_cmd = 0;
    map_config.audit_chat = 0;
    map_config.audit_say = 0;
    map_config.audit_shout = 0;
    map_config.audit_emotion = 0;
    map_config.audit_tell = 0;
    map_config.audit_yell = 0;
    map_config.audit_system = 0;
    map_config.audit_party = 0;
    map_config.audit_linkshell = 0;
    map_config.msg_server_port = 54003;
    map_config.msg_server_ip = "127.0.0.1";
    map_config.healing_tick_delay = 10;
    map_config.skillup_bloodpact = true;
    map_config.anticheat_enabled = false;
    map_config.anticheat_jail_disable = false;
    map_config.mog_garden_enabled = false;
    map_config.poshack_threshold = 60.0;
    map_config.claimbot_threshold = 10;
    map_config.cheat_threshold_warn = 1;
    map_config.cheat_threshold_jail = 1;
    map_config.debug_client_ip = 0;
    map_config.daily_tally_amount = 10;
    map_config.daily_tally_limit = 50000;
    map_config.mission_storage_recovery = false;
    map_config.helpdesk_enabled = false;
    map_config.autotarget_qol = true;
    map_config.instances_treat_GMs_as_players = true;
    return 0;
}

int32 map_config_from_env()
{
    map_config.mysql_login     = std::getenv("TPZ_DB_USER") ? std::getenv("TPZ_DB_USER") : map_config.mysql_login;
    map_config.mysql_password  = std::getenv("TPZ_DB_USER_PASSWD") ? std::getenv("TPZ_DB_USER_PASSWD") : map_config.mysql_password;
    map_config.mysql_host      = std::getenv("TPZ_DB_HOST") ? std::getenv("TPZ_DB_HOST") : map_config.mysql_host;
    map_config.mysql_port      = std::getenv("TPZ_DB_PORT") ? std::stoi(std::getenv("TPZ_DB_PORT")) : map_config.mysql_port;
    map_config.mysql_database  = std::getenv("TPZ_DB_NAME") ? std::getenv("TPZ_DB_NAME") : map_config.mysql_database;
    map_config.msg_server_ip   = std::getenv("TPZ_MSG_IP") ? std::getenv("TPZ_MSG_IP") : map_config.msg_server_ip;
    map_config.msg_server_port = std::getenv("TPZ_MSG_PORT") ? std::stoi(std::getenv("TPZ_MSG_PORT")) : map_config.msg_server_port;
    return 0;
}

/************************************************************************
*                                                                       *
*  Map-Server Config [venom]                                            *
*                                                                       *
************************************************************************/

int32 map_config_read(const int8* cfgName)
{
    char line[1024], w1[1024], w2[1024];
    FILE* fp;

    fp = fopen((const char*)cfgName, "r");
    if (fp == nullptr)
    {
        ShowError("Map configuration file not found at: %s\n", cfgName);
        return 1;
    }

    bool knownSetting = true;

    while (fgets(line, sizeof(line), fp))
    {
        char* ptr;

        if (line[0] == '#')
        {
            continue;
        }
        if (sscanf(line, "%[^:]: %[^\t\r\n]", w1, w2) < 2)
        {
            continue;
        }

        //Strip trailing spaces
        ptr = w2 + strlen(w2);
        while (--ptr >= w2 && *ptr == ' ');
        ptr++;
        *ptr = '\0';

        // TODO: Refactor these blocks of ifs 
        // There is a compiler-enforced limitation of no more than 128 nested ifs so this is split once the limitation is reached
        // https://docs.microsoft.com/en-us/cpp/error-messages/compiler-errors-1/fatal-error-c1061?view=msvc-170
        if (strcmpi(w1, "timestamp_format") == 0)
        {
            strncpy(timestamp_format, w2, 20);
        }
        else if (strcmpi(w1, "stdout_with_ansisequence") == 0)
        {
            stdout_with_ansisequence = config_switch(w2);
        }
        else if (strcmpi(w1, "console_silent") == 0)
        {
            //ShowInfo("Console Silent Setting: %d", atoi(w2));
            msg_silent = atoi(w2);
        }
        else if (strcmpi(w1, "map_port") == 0)
        {
            map_config.usMapPort = (atoi(w2));
        }
        else if (strcmp(w1, "buff_maxsize") == 0)
        {
            map_config.buffer_size = atoi(w2);
        }
        else if (strcmp(w1, "max_time_lastupdate") == 0)
        {
            map_config.max_time_lastupdate = atoi(w2);
        }
        else if (strcmp(w1, "vanadiel_time_epoch") == 0)
        {
            map_config.vanadiel_time_epoch = atoi(w2);
        }
        else if (strcmp(w1, "jst_offset") == 0)
        {
            map_config.jst_offset = atoi(w2);
        }
        else if (strcmp(w1, "fame_multiplier") == 0)
        {
            map_config.fame_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "lightluggage_block") == 0)
        {
            map_config.lightluggage_block = atoi(w2);
        }
        else if (strcmp(w1, "packetguard_enabled") == 0)
        {
            map_config.packetguard_enabled = atoi(w2);
        }
        else if (strcmp(w1, "ah_base_fee_single") == 0)
        {
            map_config.ah_base_fee_single = atoi(w2);
        }
        else if (strcmp(w1, "ah_base_fee_stacks") == 0)
        {
            map_config.ah_base_fee_stacks = atoi(w2);
        }
        else if (strcmp(w1, "ah_tax_rate_single") == 0)
        {
            map_config.ah_tax_rate_single = (float)atof(w2);
        }
        else if (strcmp(w1, "ah_tax_rate_stacks") == 0)
        {
            map_config.ah_tax_rate_stacks = (float)atof(w2);
        }
        else if (strcmp(w1, "ah_max_fee") == 0)
        {
            map_config.ah_max_fee = atoi(w2);
        }
        else if (strcmp(w1, "ah_list_limit") == 0)
        {
            map_config.ah_list_limit = atoi(w2);
        }
        else if (strcmp(w1, "exp_rate") == 0)
        {
            map_config.exp_rate = (float)atof(w2);
        }
        else if (strcmp(w1, "exp_loss_rate") == 0)
        {
            map_config.exp_loss_rate = (float)atof(w2);
        }
        else if (strcmp(w1, "exp_party_gap_penalties") == 0)
        {
            map_config.exp_party_gap_penalties = (uint8)atof(w2);
        }
        else if (strcmp(w1, "fov_allow_alliance") == 0)
        {
            map_config.fov_allow_alliance = (uint8)atof(w2);
        }
        else if (strcmp(w1, "mob_tp_multiplier") == 0)
        {
            map_config.mob_tp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_tp_multiplier") == 0)
        {
            map_config.player_tp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "nm_hp_multiplier") == 0)
        {
            map_config.nm_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_hp_multiplier") == 0)
        {
            map_config.mob_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_hp_multiplier") == 0)
        {
            map_config.player_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_hp_multiplier") == 0)
        {
            map_config.alter_ego_hp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "nm_mp_multiplier") == 0)
        {
            map_config.nm_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_mp_multiplier") == 0)
        {
            map_config.mob_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_mp_multiplier") == 0)
        {
            map_config.player_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_mp_multiplier") == 0)
        {
            map_config.alter_ego_mp_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "sj_mp_divisor") == 0)
        {
            map_config.sj_mp_divisor = (float)atof(w2);
        }
        else if (strcmp(w1, "subjob_ratio") == 0)
        {
            map_config.subjob_ratio = atoi(w2);
        }
        else if (strcmp(w1, "include_mob_sj") == 0)
        {
            map_config.include_mob_sj = atoi(w2);
        }
        else if (strcmp(w1, "vana_hours_per_pos_update") == 0)
        {
        map_config.vana_hours_per_pos_update = (uint8)atof(w2);
        }
        else if (strcmp(w1, "zone_sleep_timer") == 0)
        {
        map_config.zone_sleep_timer = (uint16)atof(w2);
        }
        else if (strcmp(w1, "zone_crash_recovery_min_players") == 0)
        {
        map_config.zone_crash_recovery_min_players = (uint8)atof(w2);
        }
        else if (strcmp(w1, "nm_stat_multiplier") == 0)
        {
            map_config.nm_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_stat_multiplier") == 0)
        {
            map_config.mob_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "player_stat_multiplier") == 0)
        {
            map_config.player_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_stat_multiplier") == 0)
        {
            map_config.alter_ego_stat_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "alter_ego_skill_multiplier") == 0)
        {
            map_config.alter_ego_skill_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "ability_recast_multiplier") == 0)
        {
            map_config.ability_recast_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "blood_pact_shared_timer") == 0)
        {
            map_config.blood_pact_shared_timer = atoi(w2);
        }
        else if (strcmp(w1, "drop_rate_multiplier") == 0)
        {
            map_config.drop_rate_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "mob_gil_multiplier") == 0)
        {
            map_config.mob_gil_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "all_mobs_gil_bonus") == 0)
        {
            map_config.all_mobs_gil_bonus = atoi(w2);
        }
        else if (strcmp(w1, "max_gil_bonus") == 0)
        {
            map_config.max_gil_bonus = atoi(w2);
        }
        else if (strcmp(w1, "exp_retain") == 0)
        {
            map_config.exp_retain = std::clamp<float>((float)atof(w2), 0.0f, 1.0f);
        }
        else if (strcmp(w1, "exp_loss_level") == 0)
        {
            map_config.exp_loss_level = atoi(w2);
        }
        else if (strcmp(w1, "level_sync_enable") == 0)
        {
            map_config.level_sync_enable = atoi(w2);
        }
        else if (strcmp(w1, "disable_gear_scaling") == 0)
        {
            map_config.disable_gear_scaling = atoi(w2);
        }
        else if (strcmp(w1, "all_jobs_widescan") == 0)
        {
            map_config.all_jobs_widescan = atoi(w2);
        }
        else if (strcmp(w1, "speed_mod") == 0)
        {
            map_config.speed_mod = atoi(w2);
        }
        else if (strcmp(w1, "mount_speed_mod") == 0)
        {
            map_config.mount_speed_mod = atoi(w2);
        }
        else if (strcmp(w1, "mob_speed_mod") == 0)
        {
            map_config.mob_speed_mod = atoi(w2);
        }
        else if (strcmp(w1, "skillup_chance_multiplier") == 0)
        {
            map_config.skillup_chance_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "craft_chance_multiplier") == 0)
        {
            map_config.craft_chance_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "skillup_amount_multiplier") == 0)
        {
            map_config.skillup_amount_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "craft_amount_multiplier") == 0)
        {
            map_config.craft_amount_multiplier = (float)atof(w2);
        }
        else if (strcmp(w1, "craft_common_cap") == 0)
        {
            map_config.craft_common_cap = atoi(w2);
        }
        else if (strcmp(w1, "craft_specialization_points") == 0)
        {
            map_config.craft_specialization_points = atoi(w2);
        }
        else if (strcmp(w1, "garden_day_matters") == 0)
        {
            map_config.garden_day_matters = atof(w2);
        }
        else if (strcmp(w1, "garden_moonphase_matters") == 0)
        {
            map_config.garden_moonphase_matters = atof(w2);
        }
        else if (strcmp(w1, "garden_pot_matters") == 0)
        {
            map_config.garden_pot_matters = atof(w2);
        }
        else if (strcmp(w1, "garden_mh_aura_matters") == 0)
        {
            map_config.garden_mh_aura_matters = atof(w2);
        }
        else if (strcmp(w1, "mysql_host") == 0)
        {
            map_config.mysql_host = std::string(w2);
        }
        else if (strcmp(w1, "mysql_login") == 0)
        {
            map_config.mysql_login = std::string(w2);
        }
        else if (strcmp(w1, "mysql_password") == 0)
        {
            map_config.mysql_password = std::string(w2);
        }
        else if (strcmp(w1, "mysql_port") == 0)
        {
            map_config.mysql_port = atoi(w2);
        }
        else if (strcmp(w1, "mysql_database") == 0)
        {
            map_config.mysql_database = std::string(w2);
        }
        else if (strcmp(w1, "mysql_ssl") == 0)
        {
        map_config.mysql_ssl = atoi(w2);
        }
        else if (strcmp(w1, "mysql_ssl_verify") == 0)
        {
        map_config.mysql_ssl_verify = atoi(w2);
        }
        else if (strcmp(w1, "mysql_ssl_ca") == 0)
        {
        map_config.mysql_ssl_ca = std::string(w2);
        }
        else if (strcmp(w1, "mysql_ssl_cert") == 0)
        {
        map_config.mysql_ssl_cert = std::string(w2);
        }
        else if (strcmp(w1, "mysql_ssl_key") == 0)
        {
        map_config.mysql_ssl_key = std::string(w2);
        }
        else if (strcmp(w1, "rabbitmq_host") == 0)
        {
            map_config.rabbitmq_host = std::string(w2);
        }
        else if (strcmp(w1, "rabbitmq_port") == 0)
        {
            map_config.rabbitmq_port = atoi(w2);
        }
        else if (strcmp(w1, "rabbitmq_login") == 0)
        {
            map_config.rabbitmq_login = std::string(w2);
        }
        else if (strcmp(w1, "rabbitmq_password") == 0)
        {
            map_config.rabbitmq_password = std::string(w2);
        }
        else if (strcmp(w1, "rabbitmq_vhost") == 0)
        {
            map_config.rabbitmq_vhost = std::string(w2);
        }
        else if (strcmp(w1, "rabbitmq_ssl") == 0)
        {
            map_config.rabbitmq_ssl = atoi(w2);
        }
        else if (strcmp(w1, "rabbitmq_ssl_verify") == 0)
        {
            map_config.rabbitmq_ssl_verify = atoi(w2);
        }
        else if (strcmp(w1, "rabbitmq_ssl_ca") == 0)
        {
            map_config.rabbitmq_ssl_ca = std::string(w2);
        }
        else if (strcmp(w1, "rabbitmq_ssl_cert") == 0)
        {
            map_config.rabbitmq_ssl_cert = std::string(w2);
        }
        else if (strcmp(w1, "rabbitmq_ssl_key") == 0)
        {
            map_config.rabbitmq_ssl_key = std::string(w2);
        }
        else if (strcmp(w1, "world_id") == 0)
        {
            map_config.world_id = atoi(w2);
        }
        else if (strcmpi(w1, "import") == 0)
        {
            map_config_read((const int8*)w2);
        }
        else if (strcmpi(w1, "newstyle_skillups") == 0)
        {
            map_config.newstyle_skillups = atoi(w2);
        }
        else if (strcmp(w1, "Battle_cap_tweak") == 0)
        {
            map_config.Battle_cap_tweak = atoi(w2);
        }
        else if (strcmp(w1, "lv_cap_mission_bcnm") == 0)
        {
            map_config.lv_cap_mission_bcnm = atoi(w2);
        }
        else if (strcmp(w1, "max_merit_points") == 0)
        {
            map_config.max_merit_points = atoi(w2);
        }
        else if (strcmp(w1, "yell_cooldown") == 0)
        {
            map_config.yell_cooldown = atoi(w2);
        }
        else if (strcmp(w1, "yell_min_level") == 0)
        {
        map_config.yell_min_level = atoi(w2);
        }
        else if (strcmp(w1, "audit_gm_cmd") == 0)
        {
            map_config.audit_gm_cmd = atoi(w2);
        }
        else if (strcmp(w1, "audit_chat") == 0)
        {
            map_config.audit_chat = atoi(w2);
        }
        else if (strcmp(w1, "audit_say") == 0)
        {
            map_config.audit_say = atoi(w2);
        }
        else if (strcmp(w1, "audit_shout") == 0)
        {
            map_config.audit_shout = atoi(w2);
        }
        else if (strcmp(w1, "audit_emotion") == 0)
        {
            map_config.audit_emotion = atoi(w2);
        }
        else if (strcmp(w1, "audit_tell") == 0)
        {
            map_config.audit_tell = atoi(w2);
        }
        else if (strcmp(w1, "audit_yell") == 0)
        {
            map_config.audit_yell = atoi(w2);
        }
        else if (strcmp(w1, "audit_system") == 0)
        {
            map_config.audit_system = atoi(w2);
        }
        else if (strcmp(w1, "audit_linkshell") == 0)
        {
            map_config.audit_linkshell = atoi(w2);
        }
        else if (strcmp(w1, "audit_party") == 0)
        {
            map_config.audit_party = atoi(w2);
        }
        else if (strcmp(w1, "msg_server_port") == 0)
        {
            map_config.msg_server_port = atoi(w2);
        }
        else if (strcmp(w1, "msg_server_ip") == 0)
        {
            map_config.msg_server_ip = std::string(w2);
        }
        else if (strcmp(w1, "mob_no_despawn") == 0)
        {
            map_config.mob_no_despawn = atoi(w2);
        }
        else if (strcmp(w1, "healing_tick_delay") == 0)
        {
            map_config.healing_tick_delay = atoi(w2);
        }
        else if (strcmp(w1, "skillup_bloodpact") == 0)
        {
            map_config.skillup_bloodpact = atoi(w2);
        }
        else if (strcmp(w1, "anticheat_enabled") == 0)
        {
            map_config.anticheat_enabled = atoi(w2);
        }
        else if (strcmp(w1, "anticheat_jail_disable") == 0)
        {
            map_config.anticheat_jail_disable = atoi(w2);
        }
        else if (strcmp(w1, "mog_garden_enabled") == 0)
        {
            map_config.mog_garden_enabled = atoi(w2);
        }
        else if (strcmp(w1, "poshack_threshold") == 0)
        {
            map_config.poshack_threshold = (float)atof(w2);
        }
        else if (strcmp(w1, "claimbot_threshold") == 0) {
            map_config.claimbot_threshold = atoi(w2);
        }
        else if (strcmp(w1, "cheat_threshold_warn") == 0)
        {
            map_config.cheat_threshold_warn = atoi(w2);
        }
        else if (strcmp(w1, "cheat_threshold_jail") == 0)
        {
            map_config.cheat_threshold_jail = atoi(w2);
        }
        else if (strcmp(w1, "debug_client_ip") == 0)
        {
        inet_pton(AF_INET, w2, &map_config.debug_client_ip);
        }
        else if (strcmp(w1, "daily_tally_amount") == 0)
        {
            map_config.daily_tally_amount = atoi(w2);
        }
        else if (strcmp(w1, "daily_tally_limit") == 0)
        {
            map_config.daily_tally_limit = atoi(w2);
        }
        else if (strcmp(w1, "mission_storage_recovery") == 0)
        {
        map_config.mission_storage_recovery = atoi(w2);
        }
        else
        {
            knownSetting = false;
        }

        // Breaking previous if statement block as a workaround for else-if clause limitatation of 128
        if (!knownSetting)
        {
            if (strcmp(w1, "helpdesk_enabled") == 0)
            {
                map_config.helpdesk_enabled = atoi(w2);
            }
            else if (strcmp(w1, "autotarget_qol") == 0)
            {
                map_config.autotarget_qol = atoi(w2);
            }
            else if (strcmp(w1, "instances_treat_GMs_as_players") == 0)
            {
                map_config.instances_treat_GMs_as_players = atoi(w2);
            }
            else
            {
                ShowWarning(CL_YELLOW"Unknown setting '%s' in file %s\n" CL_RESET, w1, cfgName);
            }
        }
        knownSetting = true;
    }

    fclose(fp);

    // Load the English server message..
    fp = fopen("./conf/server_message.conf", "rb");
    if (fp == nullptr)
    {
        ShowError("Could not read English server message from: ./conf/server_message.conf\n");
        return 1;
    }

    while (fgets(line, sizeof(line), fp))
    {
        string_t sline(line);
        map_config.server_message += sline;
    }

    fclose(fp);

    // Ensure both messages have nullptr terminates..
    if (map_config.server_message.at(map_config.server_message.length() - 1) != 0x00)
    {
        map_config.server_message += (char)0x00;
    }

    return 0;
}

int32 map_garbage_collect(time_point tick, CTaskMgr::CTask* PTask)
{
    TracyZoneScoped;
    luautils::garbageCollect();
    return 0;
}

int32 crash_recovery_end(time_point tick, CTaskMgr::CTask* PTask)
{
    //ShowDebug("ENDING CRASH RECOVERY LOOP NOW\n");
    if (!inCrashRecoveryLoop)
    {
        return 0;
    }
    
    inCrashRecoveryLoop = false;
    isForceCreateSessionEnabled = true;
    
    return 0;
}

int32 disableForceCreateSession(time_point tick, CTaskMgr::CTask* PTask)
{
    isForceCreateSessionEnabled = false;

    return 0;
}

int32 recoveryZoneChars(time_point tick, CTaskMgr::CTask* PTask)
{
    std::for_each(std::begin(prunedSessionsList), std::end(prunedSessionsList), [](pruned_session session)
    {
            CCharEntity* PChar = zoneutils::GetChar(session.m_1_charid);
            //if (PChar)
                //PChar->
            
    });

    return 0;
}



void log_init(int argc, char** argv)
{
    std::string logFile;
    std::string logDir;
#ifdef DEBUGLOGMAP
#ifdef WIN32
    logDir = "log\\";
#else
    logDir = "log/";
#endif
    logFile = logDir + "map-server.log";
#endif
    bool defaultname = true;
    for (int i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--ip") == 0 && defaultname)
        {
            logFile = logDir + argv[i + 1];
        }
        else if (strcmp(argv[i], "--port") == 0 && defaultname)
        {
            logFile.append(argv[i + 1]);
        }
        else if (strcmp(argv[i], "--log") == 0)
        {
            defaultname = false;
            logFile = argv[i + 1];
        }
    }
    InitializeLog(logFile);
}

void log_final()
{
    CloseLog();
}
