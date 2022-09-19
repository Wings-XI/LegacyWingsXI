/**
 *	@file Authentication.h
 *	User authentication routines
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_LOGIN_AUTHENTICATION_H
#define FFXI_LOGIN_AUTHENTICATION_H

#include "../new-common/TCPConnection.h"
#include <stdint.h>

/**
 *  Create one instance of this for each user that needs to authenticate.
 */
class Authentication
{
public:

    /**
     *  Initialize the authenticator.
     */
    Authentication(std::shared_ptr<TCPConnection>);

    /**
     *  Possible errors returned by the authentication process
     */
    enum AUTHENTICATION_ERROR
    {
        AUTH_SUCCESS = 0,
        AUTH_NO_USER_OR_BAD_PASSWORD = 1,
        AUTH_USERNAME_TAKEN = 2,
        AUTH_PASSWORD_TOO_WEAK = 3,
        AUTH_INTERNAL_FAILURE = 4,
        AUTH_ACCOUNT_DISABLED = 5,
        AUTH_MAINTENANCE_MODE = 6,
        AUTH_BOOTLOADER_SIGNUP_DISABLED = 7,
        AUTH_ANOTHER_ACCOUNT_SHARES_IP = 8,
        AUTH_SESSION_EXISTS = 9,
        AUTH_IP_BLOCKED = 10,
        AUTH_IP_LOCKED_OUT = 11,
        AUTH_NEED_OTP = 12,
        AUTH_BAD_OTP = 13,
        AUTH_LAST
    };

    /**
     *  The accout privileges column is a bitmask of these values
     */
    enum ACCOUNT_PRIVILEGES
    {
        // Account is enabled (without this it cannot log-in at all)
        ACCT_PRIV_ENABLED = 0x01,
        // Account can create characters on test servers
        ACCT_PRIV_HAS_TEST_ACCESS = 0x02,
        // Account can connect even in maintenance mode
        ACCT_PRIV_MAINT_MODE_ACCESS = 0x04,
        // Account has admin access
        ACCT_ADMIN = 0x08
    };

    enum AUTH_LOG_OPERATIONS
    {
        // Normal login
        AUTH_OP_LOGIN = 0,
        // New account
        AUTH_OP_CREATE_ACCOUNT = 1,
        // Password change
        AUTH_OP_CHANGE_PASSWORD = 2
    };

    /**
     *  Authenticate user by username / password.
     *  @param pszUsername Username to authenticate
     *  @param pszPassword Password to authenticate
     *  @param pszOTP One-time-password (if enabled)
     *  @param pbufAuthToken If not null receives an 8 byte authentication token
     *  @return Account ID of the user on success or 0 on failure.
     */
    uint32_t AuthenticateUser(const char* pszUsername, const char* pszPassword, const char* pszOTP, uint8_t* pbufAuthToken = NULL);

    /**
     *  Create a new user account.
     *  @param pszUsername Username to create
     *  @param pszPassword Password to assign
     *  @param pszEmail Optional email address
     *  @param pbufAuthToken If not null receives an 8 byte authentication token
     *  @return Account ID of the user on success or 0 on failure.
     */
    uint32_t CreateUser(const char* pszUsername, const char* pszPassword, const char* pszEmail = NULL, uint8_t* pbufAuthToken = NULL);

    /**
     *  Changes the password of an existing user.
     *  @param pszUsername User to modify
     *  @param pszOldPassword Existing password
     *  @param pszNewPassword New password to set
     *  @param pszOTP One-time-password (if enabled)
     *  @return true if successful, false on failure.
     */
    bool ChangePassword(const char* pszUsername, const char* pszOldPassword, const char* pszNewPassword, const char* pszOTP);

    /**
     *  Log the login into the logins log
     *  @param dwAccountId Account ID of the client, zero if nonexistent
     *  @param dwOperation The operation being performed
     *  @param bResult Whether the result is successful
     *  @param bIPExempt If one account per IP is enabled, skip this check
     *  @return If one account per IP is enabled, this will return whether login can proceed
     */
    bool LogAccess(uint32_t dwAccountId, AUTH_LOG_OPERATIONS dwOperation, bool bResult, bool bIPExempt = false);

    /**
     *  Check if the IP address associated with the current
     *  connection is on the range blacklist.
     *  @return True if blocked
     */
    bool IsIPAddressBlocked();

    /**
     *  Return the value of the last authentication error.
     *  @return Authentication error code (see enum)
     */
    AUTHENTICATION_ERROR GetLastAuthenticationError() const;

private:

    /// Last authentication error that occured
    AUTHENTICATION_ERROR mLastError;
    /// Connecting client
    std::shared_ptr<TCPConnection> mpConnection;

    /**
     *  Generate a unique string to be used as password salt.
     *  This is not cryptographically secure, just needs to be different on each call.
     *  @return Unique string to be used as salt
     */
    std::string GenerateSalt();

    /**
     *  Check whether a given password meet the following creteria -
     *  * At least 8 characters
     *  * Must have at least 3 of - Uppercase chars, lowercase chars, numerics, symbols
     *  @param pszPassword Password to check
     *  @return true if the password is complex enough, false if too weak
     */
    bool CheckPasswordComplexity(const char* pszPassword);
};

#endif
