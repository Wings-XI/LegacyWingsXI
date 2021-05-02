/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under AGPLv3, see LICENSE file.
  
  Author: Caelic

===========================================================================
*/

#ifndef _CDYNAMISHANDLER_H
#define _CDYNAMISHANDLER_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include <map>
#include <memory>
#include <vector>

class CBattlefield;
class CCharEntity;
class CBaseEntity;
class CMobEntity;
class CZone;

class CDynamisHandler
{
public:
    CDynamisHandler(CZone* PZone);

    void HandleDynamis(time_point tick);                      // called every server tick
    bool LoadDynamis(CCharEntity* PChar, uint32 token, uint32 originalRegistrant); // load a new dynamis instance
    void ExpireDynamis();                                     // time just expired, do expiration routine
    void CleanupDynamis();                                    // cleanup instance that is finished
    void ClearPlayerRegistry();
    void EjectAllPlayers(bool immediate = false);
    
    bool IsRegistered(CCharEntity* PChar);
    bool RegisterPlayer(CCharEntity* PChar);                  // returns false if dynamis registry is full (64 players)
    bool EjectPlayer(CCharEntity* PChar, bool immediate = false);

    CZone* m_PZone;
    uint32 m_expiryTimePoint; // in seconds
    uint32 m_token;
    uint32 m_originalRegistrantID;
    bool m_currencyAutoDistribute;
    bool m_given10MinWarning;
    bool m_given3MinWarning;
    bool m_expirationRoutine;
    CCharEntity* m_registeredPlayers[64];
};

#endif
