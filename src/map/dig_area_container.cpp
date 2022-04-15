/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Caelic

===========================================================================
*/

#include <algorithm>

#include "../common/utils.h"
#include "dig_area_container.h"
#include "entities/charentity.h"

CDigAreaContainer::CDigAreaContainer()
{
    uint16 i = 0;
    time_point now = std::chrono::system_clock::now();
    while (i < 1000)
    {
        m_DigObject[i] = CDigObject(0, 0, 0, now, 0);
        i++;
    }
    m_DigObjectIteratorStart = 0;
    m_DigObjectIteratorEnd = 0;
}

bool CDigAreaContainer::IsInExhaustedArea(CCharEntity* PChar)
{
    uint16 i = m_DigObjectIteratorStart;
    time_point now = std::chrono::system_clock::now();

    while (i != m_DigObjectIteratorEnd)
    {
        if ((PChar->id == m_DigObject[i].m_ownerID || now - m_DigObject[i].m_timestamp < 30s) &&
            distanceSquared(PChar->loc.p, m_DigObject[i].m_pos) < 5 * 5)
            return true;
        i = i == 999 ? 0 : i + 1;
    }

    return false;
}

void CDigAreaContainer::AddDigObject(CDigObject DigObject)
{
    m_DigObject[m_DigObjectIteratorEnd] = DigObject;

    m_DigObjectIteratorEnd = m_DigObjectIteratorEnd == 999 ? 0 : m_DigObjectIteratorEnd + 1;
    if (m_DigObjectIteratorEnd == m_DigObjectIteratorStart)
    { // my head bumped into my tail. oldest dig is being allocated as free now.
        m_DigObjectIteratorStart = m_DigObjectIteratorStart == 999 ? 0 : m_DigObjectIteratorStart + 1;
    }
}

void CDigAreaContainer::ExpireOldDigs(time_point tick)
{
    while (m_DigObjectIteratorStart != m_DigObjectIteratorEnd && m_DigObject[m_DigObjectIteratorStart].m_timestamp + 15min < tick)
    {
        m_DigObjectIteratorStart = m_DigObjectIteratorStart == 999 ? 0 : m_DigObjectIteratorStart + 1;
    }
    //ShowDebug("ExpireOldDigs, new iStart = %u, new iEnd = %u\n",m_DigObjectIteratorStart, m_DigObjectIteratorEnd);
}
