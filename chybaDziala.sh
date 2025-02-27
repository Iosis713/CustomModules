clang++-18 -std=c++20 -x c++-module source/math.cppm --precompile -o Math.pcm
clang++-18 -std=c++20 main.cpp -fprebuilt-module-path=. -c -o main.o
clang++-18 -std=c++20 Math.pcm -c -o Math.o
clang++-18 -std=c++20 main.o Math.o -o test


#https://www.youtube.com/watch?v=n3mJY8ZTSAI
