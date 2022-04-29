/**
 *	@file GlobalConfig.h
 *	Reads and stores the global configuration
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_GLOBALCONFIG_H
#define FFXI_COMMON_GLOBALCONFIG_H

#include <string>
#include <unordered_map>
#include <stddef.h>
#include <stdio.h>
#include <mutex>

// Easy way to lock the config mutex
#define LOCK_CONFIG std::lock_guard<std::recursive_mutex> l_config(*GlobalConfig::GetMutex())

class GlobalConfig;
typedef GlobalConfig* GlobalConfigPtr;

/**
 *  Singleton class for reading and accessing configuration.
 */
class GlobalConfig
{
public:

    /**
     *  Get a string type configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual std::string GetConfigString(const std::string& strConfigName);

    /**
     *  Get a string type configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual std::string GetConfigString(const char* pszConfigName);

    /**
     *  Get an interger type configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual int32_t GetConfigInt(const std::string& strConfigName);

    /**
     *  Get an interger type configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual int32_t GetConfigInt(const char* pszConfigName);

    /**
     *  Get an unsigned interger type configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual uint32_t GetConfigUInt(const std::string& strConfigName);

    /**
     *  Get an unsigned interger type configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual uint32_t GetConfigUInt(const char* pszConfigName);

    /**
     *  Get an instance of the configuration. The object is created
     *  on the first call.
     */
    static GlobalConfigPtr GetInstance();

    /**
     *  Get an instance of the configuration. The object is created
     *  on the first call, using the given configuration file name.
     *  On sequent calls this argument is ignored.
     *  @param strConfigFileName Name of the configuration file
     */
    static GlobalConfigPtr GetInstance(const std::string& strConfigFileName);

    /**
     *  Gets the global database Mutex object. Lock this before
     *  any database access.
     *  @return Database mutex object.
     */
    static std::recursive_mutex* GetMutex();

    /**
     *  Destroy and remove the current instance. Allows reloading of
     *  the configuration file. Should generally be called only before
     *  the server ends execution.
     */
    static void Destroy();

    /**
     *  Destructor, closes the config file. Generally calling Destroy
     *  explicitly is much safer.
     */
    virtual ~GlobalConfig();

protected:

    /**
     *  Read and parse a configuration file.
     *  @param strConfigFileName Name of the configuration file to parse
     */
    GlobalConfig(const std::string& strConfigFileName);

    /**
     *  Trim leading and trailing whitespaces from strings in place.
     *  @param str The string to trim
     */
    static void trim(std::string& str);

    /**
     *  Get a hardcoded default value for the given configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual std::string GetDefaultValue(const std::string& strConfigName);

    /// Hashmap containing all configuration string values read to far
    std::unordered_map<std::string, std::string> mmapStringVals;
    /// Hashmap containing all configuration int32 values read to far
    std::unordered_map<std::string, int32_t> mmapIntVals;
    /// Hashmap containing all configuration uint32 values read to far
    std::unordered_map<std::string, uint32_t> mmapUIntVals;

    /// Handle to the open configuration file
    FILE* mhConfigFile;

    /// Current singleton object
    static GlobalConfigPtr smpSingletonObj;
    /// Current object is already being destroyed
    static bool sbBeingDestroyed;
    /// Config access mutex
    std::recursive_mutex mMutex;
};

#endif
