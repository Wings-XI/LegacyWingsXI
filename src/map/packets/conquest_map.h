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

#ifndef _CCONQUESTPACKET_H
#define _CCONQUESTPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"
#include <vector>
#include <time.h>

/************************************************************************
*																		*
*  																		*
*																		*
************************************************************************/

class CCharEntity;

class CConquestPacket : public CBasicPacket
{
public:

	CConquestPacket(CCharEntity* PChar);

    // Forces a reload of the packet data from DB
    static void CMFlushCache();

private:

    // Cached data, avoid resource intensive DB queries each time
    // this packet is constructed.
    static std::vector<std::vector<int64>> m_CMCachedData;
    static uint8 m_SadoriaRegions;
    static uint8 m_BastokRegions;
    static uint8 m_WindurstRegions;
    static uint8 m_SadoriaPrev;
    static uint8 m_BastokPrev;
    static uint8 m_WindurstPrev;
    static uint8 m_Balance;
    static uint8 m_Alliance;
    static uint8 m_NextTally;
    static uint8 m_IsCalculating;
    // Time to refresh cache from DB
    static time_t m_CMCacheExpires;
};

#endif
