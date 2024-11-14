
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	02f50163          	beq	a0,a5,2c <main+0x2c>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	82858593          	addi	a1,a1,-2008 # 838 <malloc+0xfa>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	63a080e7          	jalr	1594(ra) # 654 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2f8080e7          	jalr	760(ra) # 31c <exit>
  2c:	e426                	sd	s1,8(sp)
  2e:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  30:	698c                	ld	a1,16(a1)
  32:	6488                	ld	a0,8(s1)
  34:	00000097          	auipc	ra,0x0
  38:	348080e7          	jalr	840(ra) # 37c <link>
  3c:	00054763          	bltz	a0,4a <main+0x4a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	2da080e7          	jalr	730(ra) # 31c <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4a:	6894                	ld	a3,16(s1)
  4c:	6490                	ld	a2,8(s1)
  4e:	00001597          	auipc	a1,0x1
  52:	80258593          	addi	a1,a1,-2046 # 850 <malloc+0x112>
  56:	4509                	li	a0,2
  58:	00000097          	auipc	ra,0x0
  5c:	5fc080e7          	jalr	1532(ra) # 654 <fprintf>
  60:	b7c5                	j	40 <main+0x40>

0000000000000062 <strcpy>:



char*
strcpy(char *s, const char *t)
{
  62:	1141                	addi	sp,sp,-16
  64:	e406                	sd	ra,8(sp)
  66:	e022                	sd	s0,0(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0xa>
    ;
  return os;
}
  7a:	60a2                	ld	ra,8(sp)
  7c:	6402                	ld	s0,0(sp)
  7e:	0141                	addi	sp,sp,16
  80:	8082                	ret

0000000000000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	1141                	addi	sp,sp,-16
  84:	e406                	sd	ra,8(sp)
  86:	e022                	sd	s0,0(sp)
  88:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  8a:	00054783          	lbu	a5,0(a0)
  8e:	cb91                	beqz	a5,a2 <strcmp+0x20>
  90:	0005c703          	lbu	a4,0(a1)
  94:	00f71763          	bne	a4,a5,a2 <strcmp+0x20>
    p++, q++;
  98:	0505                	addi	a0,a0,1
  9a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	fbe5                	bnez	a5,90 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a2:	0005c503          	lbu	a0,0(a1)
}
  a6:	40a7853b          	subw	a0,a5,a0
  aa:	60a2                	ld	ra,8(sp)
  ac:	6402                	ld	s0,0(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret

00000000000000b2 <strlen>:

uint
strlen(const char *s)
{
  b2:	1141                	addi	sp,sp,-16
  b4:	e406                	sd	ra,8(sp)
  b6:	e022                	sd	s0,0(sp)
  b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ba:	00054783          	lbu	a5,0(a0)
  be:	cf99                	beqz	a5,dc <strlen+0x2a>
  c0:	0505                	addi	a0,a0,1
  c2:	87aa                	mv	a5,a0
  c4:	86be                	mv	a3,a5
  c6:	0785                	addi	a5,a5,1
  c8:	fff7c703          	lbu	a4,-1(a5)
  cc:	ff65                	bnez	a4,c4 <strlen+0x12>
  ce:	40a6853b          	subw	a0,a3,a0
  d2:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  d4:	60a2                	ld	ra,8(sp)
  d6:	6402                	ld	s0,0(sp)
  d8:	0141                	addi	sp,sp,16
  da:	8082                	ret
  for(n = 0; s[n]; n++)
  dc:	4501                	li	a0,0
  de:	bfdd                	j	d4 <strlen+0x22>

00000000000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	1141                	addi	sp,sp,-16
  e2:	e406                	sd	ra,8(sp)
  e4:	e022                	sd	s0,0(sp)
  e6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e8:	ca19                	beqz	a2,fe <memset+0x1e>
  ea:	87aa                	mv	a5,a0
  ec:	1602                	slli	a2,a2,0x20
  ee:	9201                	srli	a2,a2,0x20
  f0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f8:	0785                	addi	a5,a5,1
  fa:	fee79de3          	bne	a5,a4,f4 <memset+0x14>
  }
  return dst;
}
  fe:	60a2                	ld	ra,8(sp)
 100:	6402                	ld	s0,0(sp)
 102:	0141                	addi	sp,sp,16
 104:	8082                	ret

0000000000000106 <strchr>:

