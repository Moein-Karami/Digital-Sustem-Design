#include <bits/stdc++.h>

using namespace std;
string convert(int x, int n)
{
    string s;
    for (int i = n - 1; i >= 0; i--)
    {
        if ((1 << i) <= x)
        {
            s += '1';
            x -= (1<<i);
        }
        else
            s += '0';
    }
    return s;
}


int main()
{
    ofstream tv("TestVectors.tv");
    srand(time(0));
    bool rst;
    for (int T = 1; T <= 200; T++)
    {
        for (int i = 1 ; i <= 20; i++)
            tv << "1_0_00_0_0000_0" << endl;
        rst = 0;
        int d = rand() % 4;
        int bytes = rand() % 64;
        tv << "0_0_00_0_0000_0" << endl;
        tv << d % 2 << "_0_00_0_0000_0" << endl;
        tv << (d / 2) % 2 << "_0_00_0_0000_0" << endl;
        int tmp = bytes;
        for (int i = 0; i < 6; i++)
        {
            if (i == 5)
            {
                string s = "0000";
                if (tmp%2)
                    s[3 - d] = '1';
                tv << tmp % 2 << "_0_" << convert(d, 2) << "_1_" << s << "_0" << endl;
            }
            else
                tv << tmp % 2 << "_0_00_0_0000_0" << endl;
            tmp /= 2;
        }
        string dest = convert(d, 2);
        for (int i = 0; i < bytes * 8; i++)
        {
            int bit = rand() % 2;
            tv << bit << "_0_" << dest << "_" << (i != (bytes * 8 - 1)) << "_";
            string s = "0000";
            if (bit)
                s[3 - d] = '1';
            tv << s << "_0" << endl;
            int random = rand() % 70;
            rst = (random == 1);
            if (rst)
            {
                tv << "0_1_00_0_0000_0" << endl;
                break;
            }
        }
        if (rst)
            continue;

        int error = rand() % 50;
        while (error == 1)
        {
            error = rand() % 4;
            tv << "0_0_00_0_0000_1" << endl;
        }
        tv << "1_0_00_0_0000_0" << endl;
    }
    return 0;
}
