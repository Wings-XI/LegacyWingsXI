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
#include "../entities/charentity.h"

#include "inventory_finish.h"


CInventoryFinishPacket::CInventoryFinishPacket()
{
    this->type = 0x1D;
    this->size = 0x04;

    ref<uint8>(0x04) = 1; // "Finished" flag
}

CInventoryFinishPacket::CInventoryFinishPacket(CONTAINER_ID id)
{
    // Only used in newer clients (February 2022 or later)

	this->type = 0x1D;
	this->size = 0x06;

    ref<uint8>(0x04) = 0; // "Finished" flag
    ref<uint8>(0x05) = id;
}

void CInventoryFinishPacket::ClientVerFixup(const CCharEntity* PChar)
{
    if (PChar->m_needInventoryFix) {
        // Only applies to ending packet.
        if (ref<uint8>(0x04) != 0) {
            this->size = 0x06;
            ref<uint8>(0x05) = MAX_CONTAINER_ID;
            // We have absolutely no clue what the following bytes
            // mean, we just know it completely breaks if they're
            // missing.
            ref<uint8>(0x06) = 0x00;
            ref<uint8>(0x07) = 0x00;
            ref<uint8>(0x08) = 0xFF;
            ref<uint8>(0x09) = 0xFF;
            ref<uint8>(0x0A) = 0x03;
            ref<uint8>(0x0B) = 0x00;
        }
    }
}
