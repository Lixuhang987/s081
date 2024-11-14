
user/_rm:     file format elf64-littleriscv


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
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7dd63          	bge	a5,a0,44 <main+0x44>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	35c080e7          	jalr	860(ra) # 384 <unlink>
  30:	02054a63          	bltz	a0,64 <main+0x64>
  for(i = 1; i < argc; i++){
  34:	04a1                	addi	s1,s1,8
  36:	ff2498e3          	bne	s1,s2,26 <main+0x26>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit(0);
  3a:	4501                	li	a0,0
  3c:	00000097          	auipc	ra,0x0
  40:	2f8080e7          	jalr	760(ra) # 334 <exit>
  44:	e426                	sd	s1,8(sp)
  46:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: rm files...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	80858593          	addi	a1,a1,-2040 # 850 <malloc+0xfa>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	61a080e7          	jalr	1562(ra) # 66c <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2d8080e7          	jalr	728(ra) # 334 <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  64:	6090                	ld	a2,0(s1)
  66:	00001597          	auipc	a1,0x1
  6a:	80258593          	addi	a1,a1,-2046 # 868 <malloc+0x112>
  6e:	4509                	li	a0,2
  70:	00000097          	auipc	ra,0x0
  74:	5fc080e7          	jalr	1532(ra) # 66c <fprintf>
      break;
  78:	b7c9                	j	3a <main+0x3a>

000000000000007a <strcpy>:



char*
strcpy(char *s, const char *t)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  82:	87aa                	mv	a5,a0
  84:	0585                	addi	a1,a1,1
  86:	0785                	addi	a5,a5,1
  88:	fff5c703          	lbu	a4,-1(a1)
  8c:	fee78fa3          	sb	a4,-1(a5)
  90:	fb75                	bnez	a4,84 <strcpy+0xa>
    ;
  return os;
}
  92:	60a2                	ld	ra,8(sp)
  94:	6402                	ld	s0,0(sp)
  96:	0141                	addi	sp,sp,16
  98:	8082                	ret

