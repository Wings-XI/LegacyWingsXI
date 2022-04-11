set(SOURCES
    automaton_controller.cpp
    automaton_controller.h
    controller.cpp
    controller.h
    fellow_controller.cpp
    fellow_controller.h
    mob_controller.cpp
    mob_controller.h
    pet_controller.cpp
    pet_controller.h
    player_charm_controller.cpp
    player_charm_controller.h
    player_controller.cpp
    player_controller.h
	spirit_controller.cpp
	spirit_controller.h
	targeted_avatar_controller.cpp
	targeted_avatar_controller.h
    trust_controller.cpp
    trust_controller.h)

add_library(ai_controllers STATIC ${SOURCES})

target_link_libraries(ai_controllers
    PUBLIC
    common
    project_options
    #project_warnings
)