char*
strchr(const char *s, char c)
{
 106:	1141                	addi	sp,sp,-16
 108:	e406                	sd	ra,8(sp)
 10a:	e022                	sd	s0,0(sp)
 10c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10e:	00054783          	lbu	a5,0(a0)
 112:	cf81                	beqz	a5,12a <strchr+0x24>
    if(*s == c)
 114:	00f58763          	beq	a1,a5,122 <strchr+0x1c>
  for(; *s; s++)
 118:	0505                	addi	a0,a0,1
 11a:	00054783          	lbu	a5,0(a0)
 11e:	fbfd                	bnez	a5,114 <strchr+0xe>
      return (char*)s;
  return 0;
 120:	4501                	li	a0,0
}
 122:	60a2                	ld	ra,8(sp)
 124:	6402                	ld	s0,0(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret
  return 0;
 12a:	4501                	li	a0,0
 12c:	bfdd                	j	122 <strchr+0x1c>

000000000000012e <gets>:

char*
gets(char *buf, int max)
{
 12e:	7159                	addi	sp,sp,-112
 130:	f486                	sd	ra,104(sp)
 132:	f0a2                	sd	s0,96(sp)
 134:	eca6                	sd	s1,88(sp)
 136:	e8ca                	sd	s2,80(sp)
 138:	e4ce                	sd	s3,72(sp)
 13a:	e0d2                	sd	s4,64(sp)
 13c:	fc56                	sd	s5,56(sp)
 13e:	f85a                	sd	s6,48(sp)
 140:	f45e                	sd	s7,40(sp)
 142:	f062                	sd	s8,32(sp)
 144:	ec66                	sd	s9,24(sp)
 146:	e86a                	sd	s10,16(sp)
 148:	1880                	addi	s0,sp,112
 14a:	8caa                	mv	s9,a0
 14c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14e:	892a                	mv	s2,a0
 150:	4481                	li	s1,0
    cc = read(0, &c, 1);
 152:	f9f40b13          	addi	s6,s0,-97
 156:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 158:	4ba9                	li	s7,10
 15a:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 15c:	8d26                	mv	s10,s1
 15e:	0014899b          	addiw	s3,s1,1
 162:	84ce                	mv	s1,s3
 164:	0349d763          	bge	s3,s4,192 <gets+0x64>
    cc = read(0, &c, 1);
 168:	8656                	mv	a2,s5
 16a:	85da                	mv	a1,s6
 16c:	4501                	li	a0,0
 16e:	00000097          	auipc	ra,0x0
 172:	1c6080e7          	jalr	454(ra) # 334 <read>
    if(cc < 1)
 176:	00a05e63          	blez	a0,192 <gets+0x64>
    buf[i++] = c;
 17a:	f9f44783          	lbu	a5,-97(s0)
 17e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 182:	01778763          	beq	a5,s7,190 <gets+0x62>
 186:	0905                	addi	s2,s2,1
 188:	fd879ae3          	bne	a5,s8,15c <gets+0x2e>
    buf[i++] = c;
 18c:	8d4e                	mv	s10,s3
 18e:	a011                	j	192 <gets+0x64>
 190:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 192:	9d66                	add	s10,s10,s9
 194:	000d0023          	sb	zero,0(s10)
  return buf;
}
 198:	8566                	mv	a0,s9
 19a:	70a6                	ld	ra,104(sp)
 19c:	7406                	ld	s0,96(sp)
 19e:	64e6                	ld	s1,88(sp)
 1a0:	6946                	ld	s2,80(sp)
 1a2:	69a6                	ld	s3,72(sp)
 1a4:	6a06                	ld	s4,64(sp)
 1a6:	7ae2                	ld	s5,56(sp)
 1a8:	7b42                	ld	s6,48(sp)
 1aa:	7ba2                	ld	s7,40(sp)
 1ac:	7c02                	ld	s8,32(sp)
 1ae:	6ce2                	ld	s9,24(sp)
 1b0:	6d42                	ld	s10,16(sp)
 1b2:	6165                	addi	sp,sp,112
 1b4:	8082                	ret

00000000000001b6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b6:	1101                	addi	sp,sp,-32
 1b8:	ec06                	sd	ra,24(sp)
 1ba:	e822                	sd	s0,16(sp)
 1bc:	e04a                	sd	s2,0(sp)
 1be:	1000                	addi	s0,sp,32
 1c0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c2:	4581                	li	a1,0
 1c4:	00000097          	auipc	ra,0x0
 1c8:	198080e7          	jalr	408(ra) # 35c <open>
  if(fd < 0)
 1cc:	02054663          	bltz	a0,1f8 <stat+0x42>
 1d0:	e426                	sd	s1,8(sp)
 1d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d4:	85ca                	mv	a1,s2
 1d6:	00000097          	auipc	ra,0x0
 1da:	19e080e7          	jalr	414(ra) # 374 <fstat>
 1de:	892a                	mv	s2,a0
  close(fd);
 1e0:	8526                	mv	a0,s1
 1e2:	00000097          	auipc	ra,0x0
 1e6:	162080e7          	jalr	354(ra) # 344 <close>
  return r;
 1ea:	64a2                	ld	s1,8(sp)
}
 1ec:	854a                	mv	a0,s2
 1ee:	60e2                	ld	ra,24(sp)
 1f0:	6442                	ld	s0,16(sp)
 1f2:	6902                	ld	s2,0(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret
    return -1;
 1f8:	597d                	li	s2,-1
 1fa:	bfcd                	j	1ec <stat+0x36>

00000000000001fc <atoi>:

int
atoi(const char *s)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e406                	sd	ra,8(sp)
 200:	e022                	sd	s0,0(sp)
 202:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 204:	00054683          	lbu	a3,0(a0)
 208:	fd06879b          	addiw	a5,a3,-48
 20c:	0ff7f793          	zext.b	a5,a5
 210:	4625                	li	a2,9
 212:	02f66963          	bltu	a2,a5,244 <atoi+0x48>
 216:	872a                	mv	a4,a0
  n = 0;
 218:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 21a:	0705                	addi	a4,a4,1
 21c:	0025179b          	slliw	a5,a0,0x2
 220:	9fa9                	addw	a5,a5,a0
 222:	0017979b          	slliw	a5,a5,0x1
 226:	9fb5                	addw	a5,a5,a3
 228:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 22c:	00074683          	lbu	a3,0(a4)
 230:	fd06879b          	addiw	a5,a3,-48
 234:	0ff7f793          	zext.b	a5,a5
 238:	fef671e3          	bgeu	a2,a5,21a <atoi+0x1e>
  return n;
}
 23c:	60a2                	ld	ra,8(sp)
 23e:	6402                	ld	s0,0(sp)
 240:	0141                	addi	sp,sp,16
 242:	8082                	ret
  n = 0;
 244:	4501                	li	a0,0
 246:	bfdd                	j	23c <atoi+0x40>