000000000000009a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  9a:	1141                	addi	sp,sp,-16
  9c:	e406                	sd	ra,8(sp)
  9e:	e022                	sd	s0,0(sp)
  a0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	cb91                	beqz	a5,ba <strcmp+0x20>
  a8:	0005c703          	lbu	a4,0(a1)
  ac:	00f71763          	bne	a4,a5,ba <strcmp+0x20>
    p++, q++;
  b0:	0505                	addi	a0,a0,1
  b2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  b4:	00054783          	lbu	a5,0(a0)
  b8:	fbe5                	bnez	a5,a8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  ba:	0005c503          	lbu	a0,0(a1)
}
  be:	40a7853b          	subw	a0,a5,a0
  c2:	60a2                	ld	ra,8(sp)
  c4:	6402                	ld	s0,0(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret

00000000000000ca <strlen>:

uint
strlen(const char *s)
{
  ca:	1141                	addi	sp,sp,-16
  cc:	e406                	sd	ra,8(sp)
  ce:	e022                	sd	s0,0(sp)
  d0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	cf99                	beqz	a5,f4 <strlen+0x2a>
  d8:	0505                	addi	a0,a0,1
  da:	87aa                	mv	a5,a0
  dc:	86be                	mv	a3,a5
  de:	0785                	addi	a5,a5,1
  e0:	fff7c703          	lbu	a4,-1(a5)
  e4:	ff65                	bnez	a4,dc <strlen+0x12>
  e6:	40a6853b          	subw	a0,a3,a0
  ea:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  ec:	60a2                	ld	ra,8(sp)
  ee:	6402                	ld	s0,0(sp)
  f0:	0141                	addi	sp,sp,16
  f2:	8082                	ret
  for(n = 0; s[n]; n++)
  f4:	4501                	li	a0,0
  f6:	bfdd                	j	ec <strlen+0x22>

00000000000000f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 100:	ca19                	beqz	a2,116 <memset+0x1e>
 102:	87aa                	mv	a5,a0
 104:	1602                	slli	a2,a2,0x20
 106:	9201                	srli	a2,a2,0x20
 108:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 10c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 110:	0785                	addi	a5,a5,1
 112:	fee79de3          	bne	a5,a4,10c <memset+0x14>
  }
  return dst;
}
 116:	60a2                	ld	ra,8(sp)
 118:	6402                	ld	s0,0(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strchr>:

char*
strchr(const char *s, char c)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e406                	sd	ra,8(sp)
 122:	e022                	sd	s0,0(sp)
 124:	0800                	addi	s0,sp,16
  for(; *s; s++)
 126:	00054783          	lbu	a5,0(a0)
 12a:	cf81                	beqz	a5,142 <strchr+0x24>
    if(*s == c)
 12c:	00f58763          	beq	a1,a5,13a <strchr+0x1c>
  for(; *s; s++)
 130:	0505                	addi	a0,a0,1
 132:	00054783          	lbu	a5,0(a0)
 136:	fbfd                	bnez	a5,12c <strchr+0xe>
      return (char*)s;
  return 0;
 138:	4501                	li	a0,0
}
 13a:	60a2                	ld	ra,8(sp)
 13c:	6402                	ld	s0,0(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret
  return 0;
 142:	4501                	li	a0,0
 144:	bfdd                	j	13a <strchr+0x1c>

0000000000000146 <gets>:

char*
gets(char *buf, int max)
{
 146:	7159                	addi	sp,sp,-112
 148:	f486                	sd	ra,104(sp)
 14a:	f0a2                	sd	s0,96(sp)
 14c:	eca6                	sd	s1,88(sp)
 14e:	e8ca                	sd	s2,80(sp)
 150:	e4ce                	sd	s3,72(sp)
 152:	e0d2                	sd	s4,64(sp)
 154:	fc56                	sd	s5,56(sp)
 156:	f85a                	sd	s6,48(sp)
 158:	f45e                	sd	s7,40(sp)
 15a:	f062                	sd	s8,32(sp)
 15c:	ec66                	sd	s9,24(sp)
 15e:	e86a                	sd	s10,16(sp)
 160:	1880                	addi	s0,sp,112
 162:	8caa                	mv	s9,a0
 164:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 166:	892a                	mv	s2,a0
 168:	4481                	li	s1,0
    cc = read(0, &c, 1);
 16a:	f9f40b13          	addi	s6,s0,-97
 16e:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 170:	4ba9                	li	s7,10
 172:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 174:	8d26                	mv	s10,s1
 176:	0014899b          	addiw	s3,s1,1
 17a:	84ce                	mv	s1,s3
 17c:	0349d763          	bge	s3,s4,1aa <gets+0x64>
    cc = read(0, &c, 1);
 180:	8656                	mv	a2,s5
 182:	85da                	mv	a1,s6
 184:	4501                	li	a0,0
 186:	00000097          	auipc	ra,0x0
 18a:	1c6080e7          	jalr	454(ra) # 34c <read>
    if(cc < 1)
 18e:	00a05e63          	blez	a0,1aa <gets+0x64>
    buf[i++] = c;
 192:	f9f44783          	lbu	a5,-97(s0)
 196:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 19a:	01778763          	beq	a5,s7,1a8 <gets+0x62>
 19e:	0905                	addi	s2,s2,1
 1a0:	fd879ae3          	bne	a5,s8,174 <gets+0x2e>
    buf[i++] = c;
 1a4:	8d4e                	mv	s10,s3
 1a6:	a011                	j	1aa <gets+0x64>
 1a8:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1aa:	9d66                	add	s10,s10,s9
 1ac:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1b0:	8566                	mv	a0,s9
 1b2:	70a6                	ld	ra,104(sp)
 1b4:	7406                	ld	s0,96(sp)
 1b6:	64e6                	ld	s1,88(sp)
 1b8:	6946                	ld	s2,80(sp)
 1ba:	69a6                	ld	s3,72(sp)
 1bc:	6a06                	ld	s4,64(sp)
 1be:	7ae2                	ld	s5,56(sp)
 1c0:	7b42                	ld	s6,48(sp)
 1c2:	7ba2                	ld	s7,40(sp)
 1c4:	7c02                	ld	s8,32(sp)
 1c6:	6ce2                	ld	s9,24(sp)
 1c8:	6d42                	ld	s10,16(sp)
 1ca:	6165                	addi	sp,sp,112
 1cc:	8082                	ret

00000000000001ce <stat>:

int
stat(const char *n, struct stat *st)
{
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec06                	sd	ra,24(sp)
 1d2:	e822                	sd	s0,16(sp)
 1d4:	e04a                	sd	s2,0(sp)
 1d6:	1000                	addi	s0,sp,32
 1d8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1da:	4581                	li	a1,0
 1dc:	00000097          	auipc	ra,0x0
 1e0:	198080e7          	jalr	408(ra) # 374 <open>
  if(fd < 0)
 1e4:	02054663          	bltz	a0,210 <stat+0x42>
 1e8:	e426                	sd	s1,8(sp)
 1ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ec:	85ca                	mv	a1,s2
 1ee:	00000097          	auipc	ra,0x0
 1f2:	19e080e7          	jalr	414(ra) # 38c <fstat>
 1f6:	892a                	mv	s2,a0
  close(fd);
 1f8:	8526                	mv	a0,s1
 1fa:	00000097          	auipc	ra,0x0
 1fe:	162080e7          	jalr	354(ra) # 35c <close>
  return r;
 202:	64a2                	ld	s1,8(sp)
}
 204:	854a                	mv	a0,s2
 206:	60e2                	ld	ra,24(sp)
 208:	6442                	ld	s0,16(sp)
 20a:	6902                	ld	s2,0(sp)
 20c:	6105                	addi	sp,sp,32
 20e:	8082                	ret
    return -1;
 210:	597d                	li	s2,-1
 212:	bfcd                	j	204 <stat+0x36>

0000000000000214 <atoi>:

int
atoi(const char *s)
{
 214:	1141                	addi	sp,sp,-16
 216:	e406                	sd	ra,8(sp)
 218:	e022                	sd	s0,0(sp)
 21a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21c:	00054683          	lbu	a3,0(a0)
 220:	fd06879b          	addiw	a5,a3,-48
 224:	0ff7f793          	zext.b	a5,a5
 228:	4625                	li	a2,9
 22a:	02f66963          	bltu	a2,a5,25c <atoi+0x48>
 22e:	872a                	mv	a4,a0
  n = 0;
 230:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 232:	0705                	addi	a4,a4,1
 234:	0025179b          	slliw	a5,a0,0x2
 238:	9fa9                	addw	a5,a5,a0
 23a:	0017979b          	slliw	a5,a5,0x1
 23e:	9fb5                	addw	a5,a5,a3
 240:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 244:	00074683          	lbu	a3,0(a4)
 248:	fd06879b          	addiw	a5,a3,-48
 24c:	0ff7f793          	zext.b	a5,a5
 250:	fef671e3          	bgeu	a2,a5,232 <atoi+0x1e>
  return n;
}
 254:	60a2                	ld	ra,8(sp)
 256:	6402                	ld	s0,0(sp)
 258:	0141                	addi	sp,sp,16
 25a:	8082                	ret
  n = 0;
 25c:	4501                	li	a0,0
 25e:	bfdd                	j	254 <atoi+0x40>

0000000000000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e406                	sd	ra,8(sp)
 264:	e022                	sd	s0,0(sp)
 266:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 268:	02b57563          	bgeu	a0,a1,292 <memmove+0x32>
    while(n-- > 0)
 26c:	00c05f63          	blez	a2,28a <memmove+0x2a>
 270:	1602                	slli	a2,a2,0x20
 272:	9201                	srli	a2,a2,0x20
 274:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 278:	872a                	mv	a4,a0
      *dst++ = *src++;
 27a:	0585                	addi	a1,a1,1
 27c:	0705                	addi	a4,a4,1
 27e:	fff5c683          	lbu	a3,-1(a1)
 282:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28a:	60a2                	ld	ra,8(sp)
 28c:	6402                	ld	s0,0(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret
    dst += n;
 292:	00c50733          	add	a4,a0,a2
    src += n;
 296:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 298:	fec059e3          	blez	a2,28a <memmove+0x2a>
 29c:	fff6079b          	addiw	a5,a2,-1
 2a0:	1782                	slli	a5,a5,0x20
 2a2:	9381                	srli	a5,a5,0x20
 2a4:	fff7c793          	not	a5,a5
 2a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2aa:	15fd                	addi	a1,a1,-1
 2ac:	177d                	addi	a4,a4,-1
 2ae:	0005c683          	lbu	a3,0(a1)
 2b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b6:	fef71ae3          	bne	a4,a5,2aa <memmove+0x4a>
 2ba:	bfc1                	j	28a <memmove+0x2a>

00000000000002bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e406                	sd	ra,8(sp)
 2c0:	e022                	sd	s0,0(sp)
 2c2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c4:	ca0d                	beqz	a2,2f6 <memcmp+0x3a>
 2c6:	fff6069b          	addiw	a3,a2,-1
 2ca:	1682                	slli	a3,a3,0x20
 2cc:	9281                	srli	a3,a3,0x20
 2ce:	0685                	addi	a3,a3,1
 2d0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2d2:	00054783          	lbu	a5,0(a0)
 2d6:	0005c703          	lbu	a4,0(a1)
 2da:	00e79863          	bne	a5,a4,2ea <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2de:	0505                	addi	a0,a0,1
    p2++;
 2e0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e2:	fed518e3          	bne	a0,a3,2d2 <memcmp+0x16>
  }
  return 0;
 2e6:	4501                	li	a0,0
 2e8:	a019                	j	2ee <memcmp+0x32>
      return *p1 - *p2;
 2ea:	40e7853b          	subw	a0,a5,a4
}
 2ee:	60a2                	ld	ra,8(sp)
 2f0:	6402                	ld	s0,0(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret
  return 0;
 2f6:	4501                	li	a0,0
 2f8:	bfdd                	j	2ee <memcmp+0x32>

00000000000002fa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e406                	sd	ra,8(sp)
 2fe:	e022                	sd	s0,0(sp)
 300:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 302:	00000097          	auipc	ra,0x0
 306:	f5e080e7          	jalr	-162(ra) # 260 <memmove>
}
 30a:	60a2                	ld	ra,8(sp)
 30c:	6402                	ld	s0,0(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 31a:	040007b7          	lui	a5,0x4000
 31e:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffef04>
 320:	07b2                	slli	a5,a5,0xc
}
 322:	4388                	lw	a0,0(a5)
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret

000000000000032c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 32c:	4885                	li	a7,1
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <exit>:
.global exit
exit:
 li a7, SYS_exit
 334:	4889                	li	a7,2
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <wait>:
.global wait
wait:
 li a7, SYS_wait
 33c:	488d                	li	a7,3
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 344:	4891                	li	a7,4
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <read>:
.global read
read:
 li a7, SYS_read
 34c:	4895                	li	a7,5
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <write>:
.global write
write:
 li a7, SYS_write
 354:	48c1                	li	a7,16
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <close>:
.global close
close:
 li a7, SYS_close
 35c:	48d5                	li	a7,21
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <kill>:
.global kill
kill:
 li a7, SYS_kill
 364:	4899                	li	a7,6
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <exec>:
.global exec
exec:
 li a7, SYS_exec
 36c:	489d                	li	a7,7
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <open>:
.global open
open:
 li a7, SYS_open
 374:	48bd                	li	a7,15
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 37c:	48c5                	li	a7,17
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 384:	48c9                	li	a7,18
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 38c:	48a1                	li	a7,8
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <link>:
.global link
link:
 li a7, SYS_link
 394:	48cd                	li	a7,19
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 39c:	48d1                	li	a7,20
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3a4:	48a5                	li	a7,9
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ac:	48a9                	li	a7,10
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3b4:	48ad                	li	a7,11
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 3bc:	48b1                	li	a7,12
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3c4:	48b5                	li	a7,13
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3cc:	48b9                	li	a7,14
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <connect>:
.global connect
connect:
 li a7, SYS_connect
 3d4:	48f5                	li	a7,29
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 3dc:	48f9                	li	a7,30
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3e4:	1101                	addi	sp,sp,-32
 3e6:	ec06                	sd	ra,24(sp)
 3e8:	e822                	sd	s0,16(sp)
 3ea:	1000                	addi	s0,sp,32
 3ec:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3f0:	4605                	li	a2,1
 3f2:	fef40593          	addi	a1,s0,-17
 3f6:	00000097          	auipc	ra,0x0
 3fa:	f5e080e7          	jalr	-162(ra) # 354 <write>
}
 3fe:	60e2                	ld	ra,24(sp)
 400:	6442                	ld	s0,16(sp)
 402:	6105                	addi	sp,sp,32
 404:	8082                	ret

