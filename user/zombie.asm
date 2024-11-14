
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	2d4080e7          	jalr	724(ra) # 2dc <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	2ce080e7          	jalr	718(ra) # 2e4 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	354080e7          	jalr	852(ra) # 374 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <strcpy>:



char*
strcpy(char *s, const char *t)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  32:	87aa                	mv	a5,a0
  34:	0585                	addi	a1,a1,1
  36:	0785                	addi	a5,a5,1
  38:	fff5c703          	lbu	a4,-1(a1)
  3c:	fee78fa3          	sb	a4,-1(a5)
  40:	fb75                	bnez	a4,34 <strcpy+0xa>
    ;
  return os;
}
  42:	60a2                	ld	ra,8(sp)
  44:	6402                	ld	s0,0(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e406                	sd	ra,8(sp)
  4e:	e022                	sd	s0,0(sp)
  50:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  52:	00054783          	lbu	a5,0(a0)
  56:	cb91                	beqz	a5,6a <strcmp+0x20>
  58:	0005c703          	lbu	a4,0(a1)
  5c:	00f71763          	bne	a4,a5,6a <strcmp+0x20>
    p++, q++;
  60:	0505                	addi	a0,a0,1
  62:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	fbe5                	bnez	a5,58 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  6a:	0005c503          	lbu	a0,0(a1)
}
  6e:	40a7853b          	subw	a0,a5,a0
  72:	60a2                	ld	ra,8(sp)
  74:	6402                	ld	s0,0(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strlen>:

uint
strlen(const char *s)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  82:	00054783          	lbu	a5,0(a0)
  86:	cf99                	beqz	a5,a4 <strlen+0x2a>
  88:	0505                	addi	a0,a0,1
  8a:	87aa                	mv	a5,a0
  8c:	86be                	mv	a3,a5
  8e:	0785                	addi	a5,a5,1
  90:	fff7c703          	lbu	a4,-1(a5)
  94:	ff65                	bnez	a4,8c <strlen+0x12>
  96:	40a6853b          	subw	a0,a3,a0
  9a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  9c:	60a2                	ld	ra,8(sp)
  9e:	6402                	ld	s0,0(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret
  for(n = 0; s[n]; n++)
  a4:	4501                	li	a0,0
  a6:	bfdd                	j	9c <strlen+0x22>

00000000000000a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e406                	sd	ra,8(sp)
  ac:	e022                	sd	s0,0(sp)
  ae:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  b0:	ca19                	beqz	a2,c6 <memset+0x1e>
  b2:	87aa                	mv	a5,a0
  b4:	1602                	slli	a2,a2,0x20
  b6:	9201                	srli	a2,a2,0x20
  b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  c0:	0785                	addi	a5,a5,1
  c2:	fee79de3          	bne	a5,a4,bc <memset+0x14>
  }
  return dst;
}
  c6:	60a2                	ld	ra,8(sp)
  c8:	6402                	ld	s0,0(sp)
  ca:	0141                	addi	sp,sp,16
  cc:	8082                	ret

00000000000000ce <strchr>:

