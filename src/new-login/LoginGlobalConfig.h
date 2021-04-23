/**
 *	@file LoginGlobalConfig.h
 *	Reads and stores the global configuration
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#ifndef FFXI_LOGIN_LOGINGLOBALCONFIG_H
#define FFXI_LOGIN_LOGINGLOBALCONFIG_H

#include "../new-common/GlobalConfig.h"

 // Default configuration file name
#ifdef _WIN32
#define DEFAULT_CONFIG_FILE_NAME "conf\\login.conf"
#else
#define DEFAULT_CONFIG_FILE_NAME "conf/login.conf"
#endif

/**
 *  Singleton class for reading and accessing configuration.
 */
class LoginGlobalConfig : public GlobalConfig
{
public:

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
     *  Destructor, closes the config file. Generally calling Destroy
     *  explicitly is much safer.
     */
    ~LoginGlobalConfig();

private:

    /**
     *  Read and parse a configuration file.
     *  @param strConfigFileName Name of the configuration file to parse
     */
    LoginGlobalConfig(const std::string& strConfigFileName);

    /**
     *  Default constructor, read and parse the default configuration
     */
    LoginGlobalConfig();

    /**
     *  Get a hardcoded default value for the given configuration value.
     *  @param strConfigName Name of the configuration value to fetch
     *  @return The configuration value content
     */
    virtual std::string GetDefaultValue(const std::string& strConfigName);

};

#endif
