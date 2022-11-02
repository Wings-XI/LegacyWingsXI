/**
 *	@file MQConnection.h
 *	Handles connections to world MQ servers
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_MQCONNECTION_H
#define FFXI_COMMON_MQCONNECTION_H

#include "Thread.h"
#include "MQHandler.h"
#include <amqp.h>
#include <mutex>
#include <atomic>
#include <vector>

/**
 *  Represents a single connection to a MQ server for a single world
 */
class MQConnection : public Thread
{
public:

    struct OpenChannel
    {
        uint32_t dwChannel;
        std::string strQueueName;
        std::string strExchange;
        std::string strRouteKey;
    };

    struct AssignedHandlers
    {
        uint32_t dwChannel;
        std::vector<std::shared_ptr<MQHandler>> pHandlers;
    };

    /**
     *  Create a new MQConnection objet without actually establishing
     *  a connection.
     */
    MQConnection();

    /**
     *  Initialize a connection to a world MQ server.
     *  @param dwWorldId World ID to associate the connection to
     *  @param strMqServer Server host name or IP address
     *  @param wMqPort Port of the MQ servr
     *  @param strUsername Username to login with
     *  @param strPassword Password to login with
     *  @param strVHost Virtual host to use
     *  @param bUseSSL Whether to secure the connection with SSL
     *  @param bVerifyPeer Whether to verify the server certificate
     *  @param bufCACert CA certificate (used if bVerfifyPeer is enabled)
     *  @param cbCACert Size of bufCACert in bytes
     *  @param bufClientCert Client certificate to present (optional)
     *  @param cbClientCert Size of bufClientCert in bytes
     *  @param bufClientKey Private key matching the client certificate
     *  @param cbClientKey Size of bufClientKey in bytes.
     */
    MQConnection(uint32_t dwWorldId,
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
        const std::string& strClientKey);

    /**
     *  Destructor. Disconnects from the MQ
     */
    ~MQConnection();

    /**
    *  Initialize a connection to a world MQ server.
    *  @param dwWorldId World ID to associate the connection to
    *  @param strMqServer Server host name or IP address
    *  @param wMqPort Port of the MQ servr
    *  @param strUsername Username to login with
    *  @param strPassword Password to login with
    *  @param strVHost Virtual host to use
    *  @param bUseSSL Whether to secure the connection with SSL
    *  @param bVerifyPeer Whether to verify the server certificate
    *  @param bufCACert CA certificate (used if bVerfifyPeer is enabled)
    *  @param cbCACert Size of bufCACert in bytes
    *  @param bufClientCert Client certificate to present (optional)
    *  @param cbClientCert Size of bufClientCert in bytes
    *  @param bufClientKey Private key matching the client certificate
    *  @param cbClientKey Size of bufClientKey in bytes.
    */
    void Connect(uint32_t dwWorldId,
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
        const std::string& strClientKey);

    /**
     *  Restore a previously closed connection.
     *  This should be called to recover if the connection is unexpectedly terminated.
     *  @param bRestoreChannels Attempt to restore listening channels, if false list will be truncated
     */
    void Reconnect(bool bRestoreChannels = true);

    /**
     *  Close the existing MQ connection.
     */
    void Close();

    /**
     *  Check if there is an active connection to the MQ server.
     *  @return True if connection is established
     */
    bool IsConnected() const;

    /**
     *  Open a new channel and listen on a specific queue.
     *  @param dwChannel Channel ID to assign for this listener
     *  @param strQueueName Queue name to listen on
     *  @param strRouteKey Routing key to listen on
     */
    void ListenChannel(uint32_t dwChannel,
        const std::string& strExchange,
        const std::string& strQueueName,
        const std::string& strRouteKey);

    /**
     *  Get queue information about an open channel.
     *  @param dwChannel Channel name to query
     *  @return Channel info or NULL if the channel does not exist
     */
    OpenChannel* GetChannelDetails(uint32_t dwChannel);

    /**
     *  Stop listening on a specific channel
     *  @param dwChannel Channel ID to close
     */
    void CloseChannel(uint32_t dwChannel);

    /**
     *  Get the World ID associated with this connection
     *  @return World ID
     */
    uint32_t GetWorldId() const;

