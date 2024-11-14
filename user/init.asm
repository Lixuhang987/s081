
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	8c250513          	addi	a0,a0,-1854 # 8d0 <malloc+0xfc>
  16:	00000097          	auipc	ra,0x0
  1a:	3dc080e7          	jalr	988(ra) # 3f2 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	406080e7          	jalr	1030(ra) # 42a <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	3fc080e7          	jalr	1020(ra) # 42a <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	8a290913          	addi	s2,s2,-1886 # 8d8 <malloc+0x104>
  3e:	854a                	mv	a0,s2
  40:	00000097          	auipc	ra,0x0
  44:	6d8080e7          	jalr	1752(ra) # 718 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	362080e7          	jalr	866(ra) # 3aa <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	360080e7          	jalr	864(ra) # 3ba <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	8be50513          	addi	a0,a0,-1858 # 928 <malloc+0x154>
  72:	00000097          	auipc	ra,0x0
  76:	6a6080e7          	jalr	1702(ra) # 718 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	336080e7          	jalr	822(ra) # 3b2 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	84850513          	addi	a0,a0,-1976 # 8d0 <malloc+0xfc>
  90:	00000097          	auipc	ra,0x0
  94:	36a080e7          	jalr	874(ra) # 3fa <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	83650513          	addi	a0,a0,-1994 # 8d0 <malloc+0xfc>
  a2:	00000097          	auipc	ra,0x0
  a6:	350080e7          	jalr	848(ra) # 3f2 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	84450513          	addi	a0,a0,-1980 # 8f0 <malloc+0x11c>
  b4:	00000097          	auipc	ra,0x0
  b8:	664080e7          	jalr	1636(ra) # 718 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	2f4080e7          	jalr	756(ra) # 3b2 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	8fa58593          	addi	a1,a1,-1798 # 9c0 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	83a50513          	addi	a0,a0,-1990 # 908 <malloc+0x134>
  d6:	00000097          	auipc	ra,0x0
  da:	314080e7          	jalr	788(ra) # 3ea <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	83250513          	addi	a0,a0,-1998 # 910 <malloc+0x13c>
  e6:	00000097          	auipc	ra,0x0
  ea:	632080e7          	jalr	1586(ra) # 718 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	2c2080e7          	jalr	706(ra) # 3b2 <exit>

00000000000000f8 <strcpy>:



char*
strcpy(char *s, const char *t)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 100:	87aa                	mv	a5,a0
 102:	0585                	addi	a1,a1,1
 104:	0785                	addi	a5,a5,1
 106:	fff5c703          	lbu	a4,-1(a1)
 10a:	fee78fa3          	sb	a4,-1(a5)
 10e:	fb75                	bnez	a4,102 <strcpy+0xa>
    ;
  return os;
}
 110:	60a2                	ld	ra,8(sp)
 112:	6402                	ld	s0,0(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret

0000000000000118 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 118:	1141                	addi	sp,sp,-16
 11a:	e406                	sd	ra,8(sp)
 11c:	e022                	sd	s0,0(sp)
 11e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 120:	00054783          	lbu	a5,0(a0)
 124:	cb91                	beqz	a5,138 <strcmp+0x20>
 126:	0005c703          	lbu	a4,0(a1)
 12a:	00f71763          	bne	a4,a5,138 <strcmp+0x20>
    p++, q++;
 12e:	0505                	addi	a0,a0,1
 130:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 132:	00054783          	lbu	a5,0(a0)
 136:	fbe5                	bnez	a5,126 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 138:	0005c503          	lbu	a0,0(a1)
}
 13c:	40a7853b          	subw	a0,a5,a0
 140:	60a2                	ld	ra,8(sp)
 142:	6402                	ld	s0,0(sp)
 144:	0141                	addi	sp,sp,16
 146:	8082                	ret

0000000000000148 <strlen>:

