/*
===========================================================================

Copyright (c) 2021 Wings Project

Use of this file is under GPLv3, see LICENSE file.

Author: Twilight

===========================================================================
*/

#ifndef _RPCMAPPER_H
#define _RPCMAPPER_H

#include "../common/cbasetypes.h"
#include <memory>
#include <unordered_map>

namespace message
{
    /**
     *  Actual RPC function definition
     *  @param arg Constant argument specified when the function is registered
     *  @param zone The zone to which the call is directed
     *  @param origin The zone from which the call originated
     *  @param indata Incoming data buffer
     *  @param inlen Size of the input data in bytes
     *  @param outdata Buffer to write output data
     *  @param outlen Size of the output buffer in bytes
     *  @param outwritten Write the number of bytes written to outdata here
     *  @return Any arbitrary return value
     */
    typedef uint32(*MAP_RPC_FUNC)
        (void* arg,
         uint16 zone,
         uint16 origin,
         const uint8* indata,
         uint32 inlen,
         uint8* outdata,
         uint32 outlen,
         uint32* outwritten);

    /**
     *  Handles cross-cluster RPCs
     */
    class RPCMapper
    {
    public:

        /**
         *  Gets a copy of the mapper, which is a singleton object.
         *  The object will be created on the first call.
         *  @return RPC Mapper object.
         */
        static RPCMapper* GetInstance();

        /**
         *  Register a new incoming RPC call.
         *  @param index Unique ID of the new call
         *  @param callback Function to invoke when a call to index is received
         *  @param arg An argument to be passed to the function
         *  @return true if the registration succeeded
         */
        bool RegisterIncomingRPC(uint32 index, MAP_RPC_FUNC callback, void* arg);

        /**
         *  Invokes an RPC in a target zone.
         *  @param zone Zone ID of the zone where the function is to be invoked
         *  @param origin Zone ID of the originating message (must be a zone within this instance of map)
         *  @param index Unique ID of the function to call
         *  @param data Data to pass to the remote function
         *  @param datalen Size of the data in bytes
         *  @param outdata buffer into which the function output is written
         *  @param outlen Size of the output buffer in bytes
         *  @param outwritten The number of bytes written to the output buffer.
         *  @param timeout Timeout in milliseconds. If zero, wait infinitely.
         *  @return The return value of the remote function. Zero on failure.
         */
        uint32 CallRPCSync(uint16 zone,
            uint16 origin,
            uint32 index,
            const uint8* data,
            uint32 datalen,
            uint8* outdata,
            uint32 outlen,
            uint32* outwritten,
            uint32 timeout);

        /**
        *  Invokes an RPC in a target zone and returns immediately
        *  @param zone Zone ID of the zone where the function is to be invoked
        *  @param origin Zone ID of the originating message (must be a zone within this instance of map)
        *  @param index Unique ID of the function to call
        *  @param data Data to pass to the remote function
        *  @param datalen Size of the data in bytes
        *  @param wantresponse true if the caller desires to receive a response from the remote function
        *  @param outdata buffer into which the function output is written
        *  @param outlen Size of the output buffer in bytes
        *  @param maxout Maximum size to return in bytes
        *  @return A unique token which can be used to check for the remote function response. Zero on failure.
        *  @note If wantresponse is false then the return value is nonzero if successful and zero if failed.
        */
        uint32 CallRPCAsync(uint16 zone,
            uint16 origin,
            uint32 index,
            const uint8* data,
            uint32 datalen,
            uint32 maxout,
            bool wantresponse=true);

        /**
         *  Receive the response from an RPC called in async mode
         *  @param token Token received from CallRPCAsync
         *  @param outdata Buffer that receives the output data
         *  @param outlen Size of outdata in bytes
         *  @param returncode Receives the return code of the remote function
         *  @param numwritten Number of bytes written to the output buffer
         *  @param pop Whether to free the response from memory
         *  @return 0 = Failure, 1 = Success, 2 = Remote function has not yet completed
         *  @note if outdata is zero, will only check whether the remote function has ended
         */
        uint8 GetAsyncCallResponse(uint32_t token,
            uint8* outdata,
            uint32 outlen,
            uint32* returncode,
            uint32* numwritten,
            bool pop=true);

        /////// THESE SHOULD ONLY BE CALLED BY THE MESSAGE HANDLER

#pragma pack(push, 1)

        struct RPC_CALL_DETAILS
        {
            uint32 token;
            uint16 zone;
            uint16 origin;
            uint32 index;
            uint32 datalen;
            uint32 maxout;
            bool wantresponse;
        };

        struct RPC_RESPONSE_DETAILS
        {
            uint32 token;
            uint16 zone;
            uint16 origin;
            uint32 index;
            uint32 responsecode;
            uint32 outlen;
        };

        struct RPC_FUNCTION_ENTRY
        {
            uint32 index;
            MAP_RPC_FUNC func;
            void* arg;
        };

#pragma pack(pop)

        bool IncomingRPCRequestHandler(RPC_CALL_DETAILS* details);
        bool IncomingRPCResponseHandler(RPC_RESPONSE_DETAILS* details);

        static void Destroy();
        ~RPCMapper();

    private:
        /// Can only be created using GetInstance()
        RPCMapper();

        /// Registered calls
        std::unordered_map<uint32, RPC_FUNCTION_ENTRY> m_indexes;
        /// Unread responsed
        std::unordered_map<uint32, std::shared_ptr<uint8>> m_responses;

        static RPCMapper* m_instance;
    };

};

#endif
