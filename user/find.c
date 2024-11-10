#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

void find(char* path, char* name)
{
    int fd;
    struct dirent de;
    struct stat st;



    if (stat(path, &st) < 0)
    {
        fprintf(2, "stat failed");
        return;
    }
    
    char buf[512];

    switch (st.type)
    {
    case T_DIR:
        if ((fd = open(path, 0)) < 0)
        {
            fprintf(2, "open failed");
            return;
        }
        if (sizeof path + 1 + DIRSIZ > sizeof buf)
        {
            fprintf(2, "path too long");
            break;
        }
        while (read(fd, &de, sizeof de) == sizeof de)
        {
            if (de.inum == 0 || !strcmp(de.name, ".") || !strcmp(de.name, "..")) continue;
            strcpy(buf, path);
            char *p = buf + strlen(path);
            *p = '/';
            p++;
            memmove(p, de.name, strlen(de.name));
            p[strlen(de.name)] = 0;
            find(buf, name);
        }
        break;
    
    case T_FILE:
        char *p;
        for (p = path + strlen(path); p >= path && *p != '/'; p-- )
            ;
        p++;
        if (!strcmp(p, name))
            printf("%s\n", path);
        break;
    }
}

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        fprintf(2, "command error");
        exit(1);
    }

    find(argv[1], argv[2]);
    exit(0);
}
