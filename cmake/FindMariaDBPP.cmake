# Try to find MARIADBPP
# MARIADBPP_FOUND - System has MARIADBPP
# MARIADBPP_LIBRARY - The libraries needed to use MARIADBPP
# MARIADBPP_INCLUDE_DIR - The MARIADBPP include directories

find_library(MARIADBPP_LIBRARY 
    NAMES 
        "mariadbclientpp" "libmariadbclientpp"
    PATHS
        ${LOCAL_LIB_PATH}
        ${PROJECT_SOURCE_DIR}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

find_library(MARIADBPP_LIBRARY_DEBUG
    NAMES 
        "mariadbclientpp-d" "libmariadbclientpp-d"
    PATHS
        ${LOCAL_LIB_PATH}
        ${PROJECT_SOURCE_DIR}
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

find_path(MARIADBPP_INCLUDE_DIR 
    NAMES 
        result_set.hpp
    PATHS
        ${LOCAL_INCLUDE_PATH}/mariadb++/
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MariaDBPP DEFAULT_MSG MARIADBPP_LIBRARY MARIADBPP_INCLUDE_DIR)

message(STATUS "MARIADBPP_FOUND: ${MARIADBPP_FOUND}")
message(STATUS "MARIADBPP_LIBRARY: ${MARIADBPP_LIBRARY}")
message(STATUS "MARIADBPP_INCLUDE_DIR: ${MARIADBPP_INCLUDE_DIR}")

if (${MARIADBPP_FOUND})
    #link_libraries(${MARIADBPP_LIBRARY})
    include_directories(${MARIADBPP_INCLUDE_DIR})
    include_directories(${MARIADBPP_INCLUDE_DIR}/../)
    if (NOT MARIADBPP_LIBRARY_DEBUG)
        set(MARIADBPP_LIBRARY_DEBUG ${MARIADBPP_LIBRARY})
    endif()
endif()
