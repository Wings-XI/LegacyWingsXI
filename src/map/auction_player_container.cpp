/*
===========================================================================

this entire document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.
Author: Caelic

===========================================================================
*/

#include "auction_player_container.h"

CAuctionPlayerContainer::CAuctionPlayerContainer(CCharEntity* PChar)
{
    m_PChar = PChar;
    m_AHHistoryTimestamp = 0;
    reset();
}

void CAuctionPlayerContainer::reset()
{
    m_ah_history.clear();
    m_maxPage = 0;
    m_page = 1;
}