0000000000000248 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 248:	1141                	addi	sp,sp,-16
 24a:	e406                	sd	ra,8(sp)
 24c:	e022                	sd	s0,0(sp)
 24e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 250:	02b57563          	bgeu	a0,a1,27a <memmove+0x32>
    while(n-- > 0)
 254:	00c05f63          	blez	a2,272 <memmove+0x2a>
 258:	1602                	slli	a2,a2,0x20
 25a:	9201                	srli	a2,a2,0x20
 25c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 260:	872a                	mv	a4,a0
      *dst++ = *src++;
 262:	0585                	addi	a1,a1,1
 264:	0705                	addi	a4,a4,1
 266:	fff5c683          	lbu	a3,-1(a1)
 26a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 26e:	fee79ae3          	bne	a5,a4,262 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 272:	60a2                	ld	ra,8(sp)
 274:	6402                	ld	s0,0(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
    dst += n;
 27a:	00c50733          	add	a4,a0,a2
    src += n;
 27e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 280:	fec059e3          	blez	a2,272 <memmove+0x2a>
 284:	fff6079b          	addiw	a5,a2,-1
 288:	1782                	slli	a5,a5,0x20
 28a:	9381                	srli	a5,a5,0x20
 28c:	fff7c793          	not	a5,a5
 290:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 292:	15fd                	addi	a1,a1,-1
 294:	177d                	addi	a4,a4,-1
 296:	0005c683          	lbu	a3,0(a1)
 29a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 29e:	fef71ae3          	bne	a4,a5,292 <memmove+0x4a>
 2a2:	bfc1                	j	272 <memmove+0x2a>

00000000000002a4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2a4:	1141                	addi	sp,sp,-16
 2a6:	e406                	sd	ra,8(sp)
 2a8:	e022                	sd	s0,0(sp)
 2aa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2ac:	ca0d                	beqz	a2,2de <memcmp+0x3a>
 2ae:	fff6069b          	addiw	a3,a2,-1
 2b2:	1682                	slli	a3,a3,0x20
 2b4:	9281                	srli	a3,a3,0x20
 2b6:	0685                	addi	a3,a3,1
 2b8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	0005c703          	lbu	a4,0(a1)
 2c2:	00e79863          	bne	a5,a4,2d2 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2c6:	0505                	addi	a0,a0,1
    p2++;
 2c8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ca:	fed518e3          	bne	a0,a3,2ba <memcmp+0x16>
  }
  return 0;
 2ce:	4501                	li	a0,0
 2d0:	a019                	j	2d6 <memcmp+0x32>
      return *p1 - *p2;
 2d2:	40e7853b          	subw	a0,a5,a4
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
  return 0;
 2de:	4501                	li	a0,0
 2e0:	bfdd                	j	2d6 <memcmp+0x32>

