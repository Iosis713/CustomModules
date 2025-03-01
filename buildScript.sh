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

#Ninja is required to build custom modules with clang in a simpler way instead of directly linking obj files
if ! dpkg-query -l ninja-build &>/dev/null; then
    echo "ninja-build is not installed. Installing..."
    sudo apt update && sudo apt install -y ninja-build
else
    echo "ninja-build is already installed."
fi

# Check if clang-tools-18 is installed
if ! dpkg-query -l clang-tools-18 &>/dev/null; then
    echo "clang-tools-18 is not installed. Installing..."
    sudo apt update && sudo apt install -y clang-tools-18
else
    echo "clang-tools-18 is already installed."
fi

echo "Building main project"

cmake -S . -B build -G Ninja -DCMAKE_CXX_COMPILER=clang++-18
cmake --build build

echo "Modules building - FINISHED"

