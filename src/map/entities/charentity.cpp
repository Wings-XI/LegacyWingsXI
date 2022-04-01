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
#include "../../common/timer.h"
#include "../../common/utils.h"

#include <string.h>

#include "../packets/action.h"
#include "../packets/basic.h"
#include "../packets/char.h"
#include "../packets/char_sync.h"
#include "../packets/char_update.h"
#include "../packets/char_recast.h"
#include "../packets/entity_update.h"
#include "../packets/lock_on.h"
#include "../packets/inventory_finish.h"
#include "../packets/key_items.h"
#include "../packets/menu_raisetractor.h"
#include "../packets/char_health.h"
#include "../packets/char_appearance.h"
#include "../packets/message_system.h"
#include "../packets/message_special.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/player_controller.h"
#include "../ai/helpers/targetfind.h"
#include "../ai/states/ability_state.h"
#include "../ai/states/attack_state.h"
#include "../ai/states/death_state.h"
#include "../ai/states/item_state.h"
#include "../ai/states/raise_state.h"
#include "../ai/states/range_state.h"
#include "../ai/states/weaponskill_state.h"
#include "../ai/states/magic_state.h"

#include "charentity.h"
#include "automatonentity.h"
#include "trustentity.h"
#include "../ability.h"
#include "../battlefield.h"
#include "../enmity_container.h"
#include "../notoriety_container.h"
#include "../instance.h"
#include "../conquest_system.h"
#include "../spell.h"
#include "../attack.h"
#include "../utils/attackutils.h"
#include "../utils/charutils.h"
#include "../utils/battleutils.h"
#include "../utils/gardenutils.h"
#include "../utils/zoneutils.h"
#include "../item_container.h"
#include "../items/item_weapon.h"
#include "../items/item_usable.h"
#include "../items/item_furnishing.h"
#include "../trade_container.h"
#include "../universal_container.h"
#include "../char_recast_container.h"
#include "../latent_effect_container.h"
#include "../status_effect_container.h"
#include "../treasure_pool.h"
#include "../weapon_skill.h"
#include "../packets/char_job_extra.h"
#include "../packets/status_effects.h"
#include "../mobskill.h"
#include "../linkshell.h"

CCharEntity::CCharEntity()
{
    objtype = TYPE_PC;
    m_EcoSystem = SYSTEM_HUMANOID;

    m_event.reset();

    m_GMlevel = 0;
    m_isGMHidden = false;
    m_GMSuperpowers = false;
    m_autoTargetOverride = nullptr;

    allegiance = ALLEGIANCE_PLAYER;

    TradeContainer = new CTradeContainer();
    Container = new CTradeContainer();
    UContainer = new CUContainer();
    CraftContainer = new CTradeContainer();
    AuctionPlayerContainer = new CAuctionPlayerContainer(this);

    m_Inventory = std::make_unique<CItemContainer>(LOC_INVENTORY);
    m_Mogsafe = std::make_unique<CItemContainer>(LOC_MOGSAFE);
    m_Storage = std::make_unique<CItemContainer>(LOC_STORAGE);
    m_Tempitems = std::make_unique<CItemContainer>(LOC_TEMPITEMS);
    m_Moglocker = std::make_unique<CItemContainer>(LOC_MOGLOCKER);
    m_Mogsatchel = std::make_unique<CItemContainer>(LOC_MOGSATCHEL);
    m_Mogsack = std::make_unique<CItemContainer>(LOC_MOGSACK);
    m_Mogcase = std::make_unique<CItemContainer>(LOC_MOGCASE);
    m_Wardrobe = std::make_unique<CItemContainer>(LOC_WARDROBE);
    m_Mogsafe2 = std::make_unique<CItemContainer>(LOC_MOGSAFE2);
    m_Wardrobe2 = std::make_unique<CItemContainer>(LOC_WARDROBE2);
    m_Wardrobe3 = std::make_unique<CItemContainer>(LOC_WARDROBE3);
    m_Wardrobe4 = std::make_unique<CItemContainer>(LOC_WARDROBE4);

    memset(&jobs, 0, sizeof(jobs));
    // TODO: -Wno-class-memaccess - clearing an object on non-trivial type use assignment or value-init
    memset(&keys, 0, sizeof(keys));
    memset(&equip, 0, sizeof(equip));
    memset(&equipLoc, 0, sizeof(equipLoc));
    memset(&RealSkills, 0, sizeof(RealSkills));
    memset(&expChain, 0, sizeof(expChain));
    memset(&nameflags, 0, sizeof(nameflags));
    memset(&menuConfigFlags, 0, sizeof(menuConfigFlags));
    chatFilterFlags = 0;
    m_logChat = 0;

    // TODO: -Wno-class-memaccess - clearing an object on non-trivial type use assignment or value-init
    memset(&m_SpellList, 0, sizeof(m_SpellList));
    memset(&m_LearnedAbilities, 0, sizeof(m_LearnedAbilities));
    memset(&m_TitleList, 0, sizeof(m_TitleList));
    memset(&m_ZonesList, 0, sizeof(m_ZonesList));
    memset(&m_Abilities, 0, sizeof(m_Abilities));
    memset(&m_TraitList, 0, sizeof(m_TraitList));
    memset(&m_PetCommands, 0, sizeof(m_PetCommands));
    memset(&m_WeaponSkills, 0, sizeof(m_WeaponSkills));
    memset(&m_SetBlueSpells, 0, sizeof(m_SetBlueSpells));
    memset(&m_unlockedAttachments, 0, sizeof(m_unlockedAttachments));
    lastInCombat = 1;
    lastZoneTimer = 0;

    memset(&m_questLog, 0, sizeof(m_questLog));
    memset(&m_missionLog, 0, sizeof(m_missionLog));
    memset(&m_assaultLog, 0, sizeof(m_assaultLog));
    memset(&m_campaignLog, 0, sizeof(m_campaignLog));
    memset(&m_eminenceLog, 0, sizeof(m_eminenceLog));
    m_eminenceCache.activemap.reset();

    memset(&teleport, 0, sizeof(teleport));
    memset(&teleport.homepoint.menu, -1, sizeof(teleport.homepoint.menu));
    memset(&teleport.survival.menu,  -1, sizeof(teleport.survival.menu));

    for (uint8 i = 0; i <= 3; ++i)
    {
        m_missionLog[i].current = 0xFFFF;
    }

    m_missionLog[4].current = 0;   // MISSION_TOAU
    m_missionLog[5].current = 0;   // MISSION_WOTG
    m_missionLog[6].current = 101; // MISSION_COP

    for (uint8 i = 0; i < MAX_MISSIONAREA; ++i)
    {
        m_missionLog[i].logExUpper = 0;
        m_missionLog[i].logExLower = 0;
    }

    m_copCurrent = 0;
    m_acpCurrent = 0;
    m_mkeCurrent = 0;
    m_asaCurrent = 0;

    m_Costume = 0;
    m_Monstrosity = 0;
    m_hasTractor = 0;
    m_hasRaise = 0;
    m_resendRaise = false;
    m_hasAutoTarget = 1;
    m_InsideRegionID = 0;
    m_LevelRestriction = 0;
    m_lastBcnmTimePrompt = 0;
    m_DeathTimestamp = 0;

    m_openMH = false;
    m_disconnecting = false;

    m_lastDig = std::chrono::system_clock::now() - 5s;
    m_lastDigPosition.x = 0;
    m_lastDigPosition.y = 0;
    m_lastDigPosition.z = 0;

    m_EquipFlag = 0;
    m_EquipBlock = 0;
    m_StatsDebilitation = 0;
    m_EquipSwap = false;

    MeritMode = false;

    m_isWeaponSkillKill = false;
    m_isStyleLocked = false;
    m_isBlockingAid = false;

    BazaarID.clean();
    TradePending.clean();
    InvitePending.clean();

    PLinkshell1 = nullptr;
    PLinkshell2 = nullptr;
    PTreasurePool = nullptr;
    PWideScanTarget = nullptr;

    PAutomaton = nullptr;
    PClaimedMob = nullptr;
    PRecastContainer = std::make_unique<CCharRecastContainer>(this);
    PLatentEffectContainer = new CLatentEffectContainer(this);

    petZoningInfo.respawnPet = false;
    petZoningInfo.petID = 0;
    petZoningInfo.petType = PETTYPE_AVATAR;			// dummy data, the bool tells us to respawn if required
    petZoningInfo.petHP = 0;
    petZoningInfo.petMP = 0;
    petZoningInfo.petTP = 0;

    m_LastEngagedTargID = 0;

    m_PlayTime = 0;
    m_SaveTime = 0;
    m_reloadParty = 0;

    m_moghouseID = 0;
    m_moghancementID = 0;

    m_Substate = CHAR_SUBSTATE::SUBSTATE_NONE;

    m_accountId = 0;
    m_accountFeatures = 0;
    m_clientVerMismatch = false;
    m_needChatFix = 0;
    m_needTellFix = 0;
    m_needMasterLvFix = 0;
    m_needInventoryFix = 0;
    m_lastPacketTime = time(NULL);
    m_packetLimiterEnabled = false;
    m_objectCreationTime = std::chrono::system_clock::now();

    m_distanceLastCheckTime = m_lastPacketTime;
    m_distanceFromLastCheck = 0.0;
    m_gracePeriodEnd = m_lastPacketTime;

    hookedFish = nullptr;
    lastCastTime = 0;
    nextFishTime = 0;
    fishingToken = 0;
    fishingStrike[0] = std::chrono::system_clock::now() - 8760h;
    fishingStrike[1] = std::chrono::system_clock::now() - 8760h;
    fishingStrike[2] = std::chrono::system_clock::now() - 8760h;
    fishingStrike[3] = std::chrono::system_clock::now() - 8760h;
    fishingStrike[4] = std::chrono::system_clock::now() - 8760h;

    m_ZoneAggroImmunity = server_clock::now() + 12s;
    m_fomorHate = 0;

    PAI = std::make_unique<CAIContainer>(this, nullptr, std::make_unique<CPlayerController>(this),
        std::make_unique<CTargetFind>(this));
}

CCharEntity::~CCharEntity()
{
    clearPacketList();

    if (PTreasurePool != nullptr)
    {
        // remove myself
        PTreasurePool->DelMember(this);
    }

    delete TradeContainer;
    delete Container;
    delete UContainer;
    delete CraftContainer;
    delete PMeritPoints;
    delete AuctionPlayerContainer;
}

uint8 CCharEntity::GetGender()
{
    return (look.race) % 2 ^ (look.race > 6);
}

bool CCharEntity::isPacketListEmpty()
{
    return PacketList.empty();
}

void CCharEntity::clearPacketList()
{
    while (!PacketList.empty())
    {
        delete popPacket();
    }
}

