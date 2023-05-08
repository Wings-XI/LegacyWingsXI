set(SOURCES
    DetourAlloc.cpp
    DetourAlloc.h
    DetourAssert.cpp
    DetourAssert.h
    DetourCommon.cpp
    DetourCommon.h
    DetourMath.h
    DetourNavMesh.cpp
    DetourNavMesh.h
    DetourNavMeshBuilder.cpp
    DetourNavMeshBuilder.h
    DetourNavMeshQuery.cpp
    DetourNavMeshQuery.h
    DetourNode.cpp
    DetourNode.h
    DetourStatus.h)

add_library(detour STATIC ${SOURCES})
