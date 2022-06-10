/**
 *	@file SessionTracker.cpp
 *	Keeps track of open sessions, allows cross referencing between protocols
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "SessionTracker.h"
#include "../new-common/Debugging.h"
#include <stdexcept>
#include <time.h>
#include <cstring>

SessionTrackerPtr SessionTracker::smpSingletonObj = NULL;
bool SessionTracker::sbBeingDestroyed = false;

SessionTrackerPtr SessionTracker::GetInstance()
{
    LOG_DEBUG0("Called.");
    if (smpSingletonObj == NULL) {
        smpSingletonObj = new SessionTracker;
    }
    return smpSingletonObj;
}

std::recursive_mutex* SessionTracker::GetMutex()
{
    // Commented out - Spams the log
    // LOG_DEBUG0("Called.");
    if (smpSingletonObj == NULL) {
        LOG_CRITICAL("Attempted to access session tracker before initialzing.");
        throw std::runtime_error("Tracker not initialized.");
    }
    return &smpSingletonObj->mMutex;
}

void SessionTracker::Destroy()
{
    LOG_DEBUG0("Called.");
    sbBeingDestroyed = true;
    if (smpSingletonObj != NULL) {
        LOG_DEBUG1("Deleting session tracker.");
        delete smpSingletonObj;
    }
}

SessionTracker::SessionTracker()
{
    LOG_DEBUG0("Called.");
}

SessionTracker::~SessionTracker()
{
    if (sbBeingDestroyed == false) {
        Destroy();
    }
}

std::shared_ptr<LoginSession> SessionTracker::InitializeNewSession(uint32_t dwAccountId, uint32_t dwIpAddr, time_t tmTTL)
{
    LOG_DEBUG0("Called.");
    LOCK_TRACKER;
    time_t now = time(NULL);
    auto data = mmapSessions.find(dwAccountId);
    if (data != mmapSessions.end()) {
        LOG_INFO("Session already exists, overwriting.");
        // A session has already been found for the said account
        if (data->second->GetClientIPAddress() == dwIpAddr) {
            // Matches the IP address we already have so overwrite it
            mmapSessions.erase(data->first);
        }
        else {
            // If it's from a different IP then this is an error
            LOG_ERROR("Received a session request for the same account from different IP address.");
            throw SessionExistsError("Session exists with different IP");
        }
    }
    LOG_INFO("Creating new session.");
    LoginSession* NewSession = new LoginSession(dwAccountId, dwIpAddr, tmTTL);
    std::shared_ptr<LoginSession> NewSessionPtr(NewSession);
    mmapSessions[dwAccountId] = NewSessionPtr;
    return NewSessionPtr;
}

std::shared_ptr<LoginSession> SessionTracker::GetSessionDetails(uint32_t dwAccountId)
{
    LOG_DEBUG0("Called.");
    LOCK_TRACKER;
    auto data = mmapSessions.find(dwAccountId);
    if (data != mmapSessions.end()) {
        LOG_DEBUG1("Session found for account ID: %d", dwAccountId);
        return data->second;
    }
    LOG_WARNING("Session ID not found for accout: %d", dwAccountId);
    throw std::runtime_error("Session ID not found");
}

std::shared_ptr<LoginSession> SessionTracker::LookupSessionByAuth(uint32_t dwAccountId, const uint8_t* pbufAuthToken, uint32_t dwIPAddress)
{
    LOG_DEBUG0("Called.");
    auto i = mmapSessions.begin();
    std::shared_ptr<LoginSession> pFoundSession = NULL;
    while (i != mmapSessions.end()) {
        if ((i->second->GetAccountID() == dwAccountId) &&
            (i->second->GetClientIPAddress() == dwIPAddress) &&
            (memcmp(i->second->GetAuthToken(), pbufAuthToken, 8) == 0)) {
            pFoundSession = i->second;
            break;
        }
        i++;
    }
    if (pFoundSession == NULL) {
        LOG_WARNING("Session not found for given details.");
        throw std::runtime_error("Session ID not found");
    }
    pFoundSession->SetLastLookupNow();
    return pFoundSession;
}

std::shared_ptr<LoginSession> SessionTracker::LookupSessionByIP(uint32_t dwIPAddress)
{
    LOG_DEBUG0("Called.");
    auto i = mmapSessions.begin();
    std::shared_ptr<LoginSession> pBestCandidate = NULL;
    bool bHaveCandidate = false;
    time_t tmBestCandidateTime = 0;
    time_t tmCurrentCandidateTime = 0;
    while (i != mmapSessions.end()) {
        // Terrible hack - The client never sends the view server any identifier other than the connecting IP,
        // which means that if several accounts are connecting from the same IP then we're gonna have a problem.
        // Until a better method is found, just pick the session that was looked up as far ago as possible,
        // or better yet, hasn't been looked up since creation.
        if ((i->second->GetClientIPAddress() == dwIPAddress) && (i->second->GetIgnoreIPLookupFlag() == false)) {
            tmCurrentCandidateTime = i->second->GetLastLookupTime();
            if (!bHaveCandidate || tmCurrentCandidateTime < tmBestCandidateTime) {
                pBestCandidate = i->second;
                tmBestCandidateTime = tmCurrentCandidateTime;
                bHaveCandidate = true;
            }
        }
        i++;
    }
    if (pBestCandidate == NULL) {
        LOG_WARNING("Session not found for given IP address.");
        throw std::runtime_error("Session ID not found");
    }
    pBestCandidate->SetLastLookupNow();
    return pBestCandidate;
}

void SessionTracker::SetSessionDetails(std::shared_ptr<LoginSession> SessionData)
{
    LOG_DEBUG0("Called.");
    LOCK_TRACKER;
    mmapSessions[SessionData->GetAccountID()] = SessionData;
}

void SessionTracker::DeleteSession(uint32_t dwAccountId)
{
    LOG_DEBUG0("Called.");
    LOCK_TRACKER;
    if (mmapSessions.erase(dwAccountId) == 0) {
        LOG_ERROR("Attempted to delete a nonexistent session.");
        throw std::runtime_error("Session ID not found");
    }
}

void SessionTracker::DeleteExpiredSessions()
{
    // Commented out - Spams the log
    // LOG_DEBUG0("Called.");
    LOCK_TRACKER;
    time_t tmNow = time(NULL);

    auto i = mmapSessions.begin();
    auto j = i;
    while (i != mmapSessions.end()) {
        if (i->second->HasExpired()) {
            j = i;
            j++;
            mmapSessions.erase(i->first);
            i = j;
        }
        else {
            i++;
        }
    }
}

std::vector<uint32_t> SessionTracker::GetReservedCharIDList(uint32_t dwWorldID) const
{
    auto i = mmapSessions.begin();
    auto j = i;
    uint32_t dwReservedCharID = 0;
    std::vector<uint32_t> ReservedCharIDs;
    while (i != mmapSessions.end()) {
        dwReservedCharID = i->second->GetReservedCharID(dwWorldID);
        if (dwReservedCharID != 0) {
            ReservedCharIDs.push_back(dwReservedCharID);
        }
        i++;
    }
    return ReservedCharIDs;
}