0000000000000406 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 406:	7139                	addi	sp,sp,-64
 408:	fc06                	sd	ra,56(sp)
 40a:	f822                	sd	s0,48(sp)
 40c:	f426                	sd	s1,40(sp)
 40e:	f04a                	sd	s2,32(sp)
 410:	ec4e                	sd	s3,24(sp)
 412:	0080                	addi	s0,sp,64
 414:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 416:	c299                	beqz	a3,41c <printint+0x16>
 418:	0805c063          	bltz	a1,498 <printint+0x92>
  neg = 0;
 41c:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 41e:	fc040313          	addi	t1,s0,-64
  neg = 0;
 422:	869a                	mv	a3,t1
  i = 0;
 424:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 426:	00000817          	auipc	a6,0x0
 42a:	4c280813          	addi	a6,a6,1218 # 8e8 <digits>
 42e:	88be                	mv	a7,a5
 430:	0017851b          	addiw	a0,a5,1
 434:	87aa                	mv	a5,a0
 436:	02c5f73b          	remuw	a4,a1,a2
 43a:	1702                	slli	a4,a4,0x20
 43c:	9301                	srli	a4,a4,0x20
 43e:	9742                	add	a4,a4,a6
 440:	00074703          	lbu	a4,0(a4)
 444:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 448:	872e                	mv	a4,a1
 44a:	02c5d5bb          	divuw	a1,a1,a2
 44e:	0685                	addi	a3,a3,1
 450:	fcc77fe3          	bgeu	a4,a2,42e <printint+0x28>
  if(neg)
 454:	000e0c63          	beqz	t3,46c <printint+0x66>
    buf[i++] = '-';
 458:	fd050793          	addi	a5,a0,-48
 45c:	00878533          	add	a0,a5,s0
 460:	02d00793          	li	a5,45
 464:	fef50823          	sb	a5,-16(a0)
 468:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 46c:	fff7899b          	addiw	s3,a5,-1
 470:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 474:	fff4c583          	lbu	a1,-1(s1)
 478:	854a                	mv	a0,s2
 47a:	00000097          	auipc	ra,0x0
 47e:	f6a080e7          	jalr	-150(ra) # 3e4 <putc>
  while(--i >= 0)
 482:	39fd                	addiw	s3,s3,-1
 484:	14fd                	addi	s1,s1,-1
 486:	fe09d7e3          	bgez	s3,474 <printint+0x6e>
}
 48a:	70e2                	ld	ra,56(sp)
 48c:	7442                	ld	s0,48(sp)
 48e:	74a2                	ld	s1,40(sp)
 490:	7902                	ld	s2,32(sp)
 492:	69e2                	ld	s3,24(sp)
 494:	6121                	addi	sp,sp,64
 496:	8082                	ret
    x = -xx;
 498:	40b005bb          	negw	a1,a1
    neg = 1;
 49c:	4e05                	li	t3,1
    x = -xx;
 49e:	b741                	j	41e <printint+0x18>

