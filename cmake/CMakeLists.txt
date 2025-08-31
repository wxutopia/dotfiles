cmake_minimum_required(VERSION 3.15)

project(cpputil LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (CMAKE_GENERATOR MATCHES "MinGW Makefiles")
    set(CMAKE_CXX_COMPILER g++)
    set(CMAKE_C_COMPILER gcc)
endif()

# For multi-config generators such as Visual Studio.
if (CMAKE_CONFIGURATION_TYPES)

# For single-config generators such as MakeFile.
else()
    # Default to Debug if build type is not specified by users.
    if (NOT CMAKE_BUILD_TYPE)
		set(CMAKE_BUILD_TYPE Debug CACHE STRING "Set default build type to Debug.")
	endif()
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(EXE_NAME "cpputil")

file(GLOB_RECURSE HEADER_FILES 
    ${CMAKE_CURRENT_SOURCE_DIR}/smartptr/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/smartptr/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/strutil/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/strutil/*.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/test/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/test/*.hpp
)

file(GLOB_RECURSE SRC_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/smartptr/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/smartptr/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/strutil/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/strutil/*.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/test/*.c
    ${CMAKE_CURRENT_SOURCE_DIR}/test/*.cpp
)

if(CMAKE_GENERATOR MATCHES "Visual Studio")
	add_executable(${EXE_NAME} ${SRC_FILES} ${HEADER_FILES})

	source_group(
        TREE "${CMAKE_CURRENT_SOURCE_DIR}" 
        PREFIX "Header Files" 
        FILES ${HEADER_FILES}
    )
	source_group(
        TREE "${CMAKE_CURRENT_SOURCE_DIR}" 
        PREFIX "Source Files" 
        FILES ${SRC_FILES}
    )

    set_target_properties(${EXE_NAME} PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$(Configuration)")

    set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${EXE_NAME})
else()
	add_executable(${EXE_NAME} ${SRC_FILES})
endif()

target_include_directories(
    ${EXE_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/strutil
    ${CMAKE_CURRENT_SOURCE_DIR}/smartptr
)