uint
strlen(const char *s)
{
 148:	1141                	addi	sp,sp,-16
 14a:	e406                	sd	ra,8(sp)
 14c:	e022                	sd	s0,0(sp)
 14e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 150:	00054783          	lbu	a5,0(a0)
 154:	cf99                	beqz	a5,172 <strlen+0x2a>
 156:	0505                	addi	a0,a0,1
 158:	87aa                	mv	a5,a0
 15a:	86be                	mv	a3,a5
 15c:	0785                	addi	a5,a5,1
 15e:	fff7c703          	lbu	a4,-1(a5)
 162:	ff65                	bnez	a4,15a <strlen+0x12>
 164:	40a6853b          	subw	a0,a3,a0
 168:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 16a:	60a2                	ld	ra,8(sp)
 16c:	6402                	ld	s0,0(sp)
 16e:	0141                	addi	sp,sp,16
 170:	8082                	ret
  for(n = 0; s[n]; n++)
 172:	4501                	li	a0,0
 174:	bfdd                	j	16a <strlen+0x22>

0000000000000176 <memset>:

void*
memset(void *dst, int c, uint n)
{
 176:	1141                	addi	sp,sp,-16
 178:	e406                	sd	ra,8(sp)
 17a:	e022                	sd	s0,0(sp)
 17c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 17e:	ca19                	beqz	a2,194 <memset+0x1e>
 180:	87aa                	mv	a5,a0
 182:	1602                	slli	a2,a2,0x20
 184:	9201                	srli	a2,a2,0x20
 186:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 18a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 18e:	0785                	addi	a5,a5,1
 190:	fee79de3          	bne	a5,a4,18a <memset+0x14>
  }
  return dst;
}
 194:	60a2                	ld	ra,8(sp)
 196:	6402                	ld	s0,0(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret

000000000000019c <strchr>:

char*
strchr(const char *s, char c)
{
 19c:	1141                	addi	sp,sp,-16
 19e:	e406                	sd	ra,8(sp)
 1a0:	e022                	sd	s0,0(sp)
 1a2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1a4:	00054783          	lbu	a5,0(a0)
 1a8:	cf81                	beqz	a5,1c0 <strchr+0x24>
    if(*s == c)
 1aa:	00f58763          	beq	a1,a5,1b8 <strchr+0x1c>
  for(; *s; s++)
 1ae:	0505                	addi	a0,a0,1
 1b0:	00054783          	lbu	a5,0(a0)
 1b4:	fbfd                	bnez	a5,1aa <strchr+0xe>
      return (char*)s;
  return 0;
 1b6:	4501                	li	a0,0
}
 1b8:	60a2                	ld	ra,8(sp)
 1ba:	6402                	ld	s0,0(sp)
 1bc:	0141                	addi	sp,sp,16
 1be:	8082                	ret
  return 0;
 1c0:	4501                	li	a0,0
 1c2:	bfdd                	j	1b8 <strchr+0x1c>

00000000000001c4 <gets>:

char*
gets(char *buf, int max)
{
 1c4:	7159                	addi	sp,sp,-112
 1c6:	f486                	sd	ra,104(sp)
 1c8:	f0a2                	sd	s0,96(sp)
 1ca:	eca6                	sd	s1,88(sp)
 1cc:	e8ca                	sd	s2,80(sp)
 1ce:	e4ce                	sd	s3,72(sp)
 1d0:	e0d2                	sd	s4,64(sp)
 1d2:	fc56                	sd	s5,56(sp)
 1d4:	f85a                	sd	s6,48(sp)
 1d6:	f45e                	sd	s7,40(sp)
 1d8:	f062                	sd	s8,32(sp)
 1da:	ec66                	sd	s9,24(sp)
 1dc:	e86a                	sd	s10,16(sp)
 1de:	1880                	addi	s0,sp,112
 1e0:	8caa                	mv	s9,a0
 1e2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e4:	892a                	mv	s2,a0
 1e6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1e8:	f9f40b13          	addi	s6,s0,-97
 1ec:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ee:	4ba9                	li	s7,10
 1f0:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1f2:	8d26                	mv	s10,s1
 1f4:	0014899b          	addiw	s3,s1,1
 1f8:	84ce                	mv	s1,s3
 1fa:	0349d763          	bge	s3,s4,228 <gets+0x64>
    cc = read(0, &c, 1);
 1fe:	8656                	mv	a2,s5
 200:	85da                	mv	a1,s6
 202:	4501                	li	a0,0
 204:	00000097          	auipc	ra,0x0
 208:	1c6080e7          	jalr	454(ra) # 3ca <read>
    if(cc < 1)
 20c:	00a05e63          	blez	a0,228 <gets+0x64>
    buf[i++] = c;
 210:	f9f44783          	lbu	a5,-97(s0)
 214:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 218:	01778763          	beq	a5,s7,226 <gets+0x62>
 21c:	0905                	addi	s2,s2,1
 21e:	fd879ae3          	bne	a5,s8,1f2 <gets+0x2e>
    buf[i++] = c;
 222:	8d4e                	mv	s10,s3
 224:	a011                	j	228 <gets+0x64>
 226:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 228:	9d66                	add	s10,s10,s9
 22a:	000d0023          	sb	zero,0(s10)
  return buf;
}
 22e:	8566                	mv	a0,s9
 230:	70a6                	ld	ra,104(sp)
 232:	7406                	ld	s0,96(sp)
 234:	64e6                	ld	s1,88(sp)
 236:	6946                	ld	s2,80(sp)
 238:	69a6                	ld	s3,72(sp)
 23a:	6a06                	ld	s4,64(sp)
 23c:	7ae2                	ld	s5,56(sp)
 23e:	7b42                	ld	s6,48(sp)
 240:	7ba2                	ld	s7,40(sp)
 242:	7c02                	ld	s8,32(sp)
 244:	6ce2                	ld	s9,24(sp)
 246:	6d42                	ld	s10,16(sp)
 248:	6165                	addi	sp,sp,112
 24a:	8082                	ret

000000000000024c <stat>:

int
stat(const char *n, struct stat *st)
{
 24c:	1101                	addi	sp,sp,-32
 24e:	ec06                	sd	ra,24(sp)
 250:	e822                	sd	s0,16(sp)
 252:	e04a                	sd	s2,0(sp)
 254:	1000                	addi	s0,sp,32
 256:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 258:	4581                	li	a1,0
 25a:	00000097          	auipc	ra,0x0
 25e:	198080e7          	jalr	408(ra) # 3f2 <open>
  if(fd < 0)
 262:	02054663          	bltz	a0,28e <stat+0x42>
 266:	e426                	sd	s1,8(sp)
 268:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 26a:	85ca                	mv	a1,s2
 26c:	00000097          	auipc	ra,0x0
 270:	19e080e7          	jalr	414(ra) # 40a <fstat>
 274:	892a                	mv	s2,a0
  close(fd);
 276:	8526                	mv	a0,s1
 278:	00000097          	auipc	ra,0x0
 27c:	162080e7          	jalr	354(ra) # 3da <close>
  return r;
 280:	64a2                	ld	s1,8(sp)
}
 282:	854a                	mv	a0,s2
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	6902                	ld	s2,0(sp)
 28a:	6105                	addi	sp,sp,32
 28c:	8082                	ret
    return -1;
 28e:	597d                	li	s2,-1
 290:	bfcd                	j	282 <stat+0x36>

0000000000000292 <atoi>:

int
atoi(const char *s)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29a:	00054683          	lbu	a3,0(a0)
 29e:	fd06879b          	addiw	a5,a3,-48
 2a2:	0ff7f793          	zext.b	a5,a5
 2a6:	4625                	li	a2,9
 2a8:	02f66963          	bltu	a2,a5,2da <atoi+0x48>
 2ac:	872a                	mv	a4,a0
  n = 0;
 2ae:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2b0:	0705                	addi	a4,a4,1
 2b2:	0025179b          	slliw	a5,a0,0x2
 2b6:	9fa9                	addw	a5,a5,a0
 2b8:	0017979b          	slliw	a5,a5,0x1
 2bc:	9fb5                	addw	a5,a5,a3
 2be:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c2:	00074683          	lbu	a3,0(a4)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	fef671e3          	bgeu	a2,a5,2b0 <atoi+0x1e>
  return n;
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  n = 0;
 2da:	4501                	li	a0,0
 2dc:	bfdd                	j	2d2 <atoi+0x40>

00000000000002de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e406                	sd	ra,8(sp)
 2e2:	e022                	sd	s0,0(sp)
 2e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e6:	02b57563          	bgeu	a0,a1,310 <memmove+0x32>
    while(n-- > 0)
 2ea:	00c05f63          	blez	a2,308 <memmove+0x2a>
 2ee:	1602                	slli	a2,a2,0x20
 2f0:	9201                	srli	a2,a2,0x20
 2f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f8:	0585                	addi	a1,a1,1
 2fa:	0705                	addi	a4,a4,1
 2fc:	fff5c683          	lbu	a3,-1(a1)
 300:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 304:	fee79ae3          	bne	a5,a4,2f8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    dst += n;
 310:	00c50733          	add	a4,a0,a2
    src += n;
 314:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 316:	fec059e3          	blez	a2,308 <memmove+0x2a>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 334:	fef71ae3          	bne	a4,a5,328 <memmove+0x4a>
 338:	bfc1                	j	308 <memmove+0x2a>

000000000000033a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 342:	ca0d                	beqz	a2,374 <memcmp+0x3a>
 344:	fff6069b          	addiw	a3,a2,-1
 348:	1682                	slli	a3,a3,0x20
 34a:	9281                	srli	a3,a3,0x20
 34c:	0685                	addi	a3,a3,1
 34e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 350:	00054783          	lbu	a5,0(a0)
 354:	0005c703          	lbu	a4,0(a1)
 358:	00e79863          	bne	a5,a4,368 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 35c:	0505                	addi	a0,a0,1
    p2++;
 35e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 360:	fed518e3          	bne	a0,a3,350 <memcmp+0x16>
  }
  return 0;
 364:	4501                	li	a0,0
 366:	a019                	j	36c <memcmp+0x32>
      return *p1 - *p2;
 368:	40e7853b          	subw	a0,a5,a4
}
 36c:	60a2                	ld	ra,8(sp)
 36e:	6402                	ld	s0,0(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  return 0;
 374:	4501                	li	a0,0
 376:	bfdd                	j	36c <memcmp+0x32>

0000000000000378 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 380:	00000097          	auipc	ra,0x0
 384:	f5e080e7          	jalr	-162(ra) # 2de <memmove>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 390:	1141                	addi	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 398:	040007b7          	lui	a5,0x4000
 39c:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffee3d>
 39e:	07b2                	slli	a5,a5,0xc
}
 3a0:	4388                	lw	a0,0(a5)
 3a2:	60a2                	ld	ra,8(sp)
 3a4:	6402                	ld	s0,0(sp)
 3a6:	0141                	addi	sp,sp,16
 3a8:	8082                	ret