00000000000004a0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4a0:	715d                	addi	sp,sp,-80
 4a2:	e486                	sd	ra,72(sp)
 4a4:	e0a2                	sd	s0,64(sp)
 4a6:	f84a                	sd	s2,48(sp)
 4a8:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4aa:	0005c903          	lbu	s2,0(a1)
 4ae:	1a090a63          	beqz	s2,662 <vprintf+0x1c2>
 4b2:	fc26                	sd	s1,56(sp)
 4b4:	f44e                	sd	s3,40(sp)
 4b6:	f052                	sd	s4,32(sp)
 4b8:	ec56                	sd	s5,24(sp)
 4ba:	e85a                	sd	s6,16(sp)
 4bc:	e45e                	sd	s7,8(sp)
 4be:	8aaa                	mv	s5,a0
 4c0:	8bb2                	mv	s7,a2
 4c2:	00158493          	addi	s1,a1,1
  state = 0;
 4c6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4c8:	02500a13          	li	s4,37
 4cc:	4b55                	li	s6,21
 4ce:	a839                	j	4ec <vprintf+0x4c>
        putc(fd, c);
 4d0:	85ca                	mv	a1,s2
 4d2:	8556                	mv	a0,s5
 4d4:	00000097          	auipc	ra,0x0
 4d8:	f10080e7          	jalr	-240(ra) # 3e4 <putc>
 4dc:	a019                	j	4e2 <vprintf+0x42>
    } else if(state == '%'){
 4de:	01498d63          	beq	s3,s4,4f8 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 4e2:	0485                	addi	s1,s1,1
 4e4:	fff4c903          	lbu	s2,-1(s1)
 4e8:	16090763          	beqz	s2,656 <vprintf+0x1b6>
    if(state == 0){
 4ec:	fe0999e3          	bnez	s3,4de <vprintf+0x3e>
      if(c == '%'){
 4f0:	ff4910e3          	bne	s2,s4,4d0 <vprintf+0x30>
        state = '%';
 4f4:	89d2                	mv	s3,s4
 4f6:	b7f5                	j	4e2 <vprintf+0x42>
      if(c == 'd'){
 4f8:	13490463          	beq	s2,s4,620 <vprintf+0x180>
 4fc:	f9d9079b          	addiw	a5,s2,-99
 500:	0ff7f793          	zext.b	a5,a5
 504:	12fb6763          	bltu	s6,a5,632 <vprintf+0x192>
 508:	f9d9079b          	addiw	a5,s2,-99
 50c:	0ff7f713          	zext.b	a4,a5
 510:	12eb6163          	bltu	s6,a4,632 <vprintf+0x192>
 514:	00271793          	slli	a5,a4,0x2
 518:	00000717          	auipc	a4,0x0
 51c:	37870713          	addi	a4,a4,888 # 890 <malloc+0x13a>
 520:	97ba                	add	a5,a5,a4
 522:	439c                	lw	a5,0(a5)
 524:	97ba                	add	a5,a5,a4
 526:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 528:	008b8913          	addi	s2,s7,8
 52c:	4685                	li	a3,1
 52e:	4629                	li	a2,10
 530:	000ba583          	lw	a1,0(s7)
 534:	8556                	mv	a0,s5
 536:	00000097          	auipc	ra,0x0
 53a:	ed0080e7          	jalr	-304(ra) # 406 <printint>
 53e:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 540:	4981                	li	s3,0
 542:	b745                	j	4e2 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 544:	008b8913          	addi	s2,s7,8
 548:	4681                	li	a3,0
 54a:	4629                	li	a2,10
 54c:	000ba583          	lw	a1,0(s7)
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	eb4080e7          	jalr	-332(ra) # 406 <printint>
 55a:	8bca                	mv	s7,s2
      state = 0;
 55c:	4981                	li	s3,0
 55e:	b751                	j	4e2 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 560:	008b8913          	addi	s2,s7,8
 564:	4681                	li	a3,0
 566:	4641                	li	a2,16
 568:	000ba583          	lw	a1,0(s7)
 56c:	8556                	mv	a0,s5
 56e:	00000097          	auipc	ra,0x0
 572:	e98080e7          	jalr	-360(ra) # 406 <printint>
 576:	8bca                	mv	s7,s2
      state = 0;
 578:	4981                	li	s3,0
 57a:	b7a5                	j	4e2 <vprintf+0x42>
 57c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 57e:	008b8c13          	addi	s8,s7,8
 582:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 586:	03000593          	li	a1,48
 58a:	8556                	mv	a0,s5
 58c:	00000097          	auipc	ra,0x0
 590:	e58080e7          	jalr	-424(ra) # 3e4 <putc>
  putc(fd, 'x');
 594:	07800593          	li	a1,120
 598:	8556                	mv	a0,s5
 59a:	00000097          	auipc	ra,0x0
 59e:	e4a080e7          	jalr	-438(ra) # 3e4 <putc>
 5a2:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5a4:	00000b97          	auipc	s7,0x0
 5a8:	344b8b93          	addi	s7,s7,836 # 8e8 <digits>
 5ac:	03c9d793          	srli	a5,s3,0x3c
 5b0:	97de                	add	a5,a5,s7
 5b2:	0007c583          	lbu	a1,0(a5)
 5b6:	8556                	mv	a0,s5
 5b8:	00000097          	auipc	ra,0x0
 5bc:	e2c080e7          	jalr	-468(ra) # 3e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5c0:	0992                	slli	s3,s3,0x4
 5c2:	397d                	addiw	s2,s2,-1
 5c4:	fe0914e3          	bnez	s2,5ac <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 5c8:	8be2                	mv	s7,s8
      state = 0;
 5ca:	4981                	li	s3,0
 5cc:	6c02                	ld	s8,0(sp)
 5ce:	bf11                	j	4e2 <vprintf+0x42>
        s = va_arg(ap, char*);
 5d0:	008b8993          	addi	s3,s7,8
 5d4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 5d8:	02090163          	beqz	s2,5fa <vprintf+0x15a>
        while(*s != 0){
 5dc:	00094583          	lbu	a1,0(s2)
 5e0:	c9a5                	beqz	a1,650 <vprintf+0x1b0>
          putc(fd, *s);
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	e00080e7          	jalr	-512(ra) # 3e4 <putc>
          s++;
 5ec:	0905                	addi	s2,s2,1
        while(*s != 0){
 5ee:	00094583          	lbu	a1,0(s2)
 5f2:	f9e5                	bnez	a1,5e2 <vprintf+0x142>
        s = va_arg(ap, char*);
 5f4:	8bce                	mv	s7,s3
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b5ed                	j	4e2 <vprintf+0x42>
          s = "(null)";
 5fa:	00000917          	auipc	s2,0x0
 5fe:	28e90913          	addi	s2,s2,654 # 888 <malloc+0x132>
        while(*s != 0){
 602:	02800593          	li	a1,40
 606:	bff1                	j	5e2 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 608:	008b8913          	addi	s2,s7,8
 60c:	000bc583          	lbu	a1,0(s7)
 610:	8556                	mv	a0,s5
 612:	00000097          	auipc	ra,0x0
 616:	dd2080e7          	jalr	-558(ra) # 3e4 <putc>
 61a:	8bca                	mv	s7,s2
      state = 0;
 61c:	4981                	li	s3,0
 61e:	b5d1                	j	4e2 <vprintf+0x42>
        putc(fd, c);
 620:	02500593          	li	a1,37
 624:	8556                	mv	a0,s5
 626:	00000097          	auipc	ra,0x0
 62a:	dbe080e7          	jalr	-578(ra) # 3e4 <putc>
      state = 0;
 62e:	4981                	li	s3,0
 630:	bd4d                	j	4e2 <vprintf+0x42>
        putc(fd, '%');
 632:	02500593          	li	a1,37
 636:	8556                	mv	a0,s5
 638:	00000097          	auipc	ra,0x0
 63c:	dac080e7          	jalr	-596(ra) # 3e4 <putc>
        putc(fd, c);
 640:	85ca                	mv	a1,s2
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	da0080e7          	jalr	-608(ra) # 3e4 <putc>
      state = 0;
 64c:	4981                	li	s3,0
 64e:	bd51                	j	4e2 <vprintf+0x42>
        s = va_arg(ap, char*);
 650:	8bce                	mv	s7,s3
      state = 0;
 652:	4981                	li	s3,0
 654:	b579                	j	4e2 <vprintf+0x42>
 656:	74e2                	ld	s1,56(sp)
 658:	79a2                	ld	s3,40(sp)
 65a:	7a02                	ld	s4,32(sp)
 65c:	6ae2                	ld	s5,24(sp)
 65e:	6b42                	ld	s6,16(sp)
 660:	6ba2                	ld	s7,8(sp)
    }
  }
}
 662:	60a6                	ld	ra,72(sp)
 664:	6406                	ld	s0,64(sp)
 666:	7942                	ld	s2,48(sp)
 668:	6161                	addi	sp,sp,80
 66a:	8082                	ret

000000000000066c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 66c:	715d                	addi	sp,sp,-80
 66e:	ec06                	sd	ra,24(sp)
 670:	e822                	sd	s0,16(sp)
 672:	1000                	addi	s0,sp,32
 674:	e010                	sd	a2,0(s0)
 676:	e414                	sd	a3,8(s0)
 678:	e818                	sd	a4,16(s0)
 67a:	ec1c                	sd	a5,24(s0)
 67c:	03043023          	sd	a6,32(s0)
 680:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 684:	8622                	mv	a2,s0
 686:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 68a:	00000097          	auipc	ra,0x0
 68e:	e16080e7          	jalr	-490(ra) # 4a0 <vprintf>
}
 692:	60e2                	ld	ra,24(sp)
 694:	6442                	ld	s0,16(sp)
 696:	6161                	addi	sp,sp,80
 698:	8082                	ret

000000000000069a <printf>:

void
printf(const char *fmt, ...)
{
 69a:	711d                	addi	sp,sp,-96
 69c:	ec06                	sd	ra,24(sp)
 69e:	e822                	sd	s0,16(sp)
 6a0:	1000                	addi	s0,sp,32
 6a2:	e40c                	sd	a1,8(s0)
 6a4:	e810                	sd	a2,16(s0)
 6a6:	ec14                	sd	a3,24(s0)
 6a8:	f018                	sd	a4,32(s0)
 6aa:	f41c                	sd	a5,40(s0)
 6ac:	03043823          	sd	a6,48(s0)
 6b0:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6b4:	00840613          	addi	a2,s0,8
 6b8:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6bc:	85aa                	mv	a1,a0
 6be:	4505                	li	a0,1
 6c0:	00000097          	auipc	ra,0x0
 6c4:	de0080e7          	jalr	-544(ra) # 4a0 <vprintf>
}
 6c8:	60e2                	ld	ra,24(sp)
 6ca:	6442                	ld	s0,16(sp)
 6cc:	6125                	addi	sp,sp,96
 6ce:	8082                	ret

00000000000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	1141                	addi	sp,sp,-16
 6d2:	e406                	sd	ra,8(sp)
 6d4:	e022                	sd	s0,0(sp)
 6d6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6d8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6dc:	00000797          	auipc	a5,0x0
 6e0:	2247b783          	ld	a5,548(a5) # 900 <freep>
 6e4:	a02d                	j	70e <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6e6:	4618                	lw	a4,8(a2)
 6e8:	9f2d                	addw	a4,a4,a1
 6ea:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ee:	6398                	ld	a4,0(a5)
 6f0:	6310                	ld	a2,0(a4)
 6f2:	a83d                	j	730 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6f4:	ff852703          	lw	a4,-8(a0)
 6f8:	9f31                	addw	a4,a4,a2
 6fa:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6fc:	ff053683          	ld	a3,-16(a0)
 700:	a091                	j	744 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 702:	6398                	ld	a4,0(a5)
 704:	00e7e463          	bltu	a5,a4,70c <free+0x3c>
 708:	00e6ea63          	bltu	a3,a4,71c <free+0x4c>
{
 70c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70e:	fed7fae3          	bgeu	a5,a3,702 <free+0x32>
 712:	6398                	ld	a4,0(a5)
 714:	00e6e463          	bltu	a3,a4,71c <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	fee7eae3          	bltu	a5,a4,70c <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 71c:	ff852583          	lw	a1,-8(a0)
 720:	6390                	ld	a2,0(a5)
 722:	02059813          	slli	a6,a1,0x20
 726:	01c85713          	srli	a4,a6,0x1c
 72a:	9736                	add	a4,a4,a3
 72c:	fae60de3          	beq	a2,a4,6e6 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 730:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 734:	4790                	lw	a2,8(a5)
 736:	02061593          	slli	a1,a2,0x20
 73a:	01c5d713          	srli	a4,a1,0x1c
 73e:	973e                	add	a4,a4,a5
 740:	fae68ae3          	beq	a3,a4,6f4 <free+0x24>
    p->s.ptr = bp->s.ptr;
 744:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 746:	00000717          	auipc	a4,0x0
 74a:	1af73d23          	sd	a5,442(a4) # 900 <freep>
}
 74e:	60a2                	ld	ra,8(sp)
 750:	6402                	ld	s0,0(sp)
 752:	0141                	addi	sp,sp,16
 754:	8082                	ret

0000000000000756 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 756:	7139                	addi	sp,sp,-64
 758:	fc06                	sd	ra,56(sp)
 75a:	f822                	sd	s0,48(sp)
 75c:	f04a                	sd	s2,32(sp)
 75e:	ec4e                	sd	s3,24(sp)
 760:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	02051993          	slli	s3,a0,0x20
 766:	0209d993          	srli	s3,s3,0x20
 76a:	09bd                	addi	s3,s3,15
 76c:	0049d993          	srli	s3,s3,0x4
 770:	2985                	addiw	s3,s3,1
 772:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 774:	00000517          	auipc	a0,0x0
 778:	18c53503          	ld	a0,396(a0) # 900 <freep>
 77c:	c905                	beqz	a0,7ac <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 77e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 780:	4798                	lw	a4,8(a5)
 782:	09377a63          	bgeu	a4,s3,816 <malloc+0xc0>
 786:	f426                	sd	s1,40(sp)
 788:	e852                	sd	s4,16(sp)
 78a:	e456                	sd	s5,8(sp)
 78c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 78e:	8a4e                	mv	s4,s3
 790:	6705                	lui	a4,0x1
 792:	00e9f363          	bgeu	s3,a4,798 <malloc+0x42>
 796:	6a05                	lui	s4,0x1
 798:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 79c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7a0:	00000497          	auipc	s1,0x0
 7a4:	16048493          	addi	s1,s1,352 # 900 <freep>
  if(p == (char*)-1)
 7a8:	5afd                	li	s5,-1
 7aa:	a089                	j	7ec <malloc+0x96>
 7ac:	f426                	sd	s1,40(sp)
 7ae:	e852                	sd	s4,16(sp)
 7b0:	e456                	sd	s5,8(sp)
 7b2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 7b4:	00000797          	auipc	a5,0x0
 7b8:	15478793          	addi	a5,a5,340 # 908 <base>
 7bc:	00000717          	auipc	a4,0x0
 7c0:	14f73223          	sd	a5,324(a4) # 900 <freep>
 7c4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7c6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7ca:	b7d1                	j	78e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 7cc:	6398                	ld	a4,0(a5)
 7ce:	e118                	sd	a4,0(a0)
 7d0:	a8b9                	j	82e <malloc+0xd8>
  hp->s.size = nu;
 7d2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7d6:	0541                	addi	a0,a0,16
 7d8:	00000097          	auipc	ra,0x0
 7dc:	ef8080e7          	jalr	-264(ra) # 6d0 <free>
  return freep;
 7e0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 7e2:	c135                	beqz	a0,846 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7e6:	4798                	lw	a4,8(a5)
 7e8:	03277363          	bgeu	a4,s2,80e <malloc+0xb8>
    if(p == freep)
 7ec:	6098                	ld	a4,0(s1)
 7ee:	853e                	mv	a0,a5
 7f0:	fef71ae3          	bne	a4,a5,7e4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7f4:	8552                	mv	a0,s4
 7f6:	00000097          	auipc	ra,0x0
 7fa:	bc6080e7          	jalr	-1082(ra) # 3bc <sbrk>
  if(p == (char*)-1)
 7fe:	fd551ae3          	bne	a0,s5,7d2 <malloc+0x7c>
        return 0;
 802:	4501                	li	a0,0
 804:	74a2                	ld	s1,40(sp)
 806:	6a42                	ld	s4,16(sp)
 808:	6aa2                	ld	s5,8(sp)
 80a:	6b02                	ld	s6,0(sp)
 80c:	a03d                	j	83a <malloc+0xe4>
 80e:	74a2                	ld	s1,40(sp)
 810:	6a42                	ld	s4,16(sp)
 812:	6aa2                	ld	s5,8(sp)
 814:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 816:	fae90be3          	beq	s2,a4,7cc <malloc+0x76>
        p->s.size -= nunits;
 81a:	4137073b          	subw	a4,a4,s3
 81e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 820:	02071693          	slli	a3,a4,0x20
 824:	01c6d713          	srli	a4,a3,0x1c
 828:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 82a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 82e:	00000717          	auipc	a4,0x0
 832:	0ca73923          	sd	a0,210(a4) # 900 <freep>
      return (void*)(p + 1);
 836:	01078513          	addi	a0,a5,16
  }
}
 83a:	70e2                	ld	ra,56(sp)
 83c:	7442                	ld	s0,48(sp)
 83e:	7902                	ld	s2,32(sp)
 840:	69e2                	ld	s3,24(sp)
 842:	6121                	addi	sp,sp,64
 844:	8082                	ret
 846:	74a2                	ld	s1,40(sp)
 848:	6a42                	ld	s4,16(sp)
 84a:	6aa2                	ld	s5,8(sp)
 84c:	6b02                	ld	s6,0(sp)
 84e:	b7f5                	j	83a <malloc+0xe4>