char*
strchr(const char *s, char c)
{
  ce:	1141                	addi	sp,sp,-16
  d0:	e406                	sd	ra,8(sp)
  d2:	e022                	sd	s0,0(sp)
  d4:	0800                	addi	s0,sp,16
  for(; *s; s++)
  d6:	00054783          	lbu	a5,0(a0)
  da:	cf81                	beqz	a5,f2 <strchr+0x24>
    if(*s == c)
  dc:	00f58763          	beq	a1,a5,ea <strchr+0x1c>
  for(; *s; s++)
  e0:	0505                	addi	a0,a0,1
  e2:	00054783          	lbu	a5,0(a0)
  e6:	fbfd                	bnez	a5,dc <strchr+0xe>
      return (char*)s;
  return 0;
  e8:	4501                	li	a0,0
}
  ea:	60a2                	ld	ra,8(sp)
  ec:	6402                	ld	s0,0(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret
  return 0;
  f2:	4501                	li	a0,0
  f4:	bfdd                	j	ea <strchr+0x1c>

00000000000000f6 <gets>:

char*
gets(char *buf, int max)
{
  f6:	7159                	addi	sp,sp,-112
  f8:	f486                	sd	ra,104(sp)
  fa:	f0a2                	sd	s0,96(sp)
  fc:	eca6                	sd	s1,88(sp)
  fe:	e8ca                	sd	s2,80(sp)
 100:	e4ce                	sd	s3,72(sp)
 102:	e0d2                	sd	s4,64(sp)
 104:	fc56                	sd	s5,56(sp)
 106:	f85a                	sd	s6,48(sp)
 108:	f45e                	sd	s7,40(sp)
 10a:	f062                	sd	s8,32(sp)
 10c:	ec66                	sd	s9,24(sp)
 10e:	e86a                	sd	s10,16(sp)
 110:	1880                	addi	s0,sp,112
 112:	8caa                	mv	s9,a0
 114:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 116:	892a                	mv	s2,a0
 118:	4481                	li	s1,0
    cc = read(0, &c, 1);
 11a:	f9f40b13          	addi	s6,s0,-97
 11e:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 120:	4ba9                	li	s7,10
 122:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 124:	8d26                	mv	s10,s1
 126:	0014899b          	addiw	s3,s1,1
 12a:	84ce                	mv	s1,s3
 12c:	0349d763          	bge	s3,s4,15a <gets+0x64>
    cc = read(0, &c, 1);
 130:	8656                	mv	a2,s5
 132:	85da                	mv	a1,s6
 134:	4501                	li	a0,0
 136:	00000097          	auipc	ra,0x0
 13a:	1c6080e7          	jalr	454(ra) # 2fc <read>
    if(cc < 1)
 13e:	00a05e63          	blez	a0,15a <gets+0x64>
    buf[i++] = c;
 142:	f9f44783          	lbu	a5,-97(s0)
 146:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 14a:	01778763          	beq	a5,s7,158 <gets+0x62>
 14e:	0905                	addi	s2,s2,1
 150:	fd879ae3          	bne	a5,s8,124 <gets+0x2e>
    buf[i++] = c;
 154:	8d4e                	mv	s10,s3
 156:	a011                	j	15a <gets+0x64>
 158:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 15a:	9d66                	add	s10,s10,s9
 15c:	000d0023          	sb	zero,0(s10)
  return buf;
}
 160:	8566                	mv	a0,s9
 162:	70a6                	ld	ra,104(sp)
 164:	7406                	ld	s0,96(sp)
 166:	64e6                	ld	s1,88(sp)
 168:	6946                	ld	s2,80(sp)
 16a:	69a6                	ld	s3,72(sp)
 16c:	6a06                	ld	s4,64(sp)
 16e:	7ae2                	ld	s5,56(sp)
 170:	7b42                	ld	s6,48(sp)
 172:	7ba2                	ld	s7,40(sp)
 174:	7c02                	ld	s8,32(sp)
 176:	6ce2                	ld	s9,24(sp)
 178:	6d42                	ld	s10,16(sp)
 17a:	6165                	addi	sp,sp,112
 17c:	8082                	ret

000000000000017e <stat>:

int
stat(const char *n, struct stat *st)
{
 17e:	1101                	addi	sp,sp,-32
 180:	ec06                	sd	ra,24(sp)
 182:	e822                	sd	s0,16(sp)
 184:	e04a                	sd	s2,0(sp)
 186:	1000                	addi	s0,sp,32
 188:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18a:	4581                	li	a1,0
 18c:	00000097          	auipc	ra,0x0
 190:	198080e7          	jalr	408(ra) # 324 <open>
  if(fd < 0)
 194:	02054663          	bltz	a0,1c0 <stat+0x42>
 198:	e426                	sd	s1,8(sp)
 19a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 19c:	85ca                	mv	a1,s2
 19e:	00000097          	auipc	ra,0x0
 1a2:	19e080e7          	jalr	414(ra) # 33c <fstat>
 1a6:	892a                	mv	s2,a0
  close(fd);
 1a8:	8526                	mv	a0,s1
 1aa:	00000097          	auipc	ra,0x0
 1ae:	162080e7          	jalr	354(ra) # 30c <close>
  return r;
 1b2:	64a2                	ld	s1,8(sp)
}
 1b4:	854a                	mv	a0,s2
 1b6:	60e2                	ld	ra,24(sp)
 1b8:	6442                	ld	s0,16(sp)
 1ba:	6902                	ld	s2,0(sp)
 1bc:	6105                	addi	sp,sp,32
 1be:	8082                	ret
    return -1;
 1c0:	597d                	li	s2,-1
 1c2:	bfcd                	j	1b4 <stat+0x36>

00000000000001c4 <atoi>:

int
atoi(const char *s)
{
 1c4:	1141                	addi	sp,sp,-16
 1c6:	e406                	sd	ra,8(sp)
 1c8:	e022                	sd	s0,0(sp)
 1ca:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cc:	00054683          	lbu	a3,0(a0)
 1d0:	fd06879b          	addiw	a5,a3,-48
 1d4:	0ff7f793          	zext.b	a5,a5
 1d8:	4625                	li	a2,9
 1da:	02f66963          	bltu	a2,a5,20c <atoi+0x48>
 1de:	872a                	mv	a4,a0
  n = 0;
 1e0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e2:	0705                	addi	a4,a4,1
 1e4:	0025179b          	slliw	a5,a0,0x2
 1e8:	9fa9                	addw	a5,a5,a0
 1ea:	0017979b          	slliw	a5,a5,0x1
 1ee:	9fb5                	addw	a5,a5,a3
 1f0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f4:	00074683          	lbu	a3,0(a4)
 1f8:	fd06879b          	addiw	a5,a3,-48
 1fc:	0ff7f793          	zext.b	a5,a5
 200:	fef671e3          	bgeu	a2,a5,1e2 <atoi+0x1e>
  return n;
}
 204:	60a2                	ld	ra,8(sp)
 206:	6402                	ld	s0,0(sp)
 208:	0141                	addi	sp,sp,16
 20a:	8082                	ret
  n = 0;
 20c:	4501                	li	a0,0
 20e:	bfdd                	j	204 <atoi+0x40>

0000000000000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	1141                	addi	sp,sp,-16
 212:	e406                	sd	ra,8(sp)
 214:	e022                	sd	s0,0(sp)
 216:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 218:	02b57563          	bgeu	a0,a1,242 <memmove+0x32>
    while(n-- > 0)
 21c:	00c05f63          	blez	a2,23a <memmove+0x2a>
 220:	1602                	slli	a2,a2,0x20
 222:	9201                	srli	a2,a2,0x20
 224:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 228:	872a                	mv	a4,a0
      *dst++ = *src++;
 22a:	0585                	addi	a1,a1,1
 22c:	0705                	addi	a4,a4,1
 22e:	fff5c683          	lbu	a3,-1(a1)
 232:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 236:	fee79ae3          	bne	a5,a4,22a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 23a:	60a2                	ld	ra,8(sp)
 23c:	6402                	ld	s0,0(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
    dst += n;
 242:	00c50733          	add	a4,a0,a2
    src += n;
 246:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 248:	fec059e3          	blez	a2,23a <memmove+0x2a>
 24c:	fff6079b          	addiw	a5,a2,-1
 250:	1782                	slli	a5,a5,0x20
 252:	9381                	srli	a5,a5,0x20
 254:	fff7c793          	not	a5,a5
 258:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 25a:	15fd                	addi	a1,a1,-1
 25c:	177d                	addi	a4,a4,-1
 25e:	0005c683          	lbu	a3,0(a1)
 262:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 266:	fef71ae3          	bne	a4,a5,25a <memmove+0x4a>
 26a:	bfc1                	j	23a <memmove+0x2a>

000000000000026c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 274:	ca0d                	beqz	a2,2a6 <memcmp+0x3a>
 276:	fff6069b          	addiw	a3,a2,-1
 27a:	1682                	slli	a3,a3,0x20
 27c:	9281                	srli	a3,a3,0x20
 27e:	0685                	addi	a3,a3,1
 280:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 282:	00054783          	lbu	a5,0(a0)
 286:	0005c703          	lbu	a4,0(a1)
 28a:	00e79863          	bne	a5,a4,29a <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 28e:	0505                	addi	a0,a0,1
    p2++;
 290:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 292:	fed518e3          	bne	a0,a3,282 <memcmp+0x16>
  }
  return 0;
 296:	4501                	li	a0,0
 298:	a019                	j	29e <memcmp+0x32>
      return *p1 - *p2;
 29a:	40e7853b          	subw	a0,a5,a4
}
 29e:	60a2                	ld	ra,8(sp)
 2a0:	6402                	ld	s0,0(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
  return 0;
 2a6:	4501                	li	a0,0
 2a8:	bfdd                	j	29e <memcmp+0x32>

00000000000002aa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e406                	sd	ra,8(sp)
 2ae:	e022                	sd	s0,0(sp)
 2b0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2b2:	00000097          	auipc	ra,0x0
 2b6:	f5e080e7          	jalr	-162(ra) # 210 <memmove>
}
 2ba:	60a2                	ld	ra,8(sp)
 2bc:	6402                	ld	s0,0(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e406                	sd	ra,8(sp)
 2c6:	e022                	sd	s0,0(sp)
 2c8:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 2ca:	040007b7          	lui	a5,0x4000
 2ce:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffef8c>
 2d0:	07b2                	slli	a5,a5,0xc
}
 2d2:	4388                	lw	a0,0(a5)
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2dc:	4885                	li	a7,1
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2e4:	4889                	li	a7,2
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 2ec:	488d                	li	a7,3
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2f4:	4891                	li	a7,4
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <read>:
.global read
read:
 li a7, SYS_read
 2fc:	4895                	li	a7,5
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <write>:
.global write
write:
 li a7, SYS_write
 304:	48c1                	li	a7,16
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <close>:
.global close
close:
 li a7, SYS_close
 30c:	48d5                	li	a7,21
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <kill>:
.global kill
kill:
 li a7, SYS_kill
 314:	4899                	li	a7,6
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <exec>:
.global exec
exec:
 li a7, SYS_exec
 31c:	489d                	li	a7,7
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <open>:
.global open
open:
 li a7, SYS_open
 324:	48bd                	li	a7,15
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 32c:	48c5                	li	a7,17
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 334:	48c9                	li	a7,18
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 33c:	48a1                	li	a7,8
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <link>:
.global link
link:
 li a7, SYS_link
 344:	48cd                	li	a7,19
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 34c:	48d1                	li	a7,20
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 354:	48a5                	li	a7,9
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <dup>:
.global dup
dup:
 li a7, SYS_dup
 35c:	48a9                	li	a7,10
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 364:	48ad                	li	a7,11
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 36c:	48b1                	li	a7,12
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 374:	48b5                	li	a7,13
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 37c:	48b9                	li	a7,14
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <connect>:
.global connect
connect:
 li a7, SYS_connect
 384:	48f5                	li	a7,29
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 38c:	48f9                	li	a7,30
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 394:	1101                	addi	sp,sp,-32
 396:	ec06                	sd	ra,24(sp)
 398:	e822                	sd	s0,16(sp)
 39a:	1000                	addi	s0,sp,32
 39c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a0:	4605                	li	a2,1
 3a2:	fef40593          	addi	a1,s0,-17
 3a6:	00000097          	auipc	ra,0x0
 3aa:	f5e080e7          	jalr	-162(ra) # 304 <write>
}
 3ae:	60e2                	ld	ra,24(sp)
 3b0:	6442                	ld	s0,16(sp)
 3b2:	6105                	addi	sp,sp,32
 3b4:	8082                	ret

