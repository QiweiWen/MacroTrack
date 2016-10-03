#ifndef ZEROINT_H
#define ZEROINT_H

typedef struct zeroint{
    public:
        zeroint(int val):_val(val){}
        zeroint (void): _val (0) {}
        int getval (void){return _val;}
        void putval (int val) {_val = val;}
    int _val;
}zeroint_t;


#endif

