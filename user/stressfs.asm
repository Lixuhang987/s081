
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	22913423          	sd	s1,552(sp)
  10:	23213023          	sd	s2,544(sp)
  14:	21313c23          	sd	s3,536(sp)
  18:	21413823          	sd	s4,528(sp)
  1c:	0480                	addi	s0,sp,576
  int fd, i;
  char path[] = "stressfs0";
  1e:	00001797          	auipc	a5,0x1
  22:	90a78793          	addi	a5,a5,-1782 # 928 <malloc+0x130>
  26:	6398                	ld	a4,0(a5)
  28:	fce43023          	sd	a4,-64(s0)
  2c:	0087d783          	lhu	a5,8(a5)
  30:	fcf41423          	sh	a5,-56(s0)
  char data[512];

  printf("stressfs starting\n");
  34:	00001517          	auipc	a0,0x1
  38:	8c450513          	addi	a0,a0,-1852 # 8f8 <malloc+0x100>
  3c:	00000097          	auipc	ra,0x0
  40:	700080e7          	jalr	1792(ra) # 73c <printf>
  memset(data, 'a', sizeof(data));
  44:	20000613          	li	a2,512
  48:	06100593          	li	a1,97
  4c:	dc040513          	addi	a0,s0,-576
  50:	00000097          	auipc	ra,0x0
  54:	14a080e7          	jalr	330(ra) # 19a <memset>

  for(i = 0; i < 4; i++)
  58:	4481                	li	s1,0
  5a:	4911                	li	s2,4
    if(fork() > 0)
  5c:	00000097          	auipc	ra,0x0
  60:	372080e7          	jalr	882(ra) # 3ce <fork>
  64:	00a04563          	bgtz	a0,6e <main+0x6e>
  for(i = 0; i < 4; i++)
  68:	2485                	addiw	s1,s1,1
  6a:	ff2499e3          	bne	s1,s2,5c <main+0x5c>
      break;

  printf("write %d\n", i);
  6e:	85a6                	mv	a1,s1
  70:	00001517          	auipc	a0,0x1
  74:	8a050513          	addi	a0,a0,-1888 # 910 <malloc+0x118>
  78:	00000097          	auipc	ra,0x0
  7c:	6c4080e7          	jalr	1732(ra) # 73c <printf>

  path[8] += i;
  80:	fc844783          	lbu	a5,-56(s0)
  84:	9fa5                	addw	a5,a5,s1
  86:	fcf40423          	sb	a5,-56(s0)
  fd = open(path, O_CREATE | O_RDWR);
  8a:	20200593          	li	a1,514
  8e:	fc040513          	addi	a0,s0,-64
  92:	00000097          	auipc	ra,0x0
  96:	384080e7          	jalr	900(ra) # 416 <open>
  9a:	892a                	mv	s2,a0
  9c:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  9e:	dc040a13          	addi	s4,s0,-576
  a2:	20000993          	li	s3,512
  a6:	864e                	mv	a2,s3
  a8:	85d2                	mv	a1,s4
  aa:	854a                	mv	a0,s2
  ac:	00000097          	auipc	ra,0x0
  b0:	34a080e7          	jalr	842(ra) # 3f6 <write>
  for(i = 0; i < 20; i++)
  b4:	34fd                	addiw	s1,s1,-1
  b6:	f8e5                	bnez	s1,a6 <main+0xa6>
  close(fd);
  b8:	854a                	mv	a0,s2
  ba:	00000097          	auipc	ra,0x0
  be:	344080e7          	jalr	836(ra) # 3fe <close>

  printf("read\n");
  c2:	00001517          	auipc	a0,0x1
  c6:	85e50513          	addi	a0,a0,-1954 # 920 <malloc+0x128>
  ca:	00000097          	auipc	ra,0x0
  ce:	672080e7          	jalr	1650(ra) # 73c <printf>

  fd = open(path, O_RDONLY);
  d2:	4581                	li	a1,0
  d4:	fc040513          	addi	a0,s0,-64
  d8:	00000097          	auipc	ra,0x0
  dc:	33e080e7          	jalr	830(ra) # 416 <open>
  e0:	892a                	mv	s2,a0
  e2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  e4:	dc040a13          	addi	s4,s0,-576
  e8:	20000993          	li	s3,512
  ec:	864e                	mv	a2,s3
  ee:	85d2                	mv	a1,s4
  f0:	854a                	mv	a0,s2
  f2:	00000097          	auipc	ra,0x0
  f6:	2fc080e7          	jalr	764(ra) # 3ee <read>
  for (i = 0; i < 20; i++)
  fa:	34fd                	addiw	s1,s1,-1
  fc:	f8e5                	bnez	s1,ec <main+0xec>
  close(fd);
  fe:	854a                	mv	a0,s2
 100:	00000097          	auipc	ra,0x0
 104:	2fe080e7          	jalr	766(ra) # 3fe <close>

  wait(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	2d4080e7          	jalr	724(ra) # 3de <wait>

  exit(0);
 112:	4501                	li	a0,0
 114:	00000097          	auipc	ra,0x0
 118:	2c2080e7          	jalr	706(ra) # 3d6 <exit>

000000000000011c <strcpy>:



char*
strcpy(char *s, const char *t)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e406                	sd	ra,8(sp)
 120:	e022                	sd	s0,0(sp)
 122:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 124:	87aa                	mv	a5,a0
 126:	0585                	addi	a1,a1,1
 128:	0785                	addi	a5,a5,1
 12a:	fff5c703          	lbu	a4,-1(a1)
 12e:	fee78fa3          	sb	a4,-1(a5)
 132:	fb75                	bnez	a4,126 <strcpy+0xa>
    ;
  return os;
}
 134:	60a2                	ld	ra,8(sp)
 136:	6402                	ld	s0,0(sp)
 138:	0141                	addi	sp,sp,16
 13a:	8082                	ret

