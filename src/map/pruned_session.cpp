/*
===========================================================================

this document is 100% original code written for the Wings FFXI server project
(C) 2020-2021 Wings Project. Licensed under GPLv3 as far as permitted by law.
Usage allowed only in open-source servers.

===========================================================================
*/

#include "pruned_session.h"
#include <cstring>

pruned_session::pruned_session(uint32 accid, uint32 charid, uint32* session_key, uint32 ZoneIP, uint16 ZonePort, uint32 client_addr, uint8 version_mismatch, char client_version[CLIENT_VERSION_SIZE])
{
    m_0_accid = accid;
    m_1_charid = charid;
    memcpy(m_2_session_key, session_key, sizeof(uint32)*5);
    m_3_ZoneIP = ZoneIP;
    m_4_ZonePort = ZonePort;
    m_5_client_addr = client_addr;
    m_6_version_mismatch = version_mismatch;
    memcpy(m_7_client_version, client_version, CLIENT_VERSION_SIZE);

    m_recoveryQueued = false;
}

pruned_session::~pruned_session()
{

}
