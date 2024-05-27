# ---- Add the subdirectory cmake ----
set(CMAKE_CONFIG_PATH ${CMAKE_MODULE_PATH}  "${PROJECT_SOURCE_DIR}/cmake")

if(BTCPP_GROOT_INTERFACE)
    find_package(ZeroMQ CONFIG REQUIRED)
    if (NOT ZeroMQ_FOUND)
        message(FATAL_ERROR "ZeroMQ not found")
    endif()

    list(APPEND BTCPP_EXTRA_LIBRARIES libzmq)
    list(APPEND BTCPP_EXTRA_INCLUDE_DIRS ${ZeroMQ_INCLUDE_DIR})

    include_directories(${ZeroMQ_INCLUDE_DIR})

    message(STATUS "ZeroMQ_LIBRARIES: ${ZeroMQ_LIBRARY}")
endif()

if(BTCPP_SQLITE_LOGGING)
    find_package(SQLite3 REQUIRED)
    list(APPEND BTCPP_EXTRA_LIBRARIES ${SQLite3_LIBRARIES})
    include_directories(${SQLite3_INCLUDE_DIRS})
    link_directories(${SQLite3_LIBRARY_DIRS})
    message(STATUS "SQLite3_LIBRARIES: ${SQLite3_LIBRARIES}")
endif()


set( BTCPP_LIB_DESTINATION     lib )
set( BTCPP_INCLUDE_DESTINATION include )
set( BTCPP_BIN_DESTINATION     bin )

mark_as_advanced(
    BTCPP_EXTRA_LIBRARIES
    BTCPP_LIB_DESTINATION
    BTCPP_INCLUDE_DESTINATION
    BTCPP_BIN_DESTINATION )

macro(export_btcpp_package)

    install(EXPORT ${PROJECT_NAME}Targets
        FILE "${PROJECT_NAME}Targets.cmake"
        DESTINATION "${BTCPP_LIB_DESTINATION}/cmake/${PROJECT_NAME}"
        NAMESPACE BT::
        )
    export(PACKAGE ${PROJECT_NAME})

    include(CMakePackageConfigHelpers)

    configure_package_config_file(
        "${PROJECT_SOURCE_DIR}/cmake/Config.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
        INSTALL_DESTINATION "${BTCPP_LIB_DESTINATION}/cmake/${PROJECT_NAME}"
        )

    install(
        FILES
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
        DESTINATION "${BTCPP_LIB_DESTINATION}/cmake/${PROJECT_NAME}"
        )
endmacro()