00000000000003aa <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3aa:	4885                	li	a7,1
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3b2:	4889                	li	a7,2
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <wait>:
.global wait
wait:
 li a7, SYS_wait
 3ba:	488d                	li	a7,3
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3c2:	4891                	li	a7,4
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <read>:
.global read
read:
 li a7, SYS_read
 3ca:	4895                	li	a7,5
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <write>:
.global write
write:
 li a7, SYS_write
 3d2:	48c1                	li	a7,16
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <close>:
.global close
close:
 li a7, SYS_close
 3da:	48d5                	li	a7,21
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3e2:	4899                	li	a7,6
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <exec>:
.global exec
exec:
 li a7, SYS_exec
 3ea:	489d                	li	a7,7
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <open>:
.global open
open:
 li a7, SYS_open
 3f2:	48bd                	li	a7,15
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3fa:	48c5                	li	a7,17
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 402:	48c9                	li	a7,18
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 40a:	48a1                	li	a7,8
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <link>:
.global link
link:
 li a7, SYS_link
 412:	48cd                	li	a7,19
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 41a:	48d1                	li	a7,20
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 422:	48a5                	li	a7,9
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <dup>:
.global dup
dup:
 li a7, SYS_dup
 42a:	48a9                	li	a7,10
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 432:	48ad                	li	a7,11
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 43a:	48b1                	li	a7,12
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 442:	48b5                	li	a7,13
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 44a:	48b9                	li	a7,14
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <connect>:
.global connect
connect:
 li a7, SYS_connect
 452:	48f5                	li	a7,29
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 45a:	48f9                	li	a7,30
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 462:	1101                	addi	sp,sp,-32
 464:	ec06                	sd	ra,24(sp)
 466:	e822                	sd	s0,16(sp)
 468:	1000                	addi	s0,sp,32
 46a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 46e:	4605                	li	a2,1
 470:	fef40593          	addi	a1,s0,-17
 474:	00000097          	auipc	ra,0x0
 478:	f5e080e7          	jalr	-162(ra) # 3d2 <write>
}
 47c:	60e2                	ld	ra,24(sp)
 47e:	6442                	ld	s0,16(sp)
 480:	6105                	addi	sp,sp,32
 482:	8082                	ret

