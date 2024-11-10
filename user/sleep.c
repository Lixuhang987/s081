// sleep.c
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char *argv[]) {
    if (argc == 2)    
    {
        fprintf(2, "(nothing happens for a little while)");
            sleep(atoi(argv[1]));
        exit(0);
    }  
    else
    {
        fprintf(2, "sleep failed\n");
        exit(1);
    }
}
