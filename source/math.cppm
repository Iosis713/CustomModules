export module Math;

//module;
//#include <iostream>

//export module Math;

export int add(const int first, const int second)
{
    return first + second;
}
    
export int rem(const int first, const int second)
{
    return first - second;
}

/*
export void print(const std::string& str)
{
    std::cout << str << '\n';
}

export class Calculator
{
public:
    Calculator() = default;
    ~Calculator() = default;

    int subtract(const int first, const int second) const
    {
        return first - second;
    }
    
    void print(const std::string& str)
    {
        std::cout << str << '\n';
    }
};
*/
