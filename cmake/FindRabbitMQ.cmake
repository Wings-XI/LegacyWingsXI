# Try to find RabbitMQ
# RabbitMQ_FOUND - System has RabbitMQ
# RabbitMQ_LIBRARY - The libraries needed to use RabbitMQ
# RabbitMQ_INCLUDE_DIR - The RabbitMQ include directories

find_library(RabbitMQ_LIBRARY 
    NAMES 
        "rabbitmq.4" "librabbitmq.4" "rabbitmq" "librabbitmq"
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/
        ${LOCAL_LIB_PATH}
        ${PROJECT_SOURCE_DIR})

find_path(RabbitMQ_INCLUDE_DIR 
    NAMES 
        amqp.h
    PATHS
        /usr/
        /usr/bin/
        /usr/include/
        /usr/lib/
        /usr/local/
        /usr/local/bin/
        /opt/
        ${LOCAL_INCLUDE_PATH}
        ${LOCAL_INCLUDE_PATH}/rabbitmq)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(RabbitMQ DEFAULT_MSG RabbitMQ_LIBRARY RabbitMQ_INCLUDE_DIR)

message(STATUS "RabbitMQ_FOUND: ${RabbitMQ_FOUND}")
message(STATUS "RabbitMQ_LIBRARY: ${RabbitMQ_LIBRARY}")
message(STATUS "RabbitMQ_INCLUDE_DIR: ${RabbitMQ_INCLUDE_DIR}")

if (${RabbitMQ_FOUND})
    link_libraries(${RabbitMQ_LIBRARY})
    include_directories(${RabbitMQ_INCLUDE_DIR})
    include_directories(${RabbitMQ_INCLUDE_DIR}/../)
endif()