void CCharEntity::pushPacket(CBasicPacket* packet, int priorityNumOverride)
{
    TracyZoneScoped;
    TracyZoneIString(GetName());
    TracyZoneHex16(packet->id());

    if (priorityNumOverride != 0xFF)
        packet->priorityNumOverride = priorityNumOverride;

    std::lock_guard<std::mutex> lk(m_PacketListMutex);

    if (m_clientVerMismatch) {
        packet->ClientVerFixup(this);
    }

    if (packet->getType() == 0x17) {
        if (m_logChat) {
            CHAT_MESSAGE_TYPE MessageType = (CHAT_MESSAGE_TYPE)ref<uint8>(packet->getData(), 0x04);
            char sender[16] = { 0 };
            strncpy(sender, (char*)packet->getData() + 0x08, sizeof(sender) - 1);
            char lsname[24] = { 0 };
            if (MessageType == MESSAGE_LINKSHELL || MessageType == MESSAGE_NS_LINKSHELL) {
                if (PLinkshell1) {
                    DecodeStringLinkshell(PLinkshell1->getName(), (int8*)lsname);
                }
            }
            if (MessageType == MESSAGE_LINKSHELL2 || MessageType == MESSAGE_NS_LINKSHELL2) {
                if (PLinkshell2) {
                    DecodeStringLinkshell(PLinkshell2->getName(), (int8*)lsname);
                }
            }
            ((CChatMessagePacket*)packet)->LogChat(name.c_str(), lsname);
        }
        // Cannot be done via ClientVerFixup since these packets
        // are passed through the MQ and the polymorphic information
        // is lost.
        if (m_needChatFix) {
            // Hack to word around the chat message format change of Sep. 2020
            uint8* packetbytes = packet->getData();
            uint32 pktsize = packet->getSize();
            if (pktsize > PACKET_SIZE) {
                pktsize = PACKET_SIZE;
            }
            pktsize -= 0x18;
            memmove(packetbytes + 0x17, packetbytes + 0x18, pktsize);
        }
    }

    bool packetUpdatesPosition = false;
    uint32 entityID = 0;

    if (packet->getType() == 0x0E)
    { // there can only be one of me. decide which one has the most up-to-date and most important information to send.
        packetUpdatesPosition = true;
        entityID = ref<uint32>(packet->getData(), 0x04);
        auto it = PacketList.cbegin();
        while (it != PacketList.cend())
        {
            if ((*it)->getType() == 0x0E && ref<uint32>((*it)->getData(), 0x04) == entityID)
            { // match found, already an update queued for this entity
                if (packet->packetEntityUpdateType == ENTITYUPDATE::ENTITY_NONE || packet->packetEntityUpdateType == ENTITYUPDATE::ENTITY_UPDATE)
                {
                    if ((*it)->packetEntityUpdateType == ENTITYUPDATE::ENTITY_NONE || packet->packetEntityUpdateType == ENTITYUPDATE::ENTITY_UPDATE)
                    {
                        if ((*it)->packetUpdateMask | UPDATE_LOOK && !(packet->packetUpdateMask | UPDATE_LOOK))
                        {
                            // wait to update their look before pushing any new updates.
                            delete packet;
                            return;
                        }
                        // i am the newer packet with more up-to-date information so i supercede this one
                        delete (*it);
                        it = PacketList.erase(it);
                        break;
                    }
                    else
                    {
                        // there is a pending update to spawn or despawn this entity, let's wait for that to go through
                        // before trying to send any update information about it
                        delete packet;
                        return;
                    }
                }
                else
                {
                    // i am updating spawn/despawn of the mob. no matter what i run into, i supercede it
                    delete (*it);
                    it = PacketList.erase(it);
                    break;
                }

            }
            else
            {
                it++;
            }
        }
    }

    if (packet->getType() == 0x0D)
    { // there can only be one of me. decide which one has the most up-to-date and most important information to send.
        packetUpdatesPosition = true;
        entityID = ref<uint32>(packet->getData(), 0x04);
        auto it = PacketList.cbegin();
        while (it != PacketList.cend())
        {
            if ((*it)->getType() == 0x0D && ref<uint32>((*it)->getData(), 0x04) == entityID)
            { // match found, already an update queued for this character
                if ((*it)->packetUpdateMask | UPDATE_LOOK)
                {
                    if (packet->packetUpdateMask | UPDATE_LOOK)
                    {
                        // i update look as well, and my information is more up-to-date.
                        delete (*it);
                        it = PacketList.erase(it);
                        break;
                    }
                    else
                    {
                        // all my info is more up-to-date but i don't update look, i steal yours.
                        memcpy(packet->getData() + 0x48, (*it)->getData() + 0x48, 0x12);
                        packet->packetUpdateMask |= UPDATE_LOOK;
                        ref<uint8>(packet->getData(), 0x0A) |= UPDATE_LOOK;
                        delete (*it);
                        it = PacketList.erase(it);
                        break;
                    }
                }
                else
                {
                    // my information is more up-to-date.
                    delete (*it);
                    it = PacketList.erase(it);
                    break;
                }
            }
            else
            {
                it++;
            }
        }
    }

    if (packet->getType() == 0x37)
    { // there can only be one of me. decide which one has the most up-to-date information to send.
        entityID = ref<uint32>(packet->getData(), 0x24);
        auto it = PacketList.cbegin();
        while (it != PacketList.cend())
        {
            if ((*it)->getType() == 0x37 && ref<uint32>((*it)->getData(), 0x24) == entityID)
            { // match found, already an update queued for this character
                // my information is more up-to-date.
                delete (*it);
                it = PacketList.erase(it);
                break;
            }
            else
            {
                it++;
            }
        }
    }

    if (packetUpdatesPosition || packet->getType() == 0x5B)
    { // remove any position packets we have queued (0x5B)
        entityID = entityID ? entityID : ref<uint32>(packet->getData(), 0x10);
        auto it = PacketList.cbegin();
        while (it != PacketList.cend())
        {
            if ((*it)->getType() == 0x5B && ref<uint32>((*it)->getData(), 0x10) == entityID)
            {
                delete (*it);
                it = PacketList.erase(it);
                break;
            }
            else
            {
                it++;
            }
        }
    }

    PacketList.push_back(packet);
}

void CCharEntity::pushPacket(std::unique_ptr<CBasicPacket> packet, int priorityNumOverride)
{
    pushPacket(packet.release());
}

CBasicPacket* CCharEntity::popPacket()
{
    std::lock_guard<std::mutex> lk(m_PacketListMutex);
    CBasicPacket* PPacket = PacketList.front();
    PacketList.pop_front();
    return PPacket;
}

PacketList_t CCharEntity::getPacketList()
{
    std::lock_guard<std::mutex> lk(m_PacketListMutex);
    return PacketList;
}

PacketList_t* CCharEntity::getPacketListPtr()
{
    return &PacketList;
}

std::mutex* CCharEntity::getPacketListMutexPtr()
{
    return &m_PacketListMutex;
}

size_t CCharEntity::getPacketCount()
{
    std::lock_guard<std::mutex> lk(m_PacketListMutex);
    return PacketList.size();
}

void CCharEntity::erasePackets(uint16 num)
{
    for (auto i = 0; i < num; i++)
    {
        delete popPacket();
    }
}

bool CCharEntity::isNewPlayer()
{
    return menuConfigFlags.flags & NFLAG_NEWPLAYER;
}

void CCharEntity::setPetZoningInfo()
{
    if (PPet->objtype == TYPE_PET)
    {
        if (TYPE_PET != PETTYPE_JUG_PET)
        {
            petZoningInfo.petHP = PPet->health.hp;
            petZoningInfo.petTP = PPet->health.tp;
            petZoningInfo.petMP = PPet->health.mp;
            petZoningInfo.petType = ((CPetEntity*)PPet)->getPetType();
        }
    }
}

void CCharEntity::resetPetZoningInfo()
{
    // reset the petZoning info
    petZoningInfo.petHP = 0;
    petZoningInfo.petTP = 0;
    petZoningInfo.petMP = 0;
    petZoningInfo.respawnPet = false;
    petZoningInfo.petType = PETTYPE_AVATAR;
}
/************************************************************************
*																		*
*  Возвращаем контейнер с указанным ID. Если ID выходит за рамки, то	*
*  защищаем сервер от падения использованием контейнера временных		*
*  предметов в качестве заглушки (из этого контейнера предметы нельзя	*
*  перемещать, надевать, передавать, продавать и т.д.). Отображаем		*
*  сообщение о фатальной ошибке.										*
*																		*
************************************************************************/

CItemContainer* CCharEntity::getStorage(uint8 LocationID)
{
    switch (LocationID)
    {
        case LOC_INVENTORY:	 return m_Inventory.get();
        case LOC_MOGSAFE:	 return m_Mogsafe.get();
        case LOC_STORAGE:	 return m_Storage.get();
        case LOC_TEMPITEMS:	 return m_Tempitems.get();
        case LOC_MOGLOCKER:	 return m_Moglocker.get();
        case LOC_MOGSATCHEL: return m_Mogsatchel.get();
        case LOC_MOGSACK:	 return m_Mogsack.get();
        case LOC_MOGCASE:	 return m_Mogcase.get();
        case LOC_WARDROBE:   return m_Wardrobe.get();
        case LOC_MOGSAFE2:   return m_Mogsafe2.get();
        case LOC_WARDROBE2:  return m_Wardrobe2.get();
        case LOC_WARDROBE3:  return m_Wardrobe3.get();
        case LOC_WARDROBE4:  return m_Wardrobe4.get();
    }

    TPZ_DEBUG_BREAK_IF(LocationID >= MAX_CONTAINER_ID);	// неразрешенный ID хранилища
    return 0;
}

bool CCharEntity::hasAccessToStorage(uint8 LocationID)
{
    TPZ_DEBUG_BREAK_IF(LocationID >= MAX_CONTAINER_ID);
    if (LocationID >= MAX_CONTAINER_ID) {
        // Invalid container
        return false;
    }
    if (LocationID == LOC_MOGSAFE || LocationID == LOC_MOGSAFE2) {
        // Can use in your own mog house / rent-a-room (not in open mog)
        // or in zones that have nomad moogles.
        if (m_moghouseID == id) {
            return true;
        }
        if (loc.zone) {
            return loc.zone->CanUseMisc(MISC_MOGMENU);
        }
        return false;
    }
    if (LocationID == LOC_STORAGE) {
        // Only accessible from own mog house or rent-a-room
        if (m_moghouseID == id) {
            return true;
        }
        return false;
    }
    if (LocationID == LOC_MOGLOCKER) {
        // Check for expiry
        bool safe_access = (m_moghouseID == id);
        if (loc.zone) {
            if (loc.zone->CanUseMisc(MISC_MOGMENU)) {
                safe_access = true;
            }
        }
        if (safe_access && charutils::hasMogLockerAccess(this)) {
            return true;
        }
        return false;
    }
    if (LocationID == LOC_MOGSATCHEL) {
        // Requires secure account (2FA)
        if (map_config.storage_ignore_features || m_accountFeatures & 0x01) {
            return true;
        }
        return false;
    }
    if (LocationID == LOC_WARDROBE3) {
        // Requires account feature
        if (map_config.storage_ignore_features || m_accountFeatures & 0x04) {
            return true;
        }
        return false;
    }
    if (LocationID == LOC_WARDROBE4) {
        // Requires account feature
        if (map_config.storage_ignore_features || m_accountFeatures & 0x08) {
            return true;
        }
        return false;
    }
    // Inventory, sack, case, wardrobe 1 and wardrobe 2 always accessible
    return true;
}

int8 CCharEntity::getShieldSize()
{
    CItemEquipment* PItem = (CItemEquipment*)(getEquip(SLOT_SUB));

    if (PItem == nullptr) {
        return 0;
    }

    if (!PItem->IsShield()) {
        return 0;
    }

    return PItem->getShieldSize();
}

void CCharEntity::SetName(int8* name)
{
    this->name.insert(0, (const char*)name, std::min<size_t>(strlen((const char*)name), PacketNameLength));
}

int16 CCharEntity::addTP(int16 tp)
{
    // int16 oldtp = health.tp;
    tp = CBattleEntity::addTP(tp);
    //	if ((oldtp < 1000 && health.tp >= 1000 ) || (oldtp >= 1000 && health.tp < 1000))
    //	{
    PLatentEffectContainer->CheckLatentsTP();
    //	}
    return abs(tp);
}

int32 CCharEntity::addHP(int32 hp)
{
    hp = CBattleEntity::addHP(hp);
    PLatentEffectContainer->CheckLatentsHP();

    return abs(hp);
}

int32 CCharEntity::addMP(int32 mp)
{
    mp = CBattleEntity::addMP(mp);
    PLatentEffectContainer->CheckLatentsMP();

    return abs(mp);
}

bool CCharEntity::getWeaponSkillKill()
{
    return m_isWeaponSkillKill;
}

void CCharEntity::setWeaponSkillKill(bool isWeaponSkillKill)
{
    m_isWeaponSkillKill = isWeaponSkillKill;
}

bool CCharEntity::getStyleLocked()
{
    return m_isStyleLocked;
}

void CCharEntity::setStyleLocked(bool isStyleLocked)
{
    m_isStyleLocked = isStyleLocked;
}

bool CCharEntity::getBlockingAid()
{
    return m_isBlockingAid;
}

void CCharEntity::setBlockingAid(bool isBlockingAid)
{
    m_isBlockingAid = isBlockingAid;
}

/************************************************************************
*                                                                       *
*  Does the user have all yell mesages filtered?                        *
*                                                                       *
************************************************************************/

bool CCharEntity::isYellFiltered() const
{
    return (chatFilterFlags & CHATFILTER_YELL) != 0;
}

