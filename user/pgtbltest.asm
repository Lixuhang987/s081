
user/_pgtbltest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <err>:

char *testname = "???";

void
err(char *why)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
   c:	84aa                	mv	s1,a0
  printf("pgtbltest: %s failed: %s, pid=%d\n", testname, why, getpid());
   e:	00001917          	auipc	s2,0x1
  12:	b5a93903          	ld	s2,-1190(s2) # b68 <testname>
  16:	00000097          	auipc	ra,0x0
  1a:	52e080e7          	jalr	1326(ra) # 544 <getpid>
  1e:	86aa                	mv	a3,a0
  20:	8626                	mv	a2,s1
  22:	85ca                	mv	a1,s2
  24:	00001517          	auipc	a0,0x1
  28:	9bc50513          	addi	a0,a0,-1604 # 9e0 <malloc+0xfa>
  2c:	00000097          	auipc	ra,0x0
  30:	7fe080e7          	jalr	2046(ra) # 82a <printf>
  exit(1);
  34:	4505                	li	a0,1
  36:	00000097          	auipc	ra,0x0
  3a:	48e080e7          	jalr	1166(ra) # 4c4 <exit>

000000000000003e <ugetpid_test>:
}

void
ugetpid_test()
{
  3e:	7179                	addi	sp,sp,-48
  40:	f406                	sd	ra,40(sp)
  42:	f022                	sd	s0,32(sp)
  44:	ec26                	sd	s1,24(sp)
  46:	e84a                	sd	s2,16(sp)
  48:	1800                	addi	s0,sp,48
  int i;

  printf("ugetpid_test starting\n");
  4a:	00001517          	auipc	a0,0x1
  4e:	9be50513          	addi	a0,a0,-1602 # a08 <malloc+0x122>
  52:	00000097          	auipc	ra,0x0
  56:	7d8080e7          	jalr	2008(ra) # 82a <printf>
  testname = "ugetpid_test";
  5a:	00001797          	auipc	a5,0x1
  5e:	9c678793          	addi	a5,a5,-1594 # a20 <malloc+0x13a>
  62:	00001717          	auipc	a4,0x1
  66:	b0f73323          	sd	a5,-1274(a4) # b68 <testname>
  6a:	04000493          	li	s1,64

  for (i = 0; i < 64; i++) {
    int ret = fork();
    if (ret != 0) {
      wait(&ret);
  6e:	fdc40913          	addi	s2,s0,-36
    int ret = fork();
  72:	00000097          	auipc	ra,0x0
  76:	44a080e7          	jalr	1098(ra) # 4bc <fork>
  7a:	fca42e23          	sw	a0,-36(s0)
    if (ret != 0) {
  7e:	cd15                	beqz	a0,ba <ugetpid_test+0x7c>
      wait(&ret);
  80:	854a                	mv	a0,s2
  82:	00000097          	auipc	ra,0x0
  86:	44a080e7          	jalr	1098(ra) # 4cc <wait>
      if (ret != 0)
  8a:	fdc42783          	lw	a5,-36(s0)
  8e:	e38d                	bnez	a5,b0 <ugetpid_test+0x72>
  for (i = 0; i < 64; i++) {
  90:	34fd                	addiw	s1,s1,-1
  92:	f0e5                	bnez	s1,72 <ugetpid_test+0x34>
    }
    if (getpid() != ugetpid())
      err("missmatched PID");
    exit(0);
  }
  printf("ugetpid_test: OK\n");
  94:	00001517          	auipc	a0,0x1
  98:	9ac50513          	addi	a0,a0,-1620 # a40 <malloc+0x15a>
  9c:	00000097          	auipc	ra,0x0
  a0:	78e080e7          	jalr	1934(ra) # 82a <printf>
}
  a4:	70a2                	ld	ra,40(sp)
  a6:	7402                	ld	s0,32(sp)
  a8:	64e2                	ld	s1,24(sp)
  aa:	6942                	ld	s2,16(sp)
  ac:	6145                	addi	sp,sp,48
  ae:	8082                	ret
        exit(1);
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	412080e7          	jalr	1042(ra) # 4c4 <exit>
    if (getpid() != ugetpid())
  ba:	00000097          	auipc	ra,0x0
  be:	48a080e7          	jalr	1162(ra) # 544 <getpid>
  c2:	84aa                	mv	s1,a0
  c4:	00000097          	auipc	ra,0x0
  c8:	3de080e7          	jalr	990(ra) # 4a2 <ugetpid>
  cc:	00a48a63          	beq	s1,a0,e0 <ugetpid_test+0xa2>
      err("missmatched PID");
  d0:	00001517          	auipc	a0,0x1
  d4:	96050513          	addi	a0,a0,-1696 # a30 <malloc+0x14a>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <err>
    exit(0);
  e0:	4501                	li	a0,0
  e2:	00000097          	auipc	ra,0x0
  e6:	3e2080e7          	jalr	994(ra) # 4c4 <exit>

00000000000000ea <pgaccess_test>:

void
pgaccess_test()
{
  ea:	7179                	addi	sp,sp,-48
  ec:	f406                	sd	ra,40(sp)
  ee:	f022                	sd	s0,32(sp)
  f0:	ec26                	sd	s1,24(sp)
  f2:	1800                	addi	s0,sp,48
  char *buf;
  unsigned int abits;
  printf("pgaccess_test starting\n");
  f4:	00001517          	auipc	a0,0x1
  f8:	96450513          	addi	a0,a0,-1692 # a58 <malloc+0x172>
  fc:	00000097          	auipc	ra,0x0
 100:	72e080e7          	jalr	1838(ra) # 82a <printf>
  testname = "pgaccess_test";
 104:	00001797          	auipc	a5,0x1
 108:	96c78793          	addi	a5,a5,-1684 # a70 <malloc+0x18a>
 10c:	00001717          	auipc	a4,0x1
 110:	a4f73e23          	sd	a5,-1444(a4) # b68 <testname>
  buf = malloc(32 * PGSIZE);
 114:	00020537          	lui	a0,0x20
 118:	00000097          	auipc	ra,0x0
 11c:	7ce080e7          	jalr	1998(ra) # 8e6 <malloc>
 120:	84aa                	mv	s1,a0
  if (pgaccess(buf, 32, &abits) < 0)
 122:	fdc40613          	addi	a2,s0,-36
 126:	02000593          	li	a1,32
 12a:	00000097          	auipc	ra,0x0
 12e:	442080e7          	jalr	1090(ra) # 56c <pgaccess>
 132:	06054b63          	bltz	a0,1a8 <pgaccess_test+0xbe>
    err("pgaccess failed");
  buf[PGSIZE * 1] += 1;
 136:	6785                	lui	a5,0x1
 138:	97a6                	add	a5,a5,s1
 13a:	0007c703          	lbu	a4,0(a5) # 1000 <__BSS_END__+0x478>
 13e:	2705                	addiw	a4,a4,1
 140:	00e78023          	sb	a4,0(a5)
  buf[PGSIZE * 2] += 1;
 144:	6789                	lui	a5,0x2
 146:	97a6                	add	a5,a5,s1
 148:	0007c703          	lbu	a4,0(a5) # 2000 <__global_pointer$+0xc9f>
 14c:	2705                	addiw	a4,a4,1
 14e:	00e78023          	sb	a4,0(a5)
  buf[PGSIZE * 30] += 1;
 152:	67f9                	lui	a5,0x1e
 154:	97a6                	add	a5,a5,s1
 156:	0007c703          	lbu	a4,0(a5) # 1e000 <__global_pointer$+0x1cc9f>
 15a:	2705                	addiw	a4,a4,1
 15c:	00e78023          	sb	a4,0(a5)
  if (pgaccess(buf, 32, &abits) < 0)
 160:	fdc40613          	addi	a2,s0,-36
 164:	02000593          	li	a1,32
 168:	8526                	mv	a0,s1
 16a:	00000097          	auipc	ra,0x0
 16e:	402080e7          	jalr	1026(ra) # 56c <pgaccess>
 172:	04054363          	bltz	a0,1b8 <pgaccess_test+0xce>
    err("pgaccess failed");
  if (abits != ((1 << 1) | (1 << 2) | (1 << 30)))
 176:	fdc42703          	lw	a4,-36(s0)
 17a:	400007b7          	lui	a5,0x40000
 17e:	0799                	addi	a5,a5,6 # 40000006 <__global_pointer$+0x3fffeca5>
 180:	04f71463          	bne	a4,a5,1c8 <pgaccess_test+0xde>
    err("incorrect access bits set");
  free(buf);
 184:	8526                	mv	a0,s1
 186:	00000097          	auipc	ra,0x0
 18a:	6da080e7          	jalr	1754(ra) # 860 <free>
  printf("pgaccess_test: OK\n");
 18e:	00001517          	auipc	a0,0x1
 192:	92250513          	addi	a0,a0,-1758 # ab0 <malloc+0x1ca>
 196:	00000097          	auipc	ra,0x0
 19a:	694080e7          	jalr	1684(ra) # 82a <printf>
}
 19e:	70a2                	ld	ra,40(sp)
 1a0:	7402                	ld	s0,32(sp)
 1a2:	64e2                	ld	s1,24(sp)
 1a4:	6145                	addi	sp,sp,48
 1a6:	8082                	ret
    err("pgaccess failed");
 1a8:	00001517          	auipc	a0,0x1
 1ac:	8d850513          	addi	a0,a0,-1832 # a80 <malloc+0x19a>
 1b0:	00000097          	auipc	ra,0x0
 1b4:	e50080e7          	jalr	-432(ra) # 0 <err>
    err("pgaccess failed");
 1b8:	00001517          	auipc	a0,0x1
 1bc:	8c850513          	addi	a0,a0,-1848 # a80 <malloc+0x19a>
 1c0:	00000097          	auipc	ra,0x0
 1c4:	e40080e7          	jalr	-448(ra) # 0 <err>
    err("incorrect access bits set");
 1c8:	00001517          	auipc	a0,0x1
 1cc:	8c850513          	addi	a0,a0,-1848 # a90 <malloc+0x1aa>
 1d0:	00000097          	auipc	ra,0x0
 1d4:	e30080e7          	jalr	-464(ra) # 0 <err>

00000000000001d8 <main>:
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e406                	sd	ra,8(sp)
 1dc:	e022                	sd	s0,0(sp)
 1de:	0800                	addi	s0,sp,16
  ugetpid_test();
 1e0:	00000097          	auipc	ra,0x0
 1e4:	e5e080e7          	jalr	-418(ra) # 3e <ugetpid_test>
  pgaccess_test();
 1e8:	00000097          	auipc	ra,0x0
 1ec:	f02080e7          	jalr	-254(ra) # ea <pgaccess_test>
  printf("pgtbltest: all tests succeeded\n");
 1f0:	00001517          	auipc	a0,0x1
 1f4:	8d850513          	addi	a0,a0,-1832 # ac8 <malloc+0x1e2>
 1f8:	00000097          	auipc	ra,0x0
 1fc:	632080e7          	jalr	1586(ra) # 82a <printf>
  exit(0);
 200:	4501                	li	a0,0
 202:	00000097          	auipc	ra,0x0
 206:	2c2080e7          	jalr	706(ra) # 4c4 <exit>

000000000000020a <strcpy>:



char*
strcpy(char *s, const char *t)
{
 20a:	1141                	addi	sp,sp,-16
 20c:	e406                	sd	ra,8(sp)
 20e:	e022                	sd	s0,0(sp)
 210:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 212:	87aa                	mv	a5,a0
 214:	0585                	addi	a1,a1,1
 216:	0785                	addi	a5,a5,1
 218:	fff5c703          	lbu	a4,-1(a1)
 21c:	fee78fa3          	sb	a4,-1(a5)
 220:	fb75                	bnez	a4,214 <strcpy+0xa>
    ;
  return os;
}
 222:	60a2                	ld	ra,8(sp)
 224:	6402                	ld	s0,0(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret

000000000000022a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e406                	sd	ra,8(sp)
 22e:	e022                	sd	s0,0(sp)
 230:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 232:	00054783          	lbu	a5,0(a0)
 236:	cb91                	beqz	a5,24a <strcmp+0x20>
 238:	0005c703          	lbu	a4,0(a1)
 23c:	00f71763          	bne	a4,a5,24a <strcmp+0x20>
    p++, q++;
 240:	0505                	addi	a0,a0,1
 242:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 244:	00054783          	lbu	a5,0(a0)
 248:	fbe5                	bnez	a5,238 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 24a:	0005c503          	lbu	a0,0(a1)
}
 24e:	40a7853b          	subw	a0,a5,a0
 252:	60a2                	ld	ra,8(sp)
 254:	6402                	ld	s0,0(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret

000000000000025a <strlen>:

uint
strlen(const char *s)
{
 25a:	1141                	addi	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 262:	00054783          	lbu	a5,0(a0)
 266:	cf99                	beqz	a5,284 <strlen+0x2a>
 268:	0505                	addi	a0,a0,1
 26a:	87aa                	mv	a5,a0
 26c:	86be                	mv	a3,a5
 26e:	0785                	addi	a5,a5,1
 270:	fff7c703          	lbu	a4,-1(a5)
 274:	ff65                	bnez	a4,26c <strlen+0x12>
 276:	40a6853b          	subw	a0,a3,a0
 27a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 27c:	60a2                	ld	ra,8(sp)
 27e:	6402                	ld	s0,0(sp)
 280:	0141                	addi	sp,sp,16
 282:	8082                	ret
  for(n = 0; s[n]; n++)
 284:	4501                	li	a0,0
 286:	bfdd                	j	27c <strlen+0x22>

0000000000000288 <memset>:

void*
memset(void *dst, int c, uint n)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e406                	sd	ra,8(sp)
 28c:	e022                	sd	s0,0(sp)
 28e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 290:	ca19                	beqz	a2,2a6 <memset+0x1e>
 292:	87aa                	mv	a5,a0
 294:	1602                	slli	a2,a2,0x20
 296:	9201                	srli	a2,a2,0x20
 298:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 29c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2a0:	0785                	addi	a5,a5,1
 2a2:	fee79de3          	bne	a5,a4,29c <memset+0x14>
  }
  return dst;
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <strchr>:

char*
strchr(const char *s, char c)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2b6:	00054783          	lbu	a5,0(a0)
 2ba:	cf81                	beqz	a5,2d2 <strchr+0x24>
    if(*s == c)
 2bc:	00f58763          	beq	a1,a5,2ca <strchr+0x1c>
  for(; *s; s++)
 2c0:	0505                	addi	a0,a0,1
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	fbfd                	bnez	a5,2bc <strchr+0xe>
      return (char*)s;
  return 0;
 2c8:	4501                	li	a0,0
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	bfdd                	j	2ca <strchr+0x1c>

00000000000002d6 <gets>:

char*
gets(char *buf, int max)
{
 2d6:	7159                	addi	sp,sp,-112
 2d8:	f486                	sd	ra,104(sp)
 2da:	f0a2                	sd	s0,96(sp)
 2dc:	eca6                	sd	s1,88(sp)
 2de:	e8ca                	sd	s2,80(sp)
 2e0:	e4ce                	sd	s3,72(sp)
 2e2:	e0d2                	sd	s4,64(sp)
 2e4:	fc56                	sd	s5,56(sp)
 2e6:	f85a                	sd	s6,48(sp)
 2e8:	f45e                	sd	s7,40(sp)
 2ea:	f062                	sd	s8,32(sp)
 2ec:	ec66                	sd	s9,24(sp)
 2ee:	e86a                	sd	s10,16(sp)
 2f0:	1880                	addi	s0,sp,112
 2f2:	8caa                	mv	s9,a0
 2f4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f6:	892a                	mv	s2,a0
 2f8:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2fa:	f9f40b13          	addi	s6,s0,-97
 2fe:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 300:	4ba9                	li	s7,10
 302:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 304:	8d26                	mv	s10,s1
 306:	0014899b          	addiw	s3,s1,1
 30a:	84ce                	mv	s1,s3
 30c:	0349d763          	bge	s3,s4,33a <gets+0x64>
    cc = read(0, &c, 1);
 310:	8656                	mv	a2,s5
 312:	85da                	mv	a1,s6
 314:	4501                	li	a0,0
 316:	00000097          	auipc	ra,0x0
 31a:	1c6080e7          	jalr	454(ra) # 4dc <read>
    if(cc < 1)
 31e:	00a05e63          	blez	a0,33a <gets+0x64>
    buf[i++] = c;
 322:	f9f44783          	lbu	a5,-97(s0)
 326:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 32a:	01778763          	beq	a5,s7,338 <gets+0x62>
 32e:	0905                	addi	s2,s2,1
 330:	fd879ae3          	bne	a5,s8,304 <gets+0x2e>
    buf[i++] = c;
 334:	8d4e                	mv	s10,s3
 336:	a011                	j	33a <gets+0x64>
 338:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 33a:	9d66                	add	s10,s10,s9
 33c:	000d0023          	sb	zero,0(s10)
  return buf;
}
 340:	8566                	mv	a0,s9
 342:	70a6                	ld	ra,104(sp)
 344:	7406                	ld	s0,96(sp)
 346:	64e6                	ld	s1,88(sp)
 348:	6946                	ld	s2,80(sp)
 34a:	69a6                	ld	s3,72(sp)
 34c:	6a06                	ld	s4,64(sp)
 34e:	7ae2                	ld	s5,56(sp)
 350:	7b42                	ld	s6,48(sp)
 352:	7ba2                	ld	s7,40(sp)
 354:	7c02                	ld	s8,32(sp)
 356:	6ce2                	ld	s9,24(sp)
 358:	6d42                	ld	s10,16(sp)
 35a:	6165                	addi	sp,sp,112
 35c:	8082                	ret

000000000000035e <stat>:

int
stat(const char *n, struct stat *st)
{
 35e:	1101                	addi	sp,sp,-32
 360:	ec06                	sd	ra,24(sp)
 362:	e822                	sd	s0,16(sp)
 364:	e04a                	sd	s2,0(sp)
 366:	1000                	addi	s0,sp,32
 368:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 36a:	4581                	li	a1,0
 36c:	00000097          	auipc	ra,0x0
 370:	198080e7          	jalr	408(ra) # 504 <open>
  if(fd < 0)
 374:	02054663          	bltz	a0,3a0 <stat+0x42>
 378:	e426                	sd	s1,8(sp)
 37a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 37c:	85ca                	mv	a1,s2
 37e:	00000097          	auipc	ra,0x0
 382:	19e080e7          	jalr	414(ra) # 51c <fstat>
 386:	892a                	mv	s2,a0
  close(fd);
 388:	8526                	mv	a0,s1
 38a:	00000097          	auipc	ra,0x0
 38e:	162080e7          	jalr	354(ra) # 4ec <close>
  return r;
 392:	64a2                	ld	s1,8(sp)
}
 394:	854a                	mv	a0,s2
 396:	60e2                	ld	ra,24(sp)
 398:	6442                	ld	s0,16(sp)
 39a:	6902                	ld	s2,0(sp)
 39c:	6105                	addi	sp,sp,32
 39e:	8082                	ret
    return -1;
 3a0:	597d                	li	s2,-1
 3a2:	bfcd                	j	394 <stat+0x36>

00000000000003a4 <atoi>:

int
atoi(const char *s)
{
 3a4:	1141                	addi	sp,sp,-16
 3a6:	e406                	sd	ra,8(sp)
 3a8:	e022                	sd	s0,0(sp)
 3aa:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3ac:	00054683          	lbu	a3,0(a0)
 3b0:	fd06879b          	addiw	a5,a3,-48
 3b4:	0ff7f793          	zext.b	a5,a5
 3b8:	4625                	li	a2,9
 3ba:	02f66963          	bltu	a2,a5,3ec <atoi+0x48>
 3be:	872a                	mv	a4,a0
  n = 0;
 3c0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 3c2:	0705                	addi	a4,a4,1
 3c4:	0025179b          	slliw	a5,a0,0x2
 3c8:	9fa9                	addw	a5,a5,a0
 3ca:	0017979b          	slliw	a5,a5,0x1
 3ce:	9fb5                	addw	a5,a5,a3
 3d0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3d4:	00074683          	lbu	a3,0(a4)
 3d8:	fd06879b          	addiw	a5,a3,-48
 3dc:	0ff7f793          	zext.b	a5,a5
 3e0:	fef671e3          	bgeu	a2,a5,3c2 <atoi+0x1e>
  return n;
}
 3e4:	60a2                	ld	ra,8(sp)
 3e6:	6402                	ld	s0,0(sp)
 3e8:	0141                	addi	sp,sp,16
 3ea:	8082                	ret
  n = 0;
 3ec:	4501                	li	a0,0
 3ee:	bfdd                	j	3e4 <atoi+0x40>

00000000000003f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f0:	1141                	addi	sp,sp,-16
 3f2:	e406                	sd	ra,8(sp)
 3f4:	e022                	sd	s0,0(sp)
 3f6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3f8:	02b57563          	bgeu	a0,a1,422 <memmove+0x32>
    while(n-- > 0)
 3fc:	00c05f63          	blez	a2,41a <memmove+0x2a>
 400:	1602                	slli	a2,a2,0x20
 402:	9201                	srli	a2,a2,0x20
 404:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 408:	872a                	mv	a4,a0
      *dst++ = *src++;
 40a:	0585                	addi	a1,a1,1
 40c:	0705                	addi	a4,a4,1
 40e:	fff5c683          	lbu	a3,-1(a1)
 412:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 416:	fee79ae3          	bne	a5,a4,40a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 41a:	60a2                	ld	ra,8(sp)
 41c:	6402                	ld	s0,0(sp)
 41e:	0141                	addi	sp,sp,16
 420:	8082                	ret
    dst += n;
 422:	00c50733          	add	a4,a0,a2
    src += n;
 426:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 428:	fec059e3          	blez	a2,41a <memmove+0x2a>
 42c:	fff6079b          	addiw	a5,a2,-1
 430:	1782                	slli	a5,a5,0x20
 432:	9381                	srli	a5,a5,0x20
 434:	fff7c793          	not	a5,a5
 438:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 43a:	15fd                	addi	a1,a1,-1
 43c:	177d                	addi	a4,a4,-1
 43e:	0005c683          	lbu	a3,0(a1)
 442:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 446:	fef71ae3          	bne	a4,a5,43a <memmove+0x4a>
 44a:	bfc1                	j	41a <memmove+0x2a>

000000000000044c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e406                	sd	ra,8(sp)
 450:	e022                	sd	s0,0(sp)
 452:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 454:	ca0d                	beqz	a2,486 <memcmp+0x3a>
 456:	fff6069b          	addiw	a3,a2,-1
 45a:	1682                	slli	a3,a3,0x20
 45c:	9281                	srli	a3,a3,0x20
 45e:	0685                	addi	a3,a3,1
 460:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 462:	00054783          	lbu	a5,0(a0)
 466:	0005c703          	lbu	a4,0(a1)
 46a:	00e79863          	bne	a5,a4,47a <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 46e:	0505                	addi	a0,a0,1
    p2++;
 470:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 472:	fed518e3          	bne	a0,a3,462 <memcmp+0x16>
  }
  return 0;
 476:	4501                	li	a0,0
 478:	a019                	j	47e <memcmp+0x32>
      return *p1 - *p2;
 47a:	40e7853b          	subw	a0,a5,a4
}
 47e:	60a2                	ld	ra,8(sp)
 480:	6402                	ld	s0,0(sp)
 482:	0141                	addi	sp,sp,16
 484:	8082                	ret
  return 0;
 486:	4501                	li	a0,0
 488:	bfdd                	j	47e <memcmp+0x32>

000000000000048a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 48a:	1141                	addi	sp,sp,-16
 48c:	e406                	sd	ra,8(sp)
 48e:	e022                	sd	s0,0(sp)
 490:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 492:	00000097          	auipc	ra,0x0
 496:	f5e080e7          	jalr	-162(ra) # 3f0 <memmove>
}
 49a:	60a2                	ld	ra,8(sp)
 49c:	6402                	ld	s0,0(sp)
 49e:	0141                	addi	sp,sp,16
 4a0:	8082                	ret

