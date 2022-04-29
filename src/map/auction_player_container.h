/*
===========================================================================

this entire document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
Author: Caelic

===========================================================================
*/

#ifndef _AUCTIONPLAYERCONTAINER_H
#define _AUCTIONPLAYERCONTAINER_H

#include "../common/cbasetypes.h"

#include <vector>

class CCharEntity;

struct AuctionHistory_t
{
    uint16 itemid;
    uint8 stack;
    uint32 price;
    uint8 status; // e.g. if sold/not sold/on market
    bool delisted;
};

class CAuctionPlayerContainer
{
public:
    CAuctionPlayerContainer(CCharEntity* PChar);
    virtual ~CAuctionPlayerContainer()
    {
    }
    void reset();

    CCharEntity* m_PChar;
    uint32 m_AHHistoryTimestamp;
    std::vector<AuctionHistory_t> m_ah_history;
    uint16 m_page;
    uint16 m_maxPage;
    bool isPageResetQueued; // go back to page 1 next time sales history is looked at

};

#endif