/**
 *	@file LoginSession.h
 *	Login session information and synchronization
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_LOGIN_LOGINSESSION_H
#define FFXI_LOGIN_LOGINSESSION_H

#include <stdint.h>
#include <time.h>
#include <stdexcept>
#include <mutex>
#include <queue>
#include "../new-common/CommonMessages.h"

class SessionExistsError : public std::runtime_error
{
public:
    SessionExistsError(const std::string& what) : std::runtime_error(what)
    {};
};

/**
 *  Represents a single open session.
 */
class LoginSession
{
public:
    /**
     *  Initialize a new session given the required initial values.
     *  @param dwAccountId Account ID of the session being created
     *  @param dwIpAddr IP address of the client
     *  @param tmTTL TTL for the session before it's autodeleted (default = 30 seconds)
     */
    LoginSession(uint32_t dwAccountId, uint32_t dwIpAddr, time_t tmTTL = 30);

    /**
     *  Destructor
     */
    ~LoginSession();

    /**
     *  Gets the session mutex object. Lock this before doing any changes.
     *  @return Session mutex object.
     */
    std::recursive_mutex* GetMutex();

    /**
     *  Get the account ID associated with the session
     *  @return Account ID
     */
    uint32_t GetAccountID() const;

    /**
     *  Get the authentication token associated with the session.
     *  @return Pointer to the authentication token
     */
    const uint8_t* GetAuthToken() const;

    /**
     *  Get the IP address associated with the session
     *  @return IP address in network byte order
     */
    uint32_t GetClientIPAddress() const;

    /**
     *  Get the encryption key associated with the session
     *  @return Pointer to the key buffer
     */
    const uint8_t* GetKey() const;

    /**
     *  Has the session key already been installed?
     *  @return True if the session key has been installed, false otherwise
     */
    bool IsKeyInstalled() const;

    /**
     *  Get the expiry time of the session
     *  @return Expity time as UNIX timestamp
     */
    time_t GetExpiryTime() const;

    /**
     *  Check whether the session has expired
     *  @return True if expired, false otherwise
     */
    bool HasExpired() const;

    /**
     *  Flag the session to never expire. This is done when characters are
     *  logged-in in order for them to be able to switch characters without
     *  reconnecting.
     */
    void SetNeverExpire(bool bNeverExpires);

    /**
     *  Checks whether this session should not be included in IP lookups.
     *  @return True if the session is to be ignored, false otherwise
     */
    bool GetIgnoreIPLookupFlag() const;

    /**
     *  Gets the number of characters the user already has.
     *  @return Number of characters
     */
    uint8_t GetNumCharacters() const;

    /**
     *  Returns the maximum number of characters this account can have.
     *  @return Number of accounts allowed.
     */
    uint8_t GetNumCharsAllowed() const;

    /**
     *  Get the allowed expansions for this user
     *  @return Expansions bitmask
     */
    uint32_t GetExpansionsBitmask() const;

    /**
     *  Get the account features on this account
     *  @return Features bitmask
     */
    uint32_t GetFeaturesBitmask() const;

    /**
     *  Get the account privileges on this account
     *  @return Privileges bitmask
     */
    uint32_t GetPrivilegesBitmask() const;

    /**
     *  Get the user's client version
     *  @return Client version (as sent by the client)
     */
    std::string GetClientVersion() const;

    /**
     *  Check if the data server has finished
     *  @return true if finished, false is still running.
     */
    bool IsDataServerFinished() const;

    /**
     *  Check if the view server has finished
     *  @return true if finished, false is still running.
     */
    bool IsViewServerFinished() const;

    /**
     *  Set the encryption key for this session.
     *  @param bufKey 24 byte long key buffer
     */
    void SetKey(const uint8_t* bufKey);

    /**
     *  Manually set the expiry time to the given value
     *  @param tmNewTime New expiry time to set
     */
    void SetExpiryTimeAbsolute(time_t tmNewTime);

    /**
     *  Set the expiry time relative to the current time
     *  @param tmNewTTL New TTL of the session in seconds
     *  @param bAllowDecrease Whether TTL can be decreased from its current value
     */
    void SetExpiryTimeRelative(time_t tmNewTTL, bool bAllowDecrease = false);