00000000000004a2 <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 4a2:	1141                	addi	sp,sp,-16
 4a4:	e406                	sd	ra,8(sp)
 4a6:	e022                	sd	s0,0(sp)
 4a8:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 4aa:	040007b7          	lui	a5,0x4000
 4ae:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffec9c>
 4b0:	07b2                	slli	a5,a5,0xc
}
 4b2:	4388                	lw	a0,0(a5)
 4b4:	60a2                	ld	ra,8(sp)
 4b6:	6402                	ld	s0,0(sp)
 4b8:	0141                	addi	sp,sp,16
 4ba:	8082                	ret

00000000000004bc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4bc:	4885                	li	a7,1
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4c4:	4889                	li	a7,2
 ecall
 4c6:	00000073          	ecall
 ret
 4ca:	8082                	ret

00000000000004cc <wait>:
.global wait
wait:
 li a7, SYS_wait
 4cc:	488d                	li	a7,3
 ecall
 4ce:	00000073          	ecall
 ret
 4d2:	8082                	ret

00000000000004d4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4d4:	4891                	li	a7,4
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <read>:
.global read
read:
 li a7, SYS_read
 4dc:	4895                	li	a7,5
 ecall
 4de:	00000073          	ecall
 ret
 4e2:	8082                	ret

