/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Velyn

===========================================================================
*/

#ifndef _CHATFILTER_H
#define _CHATFILTER_H

#include "../../common/cbasetypes.h"

class CBasicPacket;

class CBaseEntity;
class CCharEntity;

class CChatFilter
{
public:
    CChatFilter(const CBaseEntity* const _sender, CBasicPacket* packet);
    CChatFilter(const CBaseEntity* const _sender, uint64 _filterMask) : sender(_sender), filterMask(_filterMask) {}

    bool isFiltered(const CCharEntity* const entity) const;

private:
    const CBaseEntity* sender;
    uint64 filterMask;
};

#endif