/************************************************************************
*                                                                       *
*  Does the user have "all yell/shout messages deemed spam" filtered?   *
*                                                                       *
************************************************************************/

bool CCharEntity::isYellSpamFiltered() const
{
    return (chatFilterFlags & CHATFILTER_YELL_SPAM) != 0;
}

void CCharEntity::SetPlayTime(uint32 playTime)
{
    m_PlayTime = playTime;
    m_SaveTime = gettick() / 1000;
}

uint32 CCharEntity::GetPlayTime(bool needUpdate)
{
    if (needUpdate)
    {
        uint32 currentTime = gettick() / 1000;

        m_PlayTime += currentTime - m_SaveTime;
        m_SaveTime = currentTime;
    }

    return m_PlayTime;
}

CItemEquipment* CCharEntity::getEquip(SLOTTYPE slot)
{
    uint8 loc = equip[slot];
    uint8 est = equipLoc[slot];
    CItemEquipment* item = nullptr;

    if (loc != 0)
    {
        item = (CItemEquipment*)getStorage(est)->GetItem(loc);
    }
    return item;
}

void CCharEntity::ReloadPartyInc()
{
    m_reloadParty = true;
}

void CCharEntity::ReloadPartyDec()
{
    m_reloadParty = false;
}

bool CCharEntity::ReloadParty()
{
    return m_reloadParty;
}

void CCharEntity::RemoveTrust(CTrustEntity* PTrust)
{
    if (!PTrust->PAI->IsSpawned())
    {
        return;
    }

    auto trustIt = std::find_if(PTrusts.begin(), PTrusts.end(), [PTrust](auto trust) { return PTrust == trust; });
    if (trustIt != PTrusts.end())
    {
        if (PTrust->animation == ANIMATION_DESPAWN)
        {
            luautils::OnMobDespawn(PTrust);
        }
        PTrust->PAI->Despawn();
        PTrusts.erase(trustIt);
    }

    ReloadPartyInc();
}

void CCharEntity::ClearTrusts()
{
    for (auto PTrust : PTrusts)
    {
        PTrust->PAI->Despawn();
    }
    PTrusts.clear();

    ReloadPartyInc();
}

void CCharEntity::RefreshSpawns()
{
    for (SpawnIDList_t::const_iterator it = SpawnPCList.begin(); it != SpawnPCList.end(); ++it) {
        pushPacket(new CEntityUpdatePacket(it->second, ENTITY_SPAWN, UPDATE_ALL_CHAR));
    }
    for (SpawnIDList_t::const_iterator it = SpawnMOBList.begin(); it != SpawnMOBList.end(); ++it) {
        pushPacket(new CEntityUpdatePacket(it->second, ENTITY_SPAWN, UPDATE_ALL_MOB));
    }
    for (SpawnIDList_t::const_iterator it = SpawnPETList.begin(); it != SpawnPETList.end(); ++it) {
        pushPacket(new CEntityUpdatePacket(it->second, ENTITY_SPAWN, UPDATE_ALL_MOB));
    }
    for (SpawnIDList_t::const_iterator it = SpawnTRUSTList.begin(); it != SpawnTRUSTList.end(); ++it) {
        pushPacket(new CEntityUpdatePacket(it->second, ENTITY_SPAWN, UPDATE_ALL_MOB));
    }
    for (SpawnIDList_t::const_iterator it = SpawnNPCList.begin(); it != SpawnNPCList.end(); ++it) {
        pushPacket(new CEntityUpdatePacket(it->second, ENTITY_SPAWN, UPDATE_ALL_MOB));
    }
}

void CCharEntity::Tick(time_point tick)
{
    TracyZoneScoped;
    CBattleEntity::Tick(tick);
    if (m_DeathTimestamp > 0 && tick >= m_deathSyncTime)
    {
        // Send an update packet at a regular interval to keep the player's death variables synced
        updatemask |= UPDATE_STATUS;
        m_deathSyncTime = tick + death_update_frequency;
    }

    if (m_moghouseID != 0)
    {
        gardenutils::UpdateGardening(this, true);
    }
}

void CCharEntity::PostTick()
{
    TracyZoneScoped;
    CBattleEntity::PostTick();
    if (m_EquipSwap)
    {
        pushPacket(new CCharAppearancePacket(this));

        updatemask |= UPDATE_HP;
        m_EquipSwap = false;
    }
    if (ReloadParty())
    {
        charutils::ReloadParty(this);
    }
    if (m_EffectsChanged)
    {
        pushPacket(new CCharUpdatePacket(this));
        pushPacket(new CCharSyncPacket(this));
        pushPacket(new CCharJobExtraPacket(this, true));
        pushPacket(new CCharJobExtraPacket(this, false));
        pushPacket(new CStatusEffectPacket(this));
        if (PParty)
        {
            PParty->PushEffectsPacket();
        }
        m_EffectsChanged = false;
    }
    if (updatemask)
    {
        if (!m_EffectsChanged)
        {
            pushPacket(new CCharUpdatePacket(this));
            pushPacket(new CCharSyncPacket(this));
        }
        if (loc.zone && !m_isGMHidden)
        {
            loc.zone->PushPacket(this, CHAR_INRANGE, new CCharPacket(this, ENTITY_UPDATE, updatemask));
        }
        if (isCharmed)
        {
            pushPacket(new CCharPacket(this, ENTITY_UPDATE, updatemask));
        }
        if (updatemask & UPDATE_HP)
        {
            ForAlliance([&](auto PEntity)
            {
                if (PEntity->objtype == TYPE_PC)
                {
                    static_cast<CCharEntity*>(PEntity)->pushPacket(new CCharHealthPacket(this));
                }
            });
        }
        updatemask = 0;
    }
}

void CCharEntity::addTrait(CTrait* PTrait)
{
    CBattleEntity::addTrait(PTrait);
    charutils::addTrait(this, PTrait->getID());
}

void CCharEntity::delTrait(CTrait* PTrait)
{
    CBattleEntity::delTrait(PTrait);
    charutils::delTrait(this, PTrait->getID());
}

bool CCharEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (PInitiator->objtype == TYPE_PC && StatusEffectContainer->GetLevelRestrictionEffect() != PInitiator->StatusEffectContainer->GetLevelRestrictionEffect())
    {
        return false;
    }
    if (StatusEffectContainer->GetConfrontationEffect() != PInitiator->StatusEffectContainer->GetConfrontationEffect())
    {
        return false;
    }
    if (isDead())
    {
        return (targetFlags & TARGET_PLAYER_DEAD) != 0;
    }

    if ((targetFlags & TARGET_PLAYER) && allegiance == PInitiator->allegiance)
    {
        return true;
    }

    if (CBattleEntity::ValidTarget(PInitiator, targetFlags))
    {
        return true;
    }

    if (((targetFlags & TARGET_PLAYER_PARTY) || ((targetFlags & TARGET_PLAYER_PARTY_PIANISSIMO) &&
        PInitiator->StatusEffectContainer->HasStatusEffect(EFFECT_PIANISSIMO))) &&
        ((PParty && PInitiator->PParty == PParty) ||
        (PInitiator->PMaster && PInitiator->PMaster->PParty == PParty)) &&
        PInitiator != this)
    {
        return true;
    }

    return false;
}

bool CCharEntity::CanUseSpell(CSpell* PSpell)
{
    return charutils::hasSpell(this, static_cast<uint16>(PSpell->getID())) && CBattleEntity::CanUseSpell(PSpell) &&
        !PRecastContainer->Has(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()));
}

void CCharEntity::OnChangeTarget(CBattleEntity* PNewTarget)
{
    battleutils::RelinquishClaim(this);
    pushPacket(new CLockOnPacket(this, PNewTarget));
    PLatentEffectContainer->CheckLatentsTargetChange();
}

void CCharEntity::OnEngage(CAttackState& state)
{
    CBattleEntity::OnEngage(state);
    PLatentEffectContainer->CheckLatentsTargetChange();
}

void CCharEntity::OnDisengage(CAttackState& state)
{
    battleutils::RelinquishClaim(this);
    CBattleEntity::OnDisengage(state);
    if (state.HasErrorMsg())
    {
        pushPacket(state.GetErrorMsg());
    }
    PLatentEffectContainer->CheckLatentsWeaponDraw(false);
}

bool CCharEntity::CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg)
{
    float dist = distance(loc.p, PTarget->loc.p);

    if (!IsMobOwner(PTarget))
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);
        if (PAI->Disengage())
            m_LastEngagedTargID = 0;
        return false;
    }
    else if (dist > 30)
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_LOSE_SIGHT);
        if (PAI->Disengage())
            m_LastEngagedTargID = 0;
        return false;
    }
    else if (!facing(this->loc.p, PTarget->loc.p, 64))
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_UNABLE_TO_SEE_TARG);
        return false;
    }
    else if (PTarget->IsNameHidden())
    {
        return false;
    }
    else if ((dist - PTarget->m_ModelSize) > GetMeleeRange())
    {
        if (PTarget->objtype != TYPE_PC && (dist - PTarget->m_ModelSize) < GetMeleeRange() + 5 && (PTarget->PAI->PathFind->IsFollowingPath() || PTarget->PAI->PathFind->IsFollowingScriptedPath()) && abs(PTarget->loc.p.rotation - this->loc.p.rotation) < 30)
        { // we are chasing a moving monster, add 5 to our melee range
            return true;
        }
        if (PTarget->objtype == TYPE_PC && (dist - PTarget->m_ModelSize) < GetMeleeRange() + 6 && (uint16)(PTarget->loc.p.moving - PTarget->loc.p.movingsnapshot) && abs(PTarget->loc.p.rotation - this->loc.p.rotation) < 75)
        { // we are chasing a moving player in PVP, add 6 to our melee range
            return true;
        }
        errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_TARG_OUT_OF_RANGE);
        return false;
    }
    return true;
}

bool CCharEntity::OnAttack(CAttackState& state, action_t& action)
{
    auto controller {static_cast<CPlayerController*>(PAI->GetController())};
    controller->setLastAttackTime(server_clock::now());
    auto ret = CBattleEntity::OnAttack(state, action);

    this->lastInCombat = (uint32)CVanaTime::getInstance()->getVanaTime();

    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }

    return ret;
}

void CCharEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CBattleEntity::OnCastFinished(state, action);

    auto PSpell = state.GetSpell();
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget->id != this->id && !PSpell->isHeal() && !PSpell->isBuff())
    {
        this->lastInCombat = (uint32)CVanaTime::getInstance()->getVanaTime();
    }

    PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()), action.recast);

    for (auto&& actionList : action.actionLists)
    {
        for (auto&& actionTarget : actionList.actionTargets)
        {
            if (actionTarget.param > 0 && PSpell->dealsDamage() && PSpell->getSpellGroup() == SPELLGROUP_BLUE)
            {
                auto PBlueSpell = static_cast<CBlueSpell*>(PSpell);
                if (PBlueSpell->getPrimarySkillchain() != 0 && StatusEffectContainer->HasStatusEffect(EFFECT_CHAIN_AFFINITY))
                {
                    SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, PBlueSpell->getPrimarySkillchain(), PBlueSpell->getSecondarySkillchain(), 0 );
                    if (effect != SUBEFFECT_NONE)
                    {
                        uint16 skillChainDamage = battleutils::TakeSkillchainDamage(static_cast<CBattleEntity*>(this), PTarget, actionTarget.param, nullptr);

                        actionTarget.addEffectParam = skillChainDamage;
                        actionTarget.addEffectMessage = 287 + effect;
                        actionTarget.additionalEffect = effect;

                    }
                    if (StatusEffectContainer->HasStatusEffect({EFFECT_SEKKANOKI, EFFECT_MEIKYO_SHISUI}))
                    {
                        health.tp = (health.tp > 1000 ? health.tp - 1000 : 0);
                    }
                    else
                    {
                        health.tp = 0;
                    }

                    StatusEffectContainer->DelStatusEffectSilent(EFFECT_CHAIN_AFFINITY);
                }

                // do not need to knockback mobs if stun/terror/petrify
                if (!(PTarget->objtype == TYPE_MOB && PTarget->StatusEffectContainer->HasStatusEffect({ EFFECT_STUN, EFFECT_TERROR, EFFECT_PETRIFICATION })))
                {
                    auto PSkill = battleutils::GetMobSkill(PBlueSpell->getMonsterSkillId());
                    bool interrupted = false;
                    if (PSkill && PSkill->getKnockback() > 0)
                    {
                        auto knockback = PSkill->getKnockback();
                        actionTarget.knockback = knockback;
                        if (!(actionTarget.speceffect & SPECEFFECT_RECOIL))
                        {
                            actionTarget.speceffect = SPECEFFECT_RECOIL;
                        }

                        if (!(actionTarget.reaction & REACTION_HIT))
                        {
                            actionTarget.reaction = REACTION_HIT;
                        }

                        if (PTarget->objtype == TYPE_PC)
                        {
                            // knock back player characters and prevent anti-knockback addon
                            auto knockbackPos = nearPosition(PTarget->loc.p, knockback, (float)M_PI);
                            if(PTarget->PAI->PathFind->isNavMeshEnabled() && PTarget->loc.zone->m_navMesh->validPosition(knockbackPos))
                            {
                                PTarget->loc.p = knockbackPos;
                                PTarget->updatemask |= UPDATE_POS;
                            }
                        }

                        battleutils::TryKnockbackInterrupt(this, PTarget);
                    }
                    else
                    {
                        // Physical Spell, try to interrupt like a normal hit
                        if (PBlueSpell->getElement() == ELEMENT::ELEMENT_NONE)
                        {
                            PTarget->TryHitInterrupt(this);
                        }
                    }
                }
            }
        }
    }

    if (charutils::hasTrait(this, TRAIT_OCCULT_ACUMEN) &&(PSpell->getSkillType() == SKILLTYPE::SKILL_ELEMENTAL_MAGIC || PSpell->getSkillType() == SKILLTYPE::SKILL_DARK_MAGIC))
    {
        int16 tp = (int16)(PSpell->getMPCost() * getMod(Mod::OCCULT_ACUMEN) / 100.f * GetStoreTPMultiplier());
        addTP(tp);
    }

    charutils::RemoveStratagems(this, PSpell);
    if (PSpell->tookEffect())
    {
        charutils::TrySkillUP(this, (SKILLTYPE)PSpell->getSkillType(), PTarget->GetMLevel());
        if (PSpell->getSkillType() == SKILL_SINGING)
        {
            CItemWeapon* PItem = static_cast<CItemWeapon*>(getEquip(SLOT_RANGED));
            if (PItem && PItem->isType(ITEM_EQUIPMENT))
            {
                SKILLTYPE Skilltype = (SKILLTYPE)PItem->getSkillType();
                if (Skilltype == SKILL_STRING_INSTRUMENT || Skilltype == SKILL_WIND_INSTRUMENT || Skilltype == SKILL_SINGING)
                {
                    charutils::TrySkillUP(this, Skilltype, PTarget->GetMLevel());
                }
            }
        }
    }

    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }
}

void CCharEntity::OnCastInterrupted(CMagicState& state, action_t& action, MSGBASIC_ID msg)
{
    CBattleEntity::OnCastInterrupted(state, action, msg);

    this->lastInCombat = (uint32)CVanaTime::getInstance()->getVanaTime();

    auto message = state.GetErrorMsg();

    if (message)
    {
        pushPacket(message);
    }
}

void CCharEntity::OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action)
{
    CBattleEntity::OnWeaponSkillFinished(state, action);

    this->lastInCombat = (uint32)CVanaTime::getInstance()->getVanaTime();

    auto PWeaponSkill = state.GetSkill();
    auto PBattleTarget = static_cast<CBattleEntity*>(state.GetTarget());

    int16 tp = state.GetSpentTP();
    int16 refundedtp = tp; // in case we are out of range
    tp = battleutils::CalculateWeaponSkillTP(this, PWeaponSkill, tp);

    PLatentEffectContainer->CheckLatentsTP();

    SLOTTYPE damslot = SLOT_MAIN;
    if (distance(loc.p, PBattleTarget->loc.p) - PBattleTarget->m_ModelSize <= PWeaponSkill->getRange())
    {
        if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 221)
        {
            damslot = SLOT_RANGED;
        }

        PAI->TargetFind->reset();
        //#TODO: revise parameters
        if (PWeaponSkill->isAoE())
        {
            PAI->TargetFind->findWithinArea(PBattleTarget, AOERADIUS_TARGET, 10);
        }
        else
        {
            PAI->TargetFind->findSingleTarget(PBattleTarget);
        }

        for (auto&& PTarget : PAI->TargetFind->m_targets)
        {
            bool primary = PTarget == PBattleTarget;
            actionList_t& actionList = action.getNewActionList();
            actionList.ActionTargetID = PTarget->id;

            actionTarget_t& actionTarget = actionList.getNewActionTarget();

            uint16 tpHitsLanded;
            uint16 extraHitsLanded;
            int32 damage;
            CBattleEntity* taChar = battleutils::getAvailableTrickAttackChar(this, PTarget);

            actionTarget.reaction = REACTION_NONE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.animation = PWeaponSkill->getAnimationId();
            actionTarget.messageID = 0;
            std::tie(damage, tpHitsLanded, extraHitsLanded) = luautils::OnUseWeaponSkill(this, PTarget, PWeaponSkill, tp, primary, action, taChar);

            if (!battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
            {
                if (primary && PBattleTarget->objtype == TYPE_MOB)
                {
                    luautils::OnWeaponskillHit(PBattleTarget, this, PWeaponSkill->getID());
                }
            }
            else
            {
                actionTarget.messageID = primary ? 224 : 276; //restores mp msg
                actionTarget.reaction = REACTION_HIT;
                damage = std::max(damage, 0);
                actionTarget.param = PTarget->addMP(damage);
            }

            if (primary)
            {
                if (PWeaponSkill->getID() >= 192 && PWeaponSkill->getID() <= 218)
                {
                    uint16 recycleChance = getMod(Mod::RECYCLE) + PMeritPoints->GetMeritValue(MERIT_RECYCLE, this);

                    if (StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
                    {
                        StatusEffectContainer->DelStatusEffect(EFFECT_UNLIMITED_SHOT);
                        recycleChance = 100;
                    }
                    if (tpzrand::GetRandomNumber(100) > recycleChance)
                    {
                        battleutils::RemoveAmmo(this);
                    }
                }
                if (actionTarget.reaction == REACTION_HIT)
                {
                    if (battleutils::GetScaledItemModifier(this, m_Weapons[damslot], Mod::ADDITIONAL_EFFECT))
                    {
                        actionTarget_t dummy;
                        luautils::OnAdditionalEffect(this, PTarget, static_cast<CItemWeapon*>(m_Weapons[damslot]), &dummy, damage);
                    }
                    else if (damslot == SLOT_RANGED && m_Weapons[SLOT_AMMO] && battleutils::GetScaledItemModifier(this, m_Weapons[SLOT_AMMO], Mod::ADDITIONAL_EFFECT))
                    {
                        actionTarget_t dummy;
                        luautils::OnAdditionalEffect(this, PTarget, static_cast<CItemWeapon*>(getEquip(SLOT_AMMO)), &dummy, damage);
                    }
                    int wspoints = 1;
                    if (PWeaponSkill->getPrimarySkillchain() != 0)
                    {
                        // NOTE: GetSkillChainEffect is INSIDE this if statement because it
                        //  ALTERS the state of the resonance, which misses and non-elemental skills should NOT do.
                        SUBEFFECT effect = battleutils::GetSkillChainEffect(PBattleTarget, PWeaponSkill->getPrimarySkillchain(), PWeaponSkill->getSecondarySkillchain(), PWeaponSkill->getTertiarySkillchain() );
                        if (effect != SUBEFFECT_NONE)
                        {
                            actionTarget.addEffectParam = battleutils::TakeSkillchainDamage(this, PBattleTarget, damage, taChar);
                            if (actionTarget.addEffectParam < 0)
                            {
                                actionTarget.addEffectParam = -actionTarget.addEffectParam;
                                actionTarget.addEffectMessage = 384 + effect;
                            }
                            else
                                actionTarget.addEffectMessage = 287 + effect;
                            actionTarget.additionalEffect = effect;

                            if (effect >= 7)
                                wspoints += 1;
                            else if (effect >= 3)
                                wspoints += 2;
                            else
                                wspoints += 4;
                        }
                    }
                    // check for ws points
                    if (charutils::CheckMob(this->GetMLevel(), PTarget->GetMLevel()) > EMobDifficulty::TooWeak)
                    {
                        charutils::AddWeaponSkillPoints(this, damslot, wspoints);
                    }
                }
            }
        }
        battleutils::ClaimMob(PBattleTarget, this);

        if (PBattleTarget->isDead() && PBattleTarget->objtype == TYPE_MOB)
        {
            ((CMobEntity*)PBattleTarget)->m_autoTargetKiller = this;
            ((CMobEntity*)PBattleTarget)->DoAutoTarget();
        }
    }
    else
    {
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_TOO_FAR_AWAY));
        this->addTP(refundedtp);
    }
}