00000000000004e4 <write>:
.global write
write:
 li a7, SYS_write
 4e4:	48c1                	li	a7,16
 ecall
 4e6:	00000073          	ecall
 ret
 4ea:	8082                	ret

00000000000004ec <close>:
.global close
close:
 li a7, SYS_close
 4ec:	48d5                	li	a7,21
 ecall
 4ee:	00000073          	ecall
 ret
 4f2:	8082                	ret

00000000000004f4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4f4:	4899                	li	a7,6
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <exec>:
.global exec
exec:
 li a7, SYS_exec
 4fc:	489d                	li	a7,7
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <open>:
.global open
open:
 li a7, SYS_open
 504:	48bd                	li	a7,15
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 50c:	48c5                	li	a7,17
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 514:	48c9                	li	a7,18
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 51c:	48a1                	li	a7,8
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <link>:
.global link
link:
 li a7, SYS_link
 524:	48cd                	li	a7,19
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 52c:	48d1                	li	a7,20
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 534:	48a5                	li	a7,9
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <dup>:
.global dup
dup:
 li a7, SYS_dup
 53c:	48a9                	li	a7,10
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 544:	48ad                	li	a7,11
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 54c:	48b1                	li	a7,12
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 554:	48b5                	li	a7,13
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 55c:	48b9                	li	a7,14
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <connect>:
.global connect
connect:
 li a7, SYS_connect
 564:	48f5                	li	a7,29
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 56c:	48f9                	li	a7,30
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 574:	1101                	addi	sp,sp,-32
 576:	ec06                	sd	ra,24(sp)
 578:	e822                	sd	s0,16(sp)
 57a:	1000                	addi	s0,sp,32
 57c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 580:	4605                	li	a2,1
 582:	fef40593          	addi	a1,s0,-17
 586:	00000097          	auipc	ra,0x0
 58a:	f5e080e7          	jalr	-162(ra) # 4e4 <write>
}
 58e:	60e2                	ld	ra,24(sp)
 590:	6442                	ld	s0,16(sp)
 592:	6105                	addi	sp,sp,32
 594:	8082                	ret

