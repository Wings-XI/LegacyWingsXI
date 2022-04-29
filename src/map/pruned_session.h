/*
===========================================================================

this document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.

===========================================================================
*/

#ifndef _PRUNED_SESSION_H
#define _PRUNED_SESSION_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#define CLIENT_VERSION_SIZE 32

class pruned_session
{
public:
    pruned_session(uint32 accid, uint32 charid, uint32* session_key, uint32 ZoneIP, uint16 ZonePort, uint32 client_addr, uint8 version_mismatch, char client_version[CLIENT_VERSION_SIZE]);
    ~pruned_session();

    uint32 m_0_accid                = 0;
    uint32 m_1_charid               = 0;
    uint32 m_2_session_key[5]       = { 0 };
    uint32 m_3_ZoneIP               = 0;
    uint16 m_4_ZonePort             = 0;
    uint32 m_5_client_addr          = 0;
    uint8  m_6_version_mismatch     = 0;
    char   m_7_client_version[CLIENT_VERSION_SIZE] = { 0 };

    bool   m_recoveryQueued         = false;
};

#endif
