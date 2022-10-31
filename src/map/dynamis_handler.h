/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Caelic, Twilight

===========================================================================
*/

#ifndef _CDYNAMISHANDLER_H
#define _CDYNAMISHANDLER_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include <map>
#include <memory>
#include <vector>

// Arbitrary but must be unique
#define RPC_DYNAMIS_BASE_INDEX  0x500

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
    bool LoadDynamis(uint32 charid, uint32 token, uint32 originalRegistrant); // load a new dynamis instance
    uint32 AddTimeToDynamis(int16 minutes);
    void ExpireDynamis();                                     // time just expired, do expiration routine
    void CleanupDynamis();                                    // cleanup instance that is finished
    void ClearPlayerRegistry();
    void EjectAllPlayers(bool immediate = false);
    void ClearLootPool();

    bool IsRegistered(uint32 charid);
    bool RegisterPlayer(uint32 charid);                  // returns false if dynamis registry is full (64 players)
    bool EjectPlayer(CCharEntity* PChar, bool immediate = false);

    /**
     *  Get the expiry timepoint of a dynamis zone
     *  @param zone Targt zone ID
     *  @return Expiry timepoint of zero if not found / error
     */
    static uint32 DynamisGetExpiryTimepoint(uint16 zone);

    /**
    *  Get the expiry timepoint of the current dynamis zone
    *  @return Expiry timepoint of zero if not found / error
    */
    uint32 DynamisGetExpiryTimepoint() const;

    /**
     *  Set the token of the current dynamis zone
     *  @param token new token
     */
    void DynamisSetToken(uint32 token);

    /**
    *  Get the token of a dynamis zone
    *  @param zone Targt zone ID
    *  @return Token or zero if none found
    */
    static uint32 DynamisGetToken(uint16 zone);

    /**
    *  Get the token of the current dynamis zone
    *  @return Token or zero if none found
    */
    uint32 DynamisGetToken() const;

    /**
    *  Get the zone ID of this Dynamis instance
    *  @return Zone ID
    */
    uint16 DynamisGetZoneID() const;

    /**
     *  Get the zone object of this Dynamis instance
     *  @return Zone object
     */
    CZone* DynamisGetZone();

    /**
    *  Set the expiry timepoint of the current dynamis zone
    *  @param tp New timepoint
    */
    void DynamisSetExpiryTimepoint(uint32 tp);

    int32 DynamisHandleNewPlayer(uint32 charid, bool canLoadNewDynamis);

    bool DynamisIsExpiring() const;

    uint32 DynamisGetOriginalRegistrant() const;

    bool DynamisGetCurrencyAutoDistribute() const;

    void DynamisSetCurrencyAutoDistribute(bool val);

    /**
     *  Main RPC callback of the Dynamis handler
     *  See rpcmapper.h for description of the arguments
     */
    static uint32 DynamisZoneRPCCallback(void* arg,
        uint16 zone,
        uint16 origin,
        const uint8* indata,
        uint32 inlen,
        uint8* outdata,
        uint32 outlen,
        uint32* outwritten);

    /**
     *  RPC callback for the trail markings of the originating zone
     *  See rpcmapper.h for description of the arguments
     */
    static uint32 DynamisTrailMarkingRPCCallback(void* arg,
        uint16 zone,
        uint16 origin,
        const uint8* indata,
        uint32 inlen,
        uint8* outdata,
        uint32 outlen,
        uint32* outwritten);

    /**
     *  Zone ping of RPC handler
     *  See rpcmapper.h for description of the arguments
     */
    static uint32 DynamisPingRPCCallback(void* arg,
        uint16 zone,
        uint16 origin,
        const uint8* indata,
        uint32 inlen,
        uint8* outdata,
        uint32 outlen,
        uint32* outwritten);

private:

    CZone* m_PZone;
    uint16 m_zoneId;
    uint32 m_expiryTimePoint; // in seconds
    uint32 m_token;
    uint32 m_originalRegistrantID;
    bool m_currencyAutoDistribute;
    bool m_given10MinWarning;
    bool m_given3MinWarning;
    bool m_expirationRoutine;
    uint32 m_registeredPlayers[64];
};

#endif
