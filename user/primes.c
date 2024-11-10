#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]) 
{
    int pid;
    int p[2];
    close(0);
    for (int i = 2; i <= 35; i++) {
        pipe(p);
        if ((pid = fork()) > 0)
        {  
            close(p[0]);
            write(p[1], &i, 4);
            close(p[1]);
            wait(0);
        }       
        else if (pid == 0)
        {
            int pid2;
            close(p[1]);
            read(p[0], &i, 4);
            close(p[0]);
            pipe(p);
            if ((pid2 = fork()) > 0)
            {
                close(p[0]);
                int k;
                for (k = 2; k < i / 2; k++)
                {
                    if (!i % k)
                    {
                        close(p[1]);
                        break;
                    }
                }
                write(p[1], &i, 4);
                close(p[1]);
                wait(0);
                exit(0);
            }
            else if (pid2 == 0)
            {
                close(p[1]);
                if (read(p[0], &i, 4)) 
                {
                    fprintf(1, "prime %d\n", i);
                }
                exit(0);
            }
            else 
            {
                fprintf(2, "fork error");
                exit(1);
            }
        }
        else 
        {
            fprintf(2, "fork error");
            exit(1);
        }
    }
    if (pid > 0)
    {
        wait(0);
        exit(0);
    }
}