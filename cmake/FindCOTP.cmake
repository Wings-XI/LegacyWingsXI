# Try to find COTP
# COTP_FOUND - System has COTP
# COTP_LIBRARY - The libraries needed to use COTP
# COTP_INCLUDE_DIR - The COTP include directories

find_library(COTP_LIBRARY 
    NAMES 
        cotp libcotp
    PATHS
        /lib/
        /lib/x86_64-linux-gnu/
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/		
        ${LOCAL_LIB_PATH})

find_path(COTP_INCLUDE_DIR 
    NAMES 
        cotp.h
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/
        ${LOCAL_INCLUDE_PATH}/cotp/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(COTP DEFAULT_MSG COTP_LIBRARY COTP_INCLUDE_DIR)

message(STATUS "COTP_FOUND: ${COTP_FOUND}")
message(STATUS "COTP_LIBRARY: ${COTP_LIBRARY}")
message(STATUS "COTP_INCLUDE_DIR: ${COTP_INCLUDE_DIR}")

if (${COTP_FOUND})
    link_libraries(${COTP_LIBRARY})
    include_directories(${COTP_INCLUDE_DIR})
    include_directories(${COTP_INCLUDE_DIR}/../)
endif()