    /**
     *  Sets whether this session should not be included in IP lookups.
     *  @param bNewFlag Set to true to exclude the session from IP lookups
     */
    void SetIgnoreIPLookupFlag(bool bNewFlag);

    /**
     *  Set the allowed expansions for this user
     *  @param dwExpansions New expansions bitmask
     */
    void SetExpansionsBitmask(uint32_t dwExpansions);

    /**
     *  Get the account features on this account
     *  @param dwFeatures New features bitmask
     */
    void SetFeaturesBitmask(uint32_t dwFeatures);

    /**
     *  Get the account privileges on this account
     *  @param dwFeatures New privileges bitmask
     */
    void SetPrivilegesBitmask(uint32_t dwPrivileges);

    /**
     *  Set the user's client version.
     *  @param strClientVersion The user client version
     */
    void SetClientVersion(std::string& strClientVersion);

    /**
     *  Signal that the data server has finished running
     */
    void SetDataServerFinished(bool bFinished = true);

    /**
     *  Signal that the view server has finished running
     */
    void SetViewServerFinished(bool bFinished = true);

    /**
     *  Load the character list from the DB
     */
    void LoadCharacterList();

    /**
     *  Mark character list as outdated so it gets reloaded on
     *  the next call to load.
     */
    void InvalidateCharacterList();

    /**
     *  Get a character entry struct
     *  @param cOffset Offset in the character list
     *  @return Character entry struct with character data
     */
    CHARACTER_ENTRY* GetCharacter(uint8_t cOffset);

    /**
     *  Get a character entry struct given a content ID
     *  @param dwContentID Content ID of the needed character
     *  @return Character entry struct with character data
     */
    CHARACTER_ENTRY* GetCharacterByContentID(uint32_t dwContentID);

    /**
     *  Get the reserver character ID for this session.
     *  @param cWorldID World ID to look up the reserved character for
     *  @return Reserved character ID, zero if none or if reserved for a different world
     */
    uint32_t GetReservedCharID(uint8_t cWorldID);

    /**
     *  Generate and reserve a new character ID
     *  @param cWorldID World ID to generate the character ID in
     *  @return New character ID generated
     */
    uint32_t GenerateNewCharID(uint8_t cWorldID);

    /**
     *  If there is a reserved character for this session, remove it
     */
    void UnreserveCharacter();

    /**
     *  Internal requests sent to the data server
     */
    enum REQUESTS_TO_DATA_SERVER {
        DATA_SERVER_IDLE = 0,
        // The data server should request the user to send the session key
        DATA_SERVER_ASK_FOR_KEY = 1,
        // The data server should resend the character list
        DATA_SERVER_SEND_CHARACTER_LIST = 2
    };

    /**
     *  Internal requests sent to the view server
     */
    enum REQUESTS_TO_VIEW_SERVER {
        VIEW_SERVER_IDLE = 0,
        // Bootloader has installed the character list and the view server
        // can send the full packet.
        VIEW_SERVER_SEND_CHARACTER_LIST = 1,
        // Bootloader has installed the session key and the character can
        // log in
        VIEW_SERVER_PROCEED_LOGIN = 2
    };

    /**
     *  Issued by the view server to send a signal to the data server
     *  @param Request request type to send
     */
    void SendRequestToDataServer(REQUESTS_TO_DATA_SERVER State);

    /**
     *  Issued by the data server to send a signal to the view server
     *  @param Request request type to send
     */
    void SendRequestToViewServer(REQUESTS_TO_VIEW_SERVER State);

    /**
     *  Issued by the view server to check and receive signals from
     *  the data server.
     *  @return Pending signal or VIEW_SERVER_IDLE if none
     */
    REQUESTS_TO_VIEW_SERVER GetRequestFromDataServer();

    /**
     *  Issued by the data server to check and receive signals from
     *  the view server.
     *  @return Pending request or NO_REQUEST if none
     */
    REQUESTS_TO_DATA_SERVER GetRequestFromViewServer();

