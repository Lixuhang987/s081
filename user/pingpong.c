#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char* argv[]) {
    int p[2];
    pipe(p);
    int pid;
    char buf[10] = "ping";

    if ( (pid = fork()) < 0 )
    {
        fprintf(2, "fork error");
        exit(1);
    } else if (pid == 0)
    {
        close(0);
        dup(p[0]);
        close(p[0]);
        read(0, buf, 10);
        fprintf(1, "%d: received ping\n", getpid());
        close(1);
        dup(p[1]);
        close(p[1]);
        write(1, buf, 10);
        exit(0);
    } else 
    {
        int std = dup(1);
        close(1);
        dup(p[1]);
        close(p[1]);
        write(1, buf, 10);
        wait(0);
        close(0);
        dup(p[0]);
        close(p[0]);
        read(0, buf, 10);
        fprintf(std, "%d: received pong\n", getpid());
        exit(0);
    }
}