/**
 *	@file LoginMain.cpp
 *	Main body and initialization
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "../new-common/Debugging.h"
#include "../new-common/Database.h"
#include "../new-common/SSLConnection.h"
#include "LoginGlobalConfig.h"
#include "WorldManager.h"
#include "LoginServer.h"
#include "ProtocolFactory.h"
#include "SessionTracker.h"

#include <signal.h>
#include <time.h>
#include <thread>
#include <chrono>
#include <string>

#ifdef _WIN32
#include <io.h>
#define close _close
#define fileno _fileno
#else
#include <unistd.h>
#endif

bool gbExitFlag = false;

void LoginSignalHandler(int signal)
{
    gbExitFlag = true;
    // If we do a UI then the main thread is likely to be blocked reading
    // from the keyboard. Close stdin so the signal can be processed.
    close(fileno(stdin));
}

int main(int argc, char* argv[])
{
    LOG_INFO("Starting.");
    signal(SIGTERM, LoginSignalHandler);
    signal(SIGINT, LoginSignalHandler);
    srand(static_cast<unsigned int>(time(NULL)));

    // Load global configuration
    GlobalConfigPtr Config = LoginGlobalConfig::GetInstance();
    WorldManagerPtr WorldMgr = WorldManager::GetInstance();
    // Connect to database
    DatabasePtr DB = Database::Initialize(Config->GetConfigString("db_server").c_str(),
        Config->GetConfigUInt("db_port"),
        Config->GetConfigString("db_username").c_str(),
        Config->GetConfigString("db_password").c_str(),
        Config->GetConfigString("db_database").c_str(),
        Config->GetConfigUInt("db_ssl"),
        Config->GetConfigUInt("db_ssl_verify"),
        Config->GetConfigString("db_ssl_ca").c_str(),
        Config->GetConfigString("db_ssl_cert").c_str(),
        Config->GetConfigString("db_ssl_key").c_str());
    SessionTracker::GetInstance();

    LoginServer LoginServerInstance;
    uint32_t dwSSLSettings = Config->GetConfigUInt("ssl_enabled");
    if (dwSSLSettings != 2) {
        // Authentication server
        LoginServerInstance.AddBind(ProtocolFactory::PROTOCOL_AUTH, Config->GetConfigUInt("auth_port"));
    }
    if (dwSSLSettings == 1 || dwSSLSettings == 2) {
        SSLConnection::InitSSL();
        LoginServerInstance.AddBind(ProtocolFactory::PROTOCOL_AUTH, Config->GetConfigUInt("ssl_auth_port"), (const char*)0, true);
        // Commented out since it puts too much stress on the server.
        // LoginServerInstance.AddBind(ProtocolFactory::PROTOCOL_DATA, Config->GetConfigUInt("ssl_data_port"), (const char*)0, true);
    }
    // Key management and character list server (communicates with the bootloader)
    LoginServerInstance.AddBind(ProtocolFactory::PROTOCOL_DATA, Config->GetConfigUInt("data_port"));
    // Lobby server (communicates with the game client). Port not configurable because it's
    // hardcoded in the game client.
    LoginServerInstance.AddBind(ProtocolFactory::PROTOCOL_VIEW, 54001);
    LoginServerInstance.StartThread();

    LOG_INFO("Initialization complete, server is running.");

    // Check that it runs
    while (LoginServerInstance.IsRunning() == false) {
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
    }
    while ((gbExitFlag == false) && (LoginServerInstance.IsRunning())) {
        // TODO: Maybe should add some UI code here
        std::this_thread::sleep_for(std::chrono::milliseconds(1));
    }

    LOG_INFO("Shutting down server.");

    LoginServerInstance.Shutdown();
    SessionTracker::GetInstance()->Destroy();
    if (dwSSLSettings == 1 || dwSSLSettings == 2) {
        SSLConnection::CleanupSSL();
    }
    DB->Destroy();
    WorldMgr->Destroy();
    Config->Destroy();

    LOG_INFO("Shutdown complete.");
}