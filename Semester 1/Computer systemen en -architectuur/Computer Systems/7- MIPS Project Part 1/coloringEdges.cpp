#include <iostream>

using namespace std;
void color(string color);

int main(int argc, char const *argv[])
{
    for (int i = 0; i < 32; i++)
        color("+");

    cout << endl;

    for (int i = 0; i < 3; i++)
        color("+\n");
    

    // if the memory is in the top or bottom color everything in yellow
    // else color the first and last memory with yellow and the rest with red
    return 0;
}

void color(string color)
{
    cout << color;
}