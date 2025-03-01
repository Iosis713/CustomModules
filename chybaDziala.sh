clang++-18 -std=c++20 -x c++-module source/math.cppm --precompile -o Math.pcm
clang++-18 -std=c++20 main.cpp -fprebuilt-module-path=. -c -o main.o
clang++-18 -std=c++20 Math.pcm -c -o Math.o
clang++-18 -std=c++20 main.o Math.o -o test


#test bo chyba dziala:
# download ninja:
# sudo apt install ninja-build  # Ubuntu/Debian

# install clang-tools
# sudo apt install clang-tools-18
# clang tools required for ninja
# while ninja required for Clang CMake

# reconfigure cmake to use ninja
# cmake -S . -B build -G Ninja -DCMAKE_CXX_COMPILER=clang++-18
# cmake --build build
# or find with:
# find / -name clang-scan-deps-18 2>/dev/null


#https://www.youtube.com/watch?v=n3mJY8ZTSAI
#https://www.youtube.com/watch?v=9OwQZ-LRb0c
