project(new-common)

set(SOURCES
    BlowfishMod.c
    BlowfishMod.h
    CommonMessages.h
    Database.cpp
    Database.h
    Debugging.c
    Debugging.h
    FFXIPacket.cpp
    FFXIPacket.h
    GlobalConfig.cpp
    GlobalConfig.h
    MQConnection.cpp
    MQConnection.h
    MQHandler.cpp
    MQHandler.h
    TCPConnection.cpp
    TCPConnection.h
    Thread.cpp
    Thread.h
    Utilities.cpp
    Utilities.h
    WorldDBConnection.cpp
    WorldDBConnection.h)

add_library(new-common STATIC ${SOURCES})

target_link_libraries(
  new-common
  PUBLIC
  project_options
  # project_warnings
  )
 
#if(TRACY_ENABLE)
#    target_link_libraries(common PUBLIC tracy_client)
#endif(TRACY_ENABLE)
