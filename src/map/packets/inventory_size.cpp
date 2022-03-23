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

#include "../utils/charutils.h"
#include "inventory_size.h"
#include "../entities/charentity.h"
#include "../item_container.h"

/************************************************************************
*																		*
*  Отсутствие значения в 0x1C управляет доступом к MOGLOCKER.			*
*  По сюжету он заблокирован до выполнения соответствующей задачи		*
*																		*
************************************************************************/

CInventorySizePacket::CInventorySizePacket(CCharEntity* PChar)
{
    this->type = 0x1C;
    this->size = 0x1A;

    GetSizeAndBuff(PChar, LOC_INVENTORY, 0x04, 0x14);
    GetSizeAndBuff(PChar, LOC_MOGSAFE, 0x05, 0x16);
    GetSizeAndBuff(PChar, LOC_STORAGE, 0x06, 0x18);
    if (!PChar->hasAccessToStorage(LOC_STORAGE)) {
        // Block access from room rentals
        ref<uint16>(0x18) = 0x00;
    }
    GetSizeAndBuff(PChar, LOC_TEMPITEMS, 0x07, 0x1A);
    GetSizeAndBuff(PChar, LOC_MOGLOCKER, 0x08, 0x1C);
    if (!charutils::hasMogLockerAccess(PChar)) {
        // Mog locker lease expired
        ref<uint16>(0x1C) = 0x00;
    }
    GetSizeAndBuff(PChar, LOC_MOGSATCHEL, 0x09, 0x1E);
    if (!PChar->hasAccessToStorage(LOC_MOGSATCHEL)) {
        // Has no mog satchel access (greyed out)
        ref<uint8>(0x09) = 0x00;
        ref<uint16>(0x1E) = 0x00;
    }
    GetSizeAndBuff(PChar, LOC_MOGSACK, 0x0A, 0x20);
    GetSizeAndBuff(PChar, LOC_MOGCASE, 0x0B, 0x22);
    GetSizeAndBuff(PChar, LOC_WARDROBE, 0x0C, 0x24);
    GetSizeAndBuff(PChar, LOC_MOGSAFE2, 0x0D, 0x26);
    GetSizeAndBuff(PChar, LOC_WARDROBE2, 0x0E, 0x28);
    GetSizeAndBuff(PChar, LOC_WARDROBE3, 0x0F, 0x2A);
    if (!PChar->hasAccessToStorage(LOC_WARDROBE3)) {
        // Has no wardrobe 3 access (can still view)
        ref<uint16>(0x2A) = 0x00;
    }
    GetSizeAndBuff(PChar, LOC_WARDROBE4, 0x10, 0x2C);
    if (!PChar->hasAccessToStorage(LOC_WARDROBE4)) {
        // Has no wardrobe 4 access (can still view)
        ref<uint16>(0x2C) = 0x00;
    }

    if (PChar->m_moghouseID && PChar->m_moghouseID != PChar->id) {
        // Block access to mog safe / safe 2 when
        // in other people's open mog
        //ref<uint8>(0x05) = 0;
        ref<uint16>(0x16) = 0;
        //ref<uint8>(0x0D) = 0;
        ref<uint16>(0x26) = 0;
    }

    /*
    ref<uint8>(0x04) = 1 + PChar->getStorage(LOC_INVENTORY)->GetSize();
    ref<uint8>(0x05) = 1 + PChar->getStorage(LOC_MOGSAFE)->GetSize();
    ref<uint8>(0x06) = 1 + PChar->getStorage(LOC_STORAGE)->GetSize();
    ref<uint8>(0x07) = 1 + PChar->getStorage(LOC_TEMPITEMS)->GetSize();
    ref<uint8>(0x08) = 1 + PChar->getStorage(LOC_MOGLOCKER)->GetSize();
    ref<uint8>(0x09) = 1 + PChar->getStorage(LOC_MOGSATCHEL)->GetSize();
    ref<uint8>(0x0A) = 1 + PChar->getStorage(LOC_MOGSACK)->GetSize();
    ref<uint8>(0x0B) = 1 + PChar->getStorage(LOC_MOGCASE)->GetSize();
    ref<uint8>(0x0C) = 1 + PChar->getStorage(LOC_WARDROBE)->GetSize();
    ref<uint8>(0x0D) = 1 + PChar->getStorage(LOC_MOGSAFE2)->GetSize();
    ref<uint8>(0x0E) = 1 + PChar->getStorage(LOC_WARDROBE2)->GetSize();
    ref<uint8>(0x0F) = 1 + PChar->getStorage(LOC_WARDROBE3)->GetSize();
    ref<uint8>(0x10) = 1 + PChar->getStorage(LOC_WARDROBE4)->GetSize();

    ref<uint16>(0x14) = 1 + PChar->getStorage(LOC_INVENTORY)->GetBuff();
    ref<uint16>(0x16) = 1 + PChar->getStorage(LOC_MOGSAFE)->GetBuff();
    ref<uint16>(0x18) = 1 + PChar->getStorage(LOC_STORAGE)->GetBuff();
    ref<uint16>(0x1A) = 1 + PChar->getStorage(LOC_TEMPITEMS)->GetBuff();
    if (charutils::hasMogLockerAccess(PChar))
        ref<uint16>(0x1C) = 1 + PChar->getStorage(LOC_MOGLOCKER)->GetBuff();
    else
        ref<uint16>(0x1C) = 0x00;

    ref<uint16>(0x1E) = 1 + PChar->getStorage(LOC_MOGSATCHEL)->GetBuff();
    ref<uint16>(0x20) = 1 + PChar->getStorage(LOC_MOGSACK)->GetBuff();
    ref<uint16>(0x22) = 1 + PChar->getStorage(LOC_MOGCASE)->GetBuff();
    ref<uint16>(0x24) = 1 + PChar->getStorage(LOC_WARDROBE)->GetBuff();
    ref<uint16>(0x26) = 1 + PChar->getStorage(LOC_MOGSAFE2)->GetBuff();
    ref<uint16>(0x28) = 1 + PChar->getStorage(LOC_WARDROBE2)->GetBuff();
    ref<uint16>(0x2A) = 1 + PChar->getStorage(LOC_WARDROBE3)->GetBuff();
    ref<uint16>(0x2C) = 1 + PChar->getStorage(LOC_WARDROBE4)->GetBuff();
    */
}

void CInventorySizePacket::ClientVerFixup(const CCharEntity* PChar)
{
    if (PChar->m_needInventoryFix) {
        this->size = 0x32;
        // Buff location changed
        memmove(this->data + 0x24, this->data + 0x14, 26);
        // Disable the currently unsupported storage locations
        memset(this->data + 0x3E, 0, 10);
        memset(this->data + 0x11, 0, 19);
    }
}

void CInventorySizePacket::GetSizeAndBuff(CCharEntity* PChar, uint8 location, uint8 sizeOffset, uint8 buffOffset)
{
    uint8 storageSize = PChar->getStorage(location)->GetSize();
    uint16* outBuff = reinterpret_cast<uint16*>(data + buffOffset);
    if (storageSize > 0) {
        *outBuff = 1 + PChar->getStorage(location)->GetBuff();
        *(data + sizeOffset) = 1 + storageSize;
    }
    else {
        *outBuff = 0x00;
        *(data + sizeOffset) = 0x00;
    }
}
