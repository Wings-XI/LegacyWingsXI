/*
===========================================================================

  Copyright (c) 2021 Wings Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Twilight

===========================================================================
*/

#ifndef _CCHARJUMPPACKET_H
#define _CCHARJUMPPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

class CCharEntity;

class CCharJumpPacket : public CBasicPacket
{
public:
    CCharJumpPacket(CCharEntity* PChar, uint32 extra);
};

#endif
