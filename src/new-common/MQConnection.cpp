/**
 *	@file MQConnection.cpp
 *	Handles connections to world MQ servers
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "MQConnection.h"
#include "Debugging.h"
#include "TCPConnection.h"
#include <stdexcept>
#include <chrono>
#include <openssl/ssl.h>
#include <openssl/x509_vfy.h>

#include <amqp_tcp_socket.h>
#include <amqp_ssl_socket.h>

#define LOCK_MQCONNECTION std::lock_guard<std::recursive_timed_mutex> l_mqconnection(*GetMutex())

// We need to mess around with this struct to load certificates directly from buffer
struct amqp_ssl_socket_t {
    const struct amqp_socket_class_t *klass;
    SSL_CTX *ctx;
    int sockfd;
    SSL *ssl;
    amqp_boolean_t verify_peer;
    amqp_boolean_t verify_hostname;
    int internal_error;
};

MQConnection::MQConnection()
{
    mdwWorldId = 0;
    mbIsConnected = false;
    mcAttemptRecover = 0x01;
}

MQConnection::MQConnection(uint32_t dwWorldId,
    const std::string& strMqServer,
    uint16_t wMqPort,
    const std::string& strUsername,
    const std::string& strPassword,
    const std::string& strVHost,
    uint32_t dwChannel,
    const std::string& strExchange,
    const std::string& strQueueName,
    const std::string& strRouteKey,
    bool bUseSSL,
    bool bVerifyPeer,
    const std::string& strCACert,
    const std::string& strClientCert,
    const std::string& strClientKey)
{
    LOG_DEBUG0("Called.");
    mbIsConnected = false;
    mcAttemptRecover = 0x01;
    Connect(dwWorldId,
        strMqServer,
        wMqPort,
        strUsername,
        strPassword,
        strVHost,
        dwChannel,
        strExchange,
        strQueueName,
        strRouteKey,
        bUseSSL,
        bVerifyPeer,
        strCACert,
        strClientCert,
        strClientKey);
}

void MQConnection::Connect(uint32_t dwWorldId,
    const std::string& strMqServer,
    uint16_t wMqPort,
    const std::string& strUsername,
    const std::string& strPassword,
    const std::string& strVHost,
    uint32_t dwChannel,
    const std::string& strExchange,
    const std::string& strQueueName,
    const std::string& strRouteKey,
    bool bUseSSL,
    bool bVerifyPeer,
    const std::string& strCACert,
    const std::string& strClientCert,
    const std::string& strClientKey)
{
    LOG_DEBUG0("Called.");

    LOCK_MQCONNECTION;
    if (mbIsConnected) {
        LOG_ERROR("Already connected to MQ, close the existing connection first.");
        throw std::runtime_error("Already connected to MQ.");
    }

    mdwWorldId = dwWorldId;
    mstrMqServer = strMqServer;
    mwMqPort = wMqPort;
    mstrUsername = strUsername;
    mstrPassword = strPassword;
    mstrVHost = strVHost;
    mbUseSSL = bUseSSL;
    mbVerifyPeer = bVerifyPeer;
    mstrCACert = strCACert;
    mstrClientCert = strClientCert;
    mstrClientKey = strClientKey;
    madwSendersWaiting = 0;

    Reconnect(false);
    if (dwChannel != 0) {
        try {
            ListenChannel(dwChannel, strExchange, strQueueName, strRouteKey);
        }
        catch (std::runtime_error) {
            amqp_destroy_connection(mConnection);
            throw;
        }
    }
}

void MQConnection::Reconnect(bool bRestoreChannels)
{
    LOG_DEBUG0("Called.");

    LOCK_MQCONNECTION;
    madwSendersWaiting = 0;

    if (mbIsConnected) {
        LOG_WARNING("Already connected to MQ, not reconnecting.");
        return;
    }
    mConnection = amqp_new_connection();
    if (mConnection == NULL) {
        LOG_ERROR("AMQP initialization failed.");
        throw std::runtime_error("AMQP init error.");
    }
    if (mbUseSSL) {
        // NOTE: Out certificates / private keys are stored as DB blobs. Since the AMQP library
        // does not support reading certificates and keys from memory we'll need to use the
        // underlying OpenSSL routines to do this. Ugly but needed.
        LOG_DEBUG1("Using SSL for MQ connection.");
        mSocket = amqp_ssl_socket_new(mConnection);
        amqp_boolean_t bVerify = (mbVerifyPeer && (mstrCACert != "") ? 1 : 0);
        amqp_ssl_socket_set_verify_peer(mSocket, bVerify);
        amqp_ssl_socket_set_verify_hostname(mSocket, bVerify);
        if (bVerify) {
            LOG_DEBUG1("Verify peer enabled, installing CA certificate.");
            amqp_ssl_socket_set_cacert(mSocket, mstrCACert.c_str());
            LOG_DEBUG1("CA certificate installed.");
        }
        if ((mstrClientCert != "") && (mstrClientKey != "")) {
            LOG_DEBUG1("Client certificate provided, installing.");
            amqp_ssl_socket_set_key(mSocket, mstrClientCert.c_str(), mstrClientKey.c_str());
            LOG_DEBUG1("Client certificate installed.");
        }
    }
    else {
        mSocket = amqp_tcp_socket_new(mConnection);
    }
    if (mSocket == NULL) {
        LOG_ERROR("AMQP socket initialization failed.");
        amqp_destroy_connection(mConnection);
        throw std::runtime_error("AMQP socket init error.");
    }
    int rv = amqp_socket_open(mSocket, mstrMqServer.c_str(), mwMqPort);
    if (rv != AMQP_STATUS_OK) {
        LOG_ERROR("Could not connect to MQ server (error=%d).", rv);
        amqp_destroy_connection(mConnection);
        throw std::runtime_error("MQ connection error.");
    }
    amqp_rpc_reply_t login_rv = amqp_login(mConnection,
        mstrVHost.c_str(),
        AMQP_DEFAULT_MAX_CHANNELS,
        AMQP_DEFAULT_FRAME_SIZE,
        60,
        AMQP_SASL_METHOD_PLAIN,
        mstrUsername.c_str(),
        mstrPassword.c_str());
    if (login_rv.reply_type != AMQP_RESPONSE_NORMAL) {
        LOG_ERROR("Authentication to MQ server failed.");
        amqp_destroy_connection(mConnection);
        throw std::runtime_error("MQ login error.");
    }
    if (!mOpenChannels.empty()) {
        if (bRestoreChannels) {
            LOG_DEBUG0("Attempting to restore previously connected channels.");
            try {
                std::vector<OpenChannel> channels(mOpenChannels);
                mOpenChannels.clear();
                for (std::vector<OpenChannel>::iterator it = channels.begin(); it != channels.end(); it++) {
                    ListenChannel(it->dwChannel, it->strExchange, it->strQueueName, it->strRouteKey);
                }
            }
            catch (std::runtime_error) {
                amqp_destroy_connection(mConnection);
                throw;
            }
        }
        else {
            LOG_DEBUG0("Not restoring previous channels, clearing channel list.");
            mOpenChannels.clear();
        }
    }
    mbIsConnected = true;
    LOG_DEBUG0("MQ connection established.");
}

MQConnection::~MQConnection()
{
    if (mbIsConnected) {
        Close();
    }
}

void MQConnection::Close()
{
    LOG_DEBUG0("Called.");

    if (!mbIsConnected) {
        LOG_ERROR("Not connected to MQ, nothing to close.");
        throw std::runtime_error("Not connected to MQ.");
    }

    size_t dwNumChannels = mOpenChannels.size();
    for (size_t i = 0; i < dwNumChannels; i++) {
        amqp_queue_unbind(mConnection,
            mOpenChannels[i].dwChannel,
            amqp_cstring_bytes(mOpenChannels[i].strQueueName.c_str()),
            amqp_cstring_bytes(mOpenChannels[i].strExchange.c_str()),
            amqp_cstring_bytes(mOpenChannels[i].strRouteKey.c_str()),
            amqp_empty_table);
        amqp_channel_close(mConnection, 1, AMQP_REPLY_SUCCESS);
    }
    amqp_destroy_connection(mConnection);
    mbIsConnected = false;
}

bool MQConnection::IsConnected() const
{
    return mbIsConnected;
}

uint8_t MQConnection::CheckAutoRecover() const
{
    return mcAttemptRecover;
}

void MQConnection::SetAutoRecover(uint8_t cAutoRecover)
{
    mcAttemptRecover = cAutoRecover;
}

void MQConnection::ListenChannel(uint32_t dwChannel,
    const std::string& strExchange,
    const std::string& strQueueName,
    const std::string& strRouteKey)
{
    if (GetChannelDetails(dwChannel)) {
        LOG_ERROR("Channel is already open.");
        throw std::runtime_error("Channel already open.");
    }
    amqp_channel_open(mConnection, dwChannel);
    if (amqp_get_rpc_reply(mConnection).reply_type != AMQP_RESPONSE_NORMAL) {
        LOG_ERROR("Opening new channel failed.");
        throw std::runtime_error("MQ channel open error.");
    }
    amqp_queue_declare(mConnection, dwChannel, amqp_cstring_bytes(strQueueName.c_str()), 0, 0, 0, 1, amqp_empty_table);
    if (amqp_get_rpc_reply(mConnection).reply_type != AMQP_RESPONSE_NORMAL) {
        LOG_ERROR("Declaration of queue failed.");
        amqp_channel_close(mConnection, dwChannel, AMQP_INTERNAL_ERROR);
        throw std::runtime_error("MQ queue declare error.");
    }
    if (!strExchange.empty()) {
        amqp_queue_bind(mConnection,
            dwChannel,
            amqp_cstring_bytes(strQueueName.c_str()),
            amqp_cstring_bytes(strExchange.c_str()),
            amqp_cstring_bytes(strRouteKey.c_str()),
            amqp_empty_table);
        if (amqp_get_rpc_reply(mConnection).reply_type != AMQP_RESPONSE_NORMAL) {
            LOG_ERROR("Failed to bind queue to exchange.");
            amqp_channel_close(mConnection, dwChannel, AMQP_INTERNAL_ERROR);
            throw std::runtime_error("MQ queue bind error.");
        }
    }
    amqp_basic_consume(mConnection, dwChannel, amqp_cstring_bytes(strQueueName.c_str()), amqp_empty_bytes, 0, 1, 0, amqp_empty_table);
    if (amqp_get_rpc_reply(mConnection).reply_type != AMQP_RESPONSE_NORMAL) {
        LOG_ERROR("Unable to start consumer.");
        amqp_queue_unbind(mConnection, 1, amqp_cstring_bytes(strQueueName.c_str()), amqp_cstring_bytes(strExchange.c_str()), amqp_cstring_bytes(strRouteKey.c_str()), amqp_empty_table);
        amqp_channel_close(mConnection, 1, AMQP_INTERNAL_ERROR);
        throw std::runtime_error("MQ constume error.");
    }
    mOpenChannels.push_back({ dwChannel, strQueueName, strExchange, strRouteKey });
}

void MQConnection::CloseChannel(uint32_t dwChannel)
{
    size_t dwNumChannels = mOpenChannels.size();
    size_t i = 0;
    while (i < dwNumChannels) {
        if (mOpenChannels[i].dwChannel == dwChannel) {
            amqp_queue_unbind(mConnection,
                dwChannel,
                amqp_cstring_bytes(mOpenChannels[i].strQueueName.c_str()),
                amqp_cstring_bytes(mOpenChannels[i].strExchange.c_str()),
                amqp_cstring_bytes(mOpenChannels[i].strRouteKey.c_str()),
                amqp_empty_table);
            amqp_channel_close(mConnection, 1, AMQP_REPLY_SUCCESS);
            mOpenChannels.erase(mOpenChannels.begin() + i);
        }
        else {
            i++;
        }
    }
}

MQConnection::OpenChannel* MQConnection::GetChannelDetails(uint32_t dwChannel)
{
    size_t dwNumChannels = mOpenChannels.size();
    for (size_t i = 0; i < dwNumChannels; i++) {
        if (mOpenChannels[i].dwChannel == dwChannel) {
            return &(mOpenChannels[i]);
        }
    }
    return NULL;
}

void MQConnection::Run()
{
    amqp_rpc_reply_t Response;
    amqp_envelope_t Envelope;
    amqp_frame_t Frame;
    amqp_message_t Message;
    struct timeval tv, tv_orig = { 0, 100000 };
    size_t dwNumHandlers = 0;
    size_t dwNumChannels = 0;
    size_t i = 0;
    size_t j = 0;

    LOG_DEBUG0("Called.");

    if (!OnStartup()) {
        LOG_WARNING("Aborted by OnStartup()!");
        return;
    }
    for (j = 0; j < mHandlers.size(); j++) {
        for (i = 0; i < mHandlers[j].pHandlers.size(); i++) {
            if (!mHandlers[j].pHandlers[i]->OnStartup()) {
                LOG_WARNING("Aborted by handler's OnStartup()!");
                return;
            }
        }
    }
    i = 0;
    j = 0;

    mbRunning = true;
    amqp_maybe_release_buffers(mConnection);
    LOG_DEBUG1("MQ consumer started.");

    while (mbShutdown == false) {
        if (!mbIsConnected) {
            if (mcAttemptRecover & 0x01) {
                try {
                    Reconnect();
                }
                catch (std::runtime_error&) {
                    // Keep trying indefinitely
                    LOG_ERROR("Can't reconnect to MQ.");
                    std::this_thread::sleep_for(std::chrono::seconds(5));
                    continue;
                }
            }
            else {
                LOG_CRITICAL("Connection to mesage queue closed unexpectedly.");
                throw std::runtime_error("Connection to MQ closed.");
            }
        }

        try {
            if (madwHighPriorityAccess != 0 || madwSendersWaiting != 0) {
                // There are senders waiting to send data so give them some time to do their business
                std::this_thread::sleep_for(std::chrono::milliseconds(100));
            }
            std::unique_lock<std::recursive_timed_mutex> lk(*GetMutex(), std::defer_lock);
            if (!lk.try_lock_for(std::chrono::seconds(1))) {
                // We need to continue monitoring mbShutdown even while we're waiting
                // for the mutex, otherwise this can result in a deadlock if a signal
                // is raised while processing a message.
                continue;
            }

            tv.tv_sec = tv_orig.tv_sec;
            tv.tv_usec = tv_orig.tv_usec;
            Response = amqp_consume_message(mConnection, &Envelope, &tv, 0);
            if (Response.reply_type == AMQP_RESPONSE_NORMAL) {
                LOG_DEBUG1("Received message.");
                dwNumChannels = mHandlers.size();
                for (j = 0; j < dwNumChannels; j++) {
                    if (mHandlers[j].dwChannel == Envelope.channel) {
                        dwNumHandlers = mHandlers[j].pHandlers.size();
                        for (i = 0; i < dwNumHandlers; i++) {
                            if (mHandlers[j].pHandlers[i]->HandleRequest(Envelope.message.body, this, Envelope.channel)) {
                                break;
                            }
                        }
                    }
                }
            }
            else if (Response.reply_type == AMQP_RESPONSE_LIBRARY_EXCEPTION) {
                if (Response.library_error == AMQP_STATUS_TIMEOUT) {
                    // No message
                    continue;
                }
                else if (Response.library_error == AMQP_STATUS_UNEXPECTED_STATE) {
                    // Metadata packet
                    LOG_DEBUG1("Received metadata packet.");
                    if (amqp_simple_wait_frame(mConnection, &Frame) != AMQP_STATUS_OK) {
                        LOG_ERROR("Wait for frame failed.");
                        throw std::runtime_error("Wait for frame failed.");
                    }
                    switch (Frame.payload.method.id) {
                    case AMQP_BASIC_ACK_METHOD:
                        // Simple ACK packet. Currently we just ignore these.
                        continue;
                    case AMQP_BASIC_RETURN_METHOD:
                        // A message we've published with the mandatory flag up was not received
                        // by anyone. We may want to do something about it here if we ever have
                        // a reason to set the mandatory flag. For now just read the message and
                        // ignore it.
                        Response = amqp_read_message(mConnection, Frame.channel, &Message, 0);
                        if (Response.reply_type != AMQP_RESPONSE_NORMAL) {
                            LOG_ERROR("Error occured when attempting to read return method message.");
                            throw std::runtime_error("Return method read error.");
                        }
                        amqp_destroy_message(&Message);
                        break;
                    case AMQP_CHANNEL_CLOSE_METHOD:
                        // This shouldn't generally happen. It may be possible to recover by
                        // re-creating the channel and re-declaring the queue but the probability
                        // is so low that it's not worthwhile.
                        LOG_ERROR("Channel closed by MQ server.");
                        throw std::runtime_error("Unexcpected MQ channel close.");
                    case AMQP_CONNECTION_CLOSE_METHOD:
                        LOG_ERROR("Connection closed by MQ server.");
                        throw std::runtime_error("Unexpected MQ connection close.");
                    }
                    LOG_ERROR("Unknown library error code: %u.", Frame.payload.method.id);
                    throw std::runtime_error("Unknown library error code.");
                }
                else {
                    LOG_ERROR("Unknown library staus code: %u.", Response.reply_type);
                    throw std::runtime_error("Unknown library status code.");
                }
            }
            else {
                LOG_ERROR("Unknown reply received by consumer.");
                throw std::runtime_error("Unknown consumer reply.");
            }

            amqp_maybe_release_buffers(mConnection);
        }
        catch (std::runtime_error&) {
            // If the recovery attempt flag is up, keep the thread alive.
            // The next iteration of the loop will try to reconnect.
            Close();
            if (mcAttemptRecover & 0x01) {
                LOG_ERROR("Disconnected from message queue, will attempt to reconnect.");
            }
            else {
                throw;
            }
        }
    }
    for (j = 0; j < mHandlers.size(); j++) {
        for (i = 0; i < mHandlers[j].pHandlers.size(); i++) {
            mHandlers[j].pHandlers[i]->OnShutdown();
        }
    }
    i = 0;
    j = 0;
    OnShutdown();
    LOG_DEBUG1("MQ consumer finished.");
    mbRunning = false;
}

void MQConnection::Send(uint32_t dwChannel, const uint8_t* bufData, uint32_t cbData, const std::string* pstrRecipient)
{
    LOG_DEBUG0("Called.");
    if (!mbIsConnected) {
        LOG_ERROR("MQ connection not open.");
        throw std::runtime_error("MQ connection not open.");
    }

    madwSendersWaiting++;
    LOCK_MQCONNECTION;
    amqp_basic_properties_t Properties = { 0 };
    Properties._flags = AMQP_BASIC_CONTENT_TYPE_FLAG;
    Properties.content_type = amqp_cstring_bytes("application/octet-stream");
    amqp_bytes_t Message;
    Message.len = cbData;
    // Unfortunately this is needed (we don't want to modify external libs)
    // amqp_basic_publish is not expected to touch the buffer anyway.
    Message.bytes = const_cast<uint8_t*>(bufData);
    OpenChannel* pChannelDetails = GetChannelDetails(dwChannel);
    int rv = amqp_basic_publish(mConnection,
        dwChannel,
        // This is not reversed. If a recipient *is* specified then we need to use the
        // default exchange instead of the fanout.
        amqp_cstring_bytes(pstrRecipient ? "" : pChannelDetails->strExchange.c_str()),
        amqp_cstring_bytes(pstrRecipient ? pstrRecipient->c_str() : pChannelDetails->strRouteKey.c_str()),
        0,
        0,
        &Properties,
        Message);
    if (rv != AMQP_STATUS_OK) {
        if (mcAttemptRecover & 0x02) {
            LOG_WARNING("Failed to publish message, attempting to reconnect to MQ.");
            Close();
            Reconnect();
            rv = amqp_basic_publish(mConnection,
                dwChannel,
                // This is not reversed. If a recipient *is* specified then we need to use the
                // default exchange instead of the fanout.
                amqp_cstring_bytes(pstrRecipient ? "" : pChannelDetails->strExchange.c_str()),
                amqp_cstring_bytes(pstrRecipient ? pstrRecipient->c_str() : pChannelDetails->strRouteKey.c_str()),
                0,
                0,
                &Properties,
                Message);
        }
        if (rv != AMQP_STATUS_OK) {
            LOG_ERROR("Failed to publish message (code=%d).", rv);
            madwSendersWaiting--;
            throw std::runtime_error("Publish failed.");
        }
    }
    madwSendersWaiting--;
    LOG_DEBUG1("Published message.");
}

std::recursive_timed_mutex* MQConnection::GetMutex()
{
    return &mMutex;
}

uint32_t MQConnection::GetHighPriorityThreadsWaiting() const
{
    return madwHighPriorityAccess;
}

void MQConnection::IncrementHighPriorityThreadsWaiting()
{
    madwHighPriorityAccess++;
}

void MQConnection::DecrementHighPriorityThreadsWaiting()
{
    madwHighPriorityAccess--;
}

uint32_t MQConnection::GetWorldId() const
{
    return mdwWorldId;
}

void MQConnection::AssignHandler(uint32_t dwChannel, std::shared_ptr<MQHandler> pNewHandler)
{
    size_t dwNumChannels = mHandlers.size();
    for (size_t i = 0; i < dwNumChannels; i++) {
        if (mHandlers[i].dwChannel == dwChannel) {
            mHandlers[i].pHandlers.push_back(pNewHandler);
            return;
        }
    }
    AssignedHandlers NewHandlerList = { 0 };
    NewHandlerList.dwChannel = dwChannel;
    NewHandlerList.pHandlers.push_back(pNewHandler);
    mHandlers.push_back(NewHandlerList);
}

bool MQConnection::OnStartup()
{
    return true;
}

void MQConnection::OnShutdown()
{
}