00000000000003b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b6:	7139                	addi	sp,sp,-64
 3b8:	fc06                	sd	ra,56(sp)
 3ba:	f822                	sd	s0,48(sp)
 3bc:	f426                	sd	s1,40(sp)
 3be:	f04a                	sd	s2,32(sp)
 3c0:	ec4e                	sd	s3,24(sp)
 3c2:	0080                	addi	s0,sp,64
 3c4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c6:	c299                	beqz	a3,3cc <printint+0x16>
 3c8:	0805c063          	bltz	a1,448 <printint+0x92>
  neg = 0;
 3cc:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3ce:	fc040313          	addi	t1,s0,-64
  neg = 0;
 3d2:	869a                	mv	a3,t1
  i = 0;
 3d4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3d6:	00000817          	auipc	a6,0x0
 3da:	48a80813          	addi	a6,a6,1162 # 860 <digits>
 3de:	88be                	mv	a7,a5
 3e0:	0017851b          	addiw	a0,a5,1
 3e4:	87aa                	mv	a5,a0
 3e6:	02c5f73b          	remuw	a4,a1,a2
 3ea:	1702                	slli	a4,a4,0x20
 3ec:	9301                	srli	a4,a4,0x20
 3ee:	9742                	add	a4,a4,a6
 3f0:	00074703          	lbu	a4,0(a4)
 3f4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 3f8:	872e                	mv	a4,a1
 3fa:	02c5d5bb          	divuw	a1,a1,a2
 3fe:	0685                	addi	a3,a3,1
 400:	fcc77fe3          	bgeu	a4,a2,3de <printint+0x28>
  if(neg)
 404:	000e0c63          	beqz	t3,41c <printint+0x66>
    buf[i++] = '-';
 408:	fd050793          	addi	a5,a0,-48
 40c:	00878533          	add	a0,a5,s0
 410:	02d00793          	li	a5,45
 414:	fef50823          	sb	a5,-16(a0)
 418:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 41c:	fff7899b          	addiw	s3,a5,-1
 420:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 424:	fff4c583          	lbu	a1,-1(s1)
 428:	854a                	mv	a0,s2
 42a:	00000097          	auipc	ra,0x0
 42e:	f6a080e7          	jalr	-150(ra) # 394 <putc>
  while(--i >= 0)
 432:	39fd                	addiw	s3,s3,-1
 434:	14fd                	addi	s1,s1,-1
 436:	fe09d7e3          	bgez	s3,424 <printint+0x6e>
}
 43a:	70e2                	ld	ra,56(sp)
 43c:	7442                	ld	s0,48(sp)
 43e:	74a2                	ld	s1,40(sp)
 440:	7902                	ld	s2,32(sp)
 442:	69e2                	ld	s3,24(sp)
 444:	6121                	addi	sp,sp,64
 446:	8082                	ret
    x = -xx;
 448:	40b005bb          	negw	a1,a1
    neg = 1;
 44c:	4e05                	li	t3,1
    x = -xx;
 44e:	b741                	j	3ce <printint+0x18>

