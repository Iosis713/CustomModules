cmake_minimum_required (VERSION 3.26)
project (CustomModules LANGUAGES CXX) #excplicitly specified for which language cmake shall work

set (CMAKE_CXX_COMPILER clang++-18)
set (CMAKE_CXX_EXTENSIONS OFF) #uses -std=c++XX instead of -std=gnu++XX
set (CMAKE_CXX_SCAN_FOR_MODULES ON)
set(CMAKE_CXX_COMPILER_CLANG_SCAN_DEPS "/usr/bin/clang-scan-deps-18")

set (FLAGS  -Wno-experimental-header-units
            -fmodules
            -Werror
            -Wall
            -Wextra
            -Wpedantic)

#probably could be also in some system files, instead of project files
set (PRECOMPILED_STL -fmodule-file=../source/iostream.pcm)

add_library (MathModule STATIC)
target_compile_features (MathModule PUBLIC cxx_std_20)
target_sources (MathModule PUBLIC FILE_SET modules TYPE CXX_MODULES FILES source/math.cppm)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries (${PROJECT_NAME} PRIVATE MathModule)

target_compile_options (MathModule PRIVATE ${FLAGS}
                                           ${PRECOMPILED_STL})

target_compile_options(${PROJECT_NAME} PRIVATE  ${FLAGS}
                                                ${PRECOMPILED_STL})

set_target_properties(MathModule   PROPERTIES
                                   CXX_STANDARD 20
                                   CXX_STANDARD_REQUIRED ON)

set_target_properties(${PROJECT_NAME}   PROPERTIES
                                        CXX_STANDARD 20
                                        CXX_STANDARD_REQUIRED ON)

set (CMAKE_VERBOSE_MAKEFILE ON)