00000000000002e2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e406                	sd	ra,8(sp)
 2e6:	e022                	sd	s0,0(sp)
 2e8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ea:	00000097          	auipc	ra,0x0
 2ee:	f5e080e7          	jalr	-162(ra) # 248 <memmove>
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e406                	sd	ra,8(sp)
 2fe:	e022                	sd	s0,0(sp)
 300:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 302:	040007b7          	lui	a5,0x4000
 306:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffef24>
 308:	07b2                	slli	a5,a5,0xc
}
 30a:	4388                	lw	a0,0(a5)
 30c:	60a2                	ld	ra,8(sp)
 30e:	6402                	ld	s0,0(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret

0000000000000314 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 314:	4885                	li	a7,1
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <exit>:
.global exit
exit:
 li a7, SYS_exit
 31c:	4889                	li	a7,2
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <wait>:
.global wait
wait:
 li a7, SYS_wait
 324:	488d                	li	a7,3
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 32c:	4891                	li	a7,4
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <read>:
.global read
read:
 li a7, SYS_read
 334:	4895                	li	a7,5
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <write>:
.global write
write:
 li a7, SYS_write
 33c:	48c1                	li	a7,16
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <close>:
.global close
close:
 li a7, SYS_close
 344:	48d5                	li	a7,21
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <kill>:
.global kill
kill:
 li a7, SYS_kill
 34c:	4899                	li	a7,6
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <exec>:
.global exec
exec:
 li a7, SYS_exec
 354:	489d                	li	a7,7
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <open>:
.global open
open:
 li a7, SYS_open
 35c:	48bd                	li	a7,15
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 364:	48c5                	li	a7,17
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 36c:	48c9                	li	a7,18
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 374:	48a1                	li	a7,8
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <link>:
.global link
link:
 li a7, SYS_link
 37c:	48cd                	li	a7,19
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 384:	48d1                	li	a7,20
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38c:	48a5                	li	a7,9
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <dup>:
.global dup
dup:
 li a7, SYS_dup
 394:	48a9                	li	a7,10
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39c:	48ad                	li	a7,11
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3a4:	48b1                	li	a7,12
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3ac:	48b5                	li	a7,13
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b4:	48b9                	li	a7,14
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <connect>:
.global connect
connect:
 li a7, SYS_connect
 3bc:	48f5                	li	a7,29
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3c4:	48f9                	li	a7,30
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3cc:	1101                	addi	sp,sp,-32
 3ce:	ec06                	sd	ra,24(sp)
 3d0:	e822                	sd	s0,16(sp)
 3d2:	1000                	addi	s0,sp,32
 3d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3d8:	4605                	li	a2,1
 3da:	fef40593          	addi	a1,s0,-17
 3de:	00000097          	auipc	ra,0x0
 3e2:	f5e080e7          	jalr	-162(ra) # 33c <write>
}
 3e6:	60e2                	ld	ra,24(sp)
 3e8:	6442                	ld	s0,16(sp)
 3ea:	6105                	addi	sp,sp,32
 3ec:	8082                	ret

00000000000003ee <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ee:	7139                	addi	sp,sp,-64
 3f0:	fc06                	sd	ra,56(sp)
 3f2:	f822                	sd	s0,48(sp)
 3f4:	f426                	sd	s1,40(sp)
 3f6:	f04a                	sd	s2,32(sp)
 3f8:	ec4e                	sd	s3,24(sp)
 3fa:	0080                	addi	s0,sp,64
 3fc:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fe:	c299                	beqz	a3,404 <printint+0x16>
 400:	0805c063          	bltz	a1,480 <printint+0x92>
  neg = 0;
 404:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 406:	fc040313          	addi	t1,s0,-64
  neg = 0;
 40a:	869a                	mv	a3,t1
  i = 0;
 40c:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 40e:	00000817          	auipc	a6,0x0
 412:	4ba80813          	addi	a6,a6,1210 # 8c8 <digits>
 416:	88be                	mv	a7,a5
 418:	0017851b          	addiw	a0,a5,1
 41c:	87aa                	mv	a5,a0
 41e:	02c5f73b          	remuw	a4,a1,a2
 422:	1702                	slli	a4,a4,0x20
 424:	9301                	srli	a4,a4,0x20
 426:	9742                	add	a4,a4,a6
 428:	00074703          	lbu	a4,0(a4)
 42c:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 430:	872e                	mv	a4,a1
 432:	02c5d5bb          	divuw	a1,a1,a2
 436:	0685                	addi	a3,a3,1
 438:	fcc77fe3          	bgeu	a4,a2,416 <printint+0x28>
  if(neg)
 43c:	000e0c63          	beqz	t3,454 <printint+0x66>
    buf[i++] = '-';
 440:	fd050793          	addi	a5,a0,-48
 444:	00878533          	add	a0,a5,s0
 448:	02d00793          	li	a5,45
 44c:	fef50823          	sb	a5,-16(a0)
 450:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 454:	fff7899b          	addiw	s3,a5,-1
 458:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 45c:	fff4c583          	lbu	a1,-1(s1)
 460:	854a                	mv	a0,s2
 462:	00000097          	auipc	ra,0x0
 466:	f6a080e7          	jalr	-150(ra) # 3cc <putc>
  while(--i >= 0)
 46a:	39fd                	addiw	s3,s3,-1
 46c:	14fd                	addi	s1,s1,-1
 46e:	fe09d7e3          	bgez	s3,45c <printint+0x6e>
}
 472:	70e2                	ld	ra,56(sp)
 474:	7442                	ld	s0,48(sp)
 476:	74a2                	ld	s1,40(sp)
 478:	7902                	ld	s2,32(sp)
 47a:	69e2                	ld	s3,24(sp)
 47c:	6121                	addi	sp,sp,64
 47e:	8082                	ret
    x = -xx;
 480:	40b005bb          	negw	a1,a1
    neg = 1;
 484:	4e05                	li	t3,1
    x = -xx;
 486:	b741                	j	406 <printint+0x18>