0000000000000450 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 450:	715d                	addi	sp,sp,-80
 452:	e486                	sd	ra,72(sp)
 454:	e0a2                	sd	s0,64(sp)
 456:	f84a                	sd	s2,48(sp)
 458:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 45a:	0005c903          	lbu	s2,0(a1)
 45e:	1a090a63          	beqz	s2,612 <vprintf+0x1c2>
 462:	fc26                	sd	s1,56(sp)
 464:	f44e                	sd	s3,40(sp)
 466:	f052                	sd	s4,32(sp)
 468:	ec56                	sd	s5,24(sp)
 46a:	e85a                	sd	s6,16(sp)
 46c:	e45e                	sd	s7,8(sp)
 46e:	8aaa                	mv	s5,a0
 470:	8bb2                	mv	s7,a2
 472:	00158493          	addi	s1,a1,1
  state = 0;
 476:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 478:	02500a13          	li	s4,37
 47c:	4b55                	li	s6,21
 47e:	a839                	j	49c <vprintf+0x4c>
        putc(fd, c);
 480:	85ca                	mv	a1,s2
 482:	8556                	mv	a0,s5
 484:	00000097          	auipc	ra,0x0
 488:	f10080e7          	jalr	-240(ra) # 394 <putc>
 48c:	a019                	j	492 <vprintf+0x42>
    } else if(state == '%'){
 48e:	01498d63          	beq	s3,s4,4a8 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 492:	0485                	addi	s1,s1,1
 494:	fff4c903          	lbu	s2,-1(s1)
 498:	16090763          	beqz	s2,606 <vprintf+0x1b6>
    if(state == 0){
 49c:	fe0999e3          	bnez	s3,48e <vprintf+0x3e>
      if(c == '%'){
 4a0:	ff4910e3          	bne	s2,s4,480 <vprintf+0x30>
        state = '%';
 4a4:	89d2                	mv	s3,s4
 4a6:	b7f5                	j	492 <vprintf+0x42>
      if(c == 'd'){
 4a8:	13490463          	beq	s2,s4,5d0 <vprintf+0x180>
 4ac:	f9d9079b          	addiw	a5,s2,-99
 4b0:	0ff7f793          	zext.b	a5,a5
 4b4:	12fb6763          	bltu	s6,a5,5e2 <vprintf+0x192>
 4b8:	f9d9079b          	addiw	a5,s2,-99
 4bc:	0ff7f713          	zext.b	a4,a5
 4c0:	12eb6163          	bltu	s6,a4,5e2 <vprintf+0x192>
 4c4:	00271793          	slli	a5,a4,0x2
 4c8:	00000717          	auipc	a4,0x0
 4cc:	34070713          	addi	a4,a4,832 # 808 <malloc+0x102>
 4d0:	97ba                	add	a5,a5,a4
 4d2:	439c                	lw	a5,0(a5)
 4d4:	97ba                	add	a5,a5,a4
 4d6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4d8:	008b8913          	addi	s2,s7,8
 4dc:	4685                	li	a3,1
 4de:	4629                	li	a2,10
 4e0:	000ba583          	lw	a1,0(s7)
 4e4:	8556                	mv	a0,s5
 4e6:	00000097          	auipc	ra,0x0
 4ea:	ed0080e7          	jalr	-304(ra) # 3b6 <printint>
 4ee:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f0:	4981                	li	s3,0
 4f2:	b745                	j	492 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4f4:	008b8913          	addi	s2,s7,8
 4f8:	4681                	li	a3,0
 4fa:	4629                	li	a2,10
 4fc:	000ba583          	lw	a1,0(s7)
 500:	8556                	mv	a0,s5
 502:	00000097          	auipc	ra,0x0
 506:	eb4080e7          	jalr	-332(ra) # 3b6 <printint>
 50a:	8bca                	mv	s7,s2
      state = 0;
 50c:	4981                	li	s3,0
 50e:	b751                	j	492 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 510:	008b8913          	addi	s2,s7,8
 514:	4681                	li	a3,0
 516:	4641                	li	a2,16
 518:	000ba583          	lw	a1,0(s7)
 51c:	8556                	mv	a0,s5
 51e:	00000097          	auipc	ra,0x0
 522:	e98080e7          	jalr	-360(ra) # 3b6 <printint>
 526:	8bca                	mv	s7,s2
      state = 0;
 528:	4981                	li	s3,0
 52a:	b7a5                	j	492 <vprintf+0x42>
 52c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 52e:	008b8c13          	addi	s8,s7,8
 532:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 536:	03000593          	li	a1,48
 53a:	8556                	mv	a0,s5
 53c:	00000097          	auipc	ra,0x0
 540:	e58080e7          	jalr	-424(ra) # 394 <putc>
  putc(fd, 'x');
 544:	07800593          	li	a1,120
 548:	8556                	mv	a0,s5
 54a:	00000097          	auipc	ra,0x0
 54e:	e4a080e7          	jalr	-438(ra) # 394 <putc>
 552:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 554:	00000b97          	auipc	s7,0x0
 558:	30cb8b93          	addi	s7,s7,780 # 860 <digits>
 55c:	03c9d793          	srli	a5,s3,0x3c
 560:	97de                	add	a5,a5,s7
 562:	0007c583          	lbu	a1,0(a5)
 566:	8556                	mv	a0,s5
 568:	00000097          	auipc	ra,0x0
 56c:	e2c080e7          	jalr	-468(ra) # 394 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 570:	0992                	slli	s3,s3,0x4
 572:	397d                	addiw	s2,s2,-1
 574:	fe0914e3          	bnez	s2,55c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 578:	8be2                	mv	s7,s8
      state = 0;
 57a:	4981                	li	s3,0
 57c:	6c02                	ld	s8,0(sp)
 57e:	bf11                	j	492 <vprintf+0x42>
        s = va_arg(ap, char*);
 580:	008b8993          	addi	s3,s7,8
 584:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 588:	02090163          	beqz	s2,5aa <vprintf+0x15a>
        while(*s != 0){
 58c:	00094583          	lbu	a1,0(s2)
 590:	c9a5                	beqz	a1,600 <vprintf+0x1b0>
          putc(fd, *s);
 592:	8556                	mv	a0,s5
 594:	00000097          	auipc	ra,0x0
 598:	e00080e7          	jalr	-512(ra) # 394 <putc>
          s++;
 59c:	0905                	addi	s2,s2,1
        while(*s != 0){
 59e:	00094583          	lbu	a1,0(s2)
 5a2:	f9e5                	bnez	a1,592 <vprintf+0x142>
        s = va_arg(ap, char*);
 5a4:	8bce                	mv	s7,s3
      state = 0;
 5a6:	4981                	li	s3,0
 5a8:	b5ed                	j	492 <vprintf+0x42>
          s = "(null)";
 5aa:	00000917          	auipc	s2,0x0
 5ae:	25690913          	addi	s2,s2,598 # 800 <malloc+0xfa>
        while(*s != 0){
 5b2:	02800593          	li	a1,40
 5b6:	bff1                	j	592 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 5b8:	008b8913          	addi	s2,s7,8
 5bc:	000bc583          	lbu	a1,0(s7)
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	dd2080e7          	jalr	-558(ra) # 394 <putc>
 5ca:	8bca                	mv	s7,s2
      state = 0;
 5cc:	4981                	li	s3,0
 5ce:	b5d1                	j	492 <vprintf+0x42>
        putc(fd, c);
 5d0:	02500593          	li	a1,37
 5d4:	8556                	mv	a0,s5
 5d6:	00000097          	auipc	ra,0x0
 5da:	dbe080e7          	jalr	-578(ra) # 394 <putc>
      state = 0;
 5de:	4981                	li	s3,0
 5e0:	bd4d                	j	492 <vprintf+0x42>
        putc(fd, '%');
 5e2:	02500593          	li	a1,37
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	dac080e7          	jalr	-596(ra) # 394 <putc>
        putc(fd, c);
 5f0:	85ca                	mv	a1,s2
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	da0080e7          	jalr	-608(ra) # 394 <putc>
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	bd51                	j	492 <vprintf+0x42>
        s = va_arg(ap, char*);
 600:	8bce                	mv	s7,s3
      state = 0;
 602:	4981                	li	s3,0
 604:	b579                	j	492 <vprintf+0x42>
 606:	74e2                	ld	s1,56(sp)
 608:	79a2                	ld	s3,40(sp)
 60a:	7a02                	ld	s4,32(sp)
 60c:	6ae2                	ld	s5,24(sp)
 60e:	6b42                	ld	s6,16(sp)
 610:	6ba2                	ld	s7,8(sp)
    }
  }
}
 612:	60a6                	ld	ra,72(sp)
 614:	6406                	ld	s0,64(sp)
 616:	7942                	ld	s2,48(sp)
 618:	6161                	addi	sp,sp,80
 61a:	8082                	ret

000000000000061c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 61c:	715d                	addi	sp,sp,-80
 61e:	ec06                	sd	ra,24(sp)
 620:	e822                	sd	s0,16(sp)
 622:	1000                	addi	s0,sp,32
 624:	e010                	sd	a2,0(s0)
 626:	e414                	sd	a3,8(s0)
 628:	e818                	sd	a4,16(s0)
 62a:	ec1c                	sd	a5,24(s0)
 62c:	03043023          	sd	a6,32(s0)
 630:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 634:	8622                	mv	a2,s0
 636:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 63a:	00000097          	auipc	ra,0x0
 63e:	e16080e7          	jalr	-490(ra) # 450 <vprintf>
}
 642:	60e2                	ld	ra,24(sp)
 644:	6442                	ld	s0,16(sp)
 646:	6161                	addi	sp,sp,80
 648:	8082                	ret

000000000000064a <printf>:

void
printf(const char *fmt, ...)
{
 64a:	711d                	addi	sp,sp,-96
 64c:	ec06                	sd	ra,24(sp)
 64e:	e822                	sd	s0,16(sp)
 650:	1000                	addi	s0,sp,32
 652:	e40c                	sd	a1,8(s0)
 654:	e810                	sd	a2,16(s0)
 656:	ec14                	sd	a3,24(s0)
 658:	f018                	sd	a4,32(s0)
 65a:	f41c                	sd	a5,40(s0)
 65c:	03043823          	sd	a6,48(s0)
 660:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 664:	00840613          	addi	a2,s0,8
 668:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 66c:	85aa                	mv	a1,a0
 66e:	4505                	li	a0,1
 670:	00000097          	auipc	ra,0x0
 674:	de0080e7          	jalr	-544(ra) # 450 <vprintf>
}
 678:	60e2                	ld	ra,24(sp)
 67a:	6442                	ld	s0,16(sp)
 67c:	6125                	addi	sp,sp,96
 67e:	8082                	ret

0000000000000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	1141                	addi	sp,sp,-16
 682:	e406                	sd	ra,8(sp)
 684:	e022                	sd	s0,0(sp)
 686:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 688:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68c:	00000797          	auipc	a5,0x0
 690:	1ec7b783          	ld	a5,492(a5) # 878 <freep>
 694:	a02d                	j	6be <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 696:	4618                	lw	a4,8(a2)
 698:	9f2d                	addw	a4,a4,a1
 69a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 69e:	6398                	ld	a4,0(a5)
 6a0:	6310                	ld	a2,0(a4)
 6a2:	a83d                	j	6e0 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6a4:	ff852703          	lw	a4,-8(a0)
 6a8:	9f31                	addw	a4,a4,a2
 6aa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6ac:	ff053683          	ld	a3,-16(a0)
 6b0:	a091                	j	6f4 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b2:	6398                	ld	a4,0(a5)
 6b4:	00e7e463          	bltu	a5,a4,6bc <free+0x3c>
 6b8:	00e6ea63          	bltu	a3,a4,6cc <free+0x4c>
{
 6bc:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6be:	fed7fae3          	bgeu	a5,a3,6b2 <free+0x32>
 6c2:	6398                	ld	a4,0(a5)
 6c4:	00e6e463          	bltu	a3,a4,6cc <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c8:	fee7eae3          	bltu	a5,a4,6bc <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 6cc:	ff852583          	lw	a1,-8(a0)
 6d0:	6390                	ld	a2,0(a5)
 6d2:	02059813          	slli	a6,a1,0x20
 6d6:	01c85713          	srli	a4,a6,0x1c
 6da:	9736                	add	a4,a4,a3
 6dc:	fae60de3          	beq	a2,a4,696 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 6e0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6e4:	4790                	lw	a2,8(a5)
 6e6:	02061593          	slli	a1,a2,0x20
 6ea:	01c5d713          	srli	a4,a1,0x1c
 6ee:	973e                	add	a4,a4,a5
 6f0:	fae68ae3          	beq	a3,a4,6a4 <free+0x24>
    p->s.ptr = bp->s.ptr;
 6f4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6f6:	00000717          	auipc	a4,0x0
 6fa:	18f73123          	sd	a5,386(a4) # 878 <freep>
}
 6fe:	60a2                	ld	ra,8(sp)
 700:	6402                	ld	s0,0(sp)
 702:	0141                	addi	sp,sp,16
 704:	8082                	ret

0000000000000706 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 706:	7139                	addi	sp,sp,-64
 708:	fc06                	sd	ra,56(sp)
 70a:	f822                	sd	s0,48(sp)
 70c:	f04a                	sd	s2,32(sp)
 70e:	ec4e                	sd	s3,24(sp)
 710:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 712:	02051993          	slli	s3,a0,0x20
 716:	0209d993          	srli	s3,s3,0x20
 71a:	09bd                	addi	s3,s3,15
 71c:	0049d993          	srli	s3,s3,0x4
 720:	2985                	addiw	s3,s3,1
 722:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 724:	00000517          	auipc	a0,0x0
 728:	15453503          	ld	a0,340(a0) # 878 <freep>
 72c:	c905                	beqz	a0,75c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 72e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 730:	4798                	lw	a4,8(a5)
 732:	09377a63          	bgeu	a4,s3,7c6 <malloc+0xc0>
 736:	f426                	sd	s1,40(sp)
 738:	e852                	sd	s4,16(sp)
 73a:	e456                	sd	s5,8(sp)
 73c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 73e:	8a4e                	mv	s4,s3
 740:	6705                	lui	a4,0x1
 742:	00e9f363          	bgeu	s3,a4,748 <malloc+0x42>
 746:	6a05                	lui	s4,0x1
 748:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 74c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 750:	00000497          	auipc	s1,0x0
 754:	12848493          	addi	s1,s1,296 # 878 <freep>
  if(p == (char*)-1)
 758:	5afd                	li	s5,-1
 75a:	a089                	j	79c <malloc+0x96>
 75c:	f426                	sd	s1,40(sp)
 75e:	e852                	sd	s4,16(sp)
 760:	e456                	sd	s5,8(sp)
 762:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 764:	00000797          	auipc	a5,0x0
 768:	11c78793          	addi	a5,a5,284 # 880 <base>
 76c:	00000717          	auipc	a4,0x0
 770:	10f73623          	sd	a5,268(a4) # 878 <freep>
 774:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 776:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 77a:	b7d1                	j	73e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 77c:	6398                	ld	a4,0(a5)
 77e:	e118                	sd	a4,0(a0)
 780:	a8b9                	j	7de <malloc+0xd8>
  hp->s.size = nu;
 782:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 786:	0541                	addi	a0,a0,16
 788:	00000097          	auipc	ra,0x0
 78c:	ef8080e7          	jalr	-264(ra) # 680 <free>
  return freep;
 790:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 792:	c135                	beqz	a0,7f6 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 794:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 796:	4798                	lw	a4,8(a5)
 798:	03277363          	bgeu	a4,s2,7be <malloc+0xb8>
    if(p == freep)
 79c:	6098                	ld	a4,0(s1)
 79e:	853e                	mv	a0,a5
 7a0:	fef71ae3          	bne	a4,a5,794 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7a4:	8552                	mv	a0,s4
 7a6:	00000097          	auipc	ra,0x0
 7aa:	bc6080e7          	jalr	-1082(ra) # 36c <sbrk>
  if(p == (char*)-1)
 7ae:	fd551ae3          	bne	a0,s5,782 <malloc+0x7c>
        return 0;
 7b2:	4501                	li	a0,0
 7b4:	74a2                	ld	s1,40(sp)
 7b6:	6a42                	ld	s4,16(sp)
 7b8:	6aa2                	ld	s5,8(sp)
 7ba:	6b02                	ld	s6,0(sp)
 7bc:	a03d                	j	7ea <malloc+0xe4>
 7be:	74a2                	ld	s1,40(sp)
 7c0:	6a42                	ld	s4,16(sp)
 7c2:	6aa2                	ld	s5,8(sp)
 7c4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7c6:	fae90be3          	beq	s2,a4,77c <malloc+0x76>
        p->s.size -= nunits;
 7ca:	4137073b          	subw	a4,a4,s3
 7ce:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7d0:	02071693          	slli	a3,a4,0x20
 7d4:	01c6d713          	srli	a4,a3,0x1c
 7d8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7da:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7de:	00000717          	auipc	a4,0x0
 7e2:	08a73d23          	sd	a0,154(a4) # 878 <freep>
      return (void*)(p + 1);
 7e6:	01078513          	addi	a0,a5,16
  }
}
 7ea:	70e2                	ld	ra,56(sp)
 7ec:	7442                	ld	s0,48(sp)
 7ee:	7902                	ld	s2,32(sp)
 7f0:	69e2                	ld	s3,24(sp)
 7f2:	6121                	addi	sp,sp,64
 7f4:	8082                	ret
 7f6:	74a2                	ld	s1,40(sp)
 7f8:	6a42                	ld	s4,16(sp)
 7fa:	6aa2                	ld	s5,8(sp)
 7fc:	6b02                	ld	s6,0(sp)
 7fe:	b7f5                	j	7ea <malloc+0xe4>
