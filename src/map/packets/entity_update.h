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

#ifndef _CENTITYUPDATEPACKET_H
#define _CENTITYUPDATEPACKET_H

#include "../../common/cbasetypes.h"
#include "../entities/baseentity.h"

#include "basic.h"

enum MODELTYPE
{
	MODEL_STANDARD	= 0,
	MODEL_EQUIPED	= 1,
	MODEL_DOOR		= 2,
	MODEL_ELEVATOR	= 3,
	MODEL_SHIP		= 4,
	MODEL_UNK_5		= 5,
	MODEL_AUTOMATON	= 6,    // все куклы входят в эту категорию. но помимо них есть еще и некоторые монстры
    MODEL_CHOCOBO   = 7
};

/************************************************************************
*																		*
*  																		*
*																		*
************************************************************************/

class CBaseEntity;

class CEntityUpdatePacket: public CBasicPacket
{
public:

	CEntityUpdatePacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask);

    uint32 getEntityId() const
    {
        return m_entityId;
    }

    uint16 getTargId() const
    {
        return m_targId;
    }

    ENTITYUPDATE getUpdateType() const
    {
        return m_updateType;
    }

    uint8 getUpdateMask() const
    {
        return m_updateMask;
    }

protected:
    uint32 m_entityId;
    uint16 m_targId;
    ENTITYUPDATE m_updateType;
    uint8 m_updateMask;
    ENTITYTYPE m_objType;
    uint16 m_lookSize;
    uint8 m_animation;
    uint8 m_animationSub;
    uint8 m_allegiance;
    uint8 m_nameSize;
    STATUSTYPE m_status;
};

#endif
