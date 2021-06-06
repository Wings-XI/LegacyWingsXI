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

#include "message_special.h"

#include "../entities/baseentity.h"
#include "../entities/charentity.h"


CMessageSpecialPacket::CMessageSpecialPacket(
	CBaseEntity* PEntity,
	uint16 messageID,
	uint32 param0,
	uint32 param1,
	uint32 param2,
	uint32 param3,
	bool ShowName)
{
	this->type = 0x2A;
	this->size = 0x10;

	//TPZ_DEBUG_BREAK_IF(PEntity == nullptr);

    // Packet should include the ID of the sender.
    // Unfortunately without a major refactor we can only know that
    // if the player is in an event.
    uint32 sender_id = PEntity->id;
    uint32 targ_id = PEntity->targid;
    if (PEntity->objtype == TYPE_PC) {
        CCharEntity* PChar = (CCharEntity*)PEntity;
        if (PChar->m_event.Target) {
            sender_id = PChar->m_event.Target->id;
            targ_id = PChar->m_event.Target->targid;
        }
    }

	ref<uint32>(0x04) = sender_id;

	ref<uint32>(0x08) = param0;
	ref<uint32>(0x0C) = param1;
	ref<uint32>(0x10) = param2;
	ref<uint32>(0x14) = param3;

	ref<uint16>(0x18) = targ_id;

	if (ShowName)
	{
		this->size = 0x18;

		memcpy(data+(0x1E), PEntity->GetName(), std::min<size_t>(PEntity->name.size(), PacketNameLength));
	}
	else if (PEntity->objtype == TYPE_PC)
	{
		messageID += 0x8000;
	}

	ref<uint16>(0x1A) = messageID;
}