void CCharEntity::OnAbility(CAbilityState& state, action_t& action)
{
    auto PAbility = state.GetAbility();

    // Check if user is the right job and level
    if ((PAbility->getJob() != this->GetMJob() && PAbility->getJob() != this->GetSJob()) ||
        (PAbility->getJob() == this->GetMJob() && PAbility->getLevel() > this->GetMLevel()) ||
        (PAbility->getJob() == this->GetSJob() && PAbility->getLevel() > this->GetSLevel() && this->GetMJob() != this->GetSJob()))
    {
        pushPacket(new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
        return;
    }

    if (this->PRecastContainer->HasRecast(RECAST_ABILITY, PAbility->getRecastId(), PAbility->getRecastTime()))
    {
        pushPacket(new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_WAIT_LONGER));
        return;
    }
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_AMNESIA)) {
        pushPacket(new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_UNABLE_TO_USE_JA2));
        return;
    }
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    std::unique_ptr<CBasicPacket> errMsg;
    if (IsValidTarget(PTarget->targid, PAbility->getValidTarget(), errMsg))
    {
        if (this != PTarget && distance(this->loc.p, PTarget->loc.p) > PAbility->getRange())
        {
            pushPacket(new CMessageBasicPacket(this, PTarget, 0, 0, MSGBASIC_TOO_FAR_AWAY));
            return;
        }
        if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_PERFECT_DEFENSE)
        {
            // Blood pact MP costs are stored under animation ID
            if (this->health.mp < PAbility->getAnimationID())
            {
                pushPacket(new CMessageBasicPacket(this, PTarget, 0, 0, MSGBASIC_UNABLE_TO_USE_JA));
                return;
            }
        }

        if (battleutils::IsParalyzed(this))
        {
            if (!(PAbility->getRecastId())) // is two-hour
            {
                PRecastContainer->Add(RECAST_ABILITY, 0, 4);
            }
            else
            {
                PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), action.recast);

                // innin and yonin share recasts
                if (PAbility->getRecastId() == 146)
                    PRecastContainer->Add(RECAST_ABILITY, 147, action.recast);
                else if (PAbility->getRecastId() == 147)
                    PRecastContainer->Add(RECAST_ABILITY, 146, action.recast);

                uint16 recastID = PAbility->getRecastId();
                if (map_config.blood_pact_shared_timer && (recastID == 173 || recastID == 174))
                {
                    PRecastContainer->Add(RECAST_ABILITY, (recastID == 173 ? 174 : 173), action.recast);
                }
            }

            // display paralyzed
            loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, PTarget, 0, 0, MSGBASIC_IS_PARALYZED));
            return;
        }

        // get any available merit recast reduction
        uint16 meritRecastReduction = 0;
        uint16 id = PAbility->getID();
        uint8 chargeTime = 0;

        //Ignore SMN Group 2 Merits/Tomahawk specifically until we can long term fix merits that serve dual purpose
        if (PAbility->getMeritModID() > 0 && id != 551 && id != 567 && id != 583 && id != 599 && id != 615 && id != 631 && id != 150 && id != 152)
        {
            MERIT_TYPE meritmod = (MERIT_TYPE)PAbility->getMeritModID();
            meritRecastReduction = PMeritPoints->GetMeritValue(meritmod, this);
        }

        auto charge = ability::GetCharge(this, PAbility->getRecastId());
        if (charge && PAbility->getID() != ABILITY_SIC)
        {
            // Ready is 2sec/merit (Sic is 4sec/merit so divide by 2)
            if (PAbility->getMeritModID() == 902)
            {
                meritRecastReduction /= 2;
            }

            chargeTime = charge->chargeTime - meritRecastReduction;

            //Quickdraw Reduction
            if (id >= ABILITY_FIRE_SHOT && id <= ABILITY_DARK_SHOT) {
                chargeTime -= std::min<int16>(getMod(Mod::QUICK_DRAW_DELAY), 15);
            }

            if (id == ABILITY_READY) {
                chargeTime -= std::min<int16>(getMod(Mod::SIC_READY_DELAY), 15);
            }

            action.recast = chargeTime * PAbility->getRecastTime();
        }
        else
        {
            action.recast = PAbility->getRecastTime() - meritRecastReduction;
        }

        if (id == 62 && this->StatusEffectContainer->HasStatusEffect({EFFECT_SEIGAN}))
             action.recast = PAbility->getRecastTime() - PMeritPoints->GetMeritValue(MERIT_THIRD_EYE_RECAST, this) / 2;

        if (PAbility->getID() == ABILITY_LIGHT_ARTS || PAbility->getID() == ABILITY_DARK_ARTS || PAbility->getRecastId() == 231) //stratagems
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_TABULA_RASA))
                action.recast = 0;
        }
        else if (PAbility->getID() == ABILITY_DEACTIVATE && PAutomaton && PAutomaton->health.hp == PAutomaton->GetMaxHP())
        {
            CAbility* PAbility = ability::GetAbility(ABILITY_ACTIVATE);
            if (PAbility)
                PRecastContainer->Del(RECAST_ABILITY, PAbility->getRecastId());
        }
        else if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_PERFECT_DEFENSE)
        {
            if (this->StatusEffectContainer->HasStatusEffect(EFFECT_APOGEE))
            {
                action.recast = 0;
            }
            else
            {
                action.recast -= std::min<int16>(getMod(Mod::BP_DELAY), 15);
                action.recast -= std::min<int16>(getMod(Mod::BP_DELAY_II), 15);
            }
        }
        else if (id == ABILITY_CALL_BEAST) {
            action.recast -= std::min<int16>(getMod(Mod::CALL_BEAST_DELAY), 60);
        }

        if (id >= ABILITY_PHANTOM_ROLL && id <= ABILITY_TACTICIANS_ROLL)
            action.recast -= std::min<int16>(getMod(Mod::PHANTOM_ROLL_DELAY), 15);

        if (id == ABILITY_SIC)
            action.recast -= std::min<int16>(getMod(Mod::SIC_READY_DELAY), 15);

        // remove invisible if aggressive
        if (PAbility->getID() != ABILITY_TAME && PAbility->getID() != ABILITY_FIGHT && PAbility->getID() != ABILITY_DEPLOY)
        {
            if (PAbility->getValidTarget() & TARGET_ENEMY) {
                // aggressive action
                if (PAbility->getID() != ABILITY_ASSAULT)
                    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
                else
                    StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_INVISIBLE);
            }
            else if (PAbility->getID() != ABILITY_TRICK_ATTACK) {
                // remove invisible only
                StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_INVISIBLE);
            }
        }

        if (PAbility->getID() == ABILITY_REWARD) {
            CItem* PItem = getEquip(SLOT_HEAD);
            if (PItem && (PItem->getID() == 15157 || PItem->getID() == 15158 || PItem->getID() == 16104 || PItem->getID() == 16105)) {
                //TODO: Transform this into an item Mod::REWARD_RECAST perhaps ?
                //The Bison/Brave's Warbonnet & Khimaira/Stout Bonnet reduces recast time by 10 seconds.
                action.recast -= 10;   // remove 10 seconds
            }
        }

        action.id = this->id;
        action.actiontype = PAbility->getActionType();
        action.actionid = PAbility->getID();

        // #TODO: get rid of this to script, too
        if (PAbility->isPetAbility())
        {
            if (PPet) //is a bp - don't display msg and notify pet
            {
                actionList_t& actionList = action.getNewActionList();
                actionList.ActionTargetID = PTarget->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.animation = 94; //assault anim
                actionTarget.reaction = REACTION_NONE;
                actionTarget.speceffect = SPECEFFECT_RECOIL;
                actionTarget.param = 0;
                actionTarget.messageID = 0;

                auto PPetTarget = PTarget->targid;
                if (PAbility->getID() >= ABILITY_HEALING_RUBY && PAbility->getID() <= ABILITY_PERFECT_DEFENSE)
                {
                    // Blood Pact mp cost stored in animation ID
                    float mpCost = PAbility->getAnimationID();

                    if (StatusEffectContainer->HasStatusEffect(EFFECT_APOGEE))
                    {
                        mpCost *= 1.5f;
                        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_BLOODPACT);
                    }

                    // Blood Boon (does not affect Astral Flow BPs)
                    if ((PAbility->getAddType() & ADDTYPE_ASTRAL_FLOW) == 0)
                    {
                        int16 bloodBoonRate = getMod(Mod::BLOOD_BOON);
                        if (tpzrand::GetRandomNumber(100) < bloodBoonRate)
                        {
                            mpCost *= tpzrand::GetRandomNumber(8.f, 16.f) / 16.f;
                        }
                    }

                    addMP((int32)-mpCost);

                    if (PAbility->getValidTarget() == TARGET_SELF)
                    {
                        PPetTarget = PPet->targid;
                    }
                }
                else
                {
                    auto PMobSkill = battleutils::GetMobSkill(PAbility->getMobSkillID());
                    if (PMobSkill)
                    {
                        if (PMobSkill->getValidTargets() & TARGET_ENEMY)
                        {
                            PPetTarget = PPet->GetBattleTargetID();
                        }
                        else
                        {
                            PPetTarget = PPet->targid;
                        }
                    }
                }
                if (PAbility->getID() == ABILITY_LEVEL_QUESTION_HOLY)
                {
                    //ShowDebug("doing qm holy...\n");
                    PPet->PAI->MobSkill(PPetTarget, tpzrand::GetRandomNumber((uint16)2452, (uint16)2458));
                }
                else
                {
                    //ShowDebug("doing pet ability %i...\n", PAbility->getMobSkillID());
                    PPet->PAI->MobSkill(PPetTarget, PAbility->getMobSkillID());
                }
            }
        }
        else
        {
            std::vector<CBattleEntity*> targets = { PTarget };
            auto& PTargets = targets;
            bool first = true;

            if (PAbility->isAoE() && this->PParty != nullptr)
            {
                PAI->TargetFind->reset();

                float distance = PAbility->getRange();

                PAI->TargetFind->findWithinArea(this, AOERADIUS_ATTACKER, distance);

                PTargets = PAI->TargetFind->m_targets;
            }

            for (auto&& PTarget : PTargets)
            {
                actionList_t& actionList = action.getNewActionList();
                actionList.ActionTargetID = PTarget->id;
                actionTarget_t& actionTarget = actionList.getNewActionTarget();
                actionTarget.reaction = REACTION_NONE;
                actionTarget.speceffect = SPECEFFECT_NONE;
                actionTarget.animation = PAbility->getAnimationID();
                actionTarget.messageID = 0;
                actionTarget.param = 0;

                if (PTarget->isSuperJumped)
                {
                    actionTarget.animation = ANIMATION_NONE;
                    actionTarget.messageID = 0;
                }
                else
                {
                    int32 value = luautils::OnUseAbility(this, PTarget, PAbility, &action);

                    // If a script set messageID directly, use that;
                    // otherwise, use the ability's message id.
                    if (actionTarget.messageID == 0)
                    {
                        actionTarget.messageID = first ? PAbility->getMessage() : PAbility->getAoEMsg();
                    }

                    // Display a generic message for the caster if no message is set.
                    if (first && actionTarget.messageID == 0) actionTarget.messageID = MSGBASIC_USES_JA;

                    actionTarget.param = value;

                    if (value < 0)
                    {
                        actionTarget.messageID = ability::GetAbsorbMessage(actionTarget.messageID);
                        actionTarget.param = -value;
                    }

                    state.ApplyEnmity();
                }

                first = false;
            }
        }

        battleutils::HandlePlayerAbilityUsed(this, PAbility, &action);

        PRecastContainer->Add(RECAST_ABILITY, PAbility->getRecastId(), action.recast, chargeTime);

        // innin and yonin share recasts
        if (PAbility->getRecastId() == 146)
            PRecastContainer->Add(RECAST_ABILITY, 147, action.recast);
        else if (PAbility->getRecastId() == 147)
            PRecastContainer->Add(RECAST_ABILITY, 146, action.recast);

        uint16 recastID = PAbility->getRecastId();
        if (map_config.blood_pact_shared_timer && (recastID == 173 || recastID == 174))
        {
            PRecastContainer->Add(RECAST_ABILITY, (recastID == 173 ? 174 : 173), action.recast);
        }

        pushPacket(new CCharRecastPacket(this));

        if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
        {
            ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
            ((CMobEntity*)PTarget)->DoAutoTarget();
        }

        //#TODO: refactor
        //if (this->getMijinGakure())
        //{
        //    m_ActionType = ACTION_FALL;
        //    ActionFall();
        //}
    }
    else if (errMsg)
    {
        pushPacket(std::move(errMsg));
    }
}

