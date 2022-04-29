/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Caelic

===========================================================================
*/

#ifndef _CDIGOBJECT_H
#define _CDIGOBJECT_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include <map>
#include <memory>

class CDigObject
{
public:
    CDigObject();
    CDigObject(float x, float y, float z, time_point timestamp, uint16 ownerID);
    position_t m_pos;
    time_point m_timestamp;
    uint16 m_ownerID;
};

#endif
