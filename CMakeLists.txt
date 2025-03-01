cmake_minimum_required (VERSION 3.26)
project (CustomModules LANGUAGES CXX)

set(CMAKE_CXX_COMPILER clang++-18)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set (FLAGS  -Wno-experimental-header-units
            -std=c++20
            -fmodules
            -Werror
            -Wall
            -Wextra
            -Wpedantic
        )

#set (PRECOMPILED_STL   -fmodule-file=../source/iostream.pcm)
set (CUSTOM_MODULES     -fprebuilt-module-path=../source)

####TEST

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/Math.pcm
    COMMAND ${CMAKE_CXX_COMPILER} -std=c++20 -x c++-module ../source/math.cppm --precompile -o Math.pcm
    DEPENDS ${CMAKE_BINARY_DIR}/../source/math.cppm
    COMMENT "Precompiling module math.cppm -> Math.pcm"
)

add_custom_command(
    OUTPUT  Math.o
    COMMAND ${CMAKE_CXX_COMPILER} -std=c++20 -c Math.pcm -o Math.o
    DEPENDS ./Math.pcm
    COMMENT "Compiling module object Math.pcm -> Math.o"
)

####TEST

add_executable(${PROJECT_NAME} main.cpp Math.o)
target_compile_options(${PROJECT_NAME} PRIVATE  #${FLAGS}
                                                #${PRECOMPILED_STL}
                                                #${CUSTOM_MODULES}
                                                -fprebuilt-module-path=.
                                                -fmodules
                                                )





set_target_properties(${PROJECT_NAME}   PROPERTIES
                                        CXX_STANDARD 20
                                        CXX_STANDARD_REQUIRED ON)

set (CMAKE_VERBOSE_MAKEFILE ON)