void CCharEntity::OnRangedAttack(CRangeState& state, action_t& action)
{
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    this->lastInCombat = (uint32)CVanaTime::getInstance()->getVanaTime();

    int32 damage = 0;
    int32 totalDamage = 0;

    action.id = id;
    action.actiontype = ACTION_RANGED_FINISH;

    actionList_t& actionList = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.reaction = REACTION_HIT;		//0x10
    actionTarget.speceffect = SPECEFFECT_HIT;		//0x60 (SPECEFFECT_HIT + SPECEFFECT_RECOIL)
    actionTarget.messageID = charutils::GetRangedAttackMessage(this, distance(this->loc.p, PTarget->loc.p));
    // 352 = normal ... 576 = squarely ... 577 = strikes true ... 353 = critical ... 354 = miss

    CItemWeapon* PItem = (CItemWeapon*)this->getEquip(SLOT_RANGED);
    CItemWeapon* PAmmo = (CItemWeapon*)this->getEquip(SLOT_AMMO);

    bool ammoThrowing = PAmmo ? PAmmo->isThrowing() : false;
    bool rangedThrowing = PItem ? PItem->isThrowing() : false;
    uint8 slot = SLOT_RANGED;

    if (ammoThrowing)
    {
        slot = SLOT_AMMO;
        PItem = nullptr;
    }
    if (rangedThrowing)
    {
        PAmmo = nullptr;
    }

    uint8 shadowsTaken = 0;
    uint8 hitCount = 1;			// 1 hit by default
    uint8 realHits = 0;			// to store the real number of hit for tp multipler
    auto ammoConsumed = 0;
    bool hitOccured = false;	// track if player hit mob at all
    bool isSange = false;
    bool isBarrage = StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0);

    // if barrage is detected, getBarrageShotCount also checks for ammo count
    if (!ammoThrowing && !rangedThrowing && isBarrage)
    {
        hitCount += battleutils::getBarrageShotCount(this);
    }
    else if (ammoThrowing && this->StatusEffectContainer->HasStatusEffect(EFFECT_SANGE) && getMod(Mod::UTSUSEMI) > 0)
    {
        isSange = true;
        hitCount += getMod(Mod::UTSUSEMI);
    }
    //ShowDebug("max barrage hitcount = %u\n", hitCount);

    // loop for barrage hits, if a miss occurs, the loop will end
    for (uint8 i = 1; i <= hitCount; ++i)
    {
        if (tpzrand::GetRandomNumber(100) < battleutils::GetRangedHitRate(this, PTarget, isBarrage)) // hit!
        {
            // absorbed by shadow
            if (battleutils::IsAbsorbByShadow(PTarget, this))
            {
                shadowsTaken++;
            }
            else
            {
                bool isCritical = tpzrand::GetRandomNumber(100) < battleutils::GetCritHitRate(this, PTarget, true, true);
                float pdif = battleutils::GetRangedDamageRatio(this, PTarget, isCritical);

                if (isCritical)
                {
                    actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
                    actionTarget.messageID = 353;
                }

                // at least 1 hit occured
                hitOccured = true;
                realHits++;
                //ShowDebug("RA hit!\n");

                if (isSange)
                {
                    // change message to sange
                    actionTarget.messageID = 77;
                }

                damage = (int32)((this->GetRangedWeaponDmg() + battleutils::GetFSTR(this, PTarget, slot)) * pdif);

                if (slot == SLOT_RANGED)
                {
                    if (state.IsRapidShot())
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, PItem, damage, PHYSICAL_ATTACK_TYPE::RAPID_SHOT, SLOT_RANGED);
                    }
                    else
                    {
                        damage = attackutils::CheckForDamageMultiplier(this, PItem, damage, PHYSICAL_ATTACK_TYPE::RANGED, SLOT_RANGED);
                    }

                    if (PItem != nullptr)
                    {
                        charutils::TrySkillUP(this, (SKILLTYPE)PItem->getSkillType(), PTarget->GetMLevel());
                    }
                }
                else if (slot == SLOT_AMMO && PAmmo != nullptr)
                {
                    charutils::TrySkillUP(this, (SKILLTYPE)PAmmo->getSkillType(), PTarget->GetMLevel());
                }
            }
        }
        else //miss
        {
            actionTarget.reaction = REACTION_EVADE;
            actionTarget.speceffect = SPECEFFECT_NONE;
            actionTarget.messageID = 354;
            hitCount = i; // end barrage, shot missed
        }

        // check for recycle chance
        uint16 recycleChance = getMod(Mod::RECYCLE);
        if (charutils::hasTrait(this, TRAIT_RECYCLE))
        {
            recycleChance += PMeritPoints->GetMeritValue(MERIT_RECYCLE, this);
        }

        // Only remove unlimited shot on hit
        if (hitOccured && this->StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
        {
            StatusEffectContainer->DelStatusEffect(EFFECT_UNLIMITED_SHOT);
            recycleChance = 100;
        }

        if (PAmmo != nullptr && tpzrand::GetRandomNumber(100) > recycleChance)
        {
            ++ammoConsumed;
            TrackArrowUsageForScavenge(PAmmo);
            if (PAmmo->getQuantity() == i)
            {
                hitCount = i;
            }
        }
        totalDamage += damage;
    }

    // if a hit did occur (even without barrage)
    if (hitOccured == true)
    {
        // any misses with barrage cause remaing shots to miss, meaning we must check Action.reaction
        if (actionTarget.reaction == REACTION_EVADE && (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE) || isSange))
        {
            actionTarget.messageID = 352;
            actionTarget.reaction = REACTION_HIT;
            actionTarget.speceffect = SPECEFFECT_CRITICAL_HIT;
        }

        actionTarget.param = battleutils::TakePhysicalDamage(this, PTarget, PHYSICAL_ATTACK_TYPE::RANGED, totalDamage, false, slot, realHits, nullptr, true, true);

        // lower damage based on shadows taken
        if (shadowsTaken)
            actionTarget.param = (int32)(actionTarget.param * (1 - ((float)shadowsTaken / realHits)));

        // absorb message
        if (actionTarget.param < 0)
        {
            actionTarget.param = -(actionTarget.param);
            actionTarget.messageID = 382;
        }

        //add additional effects
        //this should go AFTER damage taken
        //or else sleep effect won't work
        //battleutils::HandleRangedAdditionalEffect(this,PTarget,&Action);
        //TODO: move all hard coded additional effect ammo to scripts
        if ((PAmmo != nullptr && battleutils::GetScaledItemModifier(this, PAmmo, Mod::ADDITIONAL_EFFECT) > 0) ||
            (PItem != nullptr && battleutils::GetScaledItemModifier(this, PItem, Mod::ADDITIONAL_EFFECT) > 0)) {}
        luautils::OnAdditionalEffect(this, PTarget, (PAmmo != nullptr ? PAmmo : PItem), &actionTarget, totalDamage);
    }
    else if (shadowsTaken > 0)
    {
        // shadows took damage
        actionTarget.messageID = 0;
        actionTarget.reaction = REACTION_EVADE;
        PTarget->loc.zone->PushPacket(PTarget, CHAR_INRANGE_SELF, new CMessageBasicPacket(PTarget, PTarget, 0, shadowsTaken, MSGBASIC_SHADOW_ABSORB));
    }
    // No hit, but unlimited shot is up, so don't consume ammo
    else if (!hitOccured && this->StatusEffectContainer->HasStatusEffect(EFFECT_UNLIMITED_SHOT))
    {
        ammoConsumed = 0;
    }

    if (actionTarget.speceffect == SPECEFFECT_HIT && actionTarget.param > 0)
        actionTarget.speceffect = SPECEFFECT_RECOIL;

    // remove barrage effect if present
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_BARRAGE, 0)) {
        StatusEffectContainer->DelStatusEffect(EFFECT_BARRAGE, 0);
    }
    else if (isSange)
    {

        // remove shadows
        while (realHits-- && battleutils::IsAbsorbByShadow(this, PTarget));

        StatusEffectContainer->DelStatusEffect(EFFECT_SANGE);
    }

    battleutils::ClaimMob(PTarget, this);
    battleutils::RemoveAmmo(this, ammoConsumed);

    // Handle Camouflage effects
    if (this->StatusEffectContainer->HasStatusEffect(EFFECT_CAMOUFLAGE, 0))
    {
        int16 retainChance = 40; // Estimate base ~30% chance to keep Camouflage on a ranged attack
        uint8 rotAllowance = 25; // Allow for some slight variance in direction faced to be "behind" the mob

        retainChance += (1.6 * distance(this->loc.p, PTarget->loc.p)); // Further distance from target = less chance of detection

        if (behind(this->loc.p, PTarget->loc.p, rotAllowance))
        {
            // We're behind the mob, so it's guaranteed to stay up.
            retainChance = 100;
        }

        if (tpzrand::GetRandomNumber(100) > retainChance)
        {
            // Camouflage was up, but is lost, so now all detectable effects must be dropped
            StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
        }
        else
        {
            // Camouflage up, and retained, but all other effects must be dropped
            StatusEffectContainer->DelStatusEffect(EFFECT_SNEAK);
            StatusEffectContainer->DelStatusEffect(EFFECT_INVISIBLE);
            StatusEffectContainer->DelStatusEffect(EFFECT_DEODORIZE);
        }
    }
    else
    {
        // Camouflage not up, so remove all detectable status effects
        StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DETECTABLE);
    }
    if (PTarget->isDead() && PTarget->objtype == TYPE_MOB)
    {
        ((CMobEntity*)PTarget)->m_autoTargetKiller = this;
        ((CMobEntity*)PTarget)->DoAutoTarget();
    }

    // Try to double shot
    //#TODO: figure out the packet structure of double/triple shot
    //if (this->StatusEffectContainer->HasStatusEffect(EFFECT_DOUBLE_SHOT, 0) && !this->secondDoubleShotTaken &&	!isBarrage && !isSange)
    //{
    //    uint16 doubleShotChance = getMod(Mod::DOUBLE_SHOT_RATE);
    //    if (tpzrand::GetRandomNumber(100) < doubleShotChance)
    //    {
    //        this->secondDoubleShotTaken = true;
    //        m_ActionType = ACTION_RANGED_FINISH;
    //        this->m_rangedDelay = 0;
    //        return;
    //    }
    //}
}

bool CCharEntity::IsMobOwner(CBattleEntity* PBattleTarget)
{
    TPZ_DEBUG_BREAK_IF(PBattleTarget == nullptr);

    if (PBattleTarget->m_OwnerID.id == 0 || PBattleTarget->m_OwnerID.id == this->id || PBattleTarget->objtype == TYPE_PC ||
        (PBattleTarget->loc.zone && PBattleTarget->loc.zone->GetType() == ZONETYPE_DYNAMIS))
    {
        return true;
    }

    bool found = false;

    static_cast<CCharEntity*>(this)->ForAlliance([&PBattleTarget, &found](CBattleEntity* PEntity) {
        if (PEntity->id == PBattleTarget->m_OwnerID.id)
        {
            found = true;
        }
    });

    return found;
}

bool CCharEntity::IsPartiedWith(CCharEntity* PTarget)
{
    bool found = false;

    static_cast<CCharEntity*>(this)->ForAlliance([&PTarget, &found](CBattleEntity* PEntity) {
        if (PEntity->id == PTarget->id)
        {
            found = true;
        }
    });

    return found;
}

void CCharEntity::HandleErrorMessage(std::unique_ptr<CBasicPacket>& msg)
{
    if (msg && !isCharmed)
        pushPacket(msg.release());
}

void CCharEntity::OnDeathTimer()
{
    charutils::HomePoint(this);
}

void CCharEntity::OnRaise()
{
    // TODO: Moghancement Experience needs to be factored in here somewhere.
    if (m_hasRaise > 0)
    {
        uint8 weaknessLvl = 1;
        if (StatusEffectContainer->HasStatusEffect(EFFECT_WEAKNESS))
        {
            //double weakness!
            weaknessLvl = 2;
        }

        //add weakness effect (75% reduction in HP/MP)
        if (GetLocalVar("MijinGakure") == 0 && GetLocalVar("Shantottofication") == 0 && m_hasRaise <= 5)
        {
            CStatusEffect* PWeaknessEffect = new CStatusEffect(EFFECT_WEAKNESS, EFFECT_WEAKNESS, weaknessLvl, 0, 300);
            StatusEffectContainer->AddStatusEffect(PWeaknessEffect);
        }
        else if (GetLocalVar("MijinGakure") == 0 && GetLocalVar("Shantottofication") == 0 && m_hasRaise == 4) // arise, 3min
        {
            CStatusEffect* PWeaknessEffect = new CStatusEffect(EFFECT_WEAKNESS, EFFECT_WEAKNESS, weaknessLvl, 0, 180);
            StatusEffectContainer->AddStatusEffect(PWeaknessEffect);
        }

        float ratioReturned = 0.0f;
        uint16 hpReturned = 1;

        action_t action;
        action.id = id;
        action.actiontype = ACTION_RAISE_MENU_SELECTION;
        auto& list = action.getNewActionList();
        auto& actionTarget = list.getNewActionTarget();

        list.ActionTargetID = id;
        // Mijin Gakure used with MIJIN_RERAISE MOD
        if (GetLocalVar("MijinGakure") != 0 && getMod(Mod::MIJIN_RERAISE) != 0)
        {
            actionTarget.animation = 511;
            hpReturned = (uint16)(GetMaxHP());
        }
        else if (m_hasRaise == 1)
        {
            actionTarget.animation = 511;
            hpReturned = (uint16)((GetLocalVar("MijinGakure") != 0 || GetLocalVar("Shantottofication") != 0) ? GetMaxHP() * 0.5f : GetMaxHP() * 0.1f);
            ratioReturned = 0.50f * (1.0f - (map_config.exp_retain));
        }
        else if (m_hasRaise == 2)
        {
            actionTarget.animation = 512;
            hpReturned = (uint16)((GetLocalVar("MijinGakure") != 0 || GetLocalVar("Shantottofication") != 0) ? GetMaxHP() * 0.5f : GetMaxHP() * 0.25f);
            ratioReturned = ((GetMLevel() <= 50) ? 0.50f : 0.75f) * (1.0f - (map_config.exp_retain));
        }
        else if (m_hasRaise == 3)
        {
            actionTarget.animation = 496;
            hpReturned = (uint16)(GetMaxHP() * 0.5f);
            ratioReturned = ((GetMLevel() <= 50) ? 0.50f : 0.90f) * (1.0f - (map_config.exp_retain));
        }
        else if (m_hasRaise == 4) // arise
        {
            actionTarget.animation = 496;
            hpReturned = GetMaxHP();
            ratioReturned = ((GetMLevel() <= 50) ? 0.50f : 0.90f) * (1.0f - (map_config.exp_retain));
            CStatusEffect* PEffect = new CStatusEffect(EFFECT_RERAISE,EFFECT_RERAISE,3,3,3600,0,0,0);
            this->StatusEffectContainer->AddStatusEffect(PEffect, true);
        }
        else if (m_hasRaise == 5) // pixie raise
        {
            actionTarget.animation = 496;
            hpReturned = GetMaxHP();
            ratioReturned = 1.0f - (map_config.exp_retain);
        }
        addHP(((hpReturned < 1) ? 1 : hpReturned));
        updatemask |= UPDATE_HP;
        actionTarget.speceffect = SPECEFFECT_RAISE;

        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CActionPacket(action));

        uint8 mLevel = (uint8)charutils::GetCharVar(this, "RaiseCharLevel");
        if (mLevel > 0)
        {
            uint16 expLost = mLevel <= 67 ? (charutils::GetExpNEXTLevel(mLevel) * 8) / 100 : 2400;

            uint16 xpNeededToLevel = charutils::GetExpNEXTLevel(jobs.job[GetMJob()]) - jobs.exp[GetMJob()];

            // Exp is enough to level you and (you're not under a level restriction, or the level restriction is higher than your current main level).
            if (xpNeededToLevel < expLost && (m_LevelRestriction == 0 || GetMLevel() < m_LevelRestriction))
            {
                // Player probably leveled down when they died.  Give they xp for the next level.
                expLost = GetMLevel() <= 67 ? (charutils::GetExpNEXTLevel(jobs.job[GetMJob()] + 1) * 8) / 100 : 2400;
            }

            uint16 xpReturned = (uint16)(ceil(expLost * ratioReturned));

            if (GetMLevel() >= map_config.exp_loss_level)
            {
                charutils::AddExperiencePoints(true, this, this, xpReturned);
            }
        }

        SetLocalVar("MijinGakure", 0);
        SetLocalVar("Shantottofication", 0);

        m_hasRaise = 0;
    }
}

