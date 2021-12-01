#include <bits/stdc++.h>

using namespace std;

string convert(int x, int n = 8)
{
    string s;
    for(int i = 0; i < n; i++)
    {
        if(x % 2)
            s += '1';
        else
            s += '0';
        x /= 2;
    }
    reverse(s.begin(), s.end());
    return s;
}

int main()
{
    ofstream o("LessDistance_TV.tv");
    srand(time(0));
    int mod = (1<<8);
    int cnt=0;
    for(int i = 0; i < 65000; i++)
    {
        int reff, a, b;
        reff = rand() % mod;
        a = rand() % mod;
        b = rand() % mod;
        if (i == 64998)
            b = 0;
        if (i == 64999)
            b = (1<<8) - 1;
        string tmp = convert(reff, 8) ;
        tmp += '_' + convert(a, 8) + '_'  +convert(b, 8) + '_';
        if (abs(reff-a) < abs(reff-b))
            tmp += convert(a);
            else
                tmp+=convert(b);
        o << tmp << endl;
        cnt++;
    }
    cout<<cnt;
    return 0;
}