0000000000000596 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 596:	7139                	addi	sp,sp,-64
 598:	fc06                	sd	ra,56(sp)
 59a:	f822                	sd	s0,48(sp)
 59c:	f426                	sd	s1,40(sp)
 59e:	f04a                	sd	s2,32(sp)
 5a0:	ec4e                	sd	s3,24(sp)
 5a2:	0080                	addi	s0,sp,64
 5a4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5a6:	c299                	beqz	a3,5ac <printint+0x16>
 5a8:	0805c063          	bltz	a1,628 <printint+0x92>
  neg = 0;
 5ac:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 5ae:	fc040313          	addi	t1,s0,-64
  neg = 0;
 5b2:	869a                	mv	a3,t1
  i = 0;
 5b4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 5b6:	00000817          	auipc	a6,0x0
 5ba:	59a80813          	addi	a6,a6,1434 # b50 <digits>
 5be:	88be                	mv	a7,a5
 5c0:	0017851b          	addiw	a0,a5,1
 5c4:	87aa                	mv	a5,a0
 5c6:	02c5f73b          	remuw	a4,a1,a2
 5ca:	1702                	slli	a4,a4,0x20
 5cc:	9301                	srli	a4,a4,0x20
 5ce:	9742                	add	a4,a4,a6
 5d0:	00074703          	lbu	a4,0(a4)
 5d4:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5d8:	872e                	mv	a4,a1
 5da:	02c5d5bb          	divuw	a1,a1,a2
 5de:	0685                	addi	a3,a3,1
 5e0:	fcc77fe3          	bgeu	a4,a2,5be <printint+0x28>
  if(neg)
 5e4:	000e0c63          	beqz	t3,5fc <printint+0x66>
    buf[i++] = '-';
 5e8:	fd050793          	addi	a5,a0,-48
 5ec:	00878533          	add	a0,a5,s0
 5f0:	02d00793          	li	a5,45
 5f4:	fef50823          	sb	a5,-16(a0)
 5f8:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 5fc:	fff7899b          	addiw	s3,a5,-1
 600:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 604:	fff4c583          	lbu	a1,-1(s1)
 608:	854a                	mv	a0,s2
 60a:	00000097          	auipc	ra,0x0
 60e:	f6a080e7          	jalr	-150(ra) # 574 <putc>
  while(--i >= 0)
 612:	39fd                	addiw	s3,s3,-1
 614:	14fd                	addi	s1,s1,-1
 616:	fe09d7e3          	bgez	s3,604 <printint+0x6e>
}
 61a:	70e2                	ld	ra,56(sp)
 61c:	7442                	ld	s0,48(sp)
 61e:	74a2                	ld	s1,40(sp)
 620:	7902                	ld	s2,32(sp)
 622:	69e2                	ld	s3,24(sp)
 624:	6121                	addi	sp,sp,64
 626:	8082                	ret
    x = -xx;
 628:	40b005bb          	negw	a1,a1
    neg = 1;
 62c:	4e05                	li	t3,1
    x = -xx;
 62e:	b741                	j	5ae <printint+0x18>

