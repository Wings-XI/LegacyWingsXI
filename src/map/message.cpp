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

#include <mutex>
#include <queue>

#include "message.h"
#include "rpcmapper.h"
#include "../new-common/MQConnection.h"
#include "../new-common/CommonMessages.h"

#include "party.h"
#include "alliance.h"
#include "linkshell.h"
#include "status_effect_container.h"

#include "entities/charentity.h"

#include "packets/message_standard.h"
#include "packets/message_system.h"
#include "packets/party_invite.h"
#include "packets/server_ip.h"

#include "utils/charutils.h"
#include "utils/zoneutils.h"
#include "utils/jailutils.h"
#include "utils/flistutils.h"
#include "items/item_linkshell.h"

#define MAP_MQ_MESSAGE_MAGIC 0x4441574E

#pragma pack(push, 1)

typedef struct _MAP_MQ_MESSAGE_HEADER
{
    uint32 magic;
    uint64 origin;
    MSGSERVTYPE type;
    uint32 packet_size;
    uint32 extra_size;
} MAP_MQ_MESSAGE_HEADER;

#pragma pack(pop)

namespace message
{
    std::queue<std::shared_ptr<uint8>> message_queue;
    uint64 own_identity;
    std::shared_ptr<MQConnection> g_mqconnection = nullptr;
    std::shared_ptr<MapMQHandler> g_handler = nullptr;
    bool g_being_closed = false;
    RPCMapper* g_mapper = nullptr;
    std::recursive_timed_mutex local_mq_mutex;

