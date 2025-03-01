#!/bin/bash

echo "Modules building - STARTED"

if ! [ -d source ]; then
    mkdir source
fi

if ! [ -f iostream.pcm ]; then
    cd source
    echo "Building Iostream module to precompiled file"
    clang++-18 -std=gnu++20 -std=c++20 -fmodules -Wno-experimental-header-units -Wall -Wpedantic -Wextra -xc++-system-header iostream -o iostream.pcm
    cd ..
fi

echo "Building main project"

if ! [ -d build ]; then
    mkdir build
fi

cd build
cmake ..
make -j

echo "Modules building - FINISHED"