0000000000000630 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 630:	715d                	addi	sp,sp,-80
 632:	e486                	sd	ra,72(sp)
 634:	e0a2                	sd	s0,64(sp)
 636:	f84a                	sd	s2,48(sp)
 638:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 63a:	0005c903          	lbu	s2,0(a1)
 63e:	1a090a63          	beqz	s2,7f2 <vprintf+0x1c2>
 642:	fc26                	sd	s1,56(sp)
 644:	f44e                	sd	s3,40(sp)
 646:	f052                	sd	s4,32(sp)
 648:	ec56                	sd	s5,24(sp)
 64a:	e85a                	sd	s6,16(sp)
 64c:	e45e                	sd	s7,8(sp)
 64e:	8aaa                	mv	s5,a0
 650:	8bb2                	mv	s7,a2
 652:	00158493          	addi	s1,a1,1
  state = 0;
 656:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 658:	02500a13          	li	s4,37
 65c:	4b55                	li	s6,21
 65e:	a839                	j	67c <vprintf+0x4c>
        putc(fd, c);
 660:	85ca                	mv	a1,s2
 662:	8556                	mv	a0,s5
 664:	00000097          	auipc	ra,0x0
 668:	f10080e7          	jalr	-240(ra) # 574 <putc>
 66c:	a019                	j	672 <vprintf+0x42>
    } else if(state == '%'){
 66e:	01498d63          	beq	s3,s4,688 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 672:	0485                	addi	s1,s1,1
 674:	fff4c903          	lbu	s2,-1(s1)
 678:	16090763          	beqz	s2,7e6 <vprintf+0x1b6>
    if(state == 0){
 67c:	fe0999e3          	bnez	s3,66e <vprintf+0x3e>
      if(c == '%'){
 680:	ff4910e3          	bne	s2,s4,660 <vprintf+0x30>
        state = '%';
 684:	89d2                	mv	s3,s4
 686:	b7f5                	j	672 <vprintf+0x42>
      if(c == 'd'){
 688:	13490463          	beq	s2,s4,7b0 <vprintf+0x180>
 68c:	f9d9079b          	addiw	a5,s2,-99
 690:	0ff7f793          	zext.b	a5,a5
 694:	12fb6763          	bltu	s6,a5,7c2 <vprintf+0x192>
 698:	f9d9079b          	addiw	a5,s2,-99
 69c:	0ff7f713          	zext.b	a4,a5
 6a0:	12eb6163          	bltu	s6,a4,7c2 <vprintf+0x192>
 6a4:	00271793          	slli	a5,a4,0x2
 6a8:	00000717          	auipc	a4,0x0
 6ac:	45070713          	addi	a4,a4,1104 # af8 <malloc+0x212>
 6b0:	97ba                	add	a5,a5,a4
 6b2:	439c                	lw	a5,0(a5)
 6b4:	97ba                	add	a5,a5,a4
 6b6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 6b8:	008b8913          	addi	s2,s7,8
 6bc:	4685                	li	a3,1
 6be:	4629                	li	a2,10
 6c0:	000ba583          	lw	a1,0(s7)
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	ed0080e7          	jalr	-304(ra) # 596 <printint>
 6ce:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	b745                	j	672 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d4:	008b8913          	addi	s2,s7,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000ba583          	lw	a1,0(s7)
 6e0:	8556                	mv	a0,s5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	eb4080e7          	jalr	-332(ra) # 596 <printint>
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	b751                	j	672 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	000ba583          	lw	a1,0(s7)
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	e98080e7          	jalr	-360(ra) # 596 <printint>
 706:	8bca                	mv	s7,s2
      state = 0;
 708:	4981                	li	s3,0
 70a:	b7a5                	j	672 <vprintf+0x42>
 70c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 70e:	008b8c13          	addi	s8,s7,8
 712:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 716:	03000593          	li	a1,48
 71a:	8556                	mv	a0,s5
 71c:	00000097          	auipc	ra,0x0
 720:	e58080e7          	jalr	-424(ra) # 574 <putc>
  putc(fd, 'x');
 724:	07800593          	li	a1,120
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e4a080e7          	jalr	-438(ra) # 574 <putc>
 732:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 734:	00000b97          	auipc	s7,0x0
 738:	41cb8b93          	addi	s7,s7,1052 # b50 <digits>
 73c:	03c9d793          	srli	a5,s3,0x3c
 740:	97de                	add	a5,a5,s7
 742:	0007c583          	lbu	a1,0(a5)
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	e2c080e7          	jalr	-468(ra) # 574 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 750:	0992                	slli	s3,s3,0x4
 752:	397d                	addiw	s2,s2,-1
 754:	fe0914e3          	bnez	s2,73c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 758:	8be2                	mv	s7,s8
      state = 0;
 75a:	4981                	li	s3,0
 75c:	6c02                	ld	s8,0(sp)
 75e:	bf11                	j	672 <vprintf+0x42>
        s = va_arg(ap, char*);
 760:	008b8993          	addi	s3,s7,8
 764:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 768:	02090163          	beqz	s2,78a <vprintf+0x15a>
        while(*s != 0){
 76c:	00094583          	lbu	a1,0(s2)
 770:	c9a5                	beqz	a1,7e0 <vprintf+0x1b0>
          putc(fd, *s);
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	e00080e7          	jalr	-512(ra) # 574 <putc>
          s++;
 77c:	0905                	addi	s2,s2,1
        while(*s != 0){
 77e:	00094583          	lbu	a1,0(s2)
 782:	f9e5                	bnez	a1,772 <vprintf+0x142>
        s = va_arg(ap, char*);
 784:	8bce                	mv	s7,s3
      state = 0;
 786:	4981                	li	s3,0
 788:	b5ed                	j	672 <vprintf+0x42>
          s = "(null)";
 78a:	00000917          	auipc	s2,0x0
 78e:	36690913          	addi	s2,s2,870 # af0 <malloc+0x20a>
        while(*s != 0){
 792:	02800593          	li	a1,40
 796:	bff1                	j	772 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 798:	008b8913          	addi	s2,s7,8
 79c:	000bc583          	lbu	a1,0(s7)
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	dd2080e7          	jalr	-558(ra) # 574 <putc>
 7aa:	8bca                	mv	s7,s2
      state = 0;
 7ac:	4981                	li	s3,0
 7ae:	b5d1                	j	672 <vprintf+0x42>
        putc(fd, c);
 7b0:	02500593          	li	a1,37
 7b4:	8556                	mv	a0,s5
 7b6:	00000097          	auipc	ra,0x0
 7ba:	dbe080e7          	jalr	-578(ra) # 574 <putc>
      state = 0;
 7be:	4981                	li	s3,0
 7c0:	bd4d                	j	672 <vprintf+0x42>
        putc(fd, '%');
 7c2:	02500593          	li	a1,37
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	dac080e7          	jalr	-596(ra) # 574 <putc>
        putc(fd, c);
 7d0:	85ca                	mv	a1,s2
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	da0080e7          	jalr	-608(ra) # 574 <putc>
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bd51                	j	672 <vprintf+0x42>
        s = va_arg(ap, char*);
 7e0:	8bce                	mv	s7,s3
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	b579                	j	672 <vprintf+0x42>
 7e6:	74e2                	ld	s1,56(sp)
 7e8:	79a2                	ld	s3,40(sp)
 7ea:	7a02                	ld	s4,32(sp)
 7ec:	6ae2                	ld	s5,24(sp)
 7ee:	6b42                	ld	s6,16(sp)
 7f0:	6ba2                	ld	s7,8(sp)
    }
  }
}
 7f2:	60a6                	ld	ra,72(sp)
 7f4:	6406                	ld	s0,64(sp)
 7f6:	7942                	ld	s2,48(sp)
 7f8:	6161                	addi	sp,sp,80
 7fa:	8082                	ret

00000000000007fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7fc:	715d                	addi	sp,sp,-80
 7fe:	ec06                	sd	ra,24(sp)
 800:	e822                	sd	s0,16(sp)
 802:	1000                	addi	s0,sp,32
 804:	e010                	sd	a2,0(s0)
 806:	e414                	sd	a3,8(s0)
 808:	e818                	sd	a4,16(s0)
 80a:	ec1c                	sd	a5,24(s0)
 80c:	03043023          	sd	a6,32(s0)
 810:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 814:	8622                	mv	a2,s0
 816:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 81a:	00000097          	auipc	ra,0x0
 81e:	e16080e7          	jalr	-490(ra) # 630 <vprintf>
}
 822:	60e2                	ld	ra,24(sp)
 824:	6442                	ld	s0,16(sp)
 826:	6161                	addi	sp,sp,80
 828:	8082                	ret

000000000000082a <printf>:

void
printf(const char *fmt, ...)
{
 82a:	711d                	addi	sp,sp,-96
 82c:	ec06                	sd	ra,24(sp)
 82e:	e822                	sd	s0,16(sp)
 830:	1000                	addi	s0,sp,32
 832:	e40c                	sd	a1,8(s0)
 834:	e810                	sd	a2,16(s0)
 836:	ec14                	sd	a3,24(s0)
 838:	f018                	sd	a4,32(s0)
 83a:	f41c                	sd	a5,40(s0)
 83c:	03043823          	sd	a6,48(s0)
 840:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 844:	00840613          	addi	a2,s0,8
 848:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 84c:	85aa                	mv	a1,a0
 84e:	4505                	li	a0,1
 850:	00000097          	auipc	ra,0x0
 854:	de0080e7          	jalr	-544(ra) # 630 <vprintf>
}
 858:	60e2                	ld	ra,24(sp)
 85a:	6442                	ld	s0,16(sp)
 85c:	6125                	addi	sp,sp,96
 85e:	8082                	ret

0000000000000860 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 860:	1141                	addi	sp,sp,-16
 862:	e406                	sd	ra,8(sp)
 864:	e022                	sd	s0,0(sp)
 866:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 868:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 86c:	00000797          	auipc	a5,0x0
 870:	3047b783          	ld	a5,772(a5) # b70 <freep>
 874:	a02d                	j	89e <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 876:	4618                	lw	a4,8(a2)
 878:	9f2d                	addw	a4,a4,a1
 87a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 87e:	6398                	ld	a4,0(a5)
 880:	6310                	ld	a2,0(a4)
 882:	a83d                	j	8c0 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 884:	ff852703          	lw	a4,-8(a0)
 888:	9f31                	addw	a4,a4,a2
 88a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 88c:	ff053683          	ld	a3,-16(a0)
 890:	a091                	j	8d4 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 892:	6398                	ld	a4,0(a5)
 894:	00e7e463          	bltu	a5,a4,89c <free+0x3c>
 898:	00e6ea63          	bltu	a3,a4,8ac <free+0x4c>
{
 89c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89e:	fed7fae3          	bgeu	a5,a3,892 <free+0x32>
 8a2:	6398                	ld	a4,0(a5)
 8a4:	00e6e463          	bltu	a3,a4,8ac <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a8:	fee7eae3          	bltu	a5,a4,89c <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 8ac:	ff852583          	lw	a1,-8(a0)
 8b0:	6390                	ld	a2,0(a5)
 8b2:	02059813          	slli	a6,a1,0x20
 8b6:	01c85713          	srli	a4,a6,0x1c
 8ba:	9736                	add	a4,a4,a3
 8bc:	fae60de3          	beq	a2,a4,876 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 8c0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c4:	4790                	lw	a2,8(a5)
 8c6:	02061593          	slli	a1,a2,0x20
 8ca:	01c5d713          	srli	a4,a1,0x1c
 8ce:	973e                	add	a4,a4,a5
 8d0:	fae68ae3          	beq	a3,a4,884 <free+0x24>
    p->s.ptr = bp->s.ptr;
 8d4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8d6:	00000717          	auipc	a4,0x0
 8da:	28f73d23          	sd	a5,666(a4) # b70 <freep>
}
 8de:	60a2                	ld	ra,8(sp)
 8e0:	6402                	ld	s0,0(sp)
 8e2:	0141                	addi	sp,sp,16
 8e4:	8082                	ret

00000000000008e6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e6:	7139                	addi	sp,sp,-64
 8e8:	fc06                	sd	ra,56(sp)
 8ea:	f822                	sd	s0,48(sp)
 8ec:	f04a                	sd	s2,32(sp)
 8ee:	ec4e                	sd	s3,24(sp)
 8f0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f2:	02051993          	slli	s3,a0,0x20
 8f6:	0209d993          	srli	s3,s3,0x20
 8fa:	09bd                	addi	s3,s3,15
 8fc:	0049d993          	srli	s3,s3,0x4
 900:	2985                	addiw	s3,s3,1
 902:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 904:	00000517          	auipc	a0,0x0
 908:	26c53503          	ld	a0,620(a0) # b70 <freep>
 90c:	c905                	beqz	a0,93c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 910:	4798                	lw	a4,8(a5)
 912:	09377a63          	bgeu	a4,s3,9a6 <malloc+0xc0>
 916:	f426                	sd	s1,40(sp)
 918:	e852                	sd	s4,16(sp)
 91a:	e456                	sd	s5,8(sp)
 91c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 91e:	8a4e                	mv	s4,s3
 920:	6705                	lui	a4,0x1
 922:	00e9f363          	bgeu	s3,a4,928 <malloc+0x42>
 926:	6a05                	lui	s4,0x1
 928:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 92c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 930:	00000497          	auipc	s1,0x0
 934:	24048493          	addi	s1,s1,576 # b70 <freep>
  if(p == (char*)-1)
 938:	5afd                	li	s5,-1
 93a:	a089                	j	97c <malloc+0x96>
 93c:	f426                	sd	s1,40(sp)
 93e:	e852                	sd	s4,16(sp)
 940:	e456                	sd	s5,8(sp)
 942:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 944:	00000797          	auipc	a5,0x0
 948:	23478793          	addi	a5,a5,564 # b78 <base>
 94c:	00000717          	auipc	a4,0x0
 950:	22f73223          	sd	a5,548(a4) # b70 <freep>
 954:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 956:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 95a:	b7d1                	j	91e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 95c:	6398                	ld	a4,0(a5)
 95e:	e118                	sd	a4,0(a0)
 960:	a8b9                	j	9be <malloc+0xd8>
  hp->s.size = nu;
 962:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 966:	0541                	addi	a0,a0,16
 968:	00000097          	auipc	ra,0x0
 96c:	ef8080e7          	jalr	-264(ra) # 860 <free>
  return freep;
 970:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 972:	c135                	beqz	a0,9d6 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 974:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 976:	4798                	lw	a4,8(a5)
 978:	03277363          	bgeu	a4,s2,99e <malloc+0xb8>
    if(p == freep)
 97c:	6098                	ld	a4,0(s1)
 97e:	853e                	mv	a0,a5
 980:	fef71ae3          	bne	a4,a5,974 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 984:	8552                	mv	a0,s4
 986:	00000097          	auipc	ra,0x0
 98a:	bc6080e7          	jalr	-1082(ra) # 54c <sbrk>
  if(p == (char*)-1)
 98e:	fd551ae3          	bne	a0,s5,962 <malloc+0x7c>
        return 0;
 992:	4501                	li	a0,0
 994:	74a2                	ld	s1,40(sp)
 996:	6a42                	ld	s4,16(sp)
 998:	6aa2                	ld	s5,8(sp)
 99a:	6b02                	ld	s6,0(sp)
 99c:	a03d                	j	9ca <malloc+0xe4>
 99e:	74a2                	ld	s1,40(sp)
 9a0:	6a42                	ld	s4,16(sp)
 9a2:	6aa2                	ld	s5,8(sp)
 9a4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9a6:	fae90be3          	beq	s2,a4,95c <malloc+0x76>
        p->s.size -= nunits;
 9aa:	4137073b          	subw	a4,a4,s3
 9ae:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9b0:	02071693          	slli	a3,a4,0x20
 9b4:	01c6d713          	srli	a4,a3,0x1c
 9b8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ba:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9be:	00000717          	auipc	a4,0x0
 9c2:	1aa73923          	sd	a0,434(a4) # b70 <freep>
      return (void*)(p + 1);
 9c6:	01078513          	addi	a0,a5,16
  }
}
 9ca:	70e2                	ld	ra,56(sp)
 9cc:	7442                	ld	s0,48(sp)
 9ce:	7902                	ld	s2,32(sp)
 9d0:	69e2                	ld	s3,24(sp)
 9d2:	6121                	addi	sp,sp,64
 9d4:	8082                	ret
 9d6:	74a2                	ld	s1,40(sp)
 9d8:	6a42                	ld	s4,16(sp)
 9da:	6aa2                	ld	s5,8(sp)
 9dc:	6b02                	ld	s6,0(sp)
 9de:	b7f5                	j	9ca <malloc+0xe4>
