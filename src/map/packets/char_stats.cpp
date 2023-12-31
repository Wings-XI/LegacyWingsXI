﻿/*
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

#include "char_stats.h"

#include "../entities/charentity.h"
#include "../utils/charutils.h"
#include "../modifier.h"


CCharStatsPacket::CCharStatsPacket(CCharEntity * PChar)
{
	this->type = 0x61;
    // Note: Appears to have changed to 0x70 on the November 2021
    // update due to master levels. Keeping the old value for the
    // time being since it doesn't seem to break anything but if
    // new clients start crashing this may need to be changed.
	this->size = 0x30;

    ref<uint32>(0x04) = PChar->GetMaxHP();
    ref<uint32>(0x08) = PChar->GetMaxMP();

	ref<uint8>(0x0C) = PChar->GetMJob();
	ref<uint8>(0x0D) = PChar->GetMLevel();
	ref<uint8>(0x0E) = PChar->GetSJob();
	ref<uint8>(0x0F) = PChar->GetSLevel();

	ref<uint16>(0x10) = PChar->jobs.exp[PChar->GetMJob()];
	ref<uint16>(0x12) = charutils::GetExpNEXTLevel(PChar->jobs.job[PChar->GetMJob()]);

	memcpy(data+(0x14), &PChar->stats, 14); // TODO: с merits это не прокатит

	ref<uint16>(0x22) = std::clamp<int16>(PChar->getMod(Mod::STR), -999 + PChar->stats.STR, 999 - PChar->stats.STR);
	ref<uint16>(0x24) = std::clamp<int16>(PChar->getMod(Mod::DEX), -999 + PChar->stats.DEX, 999 - PChar->stats.DEX);
	ref<uint16>(0x26) = std::clamp<int16>(PChar->getMod(Mod::VIT), -999 + PChar->stats.VIT, 999 - PChar->stats.VIT);
	ref<uint16>(0x28) = std::clamp<int16>(PChar->getMod(Mod::AGI), -999 + PChar->stats.AGI, 999 - PChar->stats.AGI);
	ref<uint16>(0x2A) = std::clamp<int16>(PChar->getMod(Mod::INT), -999 + PChar->stats.INT, 999 - PChar->stats.INT);
	ref<uint16>(0x2C) = std::clamp<int16>(PChar->getMod(Mod::MND), -999 + PChar->stats.MND, 999 - PChar->stats.MND);
	ref<uint16>(0x2E) = std::clamp<int16>(PChar->getMod(Mod::CHR), -999 + PChar->stats.CHR, 999 - PChar->stats.CHR);

    ref<uint16>(0x30) = PChar->ATT();
	ref<uint16>(0x32) = PChar->DEF();

	ref<uint16>(0x34) = PChar->getMod(Mod::FIRERES);
	ref<uint16>(0x36) = PChar->getMod(Mod::ICERES);
	ref<uint16>(0x38) = PChar->getMod(Mod::WINDRES);
	ref<uint16>(0x3A) = PChar->getMod(Mod::EARTHRES);
	ref<uint16>(0x3C) = PChar->getMod(Mod::THUNDERRES);
	ref<uint16>(0x3E) = PChar->getMod(Mod::WATERRES);
	ref<uint16>(0x40) = PChar->getMod(Mod::LIGHTRES);
	ref<uint16>(0x42) = PChar->getMod(Mod::DARKRES);

	ref<uint16>(0x44) = PChar->profile.title;
	ref<uint8>(0x46) = PChar->profile.rank[PChar->profile.nation];
	ref<uint16>(0x48) = PChar->profile.rankpoints;
    ref<uint16>(0x4A) = PChar->profile.home_point.destination;
	ref<uint8>(0x50) = PChar->profile.nation;

    //0x51 = 0x51 = 0x01 on fresh player, 0x03 with unity unlocked
    //0x52 = superior level (1 or 2)
    //0x54 = maximum item level
    //0x55 = itemlevel over 99
    //0x56 = main weapon item level
    //0x57 = item level of ranged

    // unity_accolades
    // ref<uint32>(0x58) = (50000 << 10) | (0x00 << 5 | 0x04);

    // Unity Points definition:
    // Bytes 58~5B, 58 most significant nibble is least sig for Points
    // 58: Unity Leader << 1 & least sig nibble

    //ref<uint8>(0x59) = 0xA0; // Bits 2-16 Unity Points
    //ref<uint8>(0x5A) = 0x0F;
    //ref<uint8>(0x5B) = 0x01;

    // ref<uint16>(0x5C) = 21; // Partial Personal Eval (current_accolades)
    // ref<uint16>(0x5E) = 42; // Personal Eval (prev_accolades)

    //0x65: master level
    //0x66: bitflags, bit 0 = master breaker
    //0x68: current exemplar points
    //0x6C: required exemplar points
}
