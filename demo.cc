#include <iostream>
#include <cstdio>
#include <string>
#include "config.h"
using namespace std;

#ifndef HAVE_DISP
#ifdef USE_UTILS
    #include "utils/disp.h"
#endif
#endif


int main(int argc, char *argv[]){
    if(argc<2){
        printf("%s Version %d.%d\n",
                argv[0],
                demo_VERSION_MAJOR,
                demo_VERSION_MINOR);
        printf("usage: %s display string\n", argv[0]);
        return 1;
    }
    string s = argv[1];
#ifndef HAVE_DISP
    cout<<"hehe!"<<endl;
    cout<<"Using our own utils library.\n";
    disp(s);
    disp(s,s);
#else
    cout<<"Using standard library.\n";
    cout<<s<<endl;
    cout<<s<<" "<<s<<endl;
#endif
    return 0;
}
