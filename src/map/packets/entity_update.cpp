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

#include "../../common/socket.h"
#include "../../common/utils.h"

#include <string.h>

#include "entity_update.h"

#include "../entities/baseentity.h"
#include "../entities/mobentity.h"
#include "../entities/trustentity.h"
#include "../entities/npcentity.h"
#include "../entities/petentity.h"
#include "../status_effect_container.h"

CEntityUpdatePacket::CEntityUpdatePacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask)
{
    this->type = 0x0E;
    this->size = 0x2C;
    m_entityId = PEntity->id;
    m_targId = PEntity->targid;
    m_updateType = type;
    m_updateMask = 0;

    ref<uint32>(0x04) = m_entityId;
    ref<uint16>(0x08) = m_targId;
    ref<uint8>(0x0A) = 0;

    merge(PEntity, type, updatemask);
}

void CEntityUpdatePacket::merge(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask)
{
    m_updateType = type;
    m_objType = PEntity->objtype;
    m_lookSize = PEntity->look.size;
    m_animation = PEntity->animation;
    m_animationSub = PEntity->animationsub;
    m_allegiance = PEntity->allegiance;
    m_status = PEntity->status;
    m_nameSize = PEntity->name.size();

    ref<uint8>(0x0A) |= updatemask;

    switch (type)
    {
        case ENTITY_DESPAWN:
        {
            ref<uint8>(0x0A) = 0x20;
            updatemask |= UPDATE_ALL_MOB;
        }
        break;
        case ENTITY_SPAWN:
        {
            updatemask |= UPDATE_ALL_MOB;
            if (PEntity->objtype == TYPE_PET)
            {
                ref<uint8>(0x28) = 0x04;
            }
            if (PEntity->objtype == TYPE_TRUST)
            {
                //  ref<uint8>(0x28) = 0x45;
            }
            if (PEntity->look.size == MODEL_EQUIPED || PEntity->look.size == MODEL_CHOCOBO)
            {
                updatemask |= 0x57;
            }
            if (PEntity->animationsub != 0)
                ref<uint8>(0x2A) = 4;
            ref<uint8>(0x0A) = updatemask;
        }
        break;
        default:
        {
            break;
        }
    }

    if (updatemask & UPDATE_POS) {
        ref<uint8>(0x0B)  = PEntity->loc.p.rotation;
        ref<float>(0x0C)  = PEntity->loc.p.x;
        ref<float>(0x10)  = PEntity->loc.p.y;
        ref<float>(0x14)  = PEntity->loc.p.z;
        ref<uint16>(0x18) = PEntity->loc.p.moving;
        ref<uint16>(0x1A) = PEntity->m_TargID << 1;
        ref<uint8>(0x1C)  = PEntity->speed;
        ref<uint8>(0x1D)  = PEntity->speedsub;
    }

    if (PEntity->allegiance == ALLEGIANCE_PLAYER && PEntity->status == STATUS_MOB)
        ref<uint8>(0x20) = STATUS_NORMAL;
    else
        ref<uint8>(0x20) = PEntity->status;

    switch (PEntity->objtype)
    {
        case TYPE_NPC:
        {
            if (updatemask & UPDATE_HP)
            {
                ref<uint8>(0x1E) = 0x64;
                ref<uint8>(0x1F) = PEntity->animation;
                ref<uint8>(0x2A) |= PEntity->animationsub;
                ref<uint32>(0x21) = ((CNpcEntity*)PEntity)->m_flags;
                ref<uint8>(0x27)  = ((CNpcEntity*)PEntity)->name_prefix; // gender and something else
                ref<uint8>(0x29) = PEntity->allegiance;
                ref<uint8>(0x2B)  = PEntity->namevis;
            }
        }
        break;
        case TYPE_MOB:
        case TYPE_PET:
        case TYPE_TRUST:
        {
            CMobEntity* PMob = (CMobEntity*)PEntity;
            {
                if (updatemask & UPDATE_HP)
                {
                    ref<uint8>(0x1E) = PMob->GetHPP();
                    ref<uint8>(0x1F) = PEntity->animation;
                    ref<uint8>(0x2A) |= PEntity->animationsub;
                    ref<uint32>(0x21) = PMob->m_flags;
                    ref<uint8>(0x25)  = PMob->health.hp > 0 ? 0x08 : 0;
                    ref<uint8>(0x27)  = PMob->m_name_prefix;
                    if (PMob->PMaster != nullptr && PMob->PMaster->objtype == TYPE_PC)
                        ref<uint8>(0x27) |= 0x08;
                    ref<uint8>(0x28) |= (PMob->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR) ? 0x10 : 0x00);
                    ref<uint8>(0x28) |= PMob->health.hp > 0 && PMob->animation == ANIMATION_DEATH ? 0x08 : 0;
                    ref<uint8>(0x29) = PEntity->allegiance;
                    ref<uint8>(0x2B) = PEntity->namevis;
                }
                if (updatemask & UPDATE_STATUS)
                {
                    ref<uint32>(0x2C) = PMob->m_OwnerID.id;
                }
            }
            if (updatemask & UPDATE_NAME)
            {
                // depending on size of name, this can be 0x20, 0x22, or 0x24
                this->size = 0x24;
                if (PMob->packetName.empty())
                    memcpy(data + (0x34), PEntity->GetName(), std::min<size_t>(PEntity->name.size(), PacketNameLength));
                else
                    memcpy(data + (0x34), PMob->packetName.c_str(), std::min<size_t>(PMob->packetName.size(), PacketNameLength));
                }
            }
        break;
        default:
        {
            break;
        }
    }

    // TODO: Read from the trust model itself
    if (PEntity->objtype == TYPE_TRUST)
    {
        // ref<uint32>(0x21) = 0x21b;
        // ref<uint8>(0x2B) = 0x06;
        // ref<uint8>(0x2A) = 0x08;
        // ref<uint8>(0x25) = 0x0f;
        // ref<uint8>(0x27) = 0x28;
        ref<uint8>(0x28) = 0x45;
    }

    switch (PEntity->look.size)
    {
        case MODEL_STANDARD:
        case MODEL_UNK_5:
        case MODEL_AUTOMATON:
        {
            ref<uint32>(0x30) = ::ref<uint32>(&PEntity->look, 0);
        }
        break;
        case MODEL_EQUIPED:
        case MODEL_CHOCOBO:
        {
            this->size = 0x24;

            memcpy(data + (0x30), &(PEntity->look), 20);
        }
        break;
        case MODEL_DOOR:
        case MODEL_ELEVATOR:
        case MODEL_SHIP:
        {
            this->size = 0x24;
            ref<uint16>(0x30) = PEntity->look.size;
            memcpy(data + (0x34), PEntity->GetName(), (PEntity->name.size() > 12 ? 12 : PEntity->name.size()));

            if (PEntity->animPath > 0)
            {
                this->size = 0x20;
                if (PEntity->animStart)
                {
                    ref<uint16>(0x18) = 0x8007;
                    ref<uint8>(0x1A) = PEntity->animStart ? 0x01 : 0;
                    ref<uint8>(0x1F) = PEntity->animation;
                    PEntity->animStart = false;
                }
                else
                {
                    std::chrono::milliseconds ms = std::chrono::duration_cast<std::chrono::milliseconds>(server_clock::now().time_since_epoch());
                    uint16 msCount = ms.count() % 1000;
                    uint32 msFrames = (uint32)std::round((msCount * 60) / 1000);
                    uint32 diff = CVanaTime::getInstance()->getVanaTime() - PEntity->animBegin;
                    uint32 frameCount = 0x8006 + (diff * 60) + msFrames;
                    ref<uint32>(0x18) = frameCount;
                }
                
                ref<uint32>(0x34) = PEntity->animPath;
                uint32 timestamp = ((CNpcEntity*)PEntity)->animBegin;
                ref<uint32>(0x38) = timestamp;
            }
        }
        break;
    }
}