0000000000000484 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 484:	7139                	addi	sp,sp,-64
 486:	fc06                	sd	ra,56(sp)
 488:	f822                	sd	s0,48(sp)
 48a:	f426                	sd	s1,40(sp)
 48c:	f04a                	sd	s2,32(sp)
 48e:	ec4e                	sd	s3,24(sp)
 490:	0080                	addi	s0,sp,64
 492:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 494:	c299                	beqz	a3,49a <printint+0x16>
 496:	0805c063          	bltz	a1,516 <printint+0x92>
  neg = 0;
 49a:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 49c:	fc040313          	addi	t1,s0,-64
  neg = 0;
 4a0:	869a                	mv	a3,t1
  i = 0;
 4a2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4a4:	00000817          	auipc	a6,0x0
 4a8:	50480813          	addi	a6,a6,1284 # 9a8 <digits>
 4ac:	88be                	mv	a7,a5
 4ae:	0017851b          	addiw	a0,a5,1
 4b2:	87aa                	mv	a5,a0
 4b4:	02c5f73b          	remuw	a4,a1,a2
 4b8:	1702                	slli	a4,a4,0x20
 4ba:	9301                	srli	a4,a4,0x20
 4bc:	9742                	add	a4,a4,a6
 4be:	00074703          	lbu	a4,0(a4)
 4c2:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4c6:	872e                	mv	a4,a1
 4c8:	02c5d5bb          	divuw	a1,a1,a2
 4cc:	0685                	addi	a3,a3,1
 4ce:	fcc77fe3          	bgeu	a4,a2,4ac <printint+0x28>
  if(neg)
 4d2:	000e0c63          	beqz	t3,4ea <printint+0x66>
    buf[i++] = '-';
 4d6:	fd050793          	addi	a5,a0,-48
 4da:	00878533          	add	a0,a5,s0
 4de:	02d00793          	li	a5,45
 4e2:	fef50823          	sb	a5,-16(a0)
 4e6:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4ea:	fff7899b          	addiw	s3,a5,-1
 4ee:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4f2:	fff4c583          	lbu	a1,-1(s1)
 4f6:	854a                	mv	a0,s2
 4f8:	00000097          	auipc	ra,0x0
 4fc:	f6a080e7          	jalr	-150(ra) # 462 <putc>
  while(--i >= 0)
 500:	39fd                	addiw	s3,s3,-1
 502:	14fd                	addi	s1,s1,-1
 504:	fe09d7e3          	bgez	s3,4f2 <printint+0x6e>
}
 508:	70e2                	ld	ra,56(sp)
 50a:	7442                	ld	s0,48(sp)
 50c:	74a2                	ld	s1,40(sp)
 50e:	7902                	ld	s2,32(sp)
 510:	69e2                	ld	s3,24(sp)
 512:	6121                	addi	sp,sp,64
 514:	8082                	ret
    x = -xx;
 516:	40b005bb          	negw	a1,a1
    neg = 1;
 51a:	4e05                	li	t3,1
    x = -xx;
 51c:	b741                	j	49c <printint+0x18>