000000000000013c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13c:	1141                	addi	sp,sp,-16
 13e:	e406                	sd	ra,8(sp)
 140:	e022                	sd	s0,0(sp)
 142:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb91                	beqz	a5,15c <strcmp+0x20>
 14a:	0005c703          	lbu	a4,0(a1)
 14e:	00f71763          	bne	a4,a5,15c <strcmp+0x20>
    p++, q++;
 152:	0505                	addi	a0,a0,1
 154:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbe5                	bnez	a5,14a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 15c:	0005c503          	lbu	a0,0(a1)
}
 160:	40a7853b          	subw	a0,a5,a0
 164:	60a2                	ld	ra,8(sp)
 166:	6402                	ld	s0,0(sp)
 168:	0141                	addi	sp,sp,16
 16a:	8082                	ret

000000000000016c <strlen>:

uint
strlen(const char *s)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e406                	sd	ra,8(sp)
 170:	e022                	sd	s0,0(sp)
 172:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf99                	beqz	a5,196 <strlen+0x2a>
 17a:	0505                	addi	a0,a0,1
 17c:	87aa                	mv	a5,a0
 17e:	86be                	mv	a3,a5
 180:	0785                	addi	a5,a5,1
 182:	fff7c703          	lbu	a4,-1(a5)
 186:	ff65                	bnez	a4,17e <strlen+0x12>
 188:	40a6853b          	subw	a0,a3,a0
 18c:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 18e:	60a2                	ld	ra,8(sp)
 190:	6402                	ld	s0,0(sp)
 192:	0141                	addi	sp,sp,16
 194:	8082                	ret
  for(n = 0; s[n]; n++)
 196:	4501                	li	a0,0
 198:	bfdd                	j	18e <strlen+0x22>

000000000000019a <memset>:

void*
memset(void *dst, int c, uint n)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e406                	sd	ra,8(sp)
 19e:	e022                	sd	s0,0(sp)
 1a0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a2:	ca19                	beqz	a2,1b8 <memset+0x1e>
 1a4:	87aa                	mv	a5,a0
 1a6:	1602                	slli	a2,a2,0x20
 1a8:	9201                	srli	a2,a2,0x20
 1aa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ae:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1b2:	0785                	addi	a5,a5,1
 1b4:	fee79de3          	bne	a5,a4,1ae <memset+0x14>
  }
  return dst;
}
 1b8:	60a2                	ld	ra,8(sp)
 1ba:	6402                	ld	s0,0(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret

00000000000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e406                	sd	ra,8(sp)
 1c4:	e022                	sd	s0,0(sp)
 1c6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	cf81                	beqz	a5,1e4 <strchr+0x24>
    if(*s == c)
 1ce:	00f58763          	beq	a1,a5,1dc <strchr+0x1c>
  for(; *s; s++)
 1d2:	0505                	addi	a0,a0,1
 1d4:	00054783          	lbu	a5,0(a0)
 1d8:	fbfd                	bnez	a5,1ce <strchr+0xe>
      return (char*)s;
  return 0;
 1da:	4501                	li	a0,0
}
 1dc:	60a2                	ld	ra,8(sp)
 1de:	6402                	ld	s0,0(sp)
 1e0:	0141                	addi	sp,sp,16
 1e2:	8082                	ret
  return 0;
 1e4:	4501                	li	a0,0
 1e6:	bfdd                	j	1dc <strchr+0x1c>

00000000000001e8 <gets>:

char*
gets(char *buf, int max)
{
 1e8:	7159                	addi	sp,sp,-112
 1ea:	f486                	sd	ra,104(sp)
 1ec:	f0a2                	sd	s0,96(sp)
 1ee:	eca6                	sd	s1,88(sp)
 1f0:	e8ca                	sd	s2,80(sp)
 1f2:	e4ce                	sd	s3,72(sp)
 1f4:	e0d2                	sd	s4,64(sp)
 1f6:	fc56                	sd	s5,56(sp)
 1f8:	f85a                	sd	s6,48(sp)
 1fa:	f45e                	sd	s7,40(sp)
 1fc:	f062                	sd	s8,32(sp)
 1fe:	ec66                	sd	s9,24(sp)
 200:	e86a                	sd	s10,16(sp)
 202:	1880                	addi	s0,sp,112
 204:	8caa                	mv	s9,a0
 206:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 208:	892a                	mv	s2,a0
 20a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 20c:	f9f40b13          	addi	s6,s0,-97
 210:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 212:	4ba9                	li	s7,10
 214:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 216:	8d26                	mv	s10,s1
 218:	0014899b          	addiw	s3,s1,1
 21c:	84ce                	mv	s1,s3
 21e:	0349d763          	bge	s3,s4,24c <gets+0x64>
    cc = read(0, &c, 1);
 222:	8656                	mv	a2,s5
 224:	85da                	mv	a1,s6
 226:	4501                	li	a0,0
 228:	00000097          	auipc	ra,0x0
 22c:	1c6080e7          	jalr	454(ra) # 3ee <read>
    if(cc < 1)
 230:	00a05e63          	blez	a0,24c <gets+0x64>
    buf[i++] = c;
 234:	f9f44783          	lbu	a5,-97(s0)
 238:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 23c:	01778763          	beq	a5,s7,24a <gets+0x62>
 240:	0905                	addi	s2,s2,1
 242:	fd879ae3          	bne	a5,s8,216 <gets+0x2e>
    buf[i++] = c;
 246:	8d4e                	mv	s10,s3
 248:	a011                	j	24c <gets+0x64>
 24a:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 24c:	9d66                	add	s10,s10,s9
 24e:	000d0023          	sb	zero,0(s10)
  return buf;
}
 252:	8566                	mv	a0,s9
 254:	70a6                	ld	ra,104(sp)
 256:	7406                	ld	s0,96(sp)
 258:	64e6                	ld	s1,88(sp)
 25a:	6946                	ld	s2,80(sp)
 25c:	69a6                	ld	s3,72(sp)
 25e:	6a06                	ld	s4,64(sp)
 260:	7ae2                	ld	s5,56(sp)
 262:	7b42                	ld	s6,48(sp)
 264:	7ba2                	ld	s7,40(sp)
 266:	7c02                	ld	s8,32(sp)
 268:	6ce2                	ld	s9,24(sp)
 26a:	6d42                	ld	s10,16(sp)
 26c:	6165                	addi	sp,sp,112
 26e:	8082                	ret

0000000000000270 <stat>:

int
stat(const char *n, struct stat *st)
{
 270:	1101                	addi	sp,sp,-32
 272:	ec06                	sd	ra,24(sp)
 274:	e822                	sd	s0,16(sp)
 276:	e04a                	sd	s2,0(sp)
 278:	1000                	addi	s0,sp,32
 27a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27c:	4581                	li	a1,0
 27e:	00000097          	auipc	ra,0x0
 282:	198080e7          	jalr	408(ra) # 416 <open>
  if(fd < 0)
 286:	02054663          	bltz	a0,2b2 <stat+0x42>
 28a:	e426                	sd	s1,8(sp)
 28c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 28e:	85ca                	mv	a1,s2
 290:	00000097          	auipc	ra,0x0
 294:	19e080e7          	jalr	414(ra) # 42e <fstat>
 298:	892a                	mv	s2,a0
  close(fd);
 29a:	8526                	mv	a0,s1
 29c:	00000097          	auipc	ra,0x0
 2a0:	162080e7          	jalr	354(ra) # 3fe <close>
  return r;
 2a4:	64a2                	ld	s1,8(sp)
}
 2a6:	854a                	mv	a0,s2
 2a8:	60e2                	ld	ra,24(sp)
 2aa:	6442                	ld	s0,16(sp)
 2ac:	6902                	ld	s2,0(sp)
 2ae:	6105                	addi	sp,sp,32
 2b0:	8082                	ret
    return -1;
 2b2:	597d                	li	s2,-1
 2b4:	bfcd                	j	2a6 <stat+0x36>

00000000000002b6 <atoi>:

int
atoi(const char *s)
{
 2b6:	1141                	addi	sp,sp,-16
 2b8:	e406                	sd	ra,8(sp)
 2ba:	e022                	sd	s0,0(sp)
 2bc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2be:	00054683          	lbu	a3,0(a0)
 2c2:	fd06879b          	addiw	a5,a3,-48
 2c6:	0ff7f793          	zext.b	a5,a5
 2ca:	4625                	li	a2,9
 2cc:	02f66963          	bltu	a2,a5,2fe <atoi+0x48>
 2d0:	872a                	mv	a4,a0
  n = 0;
 2d2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d4:	0705                	addi	a4,a4,1
 2d6:	0025179b          	slliw	a5,a0,0x2
 2da:	9fa9                	addw	a5,a5,a0
 2dc:	0017979b          	slliw	a5,a5,0x1
 2e0:	9fb5                	addw	a5,a5,a3
 2e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e6:	00074683          	lbu	a3,0(a4)
 2ea:	fd06879b          	addiw	a5,a3,-48
 2ee:	0ff7f793          	zext.b	a5,a5
 2f2:	fef671e3          	bgeu	a2,a5,2d4 <atoi+0x1e>
  return n;
}
 2f6:	60a2                	ld	ra,8(sp)
 2f8:	6402                	ld	s0,0(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret
  n = 0;
 2fe:	4501                	li	a0,0
 300:	bfdd                	j	2f6 <atoi+0x40>

0000000000000302 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 30a:	02b57563          	bgeu	a0,a1,334 <memmove+0x32>
    while(n-- > 0)
 30e:	00c05f63          	blez	a2,32c <memmove+0x2a>
 312:	1602                	slli	a2,a2,0x20
 314:	9201                	srli	a2,a2,0x20
 316:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 31a:	872a                	mv	a4,a0
      *dst++ = *src++;
 31c:	0585                	addi	a1,a1,1
 31e:	0705                	addi	a4,a4,1
 320:	fff5c683          	lbu	a3,-1(a1)
 324:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 328:	fee79ae3          	bne	a5,a4,31c <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
    dst += n;
 334:	00c50733          	add	a4,a0,a2
    src += n;
 338:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 33a:	fec059e3          	blez	a2,32c <memmove+0x2a>
 33e:	fff6079b          	addiw	a5,a2,-1
 342:	1782                	slli	a5,a5,0x20
 344:	9381                	srli	a5,a5,0x20
 346:	fff7c793          	not	a5,a5
 34a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 34c:	15fd                	addi	a1,a1,-1
 34e:	177d                	addi	a4,a4,-1
 350:	0005c683          	lbu	a3,0(a1)
 354:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 358:	fef71ae3          	bne	a4,a5,34c <memmove+0x4a>
 35c:	bfc1                	j	32c <memmove+0x2a>

000000000000035e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 35e:	1141                	addi	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 366:	ca0d                	beqz	a2,398 <memcmp+0x3a>
 368:	fff6069b          	addiw	a3,a2,-1
 36c:	1682                	slli	a3,a3,0x20
 36e:	9281                	srli	a3,a3,0x20
 370:	0685                	addi	a3,a3,1
 372:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 374:	00054783          	lbu	a5,0(a0)
 378:	0005c703          	lbu	a4,0(a1)
 37c:	00e79863          	bne	a5,a4,38c <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 380:	0505                	addi	a0,a0,1
    p2++;
 382:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 384:	fed518e3          	bne	a0,a3,374 <memcmp+0x16>
  }
  return 0;
 388:	4501                	li	a0,0
 38a:	a019                	j	390 <memcmp+0x32>
      return *p1 - *p2;
 38c:	40e7853b          	subw	a0,a5,a4
}
 390:	60a2                	ld	ra,8(sp)
 392:	6402                	ld	s0,0(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret
  return 0;
 398:	4501                	li	a0,0
 39a:	bfdd                	j	390 <memcmp+0x32>

000000000000039c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 39c:	1141                	addi	sp,sp,-16
 39e:	e406                	sd	ra,8(sp)
 3a0:	e022                	sd	s0,0(sp)
 3a2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3a4:	00000097          	auipc	ra,0x0
 3a8:	f5e080e7          	jalr	-162(ra) # 302 <memmove>
}
 3ac:	60a2                	ld	ra,8(sp)
 3ae:	6402                	ld	s0,0(sp)
 3b0:	0141                	addi	sp,sp,16
 3b2:	8082                	ret

00000000000003b4 <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 3b4:	1141                	addi	sp,sp,-16
 3b6:	e406                	sd	ra,8(sp)
 3b8:	e022                	sd	s0,0(sp)
 3ba:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 3bc:	040007b7          	lui	a5,0x4000
 3c0:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffee54>
 3c2:	07b2                	slli	a5,a5,0xc
}
 3c4:	4388                	lw	a0,0(a5)
 3c6:	60a2                	ld	ra,8(sp)
 3c8:	6402                	ld	s0,0(sp)
 3ca:	0141                	addi	sp,sp,16
 3cc:	8082                	ret

00000000000003ce <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ce:	4885                	li	a7,1
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3d6:	4889                	li	a7,2
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <wait>:
.global wait
wait:
 li a7, SYS_wait
 3de:	488d                	li	a7,3
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3e6:	4891                	li	a7,4
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <read>:
.global read
read:
 li a7, SYS_read
 3ee:	4895                	li	a7,5
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <write>:
.global write
write:
 li a7, SYS_write
 3f6:	48c1                	li	a7,16
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <close>:
.global close
close:
 li a7, SYS_close
 3fe:	48d5                	li	a7,21
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <kill>:
.global kill
kill:
 li a7, SYS_kill
 406:	4899                	li	a7,6
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <exec>:
.global exec
exec:
 li a7, SYS_exec
 40e:	489d                	li	a7,7
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <open>:
.global open
open:
 li a7, SYS_open
 416:	48bd                	li	a7,15
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 41e:	48c5                	li	a7,17
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 426:	48c9                	li	a7,18
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 42e:	48a1                	li	a7,8
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <link>:
.global link
link:
 li a7, SYS_link
 436:	48cd                	li	a7,19
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 43e:	48d1                	li	a7,20
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 446:	48a5                	li	a7,9
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <dup>:
.global dup
dup:
 li a7, SYS_dup
 44e:	48a9                	li	a7,10
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 456:	48ad                	li	a7,11
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 45e:	48b1                	li	a7,12
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 466:	48b5                	li	a7,13
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 46e:	48b9                	li	a7,14
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <connect>:
.global connect
connect:
 li a7, SYS_connect
 476:	48f5                	li	a7,29
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 47e:	48f9                	li	a7,30
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 486:	1101                	addi	sp,sp,-32
 488:	ec06                	sd	ra,24(sp)
 48a:	e822                	sd	s0,16(sp)
 48c:	1000                	addi	s0,sp,32
 48e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 492:	4605                	li	a2,1
 494:	fef40593          	addi	a1,s0,-17
 498:	00000097          	auipc	ra,0x0
 49c:	f5e080e7          	jalr	-162(ra) # 3f6 <write>
}
 4a0:	60e2                	ld	ra,24(sp)
 4a2:	6442                	ld	s0,16(sp)
 4a4:	6105                	addi	sp,sp,32
 4a6:	8082                	ret