void CCharEntity::OnItemFinish(CItemState& state, action_t& action)
{
    auto PTarget = static_cast<CBattleEntity*>(state.GetTarget());
    auto PItem = static_cast<CItemUsable*>(state.GetItem());

    //#TODO: I'm sure this is supposed to be in the action packet... (animation, message)
    if (PItem->getAoE())
    {
        //PTarget->ForParty([this, PItem, PTarget](CBattleEntity* PMember)
        if (PTarget->PParty)
        {
            for each (CBattleEntity* PMember in PTarget->PParty->members)
            {
                // Trigger for the item user last to prevent any teleportation miscues (Tidal Talisman)
                if (this->id == PMember->id)
                    continue;
                if (!PMember->isDead() && distanceSquared(PTarget->loc.p, PMember->loc.p) < 10.0f * 10.0f)
                {
                    luautils::OnItemUse(PMember, PItem, this);
                }
            };
        }
        // Triggering for item user
        luautils::OnItemUse(this, PItem, this);
    }
    else
    {
        luautils::OnItemUse(PTarget, PItem, this);
    }

    action.id = this->id;
    action.actiontype = ACTION_ITEM_FINISH;
    action.actionid = PItem->getID();

    actionList_t& actionList = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();
    actionTarget.animation = PItem->getAnimationID();

    if (PItem->isType(ITEM_EQUIPMENT))
    {
        if (PItem->getMaxCharges() > 1)
        {
            PItem->setCurrentCharges(PItem->getCurrentCharges() - 1);
        }
        PItem->setLastUseTime(CVanaTime::getInstance()->getVanaTime());

        char extra[sizeof(PItem->m_extra) * 2 + 1];
        Sql_EscapeStringLen(SqlHandle, extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

        const char* Query =
            "UPDATE char_inventory "
            "SET extra = '%s' "
            "WHERE charid = %u AND location = %u AND slot = %u;";

        Sql_Query(
            SqlHandle,
            Query,
            extra,
            this->id,
            PItem->getLocationID(),
            PItem->getSlotID());

        if (PItem->getCurrentCharges() != 0)
        {
            this->PRecastContainer->Add(RECAST_ITEM, PItem->getSlotID() << 8 | PItem->getLocationID(), PItem->getReuseTime() / 1000); // add recast timer to Recast List from any bag
        }
    }
    else // разблокируем все предметы, кроме экипирвоки
    {
        PItem->setSubType(ITEM_UNLOCKED);

        charutils::UpdateItem(this, PItem->getLocationID(), PItem->getSlotID(), -1, true);
    }
}

CBattleEntity* CCharEntity::IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg)
{
    auto PTarget = CBattleEntity::IsValidTarget(targid, validTargetFlags, errMsg);
    if (PTarget)
    {
        if (PTarget->objtype == TYPE_PC && charutils::IsAidBlocked(this, static_cast<CCharEntity*>(PTarget)))
        {
            // Target is blocking assistance
            errMsg = std::make_unique<CMessageSystemPacket>(0, 0, 225);
            // Interaction was blocked
            static_cast<CCharEntity*>(PTarget)->pushPacket(new CMessageSystemPacket(0, 0, 226));
        }
        else if (static_cast<CCharEntity*>(this)->IsMobOwner(PTarget))
        {
            if (PTarget->isAlive() || (validTargetFlags & TARGET_PLAYER_DEAD) != 0)
            {
                return PTarget;
            }
            else
            {
                errMsg = std::make_unique<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_CANNOT_ON_THAT_TARG);
            }
        }
        else
        {
            errMsg = std::make_unique<CMessageBasicPacket>(this, PTarget, 0, 0, MSGBASIC_ALREADY_CLAIMED);
        }
    }
    else
    {
        errMsg = std::make_unique<CMessageBasicPacket>(this, this, 0, 0, MSGBASIC_CANNOT_ATTACK_TARGET);
    }
    return nullptr;
}

void CCharEntity::Die()
{
    m_LastEngagedTargID = 0;

    if (PLastAttacker)
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(PLastAttacker, this, 0, 0, MSGBASIC_PLAYER_DEFEATED_BY));
    else
        loc.zone->PushPacket(this, CHAR_INRANGE_SELF, new CMessageBasicPacket(this, this, 0, 0, MSGBASIC_FALLS_TO_GROUND));

    if (this->PAutomaton && this->PAutomaton->isAlive())
        this->PAutomaton->Die();
    else if (this->PPet && this->PPet->isAlive())
        this->PPet->Die();

    battleutils::RelinquishClaim(this);
    Die(death_duration);
    SetDeathTimestamp((uint32)time(nullptr));
    if (this->PNotorietyContainer)
        this->PNotorietyContainer->clearAllEnmityForAttackers();

    setBlockingAid(false);

    //influence for conquest system
    conquest::LoseInfluencePoints(this);

    // we lose xp if we didn't use mijin gakure AND (we aren't in a battlefield OR battlefiled rules say we lose xp
    if (GetLocalVar("MijinGakure") == 0 && (!PBattlefield || (PBattlefield->GetRuleMask() & RULES_LOSE_EXP)))
    {
        float retainPercent = std::clamp(map_config.exp_retain + getMod(Mod::EXPERIENCE_RETAINED) / 100.0f, 0.0f, 1.0f);
        charutils::DelExperiencePoints(this, retainPercent, 0);

        if (m_LevelRestriction != 0 && m_LevelRestriction < GetMLevel())
        {
            charutils::SetCharVar(this, "RaiseCharLevel", m_LevelRestriction);
        }
        else
        {
            charutils::SetCharVar(this, "RaiseCharLevel", GetMLevel());
        }
    }
    else
    {
        charutils::SetCharVar(this, "RaiseCharLevel", 0);
    }
}

void CCharEntity::Die(duration _duration)
{
    this->ClearTrusts();

    m_deathSyncTime = server_clock::now() + death_update_frequency;
    PAI->ClearStateStack();
    PAI->Internal_Die(_duration);

    // If player allegiance is not reset on death they will auto-homepoint
    allegiance = ALLEGIANCE_PLAYER;

    // reraise modifiers
    if (this->getMod(Mod::RERAISE_I) > 0)
        m_hasRaise = 1;

    if (this->getMod(Mod::RERAISE_II) > 0)
        m_hasRaise = 2;

    if (this->getMod(Mod::RERAISE_III) > 0)
        m_hasRaise = 3;
    // MIJIN_RERAISE checks
    if (m_hasRaise == 0 && this->getMod(Mod::MIJIN_RERAISE) > 0)
        m_hasRaise = 1;

    CBattleEntity::Die();
}

void CCharEntity::Raise()
{
    PAI->Internal_Raise();
    SetDeathTimestamp(0);
}

void CCharEntity::SetDeathTimestamp(uint32 timestamp)
{
    m_DeathTimestamp = timestamp;
}

int32 CCharEntity::GetSecondsElapsedSinceDeath()
{
    return m_DeathTimestamp > 0 ? (uint32)time(nullptr) - m_DeathTimestamp : 0;
}

int32 CCharEntity::GetTimeRemainingUntilDeathHomepoint()
{
    // 0x0003A020 is 60 * 3960 and 3960 is 66 minutes in seconds
    // The client uses this time as the maximum amount of time for death
    // We convert the elapsed death time to this total time and subtract it which gives us the remaining time to a forced homepoint
    // Once the returned value here reaches below 360 then the client with force homepoint the character
    return 0x0003A020 - (60 * GetSecondsElapsedSinceDeath());
}


int32 CCharEntity::GetTimeCreated()
{
    const char* fmtQuery = "SELECT UNIX_TIMESTAMP(timecreated) FROM chars WHERE charid = %u;";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, id);

    if (ret != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        return Sql_GetIntData(SqlHandle, 0);
    }

    return 0;
}

bool CCharEntity::hasMoghancement(uint16 moghancementID)
{
    return m_moghancementID == moghancementID;
}

void CCharEntity::UpdateMoghancement()
{
    // Add up all of the installed furniture auras
    std::array<uint16, 8> elements = { 0 };
    for (auto containerID : {LOC_MOGSAFE, LOC_MOGSAFE2})
    {
        CItemContainer* PContainer = getStorage(containerID);
        for (int slotID = 1; slotID <= PContainer->GetSize(); ++slotID)
        {
            CItem* PItem = PContainer->GetItem(slotID);
            if (PItem != nullptr && PItem->isType(ITEM_FURNISHING))
            {
                CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PItem);
                if (PFurniture->isInstalled())
                {
                    elements[PFurniture->getElement() - 1] += PFurniture->getAura();
                }
            }
        }
    }

    // Determine the dominant aura
    uint8 dominantElement = 0;
    uint16 dominantAura = 0;
    bool hasTiedElements = false;
    for (uint8 elementID = 1; elementID < 9; ++elementID)
    {
        uint16 aura = elements[elementID - 1];
        if (aura > dominantAura)
        {
            dominantElement = elementID;
            dominantAura = aura;
            hasTiedElements = false;
        }
        else if (aura == dominantAura)
        {
            hasTiedElements = true;
        }
    }

    // Determine which moghancement to use from the dominant element
    uint8 bestAura = 0;
    uint8 bestOrder = 255;
    uint16 newMoghancementID = 0;
    if (!hasTiedElements && dominantAura > 0)
    {
        for (auto containerID : { LOC_MOGSAFE, LOC_MOGSAFE2 })
        {
            CItemContainer* PContainer = getStorage(containerID);
            for (int slotID = 1; slotID <= PContainer->GetSize(); ++slotID)
            {
                CItem* PItem = PContainer->GetItem(slotID);
                if (PItem != nullptr && PItem->isType(ITEM_FURNISHING))
                {
                    CItemFurnishing* PFurniture = static_cast<CItemFurnishing*>(PItem);
                    // If aura is tied then use whichever furniture was placed most recently
                    if (PFurniture->isInstalled() &&
                        PFurniture->getElement() == dominantElement &&
                        (PFurniture->getAura() > bestAura || (PFurniture->getAura() == bestAura && PFurniture->getOrder() < bestOrder)))
                    {
                        bestAura = PFurniture->getAura();
                        bestOrder = PFurniture->getOrder();
                        newMoghancementID = PFurniture->getMoghancement();
                    }
                }
            }
        }
    }

    // Always show which moghancement the player has if they have one at all
    if (newMoghancementID != 0)
    {
        pushPacket(new CMessageSpecialPacket(this, luautils::GetTextIDVariable(getZone(), "KEYITEM_OBTAINED"), newMoghancementID, 0, 0, 0, 0));
    }

    if (newMoghancementID != m_moghancementID)
    {
        // Remove the previous moghancement
        if (m_moghancementID != 0)
            charutils::delKeyItem(this, m_moghancementID);

        // Add the new moghancement
        if (newMoghancementID != 0)
            charutils::addKeyItem(this, newMoghancementID);

        // Send only one key item packet if they are in the same key item table
        uint8 newTable = newMoghancementID >> 9;
        uint8 currentTable = m_moghancementID >> 9;
        if (newTable == currentTable)
        {
            pushPacket(new CKeyItemsPacket(this, (KEYS_TABLE)newTable));
        }
        else
        {
            if (newTable != 0)
                pushPacket(new CKeyItemsPacket(this, (KEYS_TABLE)newTable));
            if (currentTable != 0)
                pushPacket(new CKeyItemsPacket(this, (KEYS_TABLE)currentTable));
        }
        charutils::SaveKeyItems(this);

        SetMoghancement(newMoghancementID);
        charutils::SaveCharMoghancement(this);
    }
}

