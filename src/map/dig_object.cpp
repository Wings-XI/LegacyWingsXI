/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Caelic

===========================================================================
*/

#include <algorithm>

#include "dig_object.h"

CDigObject::CDigObject()
{
    m_pos.x = 0;
    m_pos.y = 0;
    m_pos.z = 0;
    m_timestamp = std::chrono::system_clock::now();
    m_ownerID = 0;
}

CDigObject::CDigObject(float x, float y, float z, time_point timestamp, uint16 ownerID)
{
    m_pos.x = x;
    m_pos.y = y;
    m_pos.z = z;
    m_timestamp = timestamp;
    m_ownerID = ownerID;
}