00000000000004a8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a8:	7139                	addi	sp,sp,-64
 4aa:	fc06                	sd	ra,56(sp)
 4ac:	f822                	sd	s0,48(sp)
 4ae:	f426                	sd	s1,40(sp)
 4b0:	f04a                	sd	s2,32(sp)
 4b2:	ec4e                	sd	s3,24(sp)
 4b4:	0080                	addi	s0,sp,64
 4b6:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4b8:	c299                	beqz	a3,4be <printint+0x16>
 4ba:	0805c063          	bltz	a1,53a <printint+0x92>
  neg = 0;
 4be:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4c0:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4c4:	869a                	mv	a3,t1
  i = 0;
 4c6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4c8:	00000817          	auipc	a6,0x0
 4cc:	4d080813          	addi	a6,a6,1232 # 998 <digits>
 4d0:	88be                	mv	a7,a5
 4d2:	0017851b          	addiw	a0,a5,1
 4d6:	87aa                	mv	a5,a0
 4d8:	02c5f73b          	remuw	a4,a1,a2
 4dc:	1702                	slli	a4,a4,0x20
 4de:	9301                	srli	a4,a4,0x20
 4e0:	9742                	add	a4,a4,a6
 4e2:	00074703          	lbu	a4,0(a4)
 4e6:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4ea:	872e                	mv	a4,a1
 4ec:	02c5d5bb          	divuw	a1,a1,a2
 4f0:	0685                	addi	a3,a3,1
 4f2:	fcc77fe3          	bgeu	a4,a2,4d0 <printint+0x28>
  if(neg)
 4f6:	000e0c63          	beqz	t3,50e <printint+0x66>
    buf[i++] = '-';
 4fa:	fd050793          	addi	a5,a0,-48
 4fe:	00878533          	add	a0,a5,s0
 502:	02d00793          	li	a5,45
 506:	fef50823          	sb	a5,-16(a0)
 50a:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 50e:	fff7899b          	addiw	s3,a5,-1
 512:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 516:	fff4c583          	lbu	a1,-1(s1)
 51a:	854a                	mv	a0,s2
 51c:	00000097          	auipc	ra,0x0
 520:	f6a080e7          	jalr	-150(ra) # 486 <putc>
  while(--i >= 0)
 524:	39fd                	addiw	s3,s3,-1
 526:	14fd                	addi	s1,s1,-1
 528:	fe09d7e3          	bgez	s3,516 <printint+0x6e>
}
 52c:	70e2                	ld	ra,56(sp)
 52e:	7442                	ld	s0,48(sp)
 530:	74a2                	ld	s1,40(sp)
 532:	7902                	ld	s2,32(sp)
 534:	69e2                	ld	s3,24(sp)
 536:	6121                	addi	sp,sp,64
 538:	8082                	ret
    x = -xx;
 53a:	40b005bb          	negw	a1,a1
    neg = 1;
 53e:	4e05                	li	t3,1
    x = -xx;
 540:	b741                	j	4c0 <printint+0x18>