    void route_message(uint8* msg)
    {
        int ret = SQL_ERROR;
        bool ipstring = false;
        MAP_MQ_MESSAGE_HEADER* header = reinterpret_cast<MAP_MQ_MESSAGE_HEADER*>(msg);
        MSGSERVTYPE type = header->type;
        uint8* extra = msg + sizeof(MAP_MQ_MESSAGE_HEADER) + header->packet_size;
        // TODO: Probably use a different routing key for each linkshell / party etc.
        // to avoid having to send multiple messages. Better make it run as is for
        // now and change it if we really see a performance issue.
        bool broadcast = false;

        if (header->magic != MAP_MQ_MESSAGE_MAGIC) {
            // Not a map message so silent drop
            return;
        }
        switch (type)
        {
        case MSG_CHAT_TELL:
        case MSG_LINKSHELL_RANK_CHANGE:
        case MSG_LINKSHELL_REMOVE:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions LEFT JOIN chars ON "
                "accounts_sessions.charid = chars.charid WHERE charname = '%s' LIMIT 1;";
            ret = Sql_Query(SqlHandle, query, (int8*)extra + 4);
            if (Sql_NumRows(SqlHandle) == 0)
            {
                query = "SELECT server_addr, server_port FROM accounts_sessions WHERE charid = %d LIMIT 1;";
                ret = Sql_Query(SqlHandle, query, *reinterpret_cast<uint32*>(extra));
            }
            break;
        }
        case MSG_CHAT_PARTY:
        case MSG_PT_RELOAD:
        case MSG_PT_DISBAND:
        {
            const char* query = "SELECT server_addr, server_port, MIN(charid) FROM accounts_sessions JOIN accounts_parties USING (charid) "
                "WHERE IF (allianceid <> 0, allianceid = (SELECT MAX(allianceid) FROM accounts_parties WHERE partyid = %d), "
                "partyid = %d) GROUP BY server_addr, server_port;";
            uint32 partyid = *reinterpret_cast<uint32*>(extra);
            ret = Sql_Query(SqlHandle, query, partyid, partyid);
            break;
        }
        case MSG_CHAT_LINKSHELL:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions "
                "WHERE linkshellid1 = %d OR linkshellid2 = %d GROUP BY server_addr, server_port;";
            ret = Sql_Query(SqlHandle, query, *reinterpret_cast<uint32*>(extra), *reinterpret_cast<uint32*>(extra));
            break;
        }
        case MSG_CHAT_YELL:
        {
            broadcast = true;
            //const char* query = "SELECT zoneip, zoneport FROM zone_settings WHERE misc & 1024 GROUP BY zoneip, zoneport;";
            //ret = Sql_Query(SqlHandle, query);
            //ipstring = true;
            break;
        }
        case MSG_CHAT_SERVMES:
        case MSG_NEW_TICKET:
        {
            broadcast = true;
            //const char* query = "SELECT zoneip, zoneport FROM zone_settings GROUP BY zoneip, zoneport;";
            //ret = Sql_Query(SqlHandle, query);
            //ipstring = true;
            break;
        }
        case MSG_PT_INVITE:
        case MSG_PT_INV_RES:
        case MSG_DIRECT:
        case MSG_SEND_TO_ZONE:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions WHERE charid = %d;";
            ret = Sql_Query(SqlHandle, query, *reinterpret_cast<uint32*>(extra));
            break;
        }
        case MSG_SEND_TO_ENTITY:
        {
            const char* query = "SELECT zoneip, zoneport FROM zone_settings WHERE zoneid = %d;";
            ret = Sql_Query(SqlHandle, query, *reinterpret_cast<uint16*>(extra + 2));
            ipstring = true;
            break;
        }
        case MSG_SEND_FL_NOTIF:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions WHERE charid = %d LIMIT 1;";
            ret = Sql_Query(SqlHandle, query, *reinterpret_cast<uint32*>(extra + 1));
            break;
        }
        case MSG_LOGIN:
        {
            // no op
            break;
        }
        case MSG_RPC_REQUEST:
        case MSG_RPC_RESPONSE:
        {
            const char* query = "SELECT zoneip, zoneport FROM zone_settings WHERE zoneid = %d;";
            ret = Sql_Query(SqlHandle, query, *reinterpret_cast<uint16*>(extra + 4));
            ipstring = true;
            break;
        }
        default:
        {
            ShowDebug("Message: unknown type received: %u\n", static_cast<uint8>(type));
            break;
        }
        }

        if (broadcast || ret != SQL_ERROR)
        {
            ShowDebug("Message: Received message %u\n", static_cast<uint8>(type));

            if (broadcast) {
                ShowDebug("Message:  -> sending broadcast\n");
                try {
                    g_mqconnection->Send(1, msg, sizeof(MAP_MQ_MESSAGE_HEADER) + header->packet_size + header->extra_size);
                }
                catch (std::runtime_error&) {
                    ShowError("Messsage: connection to MQ failed, broadcast message not sent\n");
                }
            }
            else {
                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                {
                    uint64 ipp = 0;

                    if (ipstring)
                    {
                        inet_pton(AF_INET, (const char*)Sql_GetData(SqlHandle, 0), &ipp);
                    }
                    else
                    {
                        ipp = Sql_GetUIntData(SqlHandle, 0);
                    }

                    uint64 port = Sql_GetUIntData(SqlHandle, 1);
                    ipp |= (port << 32);

                    if (ipp != own_identity) {
                        std::string strTargetQueue = "map_" + std::to_string(ipp);

                        ShowDebug("Message:  -> sending to %s\n", strTargetQueue.c_str());

                        if (type == MSG_CHAT_PARTY || type == MSG_PT_RELOAD || type == MSG_PT_DISBAND)
                        {
                            *reinterpret_cast<uint32*>(extra) = Sql_GetUIntData(SqlHandle, 2);
                        }

                        try {
                            g_mqconnection->Send(1, msg, sizeof(MAP_MQ_MESSAGE_HEADER) + header->packet_size + header->extra_size, &strTargetQueue);
                        }
                        catch (std::runtime_error&) {
                            ShowError("Messsage: connection to MQ failed, message not sent\n");
                        }
                    }
                    else {
                        ShowDebug("Message:  -> loopback\n");
                    }

                }
            }
        }
    }

    void send_queue()
    {
        while (!message_queue.empty())
        {
            // Do not remove these wiggly braces, they are not here for looks!
            // They ensure that local_mq_mutex is released before route_message
            // is called, which prevents a potential deadlock.
            std::shared_ptr<uint8> msgptr;
            uint8* msg = nullptr;
            {
                g_mqconnection->IncrementHighPriorityThreadsWaiting();
                std::unique_lock<std::recursive_timed_mutex> lk(local_mq_mutex, std::defer_lock);
                while (!lk.try_lock_for(std::chrono::seconds(1))) {
                    if (map_doing_final) {
                        return;
                    }
                }
                g_mqconnection->DecrementHighPriorityThreadsWaiting();
                msgptr = message_queue.front();
                message_queue.pop();
            }
            try
            {
                msg = msgptr.get();
                if (msg) {
                    route_message(msg);
                }
            }
            catch (std::exception& e)
            {
                ShowError("Message: %s", e.what());
            }
        }
    }

    MapMQHandler::MapMQHandler()
    {
    }

    MapMQHandler::~MapMQHandler()
    {
    }

    void MapMQHandler::parse(MSGSERVTYPE type, uint8* extra, size_t extra_size, uint8* packet, size_t packet_size, bool from_self)
    {
        ShowDebug("Message: Received message %u from message server\n", static_cast<uint8>(type));
        switch (type)
        {
        case MSG_LOGIN:
        {
            // Not sent by new-login. Kept for partial backwards compatibility.
            CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra, 0));

            if (!PChar)
            {
                Sql_Query(SqlHandle, "DELETE FROM accounts_sessions WHERE charid = %d;", ref<uint32>((uint8*)extra, 0));
                // flist stuff
                if (FLgetSettingByID(ref<uint32>((uint8*)extra, 0), 2) == 1) { Sql_Query(SqlHandle, "UPDATE flist_settings SET lastonline = %u WHERE callingchar = %u;", (uint32)CVanaTime::getInstance()->getVanaTime(), ref<uint32>((uint8*)extra, 0)); }
                Sql_Query(SqlHandle, "UPDATE flist SET status = 0 WHERE listedchar = %u", ref<uint32>((uint8*)extra, 0));
                //FLnotify()
            }
            else
            {
                //TODO: disconnect the client, but leave the character in the disconnecting state
                //PChar->status = STATUS_SHUTDOWN;
                //won't save their position (since this is the wrong thread) but not a huge deal
                //PChar->pushPacket(new CServerIPPacket(PChar, 1, 0));
            }
            break;
        }
        case MSG_CHAT_TELL:
        {
            int8* targetCharName = (int8*)extra + 4;
            CCharEntity* PChar = zoneutils::GetCharByName(targetCharName);;
            bool charNotFound = false;
            if (!PChar) {
                int32 ret = Sql_Query(SqlHandle, "SELECT charid FROM accounts_sessions WHERE charid IN (SELECT charid FROM chars WHERE charname = '%s');",targetCharName);
                if (ret == SQL_ERROR || Sql_NumRows(SqlHandle) == 0) {
                    charNotFound = true;
                }
            }
            if (PChar && PChar->status != STATUS_DISAPPEAR && !jailutils::InPrison(PChar))
            {
                std::unique_ptr<CBasicPacket> newPacket = std::make_unique<CBasicPacket>();
                memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                auto gm_sent = newPacket->ref<uint8>(0x05);
                if (PChar->nameflags.flags & FLAG_AWAY && !gm_sent)
                {
                    send(MSG_DIRECT, extra, sizeof(uint32), new CMessageStandardPacket(PChar, 0, 0, MsgStd::TellNotReceivedAway));
                }
                else
                {
                    PChar->pushPacket(std::move(newPacket));
                }
            }
            else
            {
                if (charNotFound || (PChar && from_self) || (!PChar && !from_self)) {
                    send(MSG_DIRECT, extra, sizeof(uint32), new CMessageStandardPacket(PChar, 0, 0, MsgStd::TellNotReceivedOffline));
                }
            }
            break;
        }
        case MSG_CHAT_PARTY:
        {
            CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra, 0));
            if (PChar)
            {
                if (PChar->PParty)
                {
                    if (PChar->PParty->m_PAlliance != nullptr)
                    {
                        for (uint8 i = 0; i < PChar->PParty->m_PAlliance->partyList.size(); ++i)
                        {
                            CBasicPacket* newPacket = new CBasicPacket();
                            memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                            ((CParty*)PChar->PParty->m_PAlliance->partyList.at(i))->PushPacket(ref<uint32>((uint8*)extra, 4), 0, newPacket);
                        }
                    }
                    else
                    {
                        CBasicPacket* newPacket = new CBasicPacket();
                        memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                        PChar->PParty->PushPacket(ref<uint32>((uint8*)extra, 4), 0, newPacket);
                    }
                }
            }
            break;
        }
        case MSG_CHAT_LINKSHELL:
        {
            uint32 linkshellID = ref<uint32>((uint8*)extra, 0);
            CLinkshell* PLinkshell = linkshell::GetLinkshell(linkshellID);
            if (PLinkshell)
            {
                CBasicPacket* newPacket = new CBasicPacket();
                memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                PLinkshell->PushPacket(ref<uint32>((uint8*)extra, 4), newPacket);
            }
            break;
        }
        case MSG_CHAT_YELL:
        {
            zoneutils::ForEachZone([&packet, &extra, packet_size](CZone* PZone)
            {
                if (PZone->CanUseMisc(MISC_YELL))
                {
                    PZone->ForEachChar([&packet, &extra, packet_size](CCharEntity* PChar)
                    {
                        auto serverId = ref<uint32>((uint8*)extra, 0);
                        auto isMarkedSpam = (ref<uint32>((uint8*)extra, 4) != 0) && PChar->isYellSpamFiltered();

                        // don't push to the sender or anyone with yell filtered
                        if (PChar->id != serverId && !PChar->isYellFiltered() && !isMarkedSpam)
                        {
                            CBasicPacket* newPacket = new CBasicPacket();
                            memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));

                            PChar->pushPacket(newPacket);
                        }
                    });
                }
            });
            break;
        }
        case MSG_CHAT_SERVMES:
        {
            zoneutils::ForEachZone([&packet, packet_size](CZone* PZone)
            {
                PZone->ForEachChar([&packet, packet_size](CCharEntity* PChar)
                {
                    CBasicPacket* newPacket = new CBasicPacket();
                    memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                    PChar->pushPacket(newPacket);
                });
            });
            break;
        }
        case MSG_PT_INVITE:
        {
            uint32 id = ref<uint32>((uint8*)extra, 0);
            // uint16 targid = ref<uint16>((uint8*)extra->data(), 4);
            uint8 inviteType = ref<uint8>((uint8*)packet, 0x0B);
            CCharEntity* PInvitee = zoneutils::GetChar(id);

            if (PInvitee)
            {
                //make sure invitee isn't dead or in jail, they aren't a party member and don't already have an invite pending, and your party is not full
                if (PInvitee->isDead() || jailutils::InPrison(PInvitee) || PInvitee->InvitePending.id != 0 || (PInvitee->PParty && inviteType == INVITE_PARTY) ||
                    (inviteType == INVITE_ALLIANCE && (!PInvitee->PParty || PInvitee->PParty->GetLeader() != PInvitee || PInvitee->PParty->m_PAlliance)))
                {
                    ref<uint32>((uint8*)extra, 0) = ref<uint32>((uint8*)extra, 6);
                    send(MSG_DIRECT, extra, sizeof(uint32), new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::CannotInvite));
                    return;
                }
                // check /blockaid
                if (PInvitee->getBlockingAid())
                {
                    ref<uint32>((uint8*)extra, 0) = ref<uint32>((uint8*)extra, 6);
                    // Target is blocking assistance
                    send(MSG_DIRECT, extra, sizeof(uint32), new CMessageSystemPacket(0, 0, 225));
                    // Interaction was blocked
                    PInvitee->pushPacket(new CMessageSystemPacket(0, 0, 226));
                    // You cannot invite that person at this time.
                    send(MSG_DIRECT, extra, sizeof(uint32), new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::CannotInvite));
                    break;
                }
                if (PInvitee->StatusEffectContainer->HasStatusEffect(EFFECT_LEVEL_SYNC))
                {
                    ref<uint32>((uint8*)extra, 0) = ref<uint32>((uint8*)extra, 6);
                    send(MSG_DIRECT, extra, sizeof(uint32), new CMessageStandardPacket(PInvitee, 0, 0, MsgStd::CannotInviteLevelSync));
                    return;
                }

                PInvitee->InvitePending.id = ref<uint32>((uint8*)extra, 6);
                PInvitee->InvitePending.targid = ref<uint16>((uint8*)extra, 10);
                CBasicPacket* newPacket = new CBasicPacket();
                memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                PInvitee->pushPacket(newPacket);
            }
            break;
        }
        case MSG_PT_INV_RES:
        {
            uint32 inviterId = ref<uint32>((uint8*)extra, 0);
            // uint16 inviterTargid = ref<uint16>((uint8*)extra->data(), 4);
            uint32 inviteeId = ref<uint32>((uint8*)extra, 6);
            // uint16 inviteeTargid = ref<uint16>((uint8*)extra->data(), 10);
            uint8 inviteAnswer = ref<uint8>((uint8*)extra, 12);
            CCharEntity* PInviter = zoneutils::GetChar(inviterId);

            if (PInviter)
            {
                if (inviteAnswer == 0)
                {
                    PInviter->pushPacket(new CMessageStandardPacket(PInviter, 0, 0, MsgStd::InvitationDeclined));
                }
                else
                {
                    //both party leaders?
                    int ret = Sql_Query(SqlHandle, "SELECT * FROM accounts_parties WHERE partyid <> 0 AND \
                                                    ((charid = %u OR charid = %u) AND partyflag & %u);", inviterId,
                                                    inviteeId, PARTY_LEADER);
                    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 2)
                    {
                        if (PInviter->PParty->m_PAlliance)
                        {
                            ret = Sql_Query(SqlHandle, "SELECT * FROM accounts_parties WHERE allianceid <> 0 AND \
                                                        allianceid = (SELECT allianceid FROM accounts_parties where \
                                                        charid = %u) GROUP BY partyid;", inviterId);
                            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NumRows(SqlHandle) < 3)
                            {
                                PInviter->PParty->m_PAlliance->addParty(inviteeId);
                            }
                            else
                            {
                                send(MSG_DIRECT, (uint8*)extra + 6, sizeof(uint32), new CMessageStandardPacket(PInviter, 0, 0, MsgStd::CannotBeProcessed));
                            }
                        }
                        else
                        {
                            //make new alliance
                            CAlliance* PAlliance = new CAlliance(PInviter);
                            PAlliance->addParty(inviteeId);
                        }
                    }
                    else
                    {
                        if (PInviter->PParty == nullptr)
                        {
                            PInviter->PParty = new CParty(PInviter);
                        }
                        if (PInviter->PParty && PInviter->PParty->GetLeader() == PInviter)
                        {
                            ret = Sql_Query(SqlHandle, "SELECT * FROM accounts_parties WHERE partyid <> 0 AND \
                                                       															charid = %u;", inviteeId);
                            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 0)
                            {
                                PInviter->PParty->AddMember(inviteeId);
                            }
                        }
                    }
                }
            }
            break;
        }
        case MSG_PT_RELOAD:
        {
            if (extra_size == 8)
            {
                CCharEntity* PChar = zoneutils::GetCharToUpdate(ref<uint32>((uint8*)extra, 4), ref<uint32>((uint8*)extra, 0));
                if (PChar)
                {
                    PChar->ReloadPartyInc();
                    break;
                }
            }
            else
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra, 0));
                if (PChar)
                {
                    PChar->ForAlliance([](CBattleEntity* PMember)
                    {
                        ((CCharEntity*)PMember)->ReloadPartyInc();
                    });
                }
            }

            break;
        }
        case MSG_PT_DISBAND:
        {
            CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra, 0));
            uint32 id = ref<uint32>((uint8*)extra, 4);
            if (PChar)
            {
                if (PChar->PParty)
                {
                    if (PChar->PParty->m_PAlliance && PChar->PParty->m_PAlliance->m_AllianceID == id)
                    {
                        PChar->PParty->m_PAlliance->dissolveAlliance(false);
                    }
                    else
                    {
                        PChar->PParty->DisbandParty(false);
                    }
                }
            }
            break;
        }
        case MSG_DIRECT:
        {
            CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra, 0));
            if (PChar)
            {
                CBasicPacket* newPacket = new CBasicPacket();
                memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                PChar->pushPacket(newPacket);
            }
            break;
        }
        case MSG_LINKSHELL_RANK_CHANGE:
        {
            CLinkshell* PLinkshell = linkshell::GetLinkshell(ref<uint32>((uint8*)extra, 24));

            if (PLinkshell)
            {
                PLinkshell->ChangeMemberRank((int8*)extra + 4, ref<uint8>((uint8*)extra, 28));
            }
            break;
        }
        case MSG_LINKSHELL_REMOVE:
        {
            CCharEntity* PChar = zoneutils::GetCharByName((int8*)extra + 4);

            if (PChar && PChar->PLinkshell1 && PChar->PLinkshell1->getID() == ref<uint32>((uint8*)extra, 24))
            {
                uint8 kickerRank = ref<uint8>((uint8*)extra, 28);
                CItemLinkshell* targetLS = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);
                if (targetLS && (kickerRank == LSTYPE_LINKSHELL || (kickerRank == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
                {
                    PChar->PLinkshell1->RemoveMemberByName((int8*)extra + 4, (targetLS->GetLSType() == LSTYPE_LINKSHELL ? LSTYPE_PEARLSACK : kickerRank));
                }
            }
            else if (PChar && PChar->PLinkshell2 && PChar->PLinkshell2->getID() == ref<uint32>((uint8*)extra, 24))
            {
                uint8 kickerRank = ref<uint8>((uint8*)extra, 28);
                CItemLinkshell* targetLS = (CItemLinkshell*)PChar->getEquip(SLOT_LINK2);
                if (targetLS && (kickerRank == LSTYPE_LINKSHELL || (kickerRank == LSTYPE_PEARLSACK && targetLS->GetLSType() == LSTYPE_LINKPEARL)))
                {
                    PChar->PLinkshell2->RemoveMemberByName((int8*)extra + 4, kickerRank);
                }
            }
            break;
        }
        case MSG_SEND_TO_ZONE:
        {
            CCharEntity* PChar = zoneutils::GetChar(ref<uint32>((uint8*)extra, 0));

            if (PChar && PChar->loc.zone)
            {
                uint32 requester = ref<uint32>((uint8*)extra, 4);

                if (requester != 0)
                {
                    char buf[30];
                    memset(&buf[0], 0, sizeof(buf));

                    ref<uint32>(&buf, 0) = requester;
                    ref<uint16>(&buf, 8) = PChar->getZone();
                    ref<float>(&buf, 10) = PChar->loc.p.x;
                    ref<float>(&buf, 14) = PChar->loc.p.y;
                    ref<float>(&buf, 18) = PChar->loc.p.z;
                    ref<uint8>(&buf, 22) = PChar->loc.p.rotation;
                    ref<uint32>(&buf, 23) = PChar->m_moghouseID;

                    message::send(MSG_SEND_TO_ZONE, &buf, sizeof(buf), nullptr);
                    break;
                }

                uint16 zoneId = ref<uint16>((uint8*)extra, 8);
                float x = ref<float>((uint8*)extra, 10);
                float y = ref<float>((uint8*)extra, 14);
                float z = ref<float>((uint8*)extra, 18);
                uint8 rot = ref<uint8>((uint8*)extra, 22);
                uint32 moghouseID = ref<uint32>((uint8*)extra, 23);
                if (moghouseID != 0) {
                    x = 0;
                    y = 0;
                    z = 0;
                    rot = 192;
                }

                PChar->updatemask = 0;

                PChar->m_moghouseID = 0;

                PChar->loc.p.x = x;
                PChar->loc.p.y = y;
                PChar->loc.p.z = z;
                PChar->loc.p.rotation = rot;
                PChar->loc.destination = zoneId;
                PChar->m_moghouseID = moghouseID;
                PChar->loc.boundary = 0;
                PChar->status = STATUS_DISAPPEAR;
                PChar->animation = ANIMATION_NONE;
                PChar->clearPacketList();

                charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(zoneId));
            }
            break;
        }
        case MSG_SEND_TO_ENTITY:
        {
            // Need to check which server we're on so we don't get null pointers
            bool toTargetServer = ref<bool>((uint8*)extra, 0);
            bool spawnedOnly    = ref<bool>((uint8*)extra, 1);

            if (toTargetServer) // This is going to the target's game server
            {
                CBaseEntity* Entity = zoneutils::GetEntity(ref<uint32>((uint8*)extra, 6));

                if (Entity && Entity->loc.zone)
                {
                    char buf[22];
                    memset(&buf[0], 0, sizeof(buf));

                    uint16 targetZone = ref<uint16>((uint8*)extra,  2);
                    uint16 playerZone = ref<uint16>((uint8*)extra,  4);
                    uint16 playerID   = ref<uint16>((uint8*)extra, 10);

                    float X = Entity->GetXPos();
                    float Y = Entity->GetYPos();
                    float Z = Entity->GetZPos();
                    uint8 R = Entity->GetRotPos();

                    ref<bool> (&buf, 1) = true; // Found, so initiate warp back on the requesting server

                    if (Entity->status == STATUS_DISAPPEAR)
                    {

                        if (spawnedOnly)
                        {
                            ref<bool> (&buf, 1) = false; // Spawned only, so do not initiate warp
                        }
                        else
						{
                            // If entity not spawned, go to default location as listed in database
                            const char* query = "SELECT pos_x, pos_y, pos_z FROM mob_spawn_points WHERE mobid = %u;";
                            auto fetch = Sql_Query(SqlHandle, query, Entity->id);

                            if (fetch != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
                            {
                                while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
                                {
                                    X = (float)Sql_GetFloatData(SqlHandle, 0);
                                    Y = (float)Sql_GetFloatData(SqlHandle, 1);
                                    Z = (float)Sql_GetFloatData(SqlHandle, 2);
                                }
                            }
                        }
                    }

                    ref<bool>  (&buf,  0) = false;
                    ref<uint16>(&buf,  2) = playerZone;
                    ref<uint16>(&buf,  4) = playerID;
                    ref<float> (&buf,  6) = X;
                    ref<float> (&buf, 10) = Y;
                    ref<float> (&buf, 14) = Z;
                    ref<uint8> (&buf, 18) = R;
                    ref<uint16>(&buf, 20) = targetZone;

                    message::send(MSG_SEND_TO_ENTITY, &buf, sizeof(buf), nullptr);
                    break;
                }
            }
            else // This is going to the player's game server
            {
                CCharEntity* PChar = zoneutils::GetChar(ref<uint16>((uint8*)extra, 4));

                if (PChar && PChar->loc.zone)
                {
                    if (ref<bool> ((uint8*)extra,  1) == true)
                    {
                        PChar->loc.p.x         = ref<float> ((uint8*)extra,  6);
                        PChar->loc.p.y         = ref<float> ((uint8*)extra, 10);
                        PChar->loc.p.z         = ref<float> ((uint8*)extra, 14);
                        PChar->loc.p.rotation  = ref<uint8> ((uint8*)extra, 18);
                        PChar->loc.destination = ref<uint16>((uint8*)extra, 20);

                        PChar->m_moghouseID = 0;
                        PChar->loc.boundary = 0;
                        PChar->updatemask   = 0;

                        PChar->status    = STATUS_DISAPPEAR;
                        PChar->animation = ANIMATION_NONE;

                        PChar->clearPacketList();

                        charutils::SendToZone(PChar, 2, zoneutils::GetZoneIPP(PChar->loc.destination));
                    }
                }
            }
            break;
        }
        case MSG_SEND_FL_NOTIF:
        {
            bool logoff = ref<bool>((uint8*)extra, 0);
            uint32 charid = ref<uint32>((uint8*)extra, 1);
            CCharEntity* PChar = zoneutils::GetChar(charid);
            if (PChar)
            {
                char listedname[17] = {};
                uint8 i = 0;
                while (i < 16 && ref<bool>((uint8*)extra, i + 5) != '\0')
                {
                    listedname[i] = ref<bool>((uint8*)extra, i + 5);
                    i++;
                }
                listedname[i] = '\0';
                std::string str(listedname);
                uint32 channel = ref<uint32>((uint8*)extra, 21);
                FLnotifyCrossCluster(PChar, logoff, str, channel);
            }
            break;
        }
        case MSG_NEW_TICKET:
        {
            zoneutils::ForEachZone([&packet, packet_size](CZone* PZone) {
                PZone->ForEachChar([&packet, packet_size](CCharEntity* PChar) {
                    if (PChar != nullptr && PChar->m_GMlevel > 1)
                    {
                        CBasicPacket* newPacket = new CBasicPacket();
                        memcpy(*newPacket, packet, std::min<size_t>(packet_size, PACKET_SIZE));
                        PChar->pushPacket(newPacket);
                    }
                });
            });
            break;
        }
        case MSG_RPC_REQUEST:
        {
            if (extra_size < sizeof(RPCMapper::RPC_CALL_DETAILS)) {
                ShowWarning("Message: RPC Call packet is too short\n");
                break;
            }
            RPCMapper::RPC_CALL_DETAILS* rpcheader = reinterpret_cast<RPCMapper::RPC_CALL_DETAILS*>(extra);
            if (zoneutils::GetZone(rpcheader->zone) == nullptr) {
                // Silently ignore messages intended for zones on other clusters
                break;
            }
            if (!g_mapper) {
                ShowError("Message: RPC mapper not initialized\n");
                break;
            }
            g_mapper->IncomingRPCRequestHandler(rpcheader);
            break;
        }
        case MSG_RPC_RESPONSE:
        {
            if (extra_size < sizeof(RPCMapper::RPC_RESPONSE_DETAILS)) {
                ShowWarning("Message: RPC Response packet is too short\n");
                break;
            }
            RPCMapper::RPC_RESPONSE_DETAILS* rpcheader = reinterpret_cast<RPCMapper::RPC_RESPONSE_DETAILS*>(extra);
            if (zoneutils::GetZone(rpcheader->zone) == nullptr) {
                // Silently ignore messages intended for zones on other clusters
                break;
            }
            if (!g_mapper) {
                ShowError("Message: RPC mapper not initialized\n");
                break;
            }
            g_mapper->IncomingRPCResponseHandler(rpcheader);
            break;
        }
        default:
        {
            ShowWarning("Message: unhandled message type %d\n", (int)type);
        }
        }
    }

    bool MapMQHandler::OnStartup()
    {
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
            Sql_Keepalive(SqlHandle, "mqhandler");
        }
        return true;
    }

    void MapMQHandler::OnShutdown()
    {
        if (SqlHandle) {
            Sql_Free(SqlHandle);
            SqlHandle = nullptr;
        }
    }

    bool MapMQHandler::HandleRequest(amqp_bytes_t Request, MQConnection* pOrigin, uint32_t dwChannel)
    {
        uint32 magic = 0;
        MAP_MQ_MESSAGE_HEADER* header = nullptr;
        CHAR_MQ_MESSAGE_HEADER* login_header = nullptr;

        if (Request.len < sizeof(uint32)) {
            // Way too short
            return false;
        }
        magic = *reinterpret_cast<uint32*>(Request.bytes);
        if (magic == LOGIN_MQ_MSG_MAGIC) {
            if (Request.len < sizeof(CHAR_MQ_MESSAGE_HEADER)) {
                return true;
            }
            // Message is coming from the login server
            login_header = reinterpret_cast<CHAR_MQ_MESSAGE_HEADER*>(Request.bytes);
            if (login_header->eType == MQConnection::MQ_MESSAGE_CHAR_LOGIN) {
                // Character is logging in
                // FIXME: This will actually get executed by all map servers (if the server
                // is clustered). Not a big deal in the case of flist but can cause issues
                // if we have any logic that depends on being executed only once.
                // Since this is *not* guaranteed to run after IncrementZoneCounter, for
                // a proper fix we will need to query the DB manually to check whether the
                // character is about to connect to this instance.
                if (FLgetSettingByID(login_header->dwCharacterID, 2) == 1) {
                    Sql_Query(SqlHandle, "UPDATE flist_settings SET lastonline = %u WHERE callingchar = %u;", (uint32)CVanaTime::getInstance()->getVanaTime(), login_header->dwCharacterID);
                }
                // Sql_Query(SqlHandle, "UPDATE flist SET status = 0 WHERE listedchar = %u;", login_header->dwCharacterID);
            }
            return true;
        }
        else if (magic == MAP_MQ_MESSAGE_MAGIC) {
            if (Request.len < sizeof(MAP_MQ_MESSAGE_HEADER)) {
                return true;
            }
            // Traffic between map clusters
            header = reinterpret_cast<MAP_MQ_MESSAGE_HEADER*>(Request.bytes);
            if (Request.len < sizeof(MAP_MQ_MESSAGE_HEADER) + header->packet_size + header->extra_size) {
                return true;
            }
            if (header->origin != own_identity) {
                parse(header->type, reinterpret_cast<uint8*>(Request.bytes) + sizeof(MAP_MQ_MESSAGE_HEADER) + header->packet_size,
                    header->extra_size, reinterpret_cast<uint8*>(Request.bytes) + sizeof(MAP_MQ_MESSAGE_HEADER), header->packet_size, false);
            }
        }
        return true;
    }

    void init(const char* chatIp, uint16 chatPort)
    {
        g_being_closed = false;

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
        Sql_Keepalive(SqlHandle, "message");

        uint64 ipp = map_ip.s_addr;
        uint64 port = map_port;

        //if no ip/port were supplied, set to 1 (0 is not valid for an identity)
        if (map_ip.s_addr == 0 && map_port == 0)
        {
            int ret = Sql_Query(SqlHandle, "SELECT zoneip, zoneport FROM zone_settings GROUP BY zoneip, zoneport ORDER BY COUNT(*) DESC;");
            if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                inet_pton(AF_INET, (const char*)Sql_GetData(SqlHandle, 0), &ipp);
                port = Sql_GetUIntData(SqlHandle, 1);
            }
        }
        ipp |= (port << 32);

        own_identity = ipp;
        std::string map_qname = "map_" + std::to_string(own_identity);

        try {
            g_handler = std::shared_ptr<MapMQHandler>(new MapMQHandler());
            if (!g_handler) {
                return;
            }

            // Initialize connection to RabbitMQ
            g_mqconnection = std::shared_ptr<MQConnection>(new MQConnection(map_config.world_id,
                map_config.rabbitmq_host,
                map_config.rabbitmq_port,
                map_config.rabbitmq_login,
                map_config.rabbitmq_password,
                map_config.rabbitmq_vhost,
                1,
                "amq.fanout",
                map_qname,
                map_qname,
                map_config.rabbitmq_ssl,
                map_config.rabbitmq_ssl_verify,
                map_config.rabbitmq_ssl_ca.c_str(),
                map_config.rabbitmq_ssl_cert.c_str(),
                map_config.rabbitmq_ssl_key.c_str()));

            g_mqconnection->AssignHandler(1, g_handler);

        }
        catch (...) {
            ShowFatalError("Unable to connect to RabbitMQ.");
            close();
        }

        g_mapper = RPCMapper::GetInstance();

        try {
            g_mqconnection->StartThread();
            while (!g_being_closed) {
                if (!message_queue.empty()) {
                    send_queue();
                }
                else {
                    std::this_thread::sleep_for(std::chrono::milliseconds(50));
                }
            }
        }
        catch (std::runtime_error& e) {
            // Map and MQConnection use different design philosophies, which end up with
            // a runtime error being thrown when close() is called, so check for this
            // specific scenario and don't crash if that's the case.
            if (!g_being_closed) {
                throw;
            }
        }

    }

    void close()
    {
        g_being_closed = true;
        message::RPCMapper::Destroy();
        g_mapper = nullptr;

        if (g_mqconnection.get()) {
            g_mqconnection->Shutdown();
            g_mqconnection = nullptr;
        }
        if (g_handler.get()) {
            g_handler = nullptr;
        }
    }

    void send(MSGSERVTYPE type, void* data, size_t datalen, CBasicPacket* packet)
    {
        uint8 stub;

        MAP_MQ_MESSAGE_HEADER* header = nullptr;
        if (datalen > 1048576) {
            datalen = 1048576;
        }
        uint32 packet_size = packet ? packet->length() : 0;
        uint8* msgdata = new uint8[sizeof(MAP_MQ_MESSAGE_HEADER) + packet_size + static_cast<uint32>(datalen)];
        if (!msgdata) {
            return;
        }
        header = reinterpret_cast<MAP_MQ_MESSAGE_HEADER*>(msgdata);
        header->magic = MAP_MQ_MESSAGE_MAGIC;
        header->origin = own_identity;
        header->type = type;
        header->packet_size = packet_size;
        header->extra_size = datalen;
        if (packet && packet_size > 0) {
            memcpy(msgdata + sizeof(MAP_MQ_MESSAGE_HEADER), *packet, header->packet_size);
        }
        if (data && datalen > 0) {
            memcpy(msgdata + sizeof(MAP_MQ_MESSAGE_HEADER) + header->packet_size, data, header->extra_size);
        }

        // In addition to queueing it through ZMQ also bypass diretly to ourselves
        // This allows to reduce latency for chat packets between people in the same
        // cluster, as well as allowing people in the same cluster to chat even
        // if the MQ server is down.
        g_handler->parse(type,
            reinterpret_cast<uint8*>(data),
            datalen,
            // Seems that packet must be a valid pointer no matter what, so just set it
            // to a stub location and set length to zero and hopefully nothing else
            // will crash.
            packet ? (uint8 *)*packet : &stub,
            packet ? packet->length() : 0,
            true);
        // Only bother sending to MQ for other servers if we're connected to MQ
        if (g_mqconnection->IsConnected()) {
            g_mqconnection->IncrementHighPriorityThreadsWaiting();
            std::unique_lock<std::recursive_timed_mutex> lk(local_mq_mutex, std::defer_lock);
            while (!lk.try_lock_for(std::chrono::seconds(1))) {
                if (map_doing_final) {
                    return;
                }
            }
            g_mqconnection->DecrementHighPriorityThreadsWaiting();
            message_queue.push(std::shared_ptr<uint8>(msgdata));
        }
    }
};
