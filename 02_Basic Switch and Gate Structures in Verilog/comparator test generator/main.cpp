#include <bits/stdc++.h>
using namespace std;

vector<string> arr;
void generateGrayarr(int n)
{
	if (n <= 0)
		return;

	arr.push_back("0");
	arr.push_back("1");

	int i, j;
	for (i = 2; i < (1<<n); i = i<<1)
	{
		for (j = i-1 ; j >= 0 ; j--)
			arr.push_back(arr[j]);

		for (j = 0 ; j < i ; j++)
			arr[j] = "0" + arr[j];

		for (j = i ; j < 2*i ; j++)
			arr[j] = "1" + arr[j];
	}

}

ofstream file("BitByBit.tv", ios::app);
void print(string a, string b)
{
    if(a==b)
        file << "_10";
    else if(a < b)
        file << "_01";
    else
        file << "_00";
    file << endl;
}
int main()
{
	generateGrayarr(8);
	int cnt = 0;
    for (int i = 0; i < arr.size(); i++)
    {
        file<<arr[i]<<"_"<<arr.back();
        print(arr[i], arr.back());
        cnt ++;
        for(int j = 0; j < arr.size(); j++)
        {
            cnt ++;
            file << arr[i] << "_" << arr[j];
            print(arr[i], arr[j]);
        }
    }
    file<<arr[0]<<"_"<<arr.back();
    print(arr[0], arr.back());
    cnt ++;
    file<<arr[0]<<"_"<<arr[0];
    print(arr[0], arr[0]);
    cnt ++;

    for (int i = 0; i < arr.size(); i++)
    {
        file<<arr.back()<<"_"<<arr[i];
        print(arr.back(), arr[i]);
        cnt ++;
        for(int j = 0; j < arr.size(); j++)
        {
            cnt ++;
            file << arr[j] << "_" << arr[i];
            print(arr[j], arr[i]);
        }
    }

    cout << cnt;
	file.close();
	return 0;
}

