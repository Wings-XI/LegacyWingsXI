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
#include "../../common/timer.h"

#include <string.h>

#include "../ability.h"
#include "../entities/charentity.h"

#include "char_recast.h"
#include "../recast_container.h"


CCharRecastPacket::CCharRecastPacket(CCharEntity* PChar)
{
    this->type = 0x19;
    this->size = 0x83;

    uint8 count = 0;

    RecastList_t* RecastList = PChar->PRecastContainer->GetRecastList(RECAST_ABILITY);

    for (auto&& recast : *RecastList)
    {
        uint32 recasttime = (recast.RecastTime == 0 ? 0 : ((recast.RecastTime - (uint32)(time(0) - recast.TimeStamp))));

        if (recast.ID == 256) // borrowing this id for mount recast
        {
            ref<uint32>(0xFC) = recasttime;
            ref<uint16>(0xFE) = recast.ID;
        }
        else if (recast.ID != 0)
        {
            ref<uint32>(0x0C + count * 8) = recasttime;
            ref<uint8>(0x0F + count * 8) = (uint8)recast.ID;
            if (recast.chargeTime != 0)
            {
                auto charge = ability::GetCharge(PChar, recast.ID);
                if (charge)
                {
                    int8 chargeReduction = charge->chargeTime - recast.chargeTime; // Seconds the client should remove from the recharge timer

                    // Ready recast is 60 seconds in era so lower the reduction by 30 seconds
                    if (recast.ID == 102)
                    {
                        chargeReduction -= 30; // Adds 30 seconds to recharge timer
                    }

                    if (chargeReduction <= 0) // Timer should be higher than client thinks
                    {
                        ref<uint8>(0x10 + count * 8) = abs(chargeReduction) * charge->maxCharges;
                    }
                    else
                    {
                        ref<uint8>(0x10 + count * 8) = 256 - chargeReduction * charge->maxCharges;
                        ref<uint8>(0x11 + count * 8) = 255; // Denotes previous value is a reduction in time
                    }
                }
            }
            count++;
        }
        else
        {
            ref<uint32>(0x04) = recasttime;  // 2h ability (recast id is 0)
        }
    }
}
