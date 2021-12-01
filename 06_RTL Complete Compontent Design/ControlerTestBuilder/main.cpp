#include <bits/stdc++.h>

using namespace std;

const int test = 1e4;
int state;
bool b[16];
const int start = 0, parity = 1, stop_sign = 2, ready = 3, cnt_en = 4, cnt_init0 = 5, sel_rom = 6, sel_x = 7, reg_x_ld = 8;
const int reg_y_ld = 9, reg_tmp_ld = 10, invert = 11, minus_ = 12, reg_res_ld = 13, reg_tmp_init1 = 14, reg_res_init1 = 15;
int main()
{
    ofstream file("Controler_TV.tv");
    int nxt = 0;
    for (int i = 0; i < test; i++)
    {

        for (int j = 0; j < 16; j++)
            b[j] = 0;

        b[parity] = rand() % 2;
        if (i)
            b[start] = rand() % 2;
        b[stop_sign] = rand() % 2;

        if (state >= 2 && state <= 4)
            nxt = state + 1;
        else
        {
            if (state == 0 && b[start])
                nxt = 1;
            if (state == 1 && b[start] == 0)
                nxt = 2;
            if(state == 5)
            {
                if (b[stop_sign])
                    nxt = 0;
                else nxt = 3;
            }
        }

        state = nxt;

        if (i < 10)
                    cout << state << " start: " <<b[start]<<endl;
        if (state == 0)
        {
            b[ready] = 1;
        }
        if (state == 1)
        {
            b[cnt_init0] = 1;
            b[reg_tmp_init1] = 1;
            b[reg_res_init1] = 1;
        }
        if (state == 2)
        {
            b[reg_x_ld] = 1;
            b[reg_y_ld] = 1;
        }
        if (state == 3)
        {
            b[sel_x] = 1;
            b[reg_tmp_ld] = 1;
        }
        if (state == 4)
        {
            b[sel_rom] = 1;
            b[reg_tmp_ld] = 1;
        }
        if (state == 5)
        {
            b[cnt_en] = 1;
            b[invert] = !b[parity];
            b[minus_] = !b[parity];
            b[reg_res_ld] = 1;
        }
        for (int j = 0; j < 16; j++)
            file << b[j] << "_";
        file << endl;
    }
    file.close();
    return 0;
}
