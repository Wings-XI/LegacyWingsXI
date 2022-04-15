/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Caelic

===========================================================================
*/

#ifndef _CDIGAREACONTAINER_H
#define _CDIGAREACONTAINER_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include "dig_object.h"

#include <map>
#include <memory>

class CCharEntity;
class CDigObject;

class CDigAreaContainer
{
public:
    CDigAreaContainer();
    bool IsInExhaustedArea(CCharEntity* PChar);
    void AddDigObject(CDigObject DigObject);
    void ExpireOldDigs(time_point tick);

private:
    CDigObject m_DigObject[1000]; // 27 bytes each, array memory impact 27kb
    uint16 m_DigObjectIteratorStart; // iterator to the first element, oldest dig
    uint16 m_DigObjectIteratorEnd; // iterator to just past the last element, most recently added dig

};

#endif
