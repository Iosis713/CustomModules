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

set (CMAKE_CXX_COMPILER "/usr/bin/clang++-18")

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


#add_library(ModulesLib ${CUSTOM_MODULES})

#Add module library
add_library(math_module OBJECT)
target_sources(math_module PRIVATE source/math.cppm)
target_compile_options(math_module PRIVATE -x c++-module --precompile)
set_target_properties(math_module PROPERTIES OUTPUT_NAME "Math")

# Compile module object
add_library(math_obj OBJECT)
target_sources(math_obj PRIVATE Math.o)
target_compile_options(math_obj PRIVATE -std=c++20 -c)
add_dependencies(math_obj math_module)


add_executable(${PROJECT_NAME} main.cpp Math.o)
#target_link_libraries(${PROJECT_NAME} PRIVATE math_obj)


#target_link_libraries(${PROJECT_NAME}   PRIVATE ModulesLib)
#target_compile_options(ModulesLib PRIVATE ${FLAGS})


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