0000000000000488 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 488:	715d                	addi	sp,sp,-80
 48a:	e486                	sd	ra,72(sp)
 48c:	e0a2                	sd	s0,64(sp)
 48e:	f84a                	sd	s2,48(sp)
 490:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 492:	0005c903          	lbu	s2,0(a1)
 496:	1a090a63          	beqz	s2,64a <vprintf+0x1c2>
 49a:	fc26                	sd	s1,56(sp)
 49c:	f44e                	sd	s3,40(sp)
 49e:	f052                	sd	s4,32(sp)
 4a0:	ec56                	sd	s5,24(sp)
 4a2:	e85a                	sd	s6,16(sp)
 4a4:	e45e                	sd	s7,8(sp)
 4a6:	8aaa                	mv	s5,a0
 4a8:	8bb2                	mv	s7,a2
 4aa:	00158493          	addi	s1,a1,1
  state = 0;
 4ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4b0:	02500a13          	li	s4,37
 4b4:	4b55                	li	s6,21
 4b6:	a839                	j	4d4 <vprintf+0x4c>
        putc(fd, c);
 4b8:	85ca                	mv	a1,s2
 4ba:	8556                	mv	a0,s5
 4bc:	00000097          	auipc	ra,0x0
 4c0:	f10080e7          	jalr	-240(ra) # 3cc <putc>
 4c4:	a019                	j	4ca <vprintf+0x42>
    } else if(state == '%'){
 4c6:	01498d63          	beq	s3,s4,4e0 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 4ca:	0485                	addi	s1,s1,1
 4cc:	fff4c903          	lbu	s2,-1(s1)
 4d0:	16090763          	beqz	s2,63e <vprintf+0x1b6>
    if(state == 0){
 4d4:	fe0999e3          	bnez	s3,4c6 <vprintf+0x3e>
      if(c == '%'){
 4d8:	ff4910e3          	bne	s2,s4,4b8 <vprintf+0x30>
        state = '%';
 4dc:	89d2                	mv	s3,s4
 4de:	b7f5                	j	4ca <vprintf+0x42>
      if(c == 'd'){
 4e0:	13490463          	beq	s2,s4,608 <vprintf+0x180>
 4e4:	f9d9079b          	addiw	a5,s2,-99
 4e8:	0ff7f793          	zext.b	a5,a5
 4ec:	12fb6763          	bltu	s6,a5,61a <vprintf+0x192>
 4f0:	f9d9079b          	addiw	a5,s2,-99
 4f4:	0ff7f713          	zext.b	a4,a5
 4f8:	12eb6163          	bltu	s6,a4,61a <vprintf+0x192>
 4fc:	00271793          	slli	a5,a4,0x2
 500:	00000717          	auipc	a4,0x0
 504:	37070713          	addi	a4,a4,880 # 870 <malloc+0x132>
 508:	97ba                	add	a5,a5,a4
 50a:	439c                	lw	a5,0(a5)
 50c:	97ba                	add	a5,a5,a4
 50e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 510:	008b8913          	addi	s2,s7,8
 514:	4685                	li	a3,1
 516:	4629                	li	a2,10
 518:	000ba583          	lw	a1,0(s7)
 51c:	8556                	mv	a0,s5
 51e:	00000097          	auipc	ra,0x0
 522:	ed0080e7          	jalr	-304(ra) # 3ee <printint>
 526:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 528:	4981                	li	s3,0
 52a:	b745                	j	4ca <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 52c:	008b8913          	addi	s2,s7,8
 530:	4681                	li	a3,0
 532:	4629                	li	a2,10
 534:	000ba583          	lw	a1,0(s7)
 538:	8556                	mv	a0,s5
 53a:	00000097          	auipc	ra,0x0
 53e:	eb4080e7          	jalr	-332(ra) # 3ee <printint>
 542:	8bca                	mv	s7,s2
      state = 0;
 544:	4981                	li	s3,0
 546:	b751                	j	4ca <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 548:	008b8913          	addi	s2,s7,8
 54c:	4681                	li	a3,0
 54e:	4641                	li	a2,16
 550:	000ba583          	lw	a1,0(s7)
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	e98080e7          	jalr	-360(ra) # 3ee <printint>
 55e:	8bca                	mv	s7,s2
      state = 0;
 560:	4981                	li	s3,0
 562:	b7a5                	j	4ca <vprintf+0x42>
 564:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 566:	008b8c13          	addi	s8,s7,8
 56a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 56e:	03000593          	li	a1,48
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e58080e7          	jalr	-424(ra) # 3cc <putc>
  putc(fd, 'x');
 57c:	07800593          	li	a1,120
 580:	8556                	mv	a0,s5
 582:	00000097          	auipc	ra,0x0
 586:	e4a080e7          	jalr	-438(ra) # 3cc <putc>
 58a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 58c:	00000b97          	auipc	s7,0x0
 590:	33cb8b93          	addi	s7,s7,828 # 8c8 <digits>
 594:	03c9d793          	srli	a5,s3,0x3c
 598:	97de                	add	a5,a5,s7
 59a:	0007c583          	lbu	a1,0(a5)
 59e:	8556                	mv	a0,s5
 5a0:	00000097          	auipc	ra,0x0
 5a4:	e2c080e7          	jalr	-468(ra) # 3cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5a8:	0992                	slli	s3,s3,0x4
 5aa:	397d                	addiw	s2,s2,-1
 5ac:	fe0914e3          	bnez	s2,594 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5b0:	8be2                	mv	s7,s8
      state = 0;
 5b2:	4981                	li	s3,0
 5b4:	6c02                	ld	s8,0(sp)
 5b6:	bf11                	j	4ca <vprintf+0x42>
        s = va_arg(ap, char*);
 5b8:	008b8993          	addi	s3,s7,8
 5bc:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5c0:	02090163          	beqz	s2,5e2 <vprintf+0x15a>
        while(*s != 0){
 5c4:	00094583          	lbu	a1,0(s2)
 5c8:	c9a5                	beqz	a1,638 <vprintf+0x1b0>
          putc(fd, *s);
 5ca:	8556                	mv	a0,s5
 5cc:	00000097          	auipc	ra,0x0
 5d0:	e00080e7          	jalr	-512(ra) # 3cc <putc>
          s++;
 5d4:	0905                	addi	s2,s2,1
        while(*s != 0){
 5d6:	00094583          	lbu	a1,0(s2)
 5da:	f9e5                	bnez	a1,5ca <vprintf+0x142>
        s = va_arg(ap, char*);
 5dc:	8bce                	mv	s7,s3
      state = 0;
 5de:	4981                	li	s3,0
 5e0:	b5ed                	j	4ca <vprintf+0x42>
          s = "(null)";
 5e2:	00000917          	auipc	s2,0x0
 5e6:	28690913          	addi	s2,s2,646 # 868 <malloc+0x12a>
        while(*s != 0){
 5ea:	02800593          	li	a1,40
 5ee:	bff1                	j	5ca <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 5f0:	008b8913          	addi	s2,s7,8
 5f4:	000bc583          	lbu	a1,0(s7)
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	dd2080e7          	jalr	-558(ra) # 3cc <putc>
 602:	8bca                	mv	s7,s2
      state = 0;
 604:	4981                	li	s3,0
 606:	b5d1                	j	4ca <vprintf+0x42>
        putc(fd, c);
 608:	02500593          	li	a1,37
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	dbe080e7          	jalr	-578(ra) # 3cc <putc>
      state = 0;
 616:	4981                	li	s3,0
 618:	bd4d                	j	4ca <vprintf+0x42>
        putc(fd, '%');
 61a:	02500593          	li	a1,37
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	dac080e7          	jalr	-596(ra) # 3cc <putc>
        putc(fd, c);
 628:	85ca                	mv	a1,s2
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	da0080e7          	jalr	-608(ra) # 3cc <putc>
      state = 0;
 634:	4981                	li	s3,0
 636:	bd51                	j	4ca <vprintf+0x42>
        s = va_arg(ap, char*);
 638:	8bce                	mv	s7,s3
      state = 0;
 63a:	4981                	li	s3,0
 63c:	b579                	j	4ca <vprintf+0x42>
 63e:	74e2                	ld	s1,56(sp)
 640:	79a2                	ld	s3,40(sp)
 642:	7a02                	ld	s4,32(sp)
 644:	6ae2                	ld	s5,24(sp)
 646:	6b42                	ld	s6,16(sp)
 648:	6ba2                	ld	s7,8(sp)
    }
  }
}
 64a:	60a6                	ld	ra,72(sp)
 64c:	6406                	ld	s0,64(sp)
 64e:	7942                	ld	s2,48(sp)
 650:	6161                	addi	sp,sp,80
 652:	8082                	ret

0000000000000654 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 654:	715d                	addi	sp,sp,-80
 656:	ec06                	sd	ra,24(sp)
 658:	e822                	sd	s0,16(sp)
 65a:	1000                	addi	s0,sp,32
 65c:	e010                	sd	a2,0(s0)
 65e:	e414                	sd	a3,8(s0)
 660:	e818                	sd	a4,16(s0)
 662:	ec1c                	sd	a5,24(s0)
 664:	03043023          	sd	a6,32(s0)
 668:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 66c:	8622                	mv	a2,s0
 66e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 672:	00000097          	auipc	ra,0x0
 676:	e16080e7          	jalr	-490(ra) # 488 <vprintf>
}
 67a:	60e2                	ld	ra,24(sp)
 67c:	6442                	ld	s0,16(sp)
 67e:	6161                	addi	sp,sp,80
 680:	8082                	ret

0000000000000682 <printf>:

void
printf(const char *fmt, ...)
{
 682:	711d                	addi	sp,sp,-96
 684:	ec06                	sd	ra,24(sp)
 686:	e822                	sd	s0,16(sp)
 688:	1000                	addi	s0,sp,32
 68a:	e40c                	sd	a1,8(s0)
 68c:	e810                	sd	a2,16(s0)
 68e:	ec14                	sd	a3,24(s0)
 690:	f018                	sd	a4,32(s0)
 692:	f41c                	sd	a5,40(s0)
 694:	03043823          	sd	a6,48(s0)
 698:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 69c:	00840613          	addi	a2,s0,8
 6a0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6a4:	85aa                	mv	a1,a0
 6a6:	4505                	li	a0,1
 6a8:	00000097          	auipc	ra,0x0
 6ac:	de0080e7          	jalr	-544(ra) # 488 <vprintf>
}
 6b0:	60e2                	ld	ra,24(sp)
 6b2:	6442                	ld	s0,16(sp)
 6b4:	6125                	addi	sp,sp,96
 6b6:	8082                	ret

00000000000006b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b8:	1141                	addi	sp,sp,-16
 6ba:	e406                	sd	ra,8(sp)
 6bc:	e022                	sd	s0,0(sp)
 6be:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c4:	00000797          	auipc	a5,0x0
 6c8:	21c7b783          	ld	a5,540(a5) # 8e0 <freep>
 6cc:	a02d                	j	6f6 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6ce:	4618                	lw	a4,8(a2)
 6d0:	9f2d                	addw	a4,a4,a1
 6d2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	6398                	ld	a4,0(a5)
 6d8:	6310                	ld	a2,0(a4)
 6da:	a83d                	j	718 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6dc:	ff852703          	lw	a4,-8(a0)
 6e0:	9f31                	addw	a4,a4,a2
 6e2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6e4:	ff053683          	ld	a3,-16(a0)
 6e8:	a091                	j	72c <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ea:	6398                	ld	a4,0(a5)
 6ec:	00e7e463          	bltu	a5,a4,6f4 <free+0x3c>
 6f0:	00e6ea63          	bltu	a3,a4,704 <free+0x4c>
{
 6f4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f6:	fed7fae3          	bgeu	a5,a3,6ea <free+0x32>
 6fa:	6398                	ld	a4,0(a5)
 6fc:	00e6e463          	bltu	a3,a4,704 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 700:	fee7eae3          	bltu	a5,a4,6f4 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 704:	ff852583          	lw	a1,-8(a0)
 708:	6390                	ld	a2,0(a5)
 70a:	02059813          	slli	a6,a1,0x20
 70e:	01c85713          	srli	a4,a6,0x1c
 712:	9736                	add	a4,a4,a3
 714:	fae60de3          	beq	a2,a4,6ce <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 718:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 71c:	4790                	lw	a2,8(a5)
 71e:	02061593          	slli	a1,a2,0x20
 722:	01c5d713          	srli	a4,a1,0x1c
 726:	973e                	add	a4,a4,a5
 728:	fae68ae3          	beq	a3,a4,6dc <free+0x24>
    p->s.ptr = bp->s.ptr;
 72c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 72e:	00000717          	auipc	a4,0x0
 732:	1af73923          	sd	a5,434(a4) # 8e0 <freep>
}
 736:	60a2                	ld	ra,8(sp)
 738:	6402                	ld	s0,0(sp)
 73a:	0141                	addi	sp,sp,16
 73c:	8082                	ret

000000000000073e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 73e:	7139                	addi	sp,sp,-64
 740:	fc06                	sd	ra,56(sp)
 742:	f822                	sd	s0,48(sp)
 744:	f04a                	sd	s2,32(sp)
 746:	ec4e                	sd	s3,24(sp)
 748:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 74a:	02051993          	slli	s3,a0,0x20
 74e:	0209d993          	srli	s3,s3,0x20
 752:	09bd                	addi	s3,s3,15
 754:	0049d993          	srli	s3,s3,0x4
 758:	2985                	addiw	s3,s3,1
 75a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 75c:	00000517          	auipc	a0,0x0
 760:	18453503          	ld	a0,388(a0) # 8e0 <freep>
 764:	c905                	beqz	a0,794 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 766:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 768:	4798                	lw	a4,8(a5)
 76a:	09377a63          	bgeu	a4,s3,7fe <malloc+0xc0>
 76e:	f426                	sd	s1,40(sp)
 770:	e852                	sd	s4,16(sp)
 772:	e456                	sd	s5,8(sp)
 774:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 776:	8a4e                	mv	s4,s3
 778:	6705                	lui	a4,0x1
 77a:	00e9f363          	bgeu	s3,a4,780 <malloc+0x42>
 77e:	6a05                	lui	s4,0x1
 780:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 784:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 788:	00000497          	auipc	s1,0x0
 78c:	15848493          	addi	s1,s1,344 # 8e0 <freep>
  if(p == (char*)-1)
 790:	5afd                	li	s5,-1
 792:	a089                	j	7d4 <malloc+0x96>
 794:	f426                	sd	s1,40(sp)
 796:	e852                	sd	s4,16(sp)
 798:	e456                	sd	s5,8(sp)
 79a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 79c:	00000797          	auipc	a5,0x0
 7a0:	14c78793          	addi	a5,a5,332 # 8e8 <base>
 7a4:	00000717          	auipc	a4,0x0
 7a8:	12f73e23          	sd	a5,316(a4) # 8e0 <freep>
 7ac:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7ae:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7b2:	b7d1                	j	776 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 7b4:	6398                	ld	a4,0(a5)
 7b6:	e118                	sd	a4,0(a0)
 7b8:	a8b9                	j	816 <malloc+0xd8>
  hp->s.size = nu;
 7ba:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7be:	0541                	addi	a0,a0,16
 7c0:	00000097          	auipc	ra,0x0
 7c4:	ef8080e7          	jalr	-264(ra) # 6b8 <free>
  return freep;
 7c8:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 7ca:	c135                	beqz	a0,82e <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7ce:	4798                	lw	a4,8(a5)
 7d0:	03277363          	bgeu	a4,s2,7f6 <malloc+0xb8>
    if(p == freep)
 7d4:	6098                	ld	a4,0(s1)
 7d6:	853e                	mv	a0,a5
 7d8:	fef71ae3          	bne	a4,a5,7cc <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7dc:	8552                	mv	a0,s4
 7de:	00000097          	auipc	ra,0x0
 7e2:	bc6080e7          	jalr	-1082(ra) # 3a4 <sbrk>
  if(p == (char*)-1)
 7e6:	fd551ae3          	bne	a0,s5,7ba <malloc+0x7c>
        return 0;
 7ea:	4501                	li	a0,0
 7ec:	74a2                	ld	s1,40(sp)
 7ee:	6a42                	ld	s4,16(sp)
 7f0:	6aa2                	ld	s5,8(sp)
 7f2:	6b02                	ld	s6,0(sp)
 7f4:	a03d                	j	822 <malloc+0xe4>
 7f6:	74a2                	ld	s1,40(sp)
 7f8:	6a42                	ld	s4,16(sp)
 7fa:	6aa2                	ld	s5,8(sp)
 7fc:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7fe:	fae90be3          	beq	s2,a4,7b4 <malloc+0x76>
        p->s.size -= nunits;
 802:	4137073b          	subw	a4,a4,s3
 806:	c798                	sw	a4,8(a5)
        p += p->s.size;
 808:	02071693          	slli	a3,a4,0x20
 80c:	01c6d713          	srli	a4,a3,0x1c
 810:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 812:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 816:	00000717          	auipc	a4,0x0
 81a:	0ca73523          	sd	a0,202(a4) # 8e0 <freep>
      return (void*)(p + 1);
 81e:	01078513          	addi	a0,a5,16
  }
}
 822:	70e2                	ld	ra,56(sp)
 824:	7442                	ld	s0,48(sp)
 826:	7902                	ld	s2,32(sp)
 828:	69e2                	ld	s3,24(sp)
 82a:	6121                	addi	sp,sp,64
 82c:	8082                	ret
 82e:	74a2                	ld	s1,40(sp)
 830:	6a42                	ld	s4,16(sp)
 832:	6aa2                	ld	s5,8(sp)
 834:	6b02                	ld	s6,0(sp)
 836:	b7f5                	j	822 <malloc+0xe4>
