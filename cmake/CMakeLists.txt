cmake_minimum_required(VERSION 3.15)

project(LearnCpp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (CMAKE_GENERATOR MATCHES "MinGW Makefiles")
    set(CMAKE_CXX_COMPILER g++)
endif()

# For multi-config generators such as Visual Studio.
if (CMAKE_CONFIGURATION_TYPES)

# For single-config generators such as MakeFile.
else()
    # Default to Debug if build type is not specified by users.
    if (NOT CMAKE_BUILD_TYPE)
		set(CMAKE_BUILD_TYPE Debug CACHE STRING "Set default build type to Debug")
	endif()
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

file(GLOB HEADER_FILES 
    ${CMAKE_CURRENT_SOURCE_DIR}/split_string/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/split_string/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/smart_pointer/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/smart_pointer/*.hpp
)

file(GLOB_RECURSE SRC_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/split_string/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/split_string/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/smart_pointer/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/smart_pointer/*.cpp
)

set(EXE_NAME "LearnCpp")

if(MSVC)
	add_executable(${EXE_NAME} main.cpp ${SRC_FILES} ${HEADER_FILES})

	source_group("Header Files" FILES ${HEADER_FILES})
    set_target_properties(${EXE_NAME} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$(Configuration)")
    set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})
else()
	add_executable(${EXE_NAME} main.cpp ${SRC_FILES})
endif()

target_include_directories(
    ${EXE_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/split_string
    ${CMAKE_CURRENT_SOURCE_DIR}/smart_pointer
)

