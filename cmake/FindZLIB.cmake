# Try to find ZLIB
# ZLIB_FOUND - System has ZLIB
# ZLIB_LIBRARY - The libraries needed to use ZLIB
# ZLIB_INCLUDE_DIR - The ZLIB include directories

find_library(ZLIB_LIBRARY 
    NAMES 
        zlib1 libzlib1 zlib libz1 libz zlibstatic z z1
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

find_path(ZLIB_INCLUDE_DIR 
    NAMES 
        zlib.h
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/
        ${LOCAL_INCLUDE_PATH}/zlib/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(ZLIB DEFAULT_MSG ZLIB_LIBRARY ZLIB_INCLUDE_DIR)

message(STATUS "ZLIB_FOUND: ${ZLIB_FOUND}")
message(STATUS "ZLIB_LIBRARY: ${ZLIB_LIBRARY}")
message(STATUS "ZLIB_INCLUDE_DIR: ${ZLIB_INCLUDE_DIR}")

if (${ZLIB_FOUND})
    link_libraries(${ZLIB_LIBRARY})
    include_directories(${ZLIB_INCLUDE_DIR})
    include_directories(${ZLIB_INCLUDE_DIR}/../)
endif()
