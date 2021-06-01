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

#include "message_text.h"
#include "../entities/baseentity.h"
#include "../entities/charentity.h"


CMessageTextPacket::CMessageTextPacket(CBaseEntity* PEntity, uint16 messageID, bool showName, uint8 mode)
{
	this->type = 0x36;
	this->size = 0x08;

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

    // if a character is passed as an object,
    // then we will not display the name
    // (Google translated from Russian)
    if (PEntity->objtype == TYPE_PC || showName == false)
	{
		messageID += 0x8000;
	}

	ref<uint32>(0x04) = sender_id;
	ref<uint16>(0x08) = targ_id;
	ref<uint16>(0x0A) = messageID;
    ref<uint8>(0x0C) = mode;
}
