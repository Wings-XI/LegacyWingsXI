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

  This file is part of DarkStar-server source code.

===========================================================================
*/

// This file has been contributed courtesy of Setzor from Eden

#include "../../common/socket.h"

#include <string.h>

#include "help_desk.h"

#include "../entities/charentity.h"


CHelpDeskPacket::CHelpDeskPacket(CCharEntity * PChar, uint32 openCount)
{
    this->type = 0xB5;
    this->size = 0x10;

    ref<uint8>(0x10) = 0xC0;    // 192  - unknown
    ref<uint8>(0x11) = 0x01;    // 1    - unknown
    ref<uint8>(0x12) = 0x02;    // 2    - unknown

    ref<uint8>(0x14) = 0x80;    // separator ?
    ref<uint16>(0x15) = 0x0D;   // 13   - unknown
    ref<uint8>(0x17) = 0x80;    // separator ?

    ref<uint32>(0x18) = openCount; // number of times the help desk menu has been opened

    ref<uint16>(0x1E) = 0x0708; // 1800 - appears to be the default repositioning time
}