    /**
     *  Check the auto-recovery flag. If set and the connection is broken
     *  the handler thread will automatically attempt to re-establish it.
     *  @return Current auto-recovery flag
     */
    uint8_t CheckAutoRecover() const;

    /**
     *  Sets the auto-recovery flag.
     *  @param Auto-recovery flag to set
     */
    void SetAutoRecover(uint8_t cAutoRecover);

    /**
     *  Assign a new handler to the connection. When a message is received
     *  all handlers will be called until one function returns a true value,
     *  in which case the iteration is stopped.
     *  @param dwChannel Channel to assign the handler to
     *  @param pNewHandler New handler to register
     */
    void AssignHandler(uint32_t dwChannel, std::shared_ptr<MQHandler> pNewHandler);

    /**
     *  Gets the session mutex object. Lock this before doing any changes.
     *  @return MQ Connection mutex object.
     */
    std::recursive_timed_mutex* GetMutex();

    /**
     *  Check the number of high priority threads waiting
     *  @return Number of high priority threads
     */
    uint32_t GetHighPriorityThreadsWaiting() const;

    /**
     *  Increment the number of high priority threads waiting
     */
    void IncrementHighPriorityThreadsWaiting();

    /**
     *  Decrement the number of high priority threads waiting
     */
    void DecrementHighPriorityThreadsWaiting();

    /**
     *  Runs the MQ consumer thread.
     */
    void Run();


    /**
     *  Called once when the MQ thread starts.
     *  @return true if allowed to continue, false to stop the thread
     */
    virtual bool OnStartup();

    /**
     *  Called once when the MQ thread is about to stop.
     */
    virtual void OnShutdown();

    /**
     *  Send a message to the MQ server.
     *  @param dwChannel Channel to send the data on
     *  @param bufData Data buffer to send
     *  @param cbData Size of the data in bytes
     *  @param pstrRecipient If not null, will only send the message to the specified target queue
     */
    void Send(uint32_t dwChannel, const uint8_t* bufData, uint32_t cbData, const std::string* pstrRecipient = NULL);

    /**
     *  Message type codes for messages going between login and map servers
     */
    enum MQ_MESSAGE_TYPES
    {
        // Stub, first message handled by CharMessageHnd
        MQ_MESSAGE_CHARHND_FIRST = 1,
        // Character is about to log-in
        MQ_MESSAGE_CHAR_LOGIN = 2,
        // New character being created
        MQ_MESSAGE_CHAR_CREATE = 3,
        // Character being deleted
        MQ_MESSAGE_CHAR_DELETE = 4,
        // Stub, last message handled by CharMessageHnd
        MQ_MESSAGE_CHARHND_LAST = 5,
        // Universal system message (on all worlds)
        MQ_MESSAGE_UNIVERSAL_ANNOUNCEMENT = 6,
    };

private:

    // Connection details backup used by Reconnect()
    std::string mstrMqServer;
    uint16_t mwMqPort;
    std::string mstrUsername;
    std::string mstrPassword;
    std::string mstrVHost;
    bool mbUseSSL;
    bool mbVerifyPeer;
    std::string mstrCACert;
    std::string mstrClientCert;
    std::string mstrClientKey;

    /// World ID associated with this connection
    uint32_t mdwWorldId;
    /// Internal handles used by the AMQP library to identify the connection
    amqp_connection_state_t mConnection;
    amqp_socket_t* mSocket;
    /// Do we currently have an open connection
    bool mbIsConnected;
    /// Whether we attempt to recover if the connection is broken (1 = only receive, 2 = only send, 3 = both)
    uint8_t mcAttemptRecover;
    /// Currently open channels
    std::vector<OpenChannel> mOpenChannels;
    /// List of message handlers registered with this connection
    std::vector<AssignedHandlers> mHandlers;

    // Mutex for access sync
    std::recursive_timed_mutex mMutex;
    /// High priority thread requesting mutex access
    std::atomic<uint32_t> madwHighPriorityAccess;
    // Counts the number of senders that want to send data
    std::atomic<uint32_t> madwSendersWaiting;
};

#endif