void CEntityUpdatePacket::merge(CEntityUpdatePacket* other)
{
    m_updateType = other->m_updateType;
    uint8 newMask = other->m_updateMask;
    ref<uint8>(0x0A) |= newMask;
    m_objType = other->m_objType;
    m_lookSize = other->m_lookSize;
    m_animation = other->m_animation;
    m_animationSub = other->m_animationSub;
    // Set later
    // m_allegiance = other->m_allegiance;
    // m_status = other->m_status;
    m_nameSize = other->m_nameSize;

    switch (type)
    {
        case ENTITY_DESPAWN:
        {
            ref<uint8>(0x0A) = 0x20;
            newMask |= UPDATE_ALL_MOB;
        }
        break;
        case ENTITY_SPAWN:
        {
            newMask |= UPDATE_ALL_MOB;
            if (m_objType == TYPE_PET)
            {
                ref<uint8>(0x28) = 0x04;
            }
            if (m_objType == TYPE_TRUST)
            {
                //  ref<uint8>(0x28) = 0x45;
            }
            if (m_lookSize == MODEL_EQUIPED || m_lookSize == MODEL_CHOCOBO)
            {
                newMask |= 0x57;
            }
            if (m_animationSub != 0)
                ref<uint8>(0x2A) = 4;
            ref<uint8>(0x0A) = newMask;
        }
        break;
        default:
        {
            break;
        }
    }

    if (newMask & UPDATE_POS)
    {
        ref<uint8>(0x0B) = other->ref<uint8>(0x0B);
        ref<float>(0x0C) = other->ref<float>(0x0C);
        ref<float>(0x10) = other->ref<float>(0x10);
        ref<float>(0x14) = other->ref<float>(0x14);
        ref<uint16>(0x18) = other->ref<uint16>(0x18);
        ref<uint16>(0x1A) = other->ref<uint16>(0x1A);
        ref<uint8>(0x1C) = other->ref<uint8>(0x1C);
        ref<uint8>(0x1D) = other->ref<uint8>(0x1D);
    }

    m_allegiance = other->m_allegiance;
    if (m_allegiance == ALLEGIANCE_PLAYER && other->m_status == STATUS_MOB)
    {
        m_status = STATUS_NORMAL;
    }
    else
    {
        m_status = other->m_status;
    }
    ref<uint8>(0x20) = m_status;

    switch (m_objType)
    {
        case TYPE_NPC:
        {
            if (newMask & UPDATE_HP)
            {
                ref<uint8>(0x1E) = 0x64;
                ref<uint8>(0x1F) = other->ref<uint8>(0x1F);
                ref<uint8>(0x2A) |= other->ref<uint8>(0x2A);
                ref<uint32>(0x21) = other->ref<uint32>(0x21);
                ref<uint8>(0x27) = other->ref<uint8>(0x27);
                ref<uint8>(0x29) = other->ref<uint8>(0x29);
                ref<uint8>(0x2B) = other->ref<uint8>(0x2B);
            }
        }
        break;
        case TYPE_MOB:
        case TYPE_PET:
        case TYPE_TRUST:
        {
            {
                if (newMask & UPDATE_HP)
                {
                    ref<uint8>(0x1E) = other->ref<uint8>(0x1E);
                    ref<uint8>(0x1F) = other->ref<uint8>(0x1F);
                    ref<uint8>(0x2A) |= other->ref<uint8>(0x2A);
                    ref<uint32>(0x21) = other->ref<uint32>(0x21);
                    ref<uint8>(0x25) = other->ref<uint8>(0x25);
                    ref<uint8>(0x27) = other->ref<uint8>(0x27);
                    ref<uint8>(0x28) |= other->ref<uint8>(0x28);
                    ref<uint8>(0x29) = other->ref<uint8>(0x29);
                    ref<uint8>(0x2B) = other->ref<uint8>(0x2B);
                }
                if (newMask & UPDATE_STATUS)
                {
                    ref<uint32>(0x2C) = other->ref<uint32>(0x2C);
                }
            }
            if (newMask & UPDATE_NAME)
            {
                // depending on size of name, this can be 0x20, 0x22, or 0x24
                this->size = 0x24;
                memcpy(data + (0x34), other->data + (0x34), PacketNameLength);
            }
        }
        break;
        default:
        {
            break;
        }
    }

    // TODO: Read from the trust model itself
    if (m_objType == TYPE_TRUST)
    {
        // ref<uint32>(0x21) = 0x21b;
        // ref<uint8>(0x2B) = 0x06;
        // ref<uint8>(0x2A) = 0x08;
        // ref<uint8>(0x25) = 0x0f;
        // ref<uint8>(0x27) = 0x28;
        ref<uint8>(0x28) = 0x45;
    }

    switch (m_lookSize)
    {
        case MODEL_STANDARD:
        case MODEL_UNK_5:
        case MODEL_AUTOMATON:
        {
            ref<uint32>(0x30) = other->ref<uint32>(0x30);
        }
        break;
        case MODEL_EQUIPED:
        case MODEL_CHOCOBO:
        {
            this->size = 0x24;

            memcpy(data + (0x30), other->data + (0x30), 20);
        }
        break;
        case MODEL_DOOR:
        case MODEL_ELEVATOR:
        case MODEL_SHIP:
        {
            this->size = 0x24;

            ref<uint16>(0x30) = other->ref<uint32>(0x30);
            memcpy(data + (0x34), other->data + (0x34), m_nameSize > 12 ? 12 : m_nameSize);

            if (other->ref<uint32>(0x34) > 0)
            {
                this->size = 0x20;
                if (other->ref<uint8>(0x1A))
                {
                    ref<uint16>(0x18) = 0x8007;
                    ref<uint8>(0x1A) = other->ref<uint8>(0x1A) ? 0x01 : 0;
                    ref<uint8>(0x1F) = other->ref<uint8>(0x1F);
                }
                else
                {
                    ref<uint32>(0x18) = other->ref<uint32>(0x18);
                }

                ref<uint32>(0x34) = other->ref<uint32>(0x34);
                ref<uint32>(0x38) = other->ref<uint32>(0x38);
            }
        }
        break;
    }
}