0000000000000542 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 542:	715d                	addi	sp,sp,-80
 544:	e486                	sd	ra,72(sp)
 546:	e0a2                	sd	s0,64(sp)
 548:	f84a                	sd	s2,48(sp)
 54a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 54c:	0005c903          	lbu	s2,0(a1)
 550:	1a090a63          	beqz	s2,704 <vprintf+0x1c2>
 554:	fc26                	sd	s1,56(sp)
 556:	f44e                	sd	s3,40(sp)
 558:	f052                	sd	s4,32(sp)
 55a:	ec56                	sd	s5,24(sp)
 55c:	e85a                	sd	s6,16(sp)
 55e:	e45e                	sd	s7,8(sp)
 560:	8aaa                	mv	s5,a0
 562:	8bb2                	mv	s7,a2
 564:	00158493          	addi	s1,a1,1
  state = 0;
 568:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 56a:	02500a13          	li	s4,37
 56e:	4b55                	li	s6,21
 570:	a839                	j	58e <vprintf+0x4c>
        putc(fd, c);
 572:	85ca                	mv	a1,s2
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	f10080e7          	jalr	-240(ra) # 486 <putc>
 57e:	a019                	j	584 <vprintf+0x42>
    } else if(state == '%'){
 580:	01498d63          	beq	s3,s4,59a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 584:	0485                	addi	s1,s1,1
 586:	fff4c903          	lbu	s2,-1(s1)
 58a:	16090763          	beqz	s2,6f8 <vprintf+0x1b6>
    if(state == 0){
 58e:	fe0999e3          	bnez	s3,580 <vprintf+0x3e>
      if(c == '%'){
 592:	ff4910e3          	bne	s2,s4,572 <vprintf+0x30>
        state = '%';
 596:	89d2                	mv	s3,s4
 598:	b7f5                	j	584 <vprintf+0x42>
      if(c == 'd'){
 59a:	13490463          	beq	s2,s4,6c2 <vprintf+0x180>
 59e:	f9d9079b          	addiw	a5,s2,-99
 5a2:	0ff7f793          	zext.b	a5,a5
 5a6:	12fb6763          	bltu	s6,a5,6d4 <vprintf+0x192>
 5aa:	f9d9079b          	addiw	a5,s2,-99
 5ae:	0ff7f713          	zext.b	a4,a5
 5b2:	12eb6163          	bltu	s6,a4,6d4 <vprintf+0x192>
 5b6:	00271793          	slli	a5,a4,0x2
 5ba:	00000717          	auipc	a4,0x0
 5be:	38670713          	addi	a4,a4,902 # 940 <malloc+0x148>
 5c2:	97ba                	add	a5,a5,a4
 5c4:	439c                	lw	a5,0(a5)
 5c6:	97ba                	add	a5,a5,a4
 5c8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5ca:	008b8913          	addi	s2,s7,8
 5ce:	4685                	li	a3,1
 5d0:	4629                	li	a2,10
 5d2:	000ba583          	lw	a1,0(s7)
 5d6:	8556                	mv	a0,s5
 5d8:	00000097          	auipc	ra,0x0
 5dc:	ed0080e7          	jalr	-304(ra) # 4a8 <printint>
 5e0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e2:	4981                	li	s3,0
 5e4:	b745                	j	584 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e6:	008b8913          	addi	s2,s7,8
 5ea:	4681                	li	a3,0
 5ec:	4629                	li	a2,10
 5ee:	000ba583          	lw	a1,0(s7)
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	eb4080e7          	jalr	-332(ra) # 4a8 <printint>
 5fc:	8bca                	mv	s7,s2
      state = 0;
 5fe:	4981                	li	s3,0
 600:	b751                	j	584 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 602:	008b8913          	addi	s2,s7,8
 606:	4681                	li	a3,0
 608:	4641                	li	a2,16
 60a:	000ba583          	lw	a1,0(s7)
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	e98080e7          	jalr	-360(ra) # 4a8 <printint>
 618:	8bca                	mv	s7,s2
      state = 0;
 61a:	4981                	li	s3,0
 61c:	b7a5                	j	584 <vprintf+0x42>
 61e:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 620:	008b8c13          	addi	s8,s7,8
 624:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 628:	03000593          	li	a1,48
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	e58080e7          	jalr	-424(ra) # 486 <putc>
  putc(fd, 'x');
 636:	07800593          	li	a1,120
 63a:	8556                	mv	a0,s5
 63c:	00000097          	auipc	ra,0x0
 640:	e4a080e7          	jalr	-438(ra) # 486 <putc>
 644:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 646:	00000b97          	auipc	s7,0x0
 64a:	352b8b93          	addi	s7,s7,850 # 998 <digits>
 64e:	03c9d793          	srli	a5,s3,0x3c
 652:	97de                	add	a5,a5,s7
 654:	0007c583          	lbu	a1,0(a5)
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	e2c080e7          	jalr	-468(ra) # 486 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 662:	0992                	slli	s3,s3,0x4
 664:	397d                	addiw	s2,s2,-1
 666:	fe0914e3          	bnez	s2,64e <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 66a:	8be2                	mv	s7,s8
      state = 0;
 66c:	4981                	li	s3,0
 66e:	6c02                	ld	s8,0(sp)
 670:	bf11                	j	584 <vprintf+0x42>
        s = va_arg(ap, char*);
 672:	008b8993          	addi	s3,s7,8
 676:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 67a:	02090163          	beqz	s2,69c <vprintf+0x15a>
        while(*s != 0){
 67e:	00094583          	lbu	a1,0(s2)
 682:	c9a5                	beqz	a1,6f2 <vprintf+0x1b0>
          putc(fd, *s);
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e00080e7          	jalr	-512(ra) # 486 <putc>
          s++;
 68e:	0905                	addi	s2,s2,1
        while(*s != 0){
 690:	00094583          	lbu	a1,0(s2)
 694:	f9e5                	bnez	a1,684 <vprintf+0x142>
        s = va_arg(ap, char*);
 696:	8bce                	mv	s7,s3
      state = 0;
 698:	4981                	li	s3,0
 69a:	b5ed                	j	584 <vprintf+0x42>
          s = "(null)";
 69c:	00000917          	auipc	s2,0x0
 6a0:	29c90913          	addi	s2,s2,668 # 938 <malloc+0x140>
        while(*s != 0){
 6a4:	02800593          	li	a1,40
 6a8:	bff1                	j	684 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6aa:	008b8913          	addi	s2,s7,8
 6ae:	000bc583          	lbu	a1,0(s7)
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	dd2080e7          	jalr	-558(ra) # 486 <putc>
 6bc:	8bca                	mv	s7,s2
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	b5d1                	j	584 <vprintf+0x42>
        putc(fd, c);
 6c2:	02500593          	li	a1,37
 6c6:	8556                	mv	a0,s5
 6c8:	00000097          	auipc	ra,0x0
 6cc:	dbe080e7          	jalr	-578(ra) # 486 <putc>
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	bd4d                	j	584 <vprintf+0x42>
        putc(fd, '%');
 6d4:	02500593          	li	a1,37
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	dac080e7          	jalr	-596(ra) # 486 <putc>
        putc(fd, c);
 6e2:	85ca                	mv	a1,s2
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	da0080e7          	jalr	-608(ra) # 486 <putc>
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	bd51                	j	584 <vprintf+0x42>
        s = va_arg(ap, char*);
 6f2:	8bce                	mv	s7,s3
      state = 0;
 6f4:	4981                	li	s3,0
 6f6:	b579                	j	584 <vprintf+0x42>
 6f8:	74e2                	ld	s1,56(sp)
 6fa:	79a2                	ld	s3,40(sp)
 6fc:	7a02                	ld	s4,32(sp)
 6fe:	6ae2                	ld	s5,24(sp)
 700:	6b42                	ld	s6,16(sp)
 702:	6ba2                	ld	s7,8(sp)
    }
  }
}
 704:	60a6                	ld	ra,72(sp)
 706:	6406                	ld	s0,64(sp)
 708:	7942                	ld	s2,48(sp)
 70a:	6161                	addi	sp,sp,80
 70c:	8082                	ret

000000000000070e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 70e:	715d                	addi	sp,sp,-80
 710:	ec06                	sd	ra,24(sp)
 712:	e822                	sd	s0,16(sp)
 714:	1000                	addi	s0,sp,32
 716:	e010                	sd	a2,0(s0)
 718:	e414                	sd	a3,8(s0)
 71a:	e818                	sd	a4,16(s0)
 71c:	ec1c                	sd	a5,24(s0)
 71e:	03043023          	sd	a6,32(s0)
 722:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 726:	8622                	mv	a2,s0
 728:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 72c:	00000097          	auipc	ra,0x0
 730:	e16080e7          	jalr	-490(ra) # 542 <vprintf>
}
 734:	60e2                	ld	ra,24(sp)
 736:	6442                	ld	s0,16(sp)
 738:	6161                	addi	sp,sp,80
 73a:	8082                	ret

000000000000073c <printf>:

void
printf(const char *fmt, ...)
{
 73c:	711d                	addi	sp,sp,-96
 73e:	ec06                	sd	ra,24(sp)
 740:	e822                	sd	s0,16(sp)
 742:	1000                	addi	s0,sp,32
 744:	e40c                	sd	a1,8(s0)
 746:	e810                	sd	a2,16(s0)
 748:	ec14                	sd	a3,24(s0)
 74a:	f018                	sd	a4,32(s0)
 74c:	f41c                	sd	a5,40(s0)
 74e:	03043823          	sd	a6,48(s0)
 752:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 756:	00840613          	addi	a2,s0,8
 75a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 75e:	85aa                	mv	a1,a0
 760:	4505                	li	a0,1
 762:	00000097          	auipc	ra,0x0
 766:	de0080e7          	jalr	-544(ra) # 542 <vprintf>
}
 76a:	60e2                	ld	ra,24(sp)
 76c:	6442                	ld	s0,16(sp)
 76e:	6125                	addi	sp,sp,96
 770:	8082                	ret

0000000000000772 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 772:	1141                	addi	sp,sp,-16
 774:	e406                	sd	ra,8(sp)
 776:	e022                	sd	s0,0(sp)
 778:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 77a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77e:	00000797          	auipc	a5,0x0
 782:	2327b783          	ld	a5,562(a5) # 9b0 <freep>
 786:	a02d                	j	7b0 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 788:	4618                	lw	a4,8(a2)
 78a:	9f2d                	addw	a4,a4,a1
 78c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 790:	6398                	ld	a4,0(a5)
 792:	6310                	ld	a2,0(a4)
 794:	a83d                	j	7d2 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 796:	ff852703          	lw	a4,-8(a0)
 79a:	9f31                	addw	a4,a4,a2
 79c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 79e:	ff053683          	ld	a3,-16(a0)
 7a2:	a091                	j	7e6 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	6398                	ld	a4,0(a5)
 7a6:	00e7e463          	bltu	a5,a4,7ae <free+0x3c>
 7aa:	00e6ea63          	bltu	a3,a4,7be <free+0x4c>
{
 7ae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b0:	fed7fae3          	bgeu	a5,a3,7a4 <free+0x32>
 7b4:	6398                	ld	a4,0(a5)
 7b6:	00e6e463          	bltu	a3,a4,7be <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ba:	fee7eae3          	bltu	a5,a4,7ae <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7be:	ff852583          	lw	a1,-8(a0)
 7c2:	6390                	ld	a2,0(a5)
 7c4:	02059813          	slli	a6,a1,0x20
 7c8:	01c85713          	srli	a4,a6,0x1c
 7cc:	9736                	add	a4,a4,a3
 7ce:	fae60de3          	beq	a2,a4,788 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7d2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7d6:	4790                	lw	a2,8(a5)
 7d8:	02061593          	slli	a1,a2,0x20
 7dc:	01c5d713          	srli	a4,a1,0x1c
 7e0:	973e                	add	a4,a4,a5
 7e2:	fae68ae3          	beq	a3,a4,796 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7e6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7e8:	00000717          	auipc	a4,0x0
 7ec:	1cf73423          	sd	a5,456(a4) # 9b0 <freep>
}
 7f0:	60a2                	ld	ra,8(sp)
 7f2:	6402                	ld	s0,0(sp)
 7f4:	0141                	addi	sp,sp,16
 7f6:	8082                	ret

00000000000007f8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f8:	7139                	addi	sp,sp,-64
 7fa:	fc06                	sd	ra,56(sp)
 7fc:	f822                	sd	s0,48(sp)
 7fe:	f04a                	sd	s2,32(sp)
 800:	ec4e                	sd	s3,24(sp)
 802:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 804:	02051993          	slli	s3,a0,0x20
 808:	0209d993          	srli	s3,s3,0x20
 80c:	09bd                	addi	s3,s3,15
 80e:	0049d993          	srli	s3,s3,0x4
 812:	2985                	addiw	s3,s3,1
 814:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 816:	00000517          	auipc	a0,0x0
 81a:	19a53503          	ld	a0,410(a0) # 9b0 <freep>
 81e:	c905                	beqz	a0,84e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 820:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 822:	4798                	lw	a4,8(a5)
 824:	09377a63          	bgeu	a4,s3,8b8 <malloc+0xc0>
 828:	f426                	sd	s1,40(sp)
 82a:	e852                	sd	s4,16(sp)
 82c:	e456                	sd	s5,8(sp)
 82e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 830:	8a4e                	mv	s4,s3
 832:	6705                	lui	a4,0x1
 834:	00e9f363          	bgeu	s3,a4,83a <malloc+0x42>
 838:	6a05                	lui	s4,0x1
 83a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 83e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 842:	00000497          	auipc	s1,0x0
 846:	16e48493          	addi	s1,s1,366 # 9b0 <freep>
  if(p == (char*)-1)
 84a:	5afd                	li	s5,-1
 84c:	a089                	j	88e <malloc+0x96>
 84e:	f426                	sd	s1,40(sp)
 850:	e852                	sd	s4,16(sp)
 852:	e456                	sd	s5,8(sp)
 854:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 856:	00000797          	auipc	a5,0x0
 85a:	16278793          	addi	a5,a5,354 # 9b8 <base>
 85e:	00000717          	auipc	a4,0x0
 862:	14f73923          	sd	a5,338(a4) # 9b0 <freep>
 866:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 868:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 86c:	b7d1                	j	830 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 86e:	6398                	ld	a4,0(a5)
 870:	e118                	sd	a4,0(a0)
 872:	a8b9                	j	8d0 <malloc+0xd8>
  hp->s.size = nu;
 874:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 878:	0541                	addi	a0,a0,16
 87a:	00000097          	auipc	ra,0x0
 87e:	ef8080e7          	jalr	-264(ra) # 772 <free>
  return freep;
 882:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 884:	c135                	beqz	a0,8e8 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 886:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 888:	4798                	lw	a4,8(a5)
 88a:	03277363          	bgeu	a4,s2,8b0 <malloc+0xb8>
    if(p == freep)
 88e:	6098                	ld	a4,0(s1)
 890:	853e                	mv	a0,a5
 892:	fef71ae3          	bne	a4,a5,886 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 896:	8552                	mv	a0,s4
 898:	00000097          	auipc	ra,0x0
 89c:	bc6080e7          	jalr	-1082(ra) # 45e <sbrk>
  if(p == (char*)-1)
 8a0:	fd551ae3          	bne	a0,s5,874 <malloc+0x7c>
        return 0;
 8a4:	4501                	li	a0,0
 8a6:	74a2                	ld	s1,40(sp)
 8a8:	6a42                	ld	s4,16(sp)
 8aa:	6aa2                	ld	s5,8(sp)
 8ac:	6b02                	ld	s6,0(sp)
 8ae:	a03d                	j	8dc <malloc+0xe4>
 8b0:	74a2                	ld	s1,40(sp)
 8b2:	6a42                	ld	s4,16(sp)
 8b4:	6aa2                	ld	s5,8(sp)
 8b6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8b8:	fae90be3          	beq	s2,a4,86e <malloc+0x76>
        p->s.size -= nunits;
 8bc:	4137073b          	subw	a4,a4,s3
 8c0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c2:	02071693          	slli	a3,a4,0x20
 8c6:	01c6d713          	srli	a4,a3,0x1c
 8ca:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8cc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d0:	00000717          	auipc	a4,0x0
 8d4:	0ea73023          	sd	a0,224(a4) # 9b0 <freep>
      return (void*)(p + 1);
 8d8:	01078513          	addi	a0,a5,16
  }
}
 8dc:	70e2                	ld	ra,56(sp)
 8de:	7442                	ld	s0,48(sp)
 8e0:	7902                	ld	s2,32(sp)
 8e2:	69e2                	ld	s3,24(sp)
 8e4:	6121                	addi	sp,sp,64
 8e6:	8082                	ret
 8e8:	74a2                	ld	s1,40(sp)
 8ea:	6a42                	ld	s4,16(sp)
 8ec:	6aa2                	ld	s5,8(sp)
 8ee:	6b02                	ld	s6,0(sp)
 8f0:	b7f5                	j	8dc <malloc+0xe4>