000000000000051e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 51e:	715d                	addi	sp,sp,-80
 520:	e486                	sd	ra,72(sp)
 522:	e0a2                	sd	s0,64(sp)
 524:	f84a                	sd	s2,48(sp)
 526:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 528:	0005c903          	lbu	s2,0(a1)
 52c:	1a090a63          	beqz	s2,6e0 <vprintf+0x1c2>
 530:	fc26                	sd	s1,56(sp)
 532:	f44e                	sd	s3,40(sp)
 534:	f052                	sd	s4,32(sp)
 536:	ec56                	sd	s5,24(sp)
 538:	e85a                	sd	s6,16(sp)
 53a:	e45e                	sd	s7,8(sp)
 53c:	8aaa                	mv	s5,a0
 53e:	8bb2                	mv	s7,a2
 540:	00158493          	addi	s1,a1,1
  state = 0;
 544:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 546:	02500a13          	li	s4,37
 54a:	4b55                	li	s6,21
 54c:	a839                	j	56a <vprintf+0x4c>
        putc(fd, c);
 54e:	85ca                	mv	a1,s2
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	f10080e7          	jalr	-240(ra) # 462 <putc>
 55a:	a019                	j	560 <vprintf+0x42>
    } else if(state == '%'){
 55c:	01498d63          	beq	s3,s4,576 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 560:	0485                	addi	s1,s1,1
 562:	fff4c903          	lbu	s2,-1(s1)
 566:	16090763          	beqz	s2,6d4 <vprintf+0x1b6>
    if(state == 0){
 56a:	fe0999e3          	bnez	s3,55c <vprintf+0x3e>
      if(c == '%'){
 56e:	ff4910e3          	bne	s2,s4,54e <vprintf+0x30>
        state = '%';
 572:	89d2                	mv	s3,s4
 574:	b7f5                	j	560 <vprintf+0x42>
      if(c == 'd'){
 576:	13490463          	beq	s2,s4,69e <vprintf+0x180>
 57a:	f9d9079b          	addiw	a5,s2,-99
 57e:	0ff7f793          	zext.b	a5,a5
 582:	12fb6763          	bltu	s6,a5,6b0 <vprintf+0x192>
 586:	f9d9079b          	addiw	a5,s2,-99
 58a:	0ff7f713          	zext.b	a4,a5
 58e:	12eb6163          	bltu	s6,a4,6b0 <vprintf+0x192>
 592:	00271793          	slli	a5,a4,0x2
 596:	00000717          	auipc	a4,0x0
 59a:	3ba70713          	addi	a4,a4,954 # 950 <malloc+0x17c>
 59e:	97ba                	add	a5,a5,a4
 5a0:	439c                	lw	a5,0(a5)
 5a2:	97ba                	add	a5,a5,a4
 5a4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5a6:	008b8913          	addi	s2,s7,8
 5aa:	4685                	li	a3,1
 5ac:	4629                	li	a2,10
 5ae:	000ba583          	lw	a1,0(s7)
 5b2:	8556                	mv	a0,s5
 5b4:	00000097          	auipc	ra,0x0
 5b8:	ed0080e7          	jalr	-304(ra) # 484 <printint>
 5bc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5be:	4981                	li	s3,0
 5c0:	b745                	j	560 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5c2:	008b8913          	addi	s2,s7,8
 5c6:	4681                	li	a3,0
 5c8:	4629                	li	a2,10
 5ca:	000ba583          	lw	a1,0(s7)
 5ce:	8556                	mv	a0,s5
 5d0:	00000097          	auipc	ra,0x0
 5d4:	eb4080e7          	jalr	-332(ra) # 484 <printint>
 5d8:	8bca                	mv	s7,s2
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	b751                	j	560 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5de:	008b8913          	addi	s2,s7,8
 5e2:	4681                	li	a3,0
 5e4:	4641                	li	a2,16
 5e6:	000ba583          	lw	a1,0(s7)
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	e98080e7          	jalr	-360(ra) # 484 <printint>
 5f4:	8bca                	mv	s7,s2
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b7a5                	j	560 <vprintf+0x42>
 5fa:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5fc:	008b8c13          	addi	s8,s7,8
 600:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 604:	03000593          	li	a1,48
 608:	8556                	mv	a0,s5
 60a:	00000097          	auipc	ra,0x0
 60e:	e58080e7          	jalr	-424(ra) # 462 <putc>
  putc(fd, 'x');
 612:	07800593          	li	a1,120
 616:	8556                	mv	a0,s5
 618:	00000097          	auipc	ra,0x0
 61c:	e4a080e7          	jalr	-438(ra) # 462 <putc>
 620:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 622:	00000b97          	auipc	s7,0x0
 626:	386b8b93          	addi	s7,s7,902 # 9a8 <digits>
 62a:	03c9d793          	srli	a5,s3,0x3c
 62e:	97de                	add	a5,a5,s7
 630:	0007c583          	lbu	a1,0(a5)
 634:	8556                	mv	a0,s5
 636:	00000097          	auipc	ra,0x0
 63a:	e2c080e7          	jalr	-468(ra) # 462 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 63e:	0992                	slli	s3,s3,0x4
 640:	397d                	addiw	s2,s2,-1
 642:	fe0914e3          	bnez	s2,62a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 646:	8be2                	mv	s7,s8
      state = 0;
 648:	4981                	li	s3,0
 64a:	6c02                	ld	s8,0(sp)
 64c:	bf11                	j	560 <vprintf+0x42>
        s = va_arg(ap, char*);
 64e:	008b8993          	addi	s3,s7,8
 652:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 656:	02090163          	beqz	s2,678 <vprintf+0x15a>
        while(*s != 0){
 65a:	00094583          	lbu	a1,0(s2)
 65e:	c9a5                	beqz	a1,6ce <vprintf+0x1b0>
          putc(fd, *s);
 660:	8556                	mv	a0,s5
 662:	00000097          	auipc	ra,0x0
 666:	e00080e7          	jalr	-512(ra) # 462 <putc>
          s++;
 66a:	0905                	addi	s2,s2,1
        while(*s != 0){
 66c:	00094583          	lbu	a1,0(s2)
 670:	f9e5                	bnez	a1,660 <vprintf+0x142>
        s = va_arg(ap, char*);
 672:	8bce                	mv	s7,s3
      state = 0;
 674:	4981                	li	s3,0
 676:	b5ed                	j	560 <vprintf+0x42>
          s = "(null)";
 678:	00000917          	auipc	s2,0x0
 67c:	2d090913          	addi	s2,s2,720 # 948 <malloc+0x174>
        while(*s != 0){
 680:	02800593          	li	a1,40
 684:	bff1                	j	660 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 686:	008b8913          	addi	s2,s7,8
 68a:	000bc583          	lbu	a1,0(s7)
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	dd2080e7          	jalr	-558(ra) # 462 <putc>
 698:	8bca                	mv	s7,s2
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b5d1                	j	560 <vprintf+0x42>
        putc(fd, c);
 69e:	02500593          	li	a1,37
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	dbe080e7          	jalr	-578(ra) # 462 <putc>
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	bd4d                	j	560 <vprintf+0x42>
        putc(fd, '%');
 6b0:	02500593          	li	a1,37
 6b4:	8556                	mv	a0,s5
 6b6:	00000097          	auipc	ra,0x0
 6ba:	dac080e7          	jalr	-596(ra) # 462 <putc>
        putc(fd, c);
 6be:	85ca                	mv	a1,s2
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	da0080e7          	jalr	-608(ra) # 462 <putc>
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	bd51                	j	560 <vprintf+0x42>
        s = va_arg(ap, char*);
 6ce:	8bce                	mv	s7,s3
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	b579                	j	560 <vprintf+0x42>
 6d4:	74e2                	ld	s1,56(sp)
 6d6:	79a2                	ld	s3,40(sp)
 6d8:	7a02                	ld	s4,32(sp)
 6da:	6ae2                	ld	s5,24(sp)
 6dc:	6b42                	ld	s6,16(sp)
 6de:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6e0:	60a6                	ld	ra,72(sp)
 6e2:	6406                	ld	s0,64(sp)
 6e4:	7942                	ld	s2,48(sp)
 6e6:	6161                	addi	sp,sp,80
 6e8:	8082                	ret

00000000000006ea <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6ea:	715d                	addi	sp,sp,-80
 6ec:	ec06                	sd	ra,24(sp)
 6ee:	e822                	sd	s0,16(sp)
 6f0:	1000                	addi	s0,sp,32
 6f2:	e010                	sd	a2,0(s0)
 6f4:	e414                	sd	a3,8(s0)
 6f6:	e818                	sd	a4,16(s0)
 6f8:	ec1c                	sd	a5,24(s0)
 6fa:	03043023          	sd	a6,32(s0)
 6fe:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 702:	8622                	mv	a2,s0
 704:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 708:	00000097          	auipc	ra,0x0
 70c:	e16080e7          	jalr	-490(ra) # 51e <vprintf>
}
 710:	60e2                	ld	ra,24(sp)
 712:	6442                	ld	s0,16(sp)
 714:	6161                	addi	sp,sp,80
 716:	8082                	ret

0000000000000718 <printf>:

void
printf(const char *fmt, ...)
{
 718:	711d                	addi	sp,sp,-96
 71a:	ec06                	sd	ra,24(sp)
 71c:	e822                	sd	s0,16(sp)
 71e:	1000                	addi	s0,sp,32
 720:	e40c                	sd	a1,8(s0)
 722:	e810                	sd	a2,16(s0)
 724:	ec14                	sd	a3,24(s0)
 726:	f018                	sd	a4,32(s0)
 728:	f41c                	sd	a5,40(s0)
 72a:	03043823          	sd	a6,48(s0)
 72e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 732:	00840613          	addi	a2,s0,8
 736:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 73a:	85aa                	mv	a1,a0
 73c:	4505                	li	a0,1
 73e:	00000097          	auipc	ra,0x0
 742:	de0080e7          	jalr	-544(ra) # 51e <vprintf>
}
 746:	60e2                	ld	ra,24(sp)
 748:	6442                	ld	s0,16(sp)
 74a:	6125                	addi	sp,sp,96
 74c:	8082                	ret

000000000000074e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 74e:	1141                	addi	sp,sp,-16
 750:	e406                	sd	ra,8(sp)
 752:	e022                	sd	s0,0(sp)
 754:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 756:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75a:	00000797          	auipc	a5,0x0
 75e:	2767b783          	ld	a5,630(a5) # 9d0 <freep>
 762:	a02d                	j	78c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 764:	4618                	lw	a4,8(a2)
 766:	9f2d                	addw	a4,a4,a1
 768:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 76c:	6398                	ld	a4,0(a5)
 76e:	6310                	ld	a2,0(a4)
 770:	a83d                	j	7ae <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 772:	ff852703          	lw	a4,-8(a0)
 776:	9f31                	addw	a4,a4,a2
 778:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 77a:	ff053683          	ld	a3,-16(a0)
 77e:	a091                	j	7c2 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	6398                	ld	a4,0(a5)
 782:	00e7e463          	bltu	a5,a4,78a <free+0x3c>
 786:	00e6ea63          	bltu	a3,a4,79a <free+0x4c>
{
 78a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 78c:	fed7fae3          	bgeu	a5,a3,780 <free+0x32>
 790:	6398                	ld	a4,0(a5)
 792:	00e6e463          	bltu	a3,a4,79a <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 796:	fee7eae3          	bltu	a5,a4,78a <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 79a:	ff852583          	lw	a1,-8(a0)
 79e:	6390                	ld	a2,0(a5)
 7a0:	02059813          	slli	a6,a1,0x20
 7a4:	01c85713          	srli	a4,a6,0x1c
 7a8:	9736                	add	a4,a4,a3
 7aa:	fae60de3          	beq	a2,a4,764 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7ae:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7b2:	4790                	lw	a2,8(a5)
 7b4:	02061593          	slli	a1,a2,0x20
 7b8:	01c5d713          	srli	a4,a1,0x1c
 7bc:	973e                	add	a4,a4,a5
 7be:	fae68ae3          	beq	a3,a4,772 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7c2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c4:	00000717          	auipc	a4,0x0
 7c8:	20f73623          	sd	a5,524(a4) # 9d0 <freep>
}
 7cc:	60a2                	ld	ra,8(sp)
 7ce:	6402                	ld	s0,0(sp)
 7d0:	0141                	addi	sp,sp,16
 7d2:	8082                	ret

00000000000007d4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d4:	7139                	addi	sp,sp,-64
 7d6:	fc06                	sd	ra,56(sp)
 7d8:	f822                	sd	s0,48(sp)
 7da:	f04a                	sd	s2,32(sp)
 7dc:	ec4e                	sd	s3,24(sp)
 7de:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e0:	02051993          	slli	s3,a0,0x20
 7e4:	0209d993          	srli	s3,s3,0x20
 7e8:	09bd                	addi	s3,s3,15
 7ea:	0049d993          	srli	s3,s3,0x4
 7ee:	2985                	addiw	s3,s3,1
 7f0:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7f2:	00000517          	auipc	a0,0x0
 7f6:	1de53503          	ld	a0,478(a0) # 9d0 <freep>
 7fa:	c905                	beqz	a0,82a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fe:	4798                	lw	a4,8(a5)
 800:	09377a63          	bgeu	a4,s3,894 <malloc+0xc0>
 804:	f426                	sd	s1,40(sp)
 806:	e852                	sd	s4,16(sp)
 808:	e456                	sd	s5,8(sp)
 80a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 80c:	8a4e                	mv	s4,s3
 80e:	6705                	lui	a4,0x1
 810:	00e9f363          	bgeu	s3,a4,816 <malloc+0x42>
 814:	6a05                	lui	s4,0x1
 816:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 81a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 81e:	00000497          	auipc	s1,0x0
 822:	1b248493          	addi	s1,s1,434 # 9d0 <freep>
  if(p == (char*)-1)
 826:	5afd                	li	s5,-1
 828:	a089                	j	86a <malloc+0x96>
 82a:	f426                	sd	s1,40(sp)
 82c:	e852                	sd	s4,16(sp)
 82e:	e456                	sd	s5,8(sp)
 830:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 832:	00000797          	auipc	a5,0x0
 836:	1a678793          	addi	a5,a5,422 # 9d8 <base>
 83a:	00000717          	auipc	a4,0x0
 83e:	18f73b23          	sd	a5,406(a4) # 9d0 <freep>
 842:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 844:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 848:	b7d1                	j	80c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 84a:	6398                	ld	a4,0(a5)
 84c:	e118                	sd	a4,0(a0)
 84e:	a8b9                	j	8ac <malloc+0xd8>
  hp->s.size = nu;
 850:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 854:	0541                	addi	a0,a0,16
 856:	00000097          	auipc	ra,0x0
 85a:	ef8080e7          	jalr	-264(ra) # 74e <free>
  return freep;
 85e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 860:	c135                	beqz	a0,8c4 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 862:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 864:	4798                	lw	a4,8(a5)
 866:	03277363          	bgeu	a4,s2,88c <malloc+0xb8>
    if(p == freep)
 86a:	6098                	ld	a4,0(s1)
 86c:	853e                	mv	a0,a5
 86e:	fef71ae3          	bne	a4,a5,862 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 872:	8552                	mv	a0,s4
 874:	00000097          	auipc	ra,0x0
 878:	bc6080e7          	jalr	-1082(ra) # 43a <sbrk>
  if(p == (char*)-1)
 87c:	fd551ae3          	bne	a0,s5,850 <malloc+0x7c>
        return 0;
 880:	4501                	li	a0,0
 882:	74a2                	ld	s1,40(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	a03d                	j	8b8 <malloc+0xe4>
 88c:	74a2                	ld	s1,40(sp)
 88e:	6a42                	ld	s4,16(sp)
 890:	6aa2                	ld	s5,8(sp)
 892:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 894:	fae90be3          	beq	s2,a4,84a <malloc+0x76>
        p->s.size -= nunits;
 898:	4137073b          	subw	a4,a4,s3
 89c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 89e:	02071693          	slli	a3,a4,0x20
 8a2:	01c6d713          	srli	a4,a3,0x1c
 8a6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8a8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ac:	00000717          	auipc	a4,0x0
 8b0:	12a73223          	sd	a0,292(a4) # 9d0 <freep>
      return (void*)(p + 1);
 8b4:	01078513          	addi	a0,a5,16
  }
}
 8b8:	70e2                	ld	ra,56(sp)
 8ba:	7442                	ld	s0,48(sp)
 8bc:	7902                	ld	s2,32(sp)
 8be:	69e2                	ld	s3,24(sp)
 8c0:	6121                	addi	sp,sp,64
 8c2:	8082                	ret
 8c4:	74a2                	ld	s1,40(sp)
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
 8cc:	b7f5                	j	8b8 <malloc+0xe4>
