/*
===========================================================================

Copyright (c) 2021 Wings Project

Use of this file is under GPLv3, see LICENSE file.

Author: Twilight

===========================================================================
*/

#include "rpcmapper.h"
#include "message.h"
#include "utils/zoneutils.h"
#include <memory>
#include <chrono>
#include <thread>

namespace message
{
    RPCMapper* RPCMapper::m_instance = nullptr;

    RPCMapper* RPCMapper::GetInstance()
    {
        if (!m_instance) {
            m_instance = new RPCMapper();
        }
        return m_instance;
    }

    bool RPCMapper::IncomingRPCRequestHandler(RPC_CALL_DETAILS* details)
    {
        if (!details) {
            return false;
        }
        auto function = m_indexes.find(details->index);
        if (function == m_indexes.end()) {
            // No such registered function
            return false;
        }
        if (!function->second.func) {
            return false;
        }
        if (details->maxout > 1048576) {
            return false;
        }
        if (details->zone != 0 && zoneutils::GetZone(details->zone) == nullptr) {
            // Zone inactive or not in this cluster
            return false;
        }
        std::unique_ptr<uint8> outbuf = std::unique_ptr<uint8>(new uint8[details->maxout]);
        memset(outbuf.get(), 0, details->maxout);
        uint32 outwritten = 0;
        uint32 rv = function->second.func(function->second.arg,
            details->zone,
            details->origin,
            details->datalen != 0 ? reinterpret_cast<uint8*>(details) + sizeof(RPC_CALL_DETAILS) : nullptr,
            details->datalen,
            outbuf.get(),
            details->maxout,
            &outwritten);
        if (outwritten > 1048576) {
            return false;
        }
        if (!details->wantresponse) {
            return false;
        }
        std::unique_ptr<uint8> response(new uint8[sizeof(RPC_RESPONSE_DETAILS) + outwritten]);
        RPC_RESPONSE_DETAILS* header = reinterpret_cast<RPC_RESPONSE_DETAILS*>(response.get());
        header->index = details->index;
        header->origin = details->zone;
        header->outlen = outwritten;
        header->responsecode = rv;
        header->token = details->token;
        header->zone = details->origin;
        memcpy(response.get() + sizeof(RPC_RESPONSE_DETAILS), outbuf.get(), outwritten);
        send(MSG_RPC_RESPONSE, response.get(), sizeof(RPC_RESPONSE_DETAILS) + outwritten, nullptr);
        return true;
    }

    bool RPCMapper::IncomingRPCResponseHandler(RPC_RESPONSE_DETAILS* details)
    {
        auto response = std::shared_ptr<uint8>(reinterpret_cast<uint8*>(new uint8[sizeof(RPC_RESPONSE_DETAILS) + details->outlen]));
        memcpy(response.get(), details, sizeof(RPC_RESPONSE_DETAILS) + details->outlen);
        m_responses[details->index] = response;
        return true;
    }

    uint8 RPCMapper::GetAsyncCallResponse(uint32_t token,
        uint8* outdata,
        uint32 outlen,
        uint32* returncode,
        uint32* numwritten,
        bool pop)
    {
        if (m_responses.find(token) == m_responses.end()) {
            return 2;
        }
        uint8* response = m_responses[token].get();
        RPC_RESPONSE_DETAILS* header = reinterpret_cast<RPC_RESPONSE_DETAILS*>(response);
        if (returncode) {
            *returncode = header->responsecode;
        }
        if (numwritten) {
            *numwritten = header->outlen;
        }
        if (outdata) {
            m_responses.erase(token);
        }
        return 1;
    }

    uint32 RPCMapper::CallRPCAsync(uint16 zone,
        uint16 origin,
        uint32 index,
        const uint8* data,
        uint32 datalen,
        uint32 maxout,
        bool wantresponse)
    {
        if (datalen > 1048576) {
            return 0;
        }
        std::unique_ptr<uint8> request(new uint8[sizeof(RPC_CALL_DETAILS) + datalen]);
        RPC_CALL_DETAILS* header = reinterpret_cast<RPC_CALL_DETAILS*>(request.get());
        header->datalen = datalen;
        header->index = index;
        header->maxout = maxout;
        header->origin = origin;
        do {
            header->token = static_cast<uint32>(rand());
        } while (header->token == 0);
        header->wantresponse = wantresponse;
        header->zone = zone;
        if (data) {
            memcpy(request.get() + sizeof(RPC_CALL_DETAILS), data, datalen);
        }
        send(MSG_RPC_REQUEST, request.get(), sizeof(RPC_CALL_DETAILS) + datalen, nullptr);
        return header->token;
    }

    uint32 RPCMapper::CallRPCSync(uint16 zone,
        uint16 origin,
        uint32 index,
        const uint8* data,
        uint32 datalen,
        uint8* outdata,
        uint32 outlen,
        uint32* outwritten,
        uint32 timeout)
    {
        uint32 token = CallRPCAsync(zone, origin, index, data, datalen, outlen, true);
        if (token == 0) {
            return 0;
        }
        uint32 rv = 0;
        uint8 resp = 2;
        uint32 waited = 0;
        while ((resp == 2) && ((timeout == 0) || (waited < timeout))) {
            std::this_thread::sleep_for(200ms);
            waited += 200;
            resp = GetAsyncCallResponse(token, outdata, outlen, &rv, outwritten, true);
        }
        if (resp != 1) {
            return 0;
        }
        return rv;
    }

    bool RPCMapper::RegisterIncomingRPC(uint32 index, MAP_RPC_FUNC callback, void* arg)
    {
        if (!callback) {
            return false;
        }
        if (m_indexes.find(index) != m_indexes.end()) {
            return false;
        }
        RPC_FUNCTION_ENTRY NewEntry;
        NewEntry.index = index;
        NewEntry.func = callback;
        NewEntry.arg = arg;
        m_indexes[index] = NewEntry;
        return true;
    }

    void RPCMapper::Destroy()
    {
        if (m_instance) {
            delete m_instance;
            m_instance = nullptr;
        }
    }

    RPCMapper::~RPCMapper()
    {
        // Empty
    }

    RPCMapper::RPCMapper()
    {
        // Empty
    }

}
