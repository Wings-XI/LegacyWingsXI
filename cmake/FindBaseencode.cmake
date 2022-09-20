# Try to find Baseencode
# BASEENCODE_FOUND - System has Baseencode
# BASEENCODE_LIBRARY - The libraries needed to use Baseencode
# BASEENCODE_INCLUDE_DIR - The Baseencode include directories

find_library(BASEENCODE_LIBRARY 
    NAMES 
        baseencode libbaseencode
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

find_path(BASEENCODE_INCLUDE_DIR 
    NAMES 
        baseencode.h
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/
        ${LOCAL_INCLUDE_PATH}/baseencode/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(BASEENCODE DEFAULT_MSG BASEENCODE_LIBRARY BASEENCODE_INCLUDE_DIR)

message(STATUS "BASEENCODE_FOUND: ${BASEENCODE_FOUND}")
message(STATUS "BASEENCODE_LIBRARY: ${BASEENCODE_LIBRARY}")
message(STATUS "BASEENCODE_INCLUDE_DIR: ${BASEENCODE_INCLUDE_DIR}")

if (${BASEENCODE_FOUND})
    link_libraries(${BASEENCODE_LIBRARY})
    include_directories(${BASEENCODE_INCLUDE_DIR})
    include_directories(${BASEENCODE_INCLUDE_DIR}/../)
endif()
