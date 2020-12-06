#include <bits/stdc++.h>

using namespace std;

string convert(int x, int n)
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
    vector<string> s;
    for (int i = 0; i < (1<<8); i++)
        s.push_back(convert(i, 8));
    ofstream o("8bit_comparator_TV.tv");
    int cnt = 0;
    vector <string> v;
    for(auto i : s)
    {
        for(auto j : s)
        {
            string tmp;
            tmp =  i + "_" + j + "_";
            if(i > j)
                tmp += "0_0";
            else if (i < j)
                tmp += "0_1";
            else
                tmp += "1_0";
            cnt ++;
            v.push_back(tmp);
        }
    }
    random_shuffle(v.begin(), v.end());
    for(auto i : v)
        o << i << endl;
    cout << cnt;
    return 0;
}
