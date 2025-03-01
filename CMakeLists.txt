cmake_minimum_required (VERSION 3.26)
project (CustomModules)

set(CMAKE_CXX_COMPILER clang++-18)
set(CMAKE_CXX_EXTENSIONS OFF) #uses -std=c++XX instead of -std=gnu++XX

set (FLAGS  -Wno-experimental-header-units
            -fmodules
            -Werror
            -Wall
            -Wextra
            -Wpedantic)

set (PRECOMPILED_STL -fmodule-file=../source/iostream.pcm)
set (CUSTOM_MODULES     -fprebuilt-module-path=${CMAKE_BINARY_DIR})

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/Math.pcm
    COMMAND ${CMAKE_CXX_COMPILER} -std=c++20 ${FLAGS} ${PRECOMPILED_STL} -x c++-module ../source/math.cppm --precompile -o Math.pcm
    DEPENDS ${CMAKE_BINARY_DIR}/../source/math.cppm
    COMMENT "Precompiling module math.cppm -> Math.pcm"
)

add_custom_command(
    OUTPUT  ${CMAKE_BINARY_DIR}/Math.o
    COMMAND ${CMAKE_CXX_COMPILER} -c ${CMAKE_BINARY_DIR}/Math.pcm -o ${CMAKE_BINARY_DIR}/Math.o
    DEPENDS ${CMAKE_BINARY_DIR}/Math.pcm
    COMMENT "Compiling module object Math.pcm -> Math.o"
)

add_executable(${PROJECT_NAME} main.cpp Math.o)

target_compile_options(${PROJECT_NAME} PRIVATE  ${FLAGS}
                                                ${PRECOMPILED_STL}
                                                ${CUSTOM_MODULES}
                                                )


set_target_properties(${PROJECT_NAME}   PROPERTIES
                                        CXX_STANDARD 20
                                        CXX_STANDARD_REQUIRED ON)

set (CMAKE_VERBOSE_MAKEFILE ON)

