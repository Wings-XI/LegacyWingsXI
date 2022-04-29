/**
 *	@file GlobalConfig.cpp
 *	Reads and stores the global configuration
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "LoginGlobalConfig.h"
#include "../new-common/Debugging.h"

LoginGlobalConfig::LoginGlobalConfig() : GlobalConfig(std::string(DEFAULT_CONFIG_FILE_NAME))
{
    LOG_DEBUG0("Called.");
}

LoginGlobalConfig::LoginGlobalConfig(const std::string& strConfigFileName) : GlobalConfig(strConfigFileName)
{
    LOG_DEBUG0("Called.");
}

LoginGlobalConfig::~LoginGlobalConfig()
{
}

GlobalConfigPtr LoginGlobalConfig::GetInstance()
{
    if (smpSingletonObj == NULL) {
        smpSingletonObj = new LoginGlobalConfig(std::string(DEFAULT_CONFIG_FILE_NAME));
    }
    return smpSingletonObj;
}

GlobalConfigPtr LoginGlobalConfig::GetInstance(const std::string& strConfigFileName)
{
    if (smpSingletonObj == NULL) {
        smpSingletonObj = new LoginGlobalConfig(strConfigFileName);
    }
    return smpSingletonObj;
}

std::string LoginGlobalConfig::GetDefaultValue(const std::string& strConfigName)
{
    LOG_DEBUG0("Called.");
    if (strConfigName == "db_server") {
        return "127.0.0.1";
    }
    else if (strConfigName == "db_port") {
        return "3306";
    }
    else if (strConfigName == "db_database") {
        return "topaz_login";
    }
    else if (strConfigName == "db_username") {
        return "topaz";
    }
    else if (strConfigName == "db_password") {
        return "topaz";
    }
    else if (strConfigName == "db_prefix") {
        return "";
    }
    else if (strConfigName == "db_ssl") {
        return "0";
    }
    else if (strConfigName == "db_ssl_verify") {
        return "0";
    }
    else if (strConfigName == "db_ssl_ca") {
        return "";
    }
    else if (strConfigName == "db_ssl_cert") {
        return "";
    }
    else if (strConfigName == "db_ssl_key") {
        return "";
    }
    else if (strConfigName == "auth_port") {
        return "54231";
    }
    else if (strConfigName == "data_port") {
        return "54230";
    }
    else if (strConfigName == "login_ip") {
        return "0.0.0.0";
    }
    else if (strConfigName == "ssl_enabled") {
        return "0";
    }
    else if (strConfigName == "ssl_certificate_file") {
        return "";
    }
    else if (strConfigName == "ssl_private_key_file") {
        return "";
    }
    else if (strConfigName == "ssl_auth_port") {
        return "54331";
    }
    else if (strConfigName == "ssl_data_port") {
        return "54330";
    }
    else if (strConfigName == "password_hash_secret") {
        // Secret to add to password hashes, change this to something random
        return "";
    }
    else if (strConfigName == "disable_user_registrations") {
        // Users cannot sign up using the bootloader
        return "0";
    }
    else if (strConfigName == "new_account_content_ids") {
        // Number of content ids to associate with new accounts
        return "3";
    }
    else if (strConfigName == "max_login_attempts") {
        // Max number of login attempts before the client is disconnected
        return "3";
    }
    else if (strConfigName == "max_client_connections") {
        // Max number of concurrent connections a single client
        // can have open. Note - Each client needs at least 3 concurrent
        // connections (auth, data and view)
        return "10";
    }
    else if (strConfigName == "session_timeout") {
        return "30";
    }
    else if (strConfigName == "expected_client_version") {
        return "30191004_0";
    }
    else if (strConfigName == "version_lock") {
        // 0 - No version lock
        // 1 - Version lock, only expected client version can connect
        // 2 - One way version lock, expected client version or greater can connect
        return "0";
    }
    else if (strConfigName == "allow_concurrent_logins") {
        // Allow more than a single character to be logged-in to the same
        // world concurrently.
        return "0";
    }
    else if (strConfigName == "real_delete_char") {
        // 1 - Actually delete rows from the DB when deleting a char
        // 0 - Mark the char as deleted but do not remove rows
        return "0";
    }
    else if (strConfigName == "delete_char_cooldown") {
        // Do not allow deletion of characters created less than
        // the configured number in minutes. Set to zero to disable
        // and allow character deletion regardless of time.
        return "0";
    }
    else if (strConfigName == "maintenance_mode") {
        // The server is in maintenance mode, only those with special
        // permission can log-in.
        return "0";
    }
    else if (strConfigName == "check_password_complexity") {
        // Force a complex password when creating new accounts or when
        // changing passwords.
        return "0";
    }
    else if (strConfigName == "one_account_per_ip") {
        // Allow only a single account per IP address unless exempt
        return "0";
    }
    else if (strConfigName == "ip_lookup_identification") {
        // Use the old IP lookup method for data and view server
        // user identification.
        return "0";
    }
    LOG_ERROR("No default configuration value found.");
    throw std::runtime_error("Configuration value does not have a hardcoded default");
}
