set(SOURCES
    Authentication.cpp
    Authentication.h
    AuthHandler.cpp
    AuthHandler.h
    CharMessageHnd.cpp
    CharMessageHnd.h
    DataHandler.cpp
    FFXILoginPacket.cpp
    FFXILoginPacket.h
    LoginGlobalConfig.cpp
    LoginGlobalConfig.h
    LoginMain.cpp
    LoginServer.cpp
    LoginServer.h
    LoginSession.cpp
    LoginSession.h
    ProtocolFactory.cpp
    ProtocolFactory.h
    ProtocolHandler.cpp
    ProtocolHandler.h
    SessionTracker.cpp
    SessionTracker.h
    ViewHandler.cpp
    ViewHandler.h
    WorldManager.cpp
    WorldManager.h)

if(UNIX)
    set(resource "")
else()
    set(resource "${CMAKE_SOURCE_DIR}/res/connectserver.rc")
endif()

add_executable(topaz_new_connect ${SOURCES} ${resource})

if(WIN32)
    set_target_properties(topaz_new_connect PROPERTIES OUTPUT_NAME topaz_new_connect${spacer}${platform_suffix} DEBUG_POSTFIX _d)
endif()

target_compile_definitions(
    topaz_new_connect
    PUBLIC
)

target_link_libraries(topaz_new_connect
    PUBLIC
	debug ${MARIADBPP_LIBRARY_DEBUG}
	optimized ${MARIADBPP_LIBRARY}
    new-common
    project_options
    #project_warnings
)

set_property(TARGET topaz_new_connect PROPERTY VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_PROJECT_SOURCE_DIR}")