void CCharEntity::SetFomorHate(uint32 fomorHate)
{
    if (fomorHate > 60) {
        fomorHate = 60;
    }
    m_fomorHate = fomorHate;
    charutils::SetCharVar(this, "FOMOR_HATE", fomorHate);
}

void CCharEntity::SetPixieHate(uint32 pixieHate)
{
    if (pixieHate > 60) {
        pixieHate = 60;
    }
    m_pixieHate = pixieHate;
    charutils::SetCharVar(this, "PIXIE_HATE", pixieHate);
}

void CCharEntity::DropBattlefield()
{
    PBattlefield = nullptr;
    PInstance = nullptr;
    charutils::SetCharVar(id, "BattlefieldToken", 0);
    charutils::SetCharVar(id, "BattlefieldEnterToken", 0);
    if (StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD)) {
        StatusEffectContainer->DelStatusEffect(EFFECT_BATTLEFIELD);
    }
    if (PPet)
    {
        PPet->PBattlefield = nullptr;
        PPet->PInstance = nullptr;
        if (PPet->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD)) {
            PPet->StatusEffectContainer->DelStatusEffect(EFFECT_BATTLEFIELD);
        }
    }
    auto PZone = zoneutils::GetZone(getZone());
    if ((PZone) && (PZone->m_BattlefieldHandler)) {
        auto PBattlefield = PZone->m_BattlefieldHandler->GetBattlefield(this, true);
        if (PBattlefield && PZone->m_BattlefieldHandler->IsRegistered(this)) {
            PBattlefield->m_RegisteredPlayers.erase(PBattlefield->m_RegisteredPlayers.find(id));
        }
    }
}

void CCharEntity::DropBattlefieldIfOutside()
{
    if ((PBattlefield) && (PBattlefield->m_EnteredPlayers.find(id) == PBattlefield->m_EnteredPlayers.end())) {
        DropBattlefield();
        return;
    }
    if (PInstance) {
        auto enteredChars = PInstance->GetEnteredChars();
        if (enteredChars->find(id) == enteredChars->end()) {
            DropBattlefield();
            return;
        }
    }
    if ((!PBattlefield) && (!PInstance)) {
        DropBattlefield();
        return;
    }
}

void CCharEntity::SetMoghancement(uint16 moghancementID)
{
    m_moghancementID = moghancementID;

    // Apply the moghancement
    if (m_moghancementID != 0)
    {
        switch (m_moghancementID)
        {
            case MOGHANCEMENT_FIRE:
                addModifier(Mod::SYNTH_FAIL_RATE_FIRE, 5);
                break;
            case MOGHANCEMENT_ICE:
                addModifier(Mod::SYNTH_FAIL_RATE_ICE, 5);
                break;
            case MOGHANCEMENT_WIND:
                addModifier(Mod::SYNTH_FAIL_RATE_WIND, 5);
                break;
            case MOGHANCEMENT_EARTH:
                addModifier(Mod::SYNTH_FAIL_RATE_EARTH, 5);
                break;
            case MOGHANCEMENT_LIGHTNING:
                addModifier(Mod::SYNTH_FAIL_RATE_LIGHTNING, 5);
                break;
            case MOGHANCEMENT_WATER:
                addModifier(Mod::SYNTH_FAIL_RATE_WATER, 5);
                break;
            case MOGHANCEMENT_LIGHT:
                addModifier(Mod::SYNTH_FAIL_RATE_LIGHT, 5);
                break;
            case MOGHANCEMENT_DARK:
                addModifier(Mod::SYNTH_FAIL_RATE_DARK, 5);
                break;

            case MOGHANCEMENT_FISHING:
                addModifier(Mod::FISH, 1);
                break;
            case MOGHANCEMENT_WOODWORKING:
                addModifier(Mod::WOOD, 1);
                break;
            case MOGHANCEMENT_SMITHING:
                addModifier(Mod::SMITH, 1);
                break;
            case MOGHANCEMENT_GOLDSMITHING:
                addModifier(Mod::GOLDSMITH, 1);
                break;
            case MOGHANCEMENT_CLOTHCRAFT:
                addModifier(Mod::CLOTH, 1);
                break;
            case MOGHANCEMENT_LEATHERCRAFT:
                addModifier(Mod::LEATHER, 1);
                break;
            case MOGHANCEMENT_BONECRAFT:
                addModifier(Mod::BONE, 1);
                break;
            case MOGHANCEMENT_ALCHEMY:
                addModifier(Mod::ALCHEMY, 1);
                break;
            case MOGHANCEMENT_COOKING:
                addModifier(Mod::COOK, 1);
                break;

            case MOGLIFICATION_FISHING:
                addModifier(Mod::FISH, 1);
                // TODO: "makes it slightly easier to reel in your catch"
                break;
            case MOGLIFICATION_WOODWORKING:
                addModifier(Mod::WOOD, 1);
                break;
            case MOGLIFICATION_SMITHING:
                addModifier(Mod::SMITH, 1);
                break;
            case MOGLIFICATION_GOLDSMITHING:
                addModifier(Mod::GOLDSMITH, 1);
                break;
            case MOGLIFICATION_CLOTHCRAFT:
                addModifier(Mod::CLOTH, 1);
                break;
            case MOGLIFICATION_LEATHERCRAFT:
                addModifier(Mod::LEATHER, 1);
                break;
            case MOGLIFICATION_BONECRAFT:
                addModifier(Mod::BONE, 1);
                break;
            case MOGLIFICATION_ALCHEMY:
                addModifier(Mod::ALCHEMY, 1);
                break;
            case MOGLIFICATION_COOKING:
                addModifier(Mod::COOK, 1);
                break;

            case MEGA_MOGLIFICATION_FISHING:
                addModifier(Mod::FISH, 5);
                break;
            case MEGA_MOGLIFICATION_WOODWORKING:
                addModifier(Mod::WOOD, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_WOOD, 5);
                break;
            case MEGA_MOGLIFICATION_SMITHING:
                addModifier(Mod::SMITH, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_SMITH, 5);
                break;
            case MEGA_MOGLIFICATION_GOLDSMITHING:
                addModifier(Mod::GOLDSMITH, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_GOLDSMITH, 5);
                break;
            case MEGA_MOGLIFICATION_CLOTHCRAFT:
                addModifier(Mod::CLOTH, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_CLOTH, 5);
                break;
            case MEGA_MOGLIFICATION_LEATHERCRAFT:
                addModifier(Mod::LEATHER, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_LEATHER, 5);
                break;
            case MEGA_MOGLIFICATION_BONECRAFT:
                addModifier(Mod::BONE, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_BONE, 5);
                break;
            case MEGA_MOGLIFICATION_ALCHEMY:
                addModifier(Mod::ALCHEMY, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_ALCHEMY, 5);
                break;
            case MEGA_MOGLIFICATION_COOKING:
                addModifier(Mod::COOK, 5);
                addModifier(Mod::SYNTH_FAIL_RATE_COOK, 5);
                break;

            case MOGHANCEMENT_EXPERIENCE:
                addModifier(Mod::EXPERIENCE_RETAINED, 5);
                break;
            case MOGHANCEMENT_GARDENING:
                addModifier(Mod::GARDENING_WILT_BONUS, 36);
                break;
            case MOGHANCEMENT_DESYNTHESIS:
                addModifier(Mod::DESYNTH_SUCCESS, 2);
                break;
            case MOGHANCEMENT_CONQUEST:
                addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_REGION:
                addModifier(Mod::CONQUEST_REGION_BONUS, 10);
                break;
            case MOGHANCEMENT_FISHING_ITEM:
                // TODO: Increases the chances of finding items when fishing
                break;
            case MOGHANCEMENT_SANDORIA_CONQUEST:
                if (profile.nation == 0)
                    addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_BASTOK_CONQUEST:
                if (profile.nation == 1)
                    addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_WINDURST_CONQUEST:
                if (profile.nation == 2)
                    addModifier(Mod::CONQUEST_BONUS, 6);
                break;
            case MOGHANCEMENT_MONEY:
                addModifier(Mod::GILFINDER, 10);
                break;
            case MOGHANCEMENT_CAMPAIGN:
                addModifier(Mod::CAMPAIGN_BONUS, 5);
                break;
            case MOGHANCEMENT_MONEY_II:
                addModifier(Mod::GILFINDER, 15);
                break;
            case MOGHANCEMENT_SKILL_GAINS:
                // NOTE: Exact value is unknown but considering this only granted by a newish item it makes sense SE made it fairly strong
                addModifier(Mod::COMBAT_SKILLUP_RATE, 25);
                addModifier(Mod::MAGIC_SKILLUP_RATE, 25);
                break;
            case MOGHANCEMENT_BOUNTY:
                addModifier(Mod::EXP_BONUS, 10);
                addModifier(Mod::CAPACITY_BONUS, 10);
                break;
            case MOGLIFICATION_EXPERIENCE_BOOST:
                addModifier(Mod::EXP_BONUS, 15);
                break;
            case MOGLIFICATION_CAPACITY_BOOST:
                addModifier(Mod::CAPACITY_BONUS, 15);
                break;

            // NOTE: Exact values for resistances is unknown
            case MOGLIFICATION_RESIST_POISON:
                addModifier(Mod::POISONRES, 20);
                break;
            case MOGLIFICATION_RESIST_PARALYSIS:
                addModifier(Mod::SILENCERES, 20);
                break;
            case MOGLIFICATION_RESIST_SILENCE:
                addModifier(Mod::SILENCERES, 20);
                break;
            case MOGLIFICATION_RESIST_PETRIFICATION:
                addModifier(Mod::PETRIFYRES, 20);
                break;
            case MOGLIFICATION_RESIST_VIRUS:
                addModifier(Mod::VIRUSRES, 20);
                break;
            case MOGLIFICATION_RESIST_CURSE:
                addModifier(Mod::CURSERES, 20);
                break;
            default:
                break;
        }
    }
}

void CCharEntity::TrackArrowUsageForScavenge(CItemWeapon* PAmmo)
{
    // Check if local has been set yet
    if (this->GetLocalVar("ArrowsUsed") == 0)
    {
        // Local not set yet so set
        this->SetLocalVar("ArrowsUsed", PAmmo->getID() * 10000 + 1);
    }
    else
    {
        // Local exists now check if arrow used is same as last time
        if ((floor(this->GetLocalVar("ArrowsUsed") / 10000)) == PAmmo->getID())
        {
            // Same arrow used as last time now check that arrows used do not go above 1980
            if (!(floor(this->GetLocalVar("ArrowsUsed") % 10000) >= 1980))
            {
                // Safe to increment arrows used
                this->SetLocalVar("ArrowsUsed", this->GetLocalVar("ArrowsUsed") + 1);
            }
        }
        else
        {
            // Different arrow is being used so remake local
            this->SetLocalVar("ArrowsUsed", PAmmo->getID() * 10000 + 1);
        }
    }
}

bool CCharEntity::OnAttackError(CAttackState& state)
{
    auto controller {static_cast<CPlayerController*>(PAI->GetController())};
    if (controller->getLastErrMsgTime() + std::chrono::milliseconds(this->GetWeaponDelay(false)) < PAI->getTick())
    {
        controller->setLastErrMsgTime(PAI->getTick());
        return true;
    }
    return false;
}
