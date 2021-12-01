#include <bits/stdc++.h>

using namespace std;

string bit(int x)
{
    string s;
    for (int i = 1; i >=0; i--)
    {
        if ((1 << i ) <= x)
            s += '1', x -= (1 << i);
        else
            s += '0';
    }
    return s;
}

int main()
{
    int cnt = 0;
    for (int a = 0; a < 4; a++)
    {
        for (int b = 0; b < 4; b++)
        {
            for(int eq = 0; eq < 2; eq++)
            {
                for(int gt = 0; gt < 2; gt++)
                {
                    if (gt && eq)
                        continue;
                    cnt ++;
                    cout << bit(a) << "_" << bit(b)
                        << "_" << eq << "_" << gt << "_";
                    if (gt)
                        cout << 0 << "_" << 1;
                    else if (eq)
                    {
                        if(a == b)
                            cout << 1 << "_" << 0;
                        else if (b > a)
                            cout << 0 << "_" << 1;
                        else
                            cout << 0 << "_" << 0;
                    }
                    else
                        cout << 0 << "_" << 0;
                    cout << endl;
                }
            }
        }
    }
    cout << cnt;
    return 0;
}
