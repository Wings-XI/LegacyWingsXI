# Try to find OpenSSL
# OPENSSL_FOUND - System has OpenSSL
# OPENSSL_CRYPTO_LIBRARY - LibCrypto
# OPENSSL_SSL_LIBRARY - LibSSL
# OPENSSL_INCLUDE_DIR - The OpenSSL include directories

find_library(OPENSSL_CRYPTO_LIBRARY 
    NAMES 
        crypto crypto-3 libcrypto libcrypto-3
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/		
        ${LOCAL_LIB_PATH})

find_library(OPENSSL_SSL_LIBRARY 
    NAMES 
        ssl ssl-3 libssl libssl-3
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/		
        ${LOCAL_LIB_PATH})

find_path(OPENSSL_INCLUDE_DIR 
    NAMES 
        openssl/crypto.h
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/
        ${LOCAL_INCLUDE_PATH}/openssl/)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenSSL DEFAULT_MSG OPENSSL_CRYPTO_LIBRARY OPENSSL_SSL_LIBRARY OPENSSL_INCLUDE_DIR)

message(STATUS "OPENSSL_FOUND: ${OPENSSL_FOUND}")
message(STATUS "OPENSSL_CRYPTO_LIBRARY: ${OPENSSL_CRYPTO_LIBRARY}")
message(STATUS "OPENSSL_SSL_LIBRARY: ${OPENSSL_SSL_LIBRARY}")
message(STATUS "OPENSSL_INCLUDE_DIR: ${OPENSSL_INCLUDE_DIR}")

if (${OPENSSL_FOUND})
    link_libraries(${OPENSSL_CRYPTO_LIBRARY})
    link_libraries(${OPENSSL_SSL_LIBRARY})
    include_directories(${OPENSSL_INCLUDE_DIR})
endif()