    /**
     *  Get the last message sent from the MQ regarding this session.
     *  @param pSendingWorld If not NULL, receives the world ID of the sender
     *  @return Last message from MQ.
     *  @note Also removes the message from the queue
     */
    std::shared_ptr<uint8_t> GetMessageFromMQ(uint8_t* pSendingWorld = NULL);

    /**
     *  Called by the MQ handler to send a message to the view server.
     *  @param pMQMessage message to send
     *  @param cSendingWorld World ID of the sender
     *  @note Will throw if an existing message is already pending
     */
    void SendMQMessageToViewServer(std::shared_ptr<uint8_t> pMQMessage, uint8_t cSendingWorld);

    /**
     *  Check whether a given character ID is associated with the account
     *  being processed in this session.
     *  @param dwChacarcterID Character ID to check
     *  @param cWorldID World ID scope for the character
     *  @return True if associated with this session, false otherwise
     */
    bool IsCharacterAssociatedWithSession(uint32_t dwCharacterID, uint8_t cWorldID);

    /**
     *  Check whether a given content ID is associated with the account
     *  being processed in this session.
     *  @param dwContentID Content ID to check
     *  @return True if associated with this session, false otherwise
     */
    bool IsContentIDAssociatedWithSession(uint32_t dwContentID);

    /**
     *  Return the time where this session was last looked up by IP.
     *  @return UNIX timestamp indicating last lookup
     */
    time_t GetLastLookupTime() const;

    /**
     *  Return the time the last network packet regarding this session
     *  has been received.
     *  @return UNIX timestamp indicating last packet
     */
    time_t GetLastPacketTime() const;

    /**
     *  Set the last lookup time to the current timestamp
     */
    void SetLastLookupNow();

    /**
    *  Set the last packet time to the current timestamp
    */
    void SetLastPacketNow();

    /**
     *  Get the list of content IDs that were in use when the client connected
     *  @return Vector of the used content IDs
     */
    const std::vector<uint32_t>* GetUsedContentIDsConnect() const;

private:
    // Account ID received from authentication
    uint32_t mdwAccountId;
    // Authentication token to verify the session with
    uint8_t mbufAuthToken[8];
    // IP address the user is connecting from
    uint32_t mdwIpAddr;
    // Initial key to be sent to the map server
    uint8_t mbufInitialKey[24];
    // Whether the key has been installed
    bool mbKeyInstalled;
    // When the session expires and auto-removed
    time_t mtmExpires;
    // Whether to ignore this packet when doing IP lookups
    bool mbIgnoreOnIPLookup;
    // Session never expires
    bool mbNeverExpires;
    // Number of characters the user has
    uint8_t mcNumCharacters;
    // Number of characters the user is allowed
    uint8_t mcNumCharsAllowed;
    // Account expansion bitmask
    uint32_t mdwExpansionsBitmask;
    // Account features bitmask
    uint32_t mdwFeaturesBitmask;
    // Account privileges bitmask
    uint32_t mdwPrivilegesBitmask;
    // Client version
    std::string mstrClientVersion;
    // Character data list
    CHARACTER_ENTRY mCharacters[16];
    // Whether character list has been loaded
    bool mbCharListLoaded;
    // Whether character list has been loaded at least once
    bool mbCharListLoadedOnce;
    // Mutex for access sync
    std::recursive_mutex mMutex;
    // Request sent to the data server
    REQUESTS_TO_DATA_SERVER mRequestToData;
    // Request to the view server
    REQUESTS_TO_VIEW_SERVER mRequestToView;
    // Has the data server finished
    bool mbDataServerFinished;
    // Has the view server finished
    bool mbViewServerFinished;
    // Request received from MQ to view server
    std::shared_ptr<uint8_t> mpMessageFromMQ;
    // World ID of the sender of the MQ message
    uint8_t mcMQMessageOriginatingWorld;
    // When a character is being created, a char ID is reserved
    uint32_t mdwReservedCharID;
    // World ID where the char ID is reserved
    uint8_t mcReservedCharWorld;
    // Last time this session was looked up
    time_t tmLastLookup;
    // Content IDs which were used when the user connected
    std::vector<uint32_t> mvecUsedContentIDsConnect;
    // Last time this session has received any network traffic
    time_t tmLastPacket;
};

#endif
