/*
===========================================================================

  Copyright (c) 2021 Wings Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Twilight

===========================================================================
*/

#include "char_jump.h"
#include "../entities/charentity.h"
#include "../item_container.h"
#include "../items/item_weapon.h"

CCharJumpPacket::CCharJumpPacket(CCharEntity* PChar, uint32 extra)
{
    this->id(0x11E);
    this->length(8);

    ref<uint32>(0x04) = extra;
}
