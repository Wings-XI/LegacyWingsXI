set(SOURCES
    automatonentity.cpp
    automatonentity.h
    baseentity.cpp
    baseentity.h
    battleentity.cpp
    battleentity.h
    charentity.cpp
    charentity.h
    fellowentity.cpp
    fellowentity.h
    mobentity.cpp
    mobentity.h
    npcentity.cpp
    npcentity.h
    petentity.cpp
    petentity.h
    trustentity.cpp
    trustentity.h)

add_library(entities STATIC ${SOURCES})

target_link_libraries(entities
    PUBLIC
    common
    ai
    project_options
    #project_warnings
)
