#include "../kernel/types.h"
#include "../kernel/stat.h"
#include "../user/user.h"
#include "../kernel/param.h"

void free_args(char** args, int cmd)
{
    for (char* p = args[cmd]; p != 0; p++ )
    {
        free(p);
    }
}

int main(int argc, char* argv[])
{
    char buf[16];
    char* args[MAXARG];
    int read_byte;
    char ins[strlen(argv[1]) + 1];
    strcpy(ins + 1, argv[1]);
    ins[0] = '/';
    args[0] = ins;
    int i;
    for (i = 2; i < argc; i++)
    {
        args[i - 1] = argv[i];
    }
    i -= 1;
    int cmd = i;
    char *arg = malloc(MAXPATH);
    int arg_build = 0;
    while ((read_byte = read(0, buf, sizeof(buf))) > 0)
    {    
        for (int k = 0; k < read_byte; k++ )
        {
            if (buf[k] == ' ')
            {
                arg[arg_build] = 0;
                args[i] = arg;
                i++;
                arg = malloc(MAXPATH);
                arg_build = 0;
            }
            else if (buf[k] == '\n') 
            {
                arg[arg_build] = 0;
                arg_build = 0;
                args[i] = arg;
                args[++i] = 0;
                if (fork() == 0)
                    exec(args[0], args);
                wait(0);
                i = cmd;
            }
            else
            {
                arg[arg_build] = buf[k];
                arg_build++;
            }
        }
    }
    exit(0);
}