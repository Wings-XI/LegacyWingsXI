/**
 *	@file Authentication.cpp
 *	User authentication routines
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#include <mariadb++/connection.hpp>
#include "Authentication.h"
#include "../new-common/Database.h"
#include "LoginGlobalConfig.h"
#include "../new-common/Utilities.h"
#include "../new-common/Debugging.h"
#include "SessionTracker.h"
#include <mutex>
#include <time.h>
#include <openssl/evp.h>
#include <string.h>
#include <cotp.h>

Authentication::Authentication(std::shared_ptr<TCPConnection> Connection) : mLastError(AUTH_SUCCESS), mpConnection(Connection)
{
    LOG_DEBUG0("Called.");
}

uint32_t Authentication::AuthenticateUser(const char* pszUsername, const char* pszPassword, const char* pszOTP, uint8_t* pbufAuthToken)
{
    LOG_DEBUG0("Called.");
    try {
        LOCK_DB;
        DBConnection DB = Database::GetDatabase();
        GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
        std::string strPassHash;
        std::string strSalt;
        unsigned char binEnteredHash[32] = { 0 };
        unsigned char binRealHash[32] = { 0 };
        uint32_t dwAccountId = 0;
        uint32_t dwStatus = 0;
        uint32_t dwPrivileges = 0;
        bool bUserExists = false;
        uint32_t dwIpExempt = 0;
        time_t tmTempExempt = 0;
        uint32_t dwFeatures = 0;
        std::string strOTPSecret;

        LOG_DEBUG0("Attempting to authenticate user %s", pszUsername);
        std::string strSqlQueryFmt("SELECT id, password, salt, status, privileges, ip_exempt, temp_exempt, features, otp_secret FROM %saccounts WHERE username='%s'");
        std::string strSqlFinalQuery(FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(pszUsername).c_str()));
        mariadb::result_set_ref pAccountsFound = DB->query(strSqlFinalQuery);
        if (pAccountsFound->row_count() == 0) {
            // No such user. Do *NOT* return here as this will make us vulnerable to a timing attack.
            LOG_DEBUG1("User %s does not exist in DB!", pszUsername);
            strSalt = "00000000000000000000000000000000";
            strPassHash = "0000000000000000000000000000000000000000000000000000000000000000";
        }
        else {
            LOG_DEBUG1("User %s found.", pszUsername);
            bUserExists = true;
            pAccountsFound->next();
            dwAccountId = pAccountsFound->get_unsigned32(0);
            strPassHash = pAccountsFound->get_string(1);
            strSalt = pAccountsFound->get_string(2);
            dwStatus = pAccountsFound->get_unsigned16(3);
            dwPrivileges = pAccountsFound->get_unsigned32(4);
            dwIpExempt = pAccountsFound->get_unsigned16(5);
            if (!pAccountsFound->get_is_null(6)) {
                tmTempExempt = (pAccountsFound->get_date_time(6)).mktime();
            }
            dwFeatures = pAccountsFound->get_unsigned32(7);
            if (!pAccountsFound->get_is_null(8)) {
                strOTPSecret = pAccountsFound->get_string(8);
            }
        }
        mLastError = AUTH_SUCCESS;
        // Hash the entered password even if the user does not exist. This prevents valid username
        // discovery via a timing attack.
        std::string strSaltPepper = strSalt + Config->GetConfigString("password_hash_secret");
        if (PKCS5_PBKDF2_HMAC(pszPassword, -1, reinterpret_cast<const unsigned char*>(strSaltPepper.c_str()), strSaltPepper.size(), 2048, EVP_sha256(), 32, binEnteredHash) == 0) {
            LOG_ERROR("Failed to calculate PBKDF2 for user %s.", pszUsername);
            mLastError = AUTH_INTERNAL_FAILURE;
        }
        else if (HexToBinary(strPassHash, binRealHash, sizeof(binRealHash)) == 0) {
            LOG_ERROR("Stored password for %s is not a hex string.", pszUsername);
            mLastError = AUTH_INTERNAL_FAILURE;
        }
        else if ((memcmp(binEnteredHash, binRealHash, sizeof(binRealHash)) != 0) || (!bUserExists)) {
            LOG_DEBUG1("Incorrect password for user %s", pszUsername);
            mLastError = AUTH_NO_USER_OR_BAD_PASSWORD;
        }
        else if (dwFeatures & 0x01) {
            // OTP is enabled on this account
            if (strOTPSecret == "") {
                LOG_ERROR("User %s has OTP enabled but OTP secret is empty.", pszUsername);
                mLastError = AUTH_INTERNAL_FAILURE;
            }
            else if (pszOTP == NULL || *pszOTP == '\0') {
                LOG_DEBUG1("No OTP supplied for user %s", pszUsername);
                mLastError = AUTH_NEED_OTP;
            }
            else
            {
                uint8_t totpReturn = totp_verify(strOTPSecret.c_str(), pszOTP, 6, 30, SHA1);
                if (totpReturn != VALID) {
                    LOG_DEBUG1("OTP invalid for user %s, results: %u", pszUsername, totpReturn);
                    mLastError = AUTH_BAD_OTP;
                }
            }
        }
        if (mLastError != AUTH_SUCCESS) {
            return false;
        }
        if ((dwStatus != 1) || (dwPrivileges & ACCT_PRIV_ENABLED) == 0) {
            LOG_DEBUG1("Account %s is disabled.", pszUsername);
            mLastError = AUTH_ACCOUNT_DISABLED;
        }
        else if (((dwIpExempt & 0x02) == 0) && (IsIPAddressBlocked())) {
            LOG_DEBUG1("IP address of the user is blocked.");
            mLastError = AUTH_IP_BLOCKED;
        }
        if (mLastError == AUTH_SUCCESS && Config->GetConfigUInt("maintenance_mode") != 0) {
            if ((dwPrivileges & ACCT_PRIV_MAINT_MODE_ACCESS) == 0) {
                LOG_DEBUG1("Account %s does not have maintenance mode access.", pszUsername);
                mLastError = AUTH_MAINTENANCE_MODE;
            }
        }
        if ((tmTempExempt != 0) && (time(NULL) < tmTempExempt)) {
            // LAN party mode enabled
            dwIpExempt |= 0x01;
        }
        if (!LogAccess(dwAccountId, AUTH_OP_LOGIN, mLastError == AUTH_SUCCESS, ((dwIpExempt & 0x01) != 0))) {
            if (mLastError == AUTH_SUCCESS) {
                LOG_DEBUG1("Another account shares IP with %s.", pszUsername);
                mLastError = AUTH_ANOTHER_ACCOUNT_SHARES_IP;
            }
        }
        if (mLastError != AUTH_SUCCESS) {
            return 0;
        }
        LOG_DEBUG0("Login successful for account %s.", pszUsername);
        // Add this account to the session tracker, which will allow the client
        // to connect to the data server.
        std::shared_ptr<LoginSession> NewSession = SessionTracker::GetInstance()->InitializeNewSession(dwAccountId,
            mpConnection->GetConnectionDetails().BindDetails.sin_addr.s_addr,
            LoginGlobalConfig::GetInstance()->GetConfigUInt("session_timeout"));
        NewSession->SetPrivilegesBitmask(dwPrivileges);
        if (pbufAuthToken) {
            memcpy(pbufAuthToken, NewSession->GetAuthToken(), 8);
        }
        return dwAccountId;
    }
    catch (SessionExistsError) {
        LOG_DEBUG1("Session already exists, authentication rejected.");
        mLastError = AUTH_SESSION_EXISTS;
        return 0;
    }
    catch (...) {
        LOG_ERROR("Exception thrown during authentication.");
    }
    mLastError = AUTH_INTERNAL_FAILURE;
    return 0;
}

uint32_t Authentication::CreateUser(const char* pszUsername, const char* pszPassword, const char* pszEmail, uint8_t* pbufAuthToken)
{
    LOG_DEBUG0("Called.");
    try {
        LOCK_DB;
        DBConnection DB = Database::GetDatabase();
        GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();

        mLastError = AUTH_SUCCESS;
        if (Config->GetConfigUInt("disable_user_registrations") != 0) {
            mLastError = AUTH_BOOTLOADER_SIGNUP_DISABLED;
            LogAccess(0, AUTH_OP_CREATE_ACCOUNT, false, false);
            return 0;
        }
        // Check IP address block before everything so we don't have
        // to do extra work.
        if (IsIPAddressBlocked()) {
            LOG_DEBUG1("IP address of the user is blocked.");
            mLastError = AUTH_IP_BLOCKED;
            LogAccess(0, AUTH_OP_CREATE_ACCOUNT, false, false);
            return 0;
        }

        // First make sure username is unique
        std::string strSqlQueryFmt("SELECT id FROM %saccounts WHERE username='%s';");
        std::string strSqlFinalQuery(FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(pszUsername).c_str()));
        mariadb::result_set_ref pAccountsFound = DB->query(strSqlFinalQuery);
        if (pAccountsFound->row_count() != 0) {
            // User name already taken
            mLastError = AUTH_USERNAME_TAKEN;
        }
        // Then make sure the user is not using "1234" or something dumb like that as password
        else if (!CheckPasswordComplexity(pszPassword)) {
            mLastError = AUTH_PASSWORD_TOO_WEAK;
        }
        if (mLastError != AUTH_SUCCESS) {
            LogAccess(0, AUTH_OP_CREATE_ACCOUNT, false, false);
            return 0;
        }
        // Random salt automatically added so two identical passwords won't have the same hash
        std::string strSalt(GenerateSalt());
        uint8_t binPassHash[32] = { 0 };
        std::string strSaltPepper = strSalt + Config->GetConfigString("password_hash_secret");
        if (mLastError == AUTH_SUCCESS && PKCS5_PBKDF2_HMAC(pszPassword, -1, reinterpret_cast<const unsigned char*>(strSaltPepper.c_str()), strSaltPepper.size(), 2048, EVP_sha256(), 32, binPassHash) == 0) {
            mLastError = AUTH_INTERNAL_FAILURE;
            LogAccess(0, AUTH_OP_CREATE_ACCOUNT, false, false);
            return 0;
        }
        std::string strPassHash = BinaryToHex(binPassHash, sizeof(binPassHash));
        if (!LogAccess(0, AUTH_OP_CREATE_ACCOUNT, true, false)) {
            mLastError = AUTH_ANOTHER_ACCOUNT_SHARES_IP;
            return 0;
        }
        // Showtime
        if (pszEmail) {
            strSqlQueryFmt = "INSERT INTO %saccounts (username, password, salt, email, status) VALUES ('%s', '%s', '%s', '%s', 1)";
            strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
                Database::RealEscapeString(pszUsername).c_str(),
                Database::RealEscapeString(strPassHash).c_str(),
                Database::RealEscapeString(strSalt).c_str(),
                Database::RealEscapeString(pszEmail).c_str());
        }
        else {
            strSqlQueryFmt = "INSERT INTO %saccounts (username, password, salt, status) VALUES ('%s', '%s', '%s', 1)";
            strSqlFinalQuery = FormatString(&strSqlQueryFmt,
                Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
                Database::RealEscapeString(pszUsername).c_str(),
                Database::RealEscapeString(strPassHash).c_str(),
                Database::RealEscapeString(strSalt).c_str());
            }
        if (DB->insert(strSqlFinalQuery) == 0) {
            // Failed
            mLastError = mLastError = AUTH_INTERNAL_FAILURE;
            return 0;
        }
        // Now pull the id of the user we've just created
        strSqlQueryFmt = "SELECT id FROM %saccounts WHERE username='%s';";
        pAccountsFound = DB->query(FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(pszUsername).c_str()));
        if (pAccountsFound->row_count() == 0) {
            // Shouldn't happen
            mLastError = AUTH_INTERNAL_FAILURE;
            return 0;
        }
        pAccountsFound->next();
        mLastError = AUTH_SUCCESS;
        uint32_t dwAccountId = pAccountsFound->get_unsigned32(0);
        // Associate content ids with this account so it can actually create characters
        uint8_t cContentIds = ffxi_min(static_cast<uint8_t>(Config->GetConfigUInt("new_account_content_ids")), 16);
        strSqlQueryFmt = "INSERT INTO %scontents (account_id) VALUES (%d);";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(), dwAccountId);
        for (uint8_t i = 0; i < cContentIds; i++) {
            DB->insert(strSqlFinalQuery);
        }
        // Add this account to the session tracker, which will allow the client
        // to connect to the data server.
        std::shared_ptr<LoginSession> NewSession = SessionTracker::GetInstance()->InitializeNewSession(dwAccountId,
            mpConnection->GetConnectionDetails().BindDetails.sin_addr.s_addr,
            LoginGlobalConfig::GetInstance()->GetConfigUInt("session_timeout"));
        // Assume newly created accounts are normal users so we can save a DB query
        NewSession->SetPrivilegesBitmask(ACCT_PRIV_ENABLED);
        if (pbufAuthToken) {
            memcpy(pbufAuthToken, NewSession->GetAuthToken(), 8);
        }
        return dwAccountId;
    }
    catch (...) {
        LOG_ERROR("Exception thrown on DB access.");
        mLastError = AUTH_INTERNAL_FAILURE;
        return 0;
    }
}

bool Authentication::ChangePassword(const char* pszUsername, const char* pszOldPassword, const char* pszNewPassword, const char* pszOTP)
{
    LOG_DEBUG0("Called.");
    try {
        LOCK_DB;
        DBConnection DB = Database::GetDatabase();
        GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();

        uint32_t dwUserUID = AuthenticateUser(pszUsername, pszOldPassword, pszOTP);
        if ((dwUserUID == 0) && (mLastError != AUTH_ACCOUNT_DISABLED) && (mLastError != AUTH_MAINTENANCE_MODE) && (mLastError != AUTH_ANOTHER_ACCOUNT_SHARES_IP)) {
            // mLastError already set by AuthenticateUser
            // Note: For security reasons, disabled accounts are still allowed to change their passwords
            LogAccess(dwUserUID, AUTH_OP_CHANGE_PASSWORD, true, true);
            return false;
        }
        if (!CheckPasswordComplexity(pszNewPassword)) {
            mLastError = AUTH_PASSWORD_TOO_WEAK;
            LogAccess(dwUserUID, AUTH_OP_CHANGE_PASSWORD, false, true);
            return false;
        }
        std::string strSalt(GenerateSalt());
        uint8_t binPassHash[32] = { 0 };
        std::string strSaltPepper = strSalt + Config->GetConfigString("password_hash_secret");
        if (PKCS5_PBKDF2_HMAC(pszNewPassword, -1, reinterpret_cast<const unsigned char*>(strSaltPepper.c_str()), strSaltPepper.size(), 2048, EVP_sha256(), 32, binPassHash) == 0) {
            mLastError = AUTH_INTERNAL_FAILURE;
            LogAccess(dwUserUID, AUTH_OP_CHANGE_PASSWORD, false, true);
            return false;
        }
        std::string strPassHash = BinaryToHex(binPassHash, sizeof(binPassHash));
        std::string strSqlQueryFmt("UPDATE %saccounts SET password='%s', salt='%s' WHERE id=%d;");
        if (DB->execute(FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(strPassHash).c_str(),
            Database::RealEscapeString(strSalt).c_str(),
            dwUserUID)) == 0) {
            mLastError = AUTH_INTERNAL_FAILURE;
            LogAccess(dwUserUID, AUTH_OP_CHANGE_PASSWORD, false, true);
            return false;
        }
        mLastError = AUTH_SUCCESS;
        return true;
    }
    catch (...) {
        LOG_ERROR("Exception thrown on DB access.");
        mLastError = AUTH_INTERNAL_FAILURE;
        LogAccess(0, AUTH_OP_CHANGE_PASSWORD, false, true);
        return false;
    }
}

Authentication::AUTHENTICATION_ERROR Authentication::GetLastAuthenticationError() const
{
    return mLastError;
}

std::string Authentication::GenerateSalt()
{
    LOG_DEBUG0("Called.");
    char szRandomChars[33] = { 0 };
    for (int i = 0; i < sizeof(szRandomChars) - 1; i++) {
        // Generate 10 printable characters (range 33-126)
        szRandomChars[i] = (rand() % 93) + 33;
    }
    szRandomChars[sizeof(szRandomChars) - 1] = '\0';
    return std::string(szRandomChars);
}

bool Authentication::CheckPasswordComplexity(const char* pszPassword)
{
    LOG_DEBUG0("Called.");
    if (LoginGlobalConfig::GetInstance()->GetConfigUInt("check_password_complexity") == 0) {
        LOG_DEBUG0("Complexity check disabled in settings.");
        return true;
    }
    size_t sPassLen = strlen(pszPassword);
    if (sPassLen < 8) {
        return false;
    }
    uint8_t cHasUppercase = 0;
    uint8_t cHasLowercase = 0;
    uint8_t cHasNumerics = 0;
    uint8_t cHasOthers = 0;
    for (size_t i = 0; i < sPassLen; i++) {
        if ((pszPassword[i] >= 'A') && (pszPassword[i] <= 'Z')) {
            cHasUppercase = 1;
        }
        else if ((pszPassword[i] >= 'a') && (pszPassword[i] <= 'z')) {
            cHasLowercase = 1;
        }
        else if ((pszPassword[i] >= '0') && (pszPassword[i] <= '9')) {
            cHasNumerics = 1;
        }
        else {
            cHasOthers = 1;
        }
    }
    return (cHasUppercase + cHasLowercase + cHasNumerics + cHasOthers) >= 3;
}

bool Authentication::LogAccess(uint32_t dwAccountId, AUTH_LOG_OPERATIONS dwOperation, bool bResult, bool bIPExempt)
{
    LOG_DEBUG0("Called.");
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();

    LOCK_DB;
    DBConnection DB = Database::GetDatabase();
    std::string strSqlQueryFmt;
    std::string strSqlFinalQuery;
    std::string strClientIP = inet_ntoa(mpConnection->GetConnectionDetails().BindDetails.sin_addr);
    if (bResult && !bIPExempt && Config->GetConfigUInt("one_account_per_ip")) {
        strSqlQueryFmt = "SELECT account_id FROM %slogin_log, %saccounts WHERE %slogin_log.account_id = %saccounts.id AND client_ip = '%s' AND account_id != %d AND account_id != 0 AND result != 0 AND login_time >= NOW() - INTERVAL 1 MONTH AND ((ip_exempt & 0x01) = 0) AND ((exempt & 0x01) = 0) LIMIT 1;";
        strSqlFinalQuery = FormatString(&strSqlQueryFmt,
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
            Database::RealEscapeString(strClientIP).c_str(),
            dwAccountId);
        mariadb::result_set_ref pLogFound = DB->query(strSqlFinalQuery);
        if (pLogFound && pLogFound->row_count() != 0) {
            // Another account already logged in from this IP address
            bResult = false;
        }
    }
    strSqlQueryFmt = "INSERT INTO %slogin_log (login_time, account_id, client_ip, operation, source, result, exempt) VALUES (NOW(), %d, '%s', %d, 1, %d, %d);";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        dwAccountId,
        Database::RealEscapeString(strClientIP).c_str(),
        static_cast<uint32_t>(dwOperation),
        (bResult ? 1 : 0),
        (bIPExempt ? 1 : 0));
    DB->query(strSqlFinalQuery);
    return bResult;
}

bool Authentication::IsIPAddressBlocked()
{
    LOG_DEBUG0("Called.");
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();

    LOCK_DB;
    DBConnection DB = Database::GetDatabase();
    std::string strSqlQueryFmt;
    std::string strSqlFinalQuery;
    std::string strClientIP = inet_ntoa(mpConnection->GetConnectionDetails().BindDetails.sin_addr);
    strSqlQueryFmt = "SELECT network_address FROM %sblocked_ranges WHERE (INET_ATON(network_address) & INET_ATON(subnet_mask)) = (INET_ATON(\"%s\") & INET_ATON(subnet_mask)) LIMIT 1;";
    strSqlFinalQuery = FormatString(&strSqlQueryFmt,
        Database::RealEscapeString(Config->GetConfigString("db_prefix")).c_str(),
        Database::RealEscapeString(strClientIP).c_str());
    mariadb::result_set_ref pBlockedResult = DB->query(strSqlFinalQuery);
    if (pBlockedResult && pBlockedResult->row_count() != 0) {
        // Another account already logged in from this IP address
        return true;
    }
    return false;
}
