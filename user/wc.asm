
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	a02d8d93          	addi	s11,s11,-1534 # a30 <buf>
  36:	20000d13          	li	s10,512
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  3a:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  3c:	00001a17          	auipc	s4,0x1
  40:	92ca0a13          	addi	s4,s4,-1748 # 968 <malloc+0xfc>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  44:	a805                	j	74 <wc+0x74>
      if(strchr(" \r\t\n\v", buf[i]))
  46:	8552                	mv	a0,s4
  48:	00000097          	auipc	ra,0x0
  4c:	1ec080e7          	jalr	492(ra) # 234 <strchr>
  50:	c919                	beqz	a0,66 <wc+0x66>
        inword = 0;
  52:	4901                	li	s2,0
    for(i=0; i<n; i++){
  54:	0485                	addi	s1,s1,1
  56:	01348d63          	beq	s1,s3,70 <wc+0x70>
      if(buf[i] == '\n')
  5a:	0004c583          	lbu	a1,0(s1)
  5e:	ff5594e3          	bne	a1,s5,46 <wc+0x46>
        l++;
  62:	2b85                	addiw	s7,s7,1
  64:	b7cd                	j	46 <wc+0x46>
      else if(!inword){
  66:	fe0917e3          	bnez	s2,54 <wc+0x54>
        w++;
  6a:	2c05                	addiw	s8,s8,1
        inword = 1;
  6c:	4905                	li	s2,1
  6e:	b7dd                	j	54 <wc+0x54>
  70:	019b0cbb          	addw	s9,s6,s9
  while((n = read(fd, buf, sizeof(buf))) > 0){
  74:	866a                	mv	a2,s10
  76:	85ee                	mv	a1,s11
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	3e6080e7          	jalr	998(ra) # 462 <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
  8a:	00001497          	auipc	s1,0x1
  8e:	9a648493          	addi	s1,s1,-1626 # a30 <buf>
  92:	009b09b3          	add	s3,s6,s1
  96:	b7d1                	j	5a <wc+0x5a>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86e6                	mv	a3,s9
  a2:	8662                	mv	a2,s8
  a4:	85de                	mv	a1,s7
  a6:	00001517          	auipc	a0,0x1
  aa:	8e250513          	addi	a0,a0,-1822 # 988 <malloc+0x11c>
  ae:	00000097          	auipc	ra,0x0
  b2:	702080e7          	jalr	1794(ra) # 7b0 <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	addi	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	8a450513          	addi	a0,a0,-1884 # 978 <malloc+0x10c>
  dc:	00000097          	auipc	ra,0x0
  e0:	6d4080e7          	jalr	1748(ra) # 7b0 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	364080e7          	jalr	868(ra) # 44a <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	addi	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  f6:	4785                	li	a5,1
  f8:	04a7dc63          	bge	a5,a0,150 <main+0x62>
  fc:	ec26                	sd	s1,24(sp)
  fe:	e84a                	sd	s2,16(sp)
 100:	e44e                	sd	s3,8(sp)
 102:	00858913          	addi	s2,a1,8
 106:	ffe5099b          	addiw	s3,a0,-2
 10a:	02099793          	slli	a5,s3,0x20
 10e:	01d7d993          	srli	s3,a5,0x1d
 112:	05c1                	addi	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	36e080e7          	jalr	878(ra) # 48a <open>
 124:	84aa                	mv	s1,a0
 126:	04054663          	bltz	a0,172 <main+0x84>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	33a080e7          	jalr	826(ra) # 472 <close>
  for(i = 1; i < argc; i++){
 140:	0921                	addi	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	302080e7          	jalr	770(ra) # 44a <exit>
 150:	ec26                	sd	s1,24(sp)
 152:	e84a                	sd	s2,16(sp)
 154:	e44e                	sd	s3,8(sp)
    wc(0, "");
 156:	00001597          	auipc	a1,0x1
 15a:	81a58593          	addi	a1,a1,-2022 # 970 <malloc+0x104>
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	ea0080e7          	jalr	-352(ra) # 0 <wc>
    exit(0);
 168:	4501                	li	a0,0
 16a:	00000097          	auipc	ra,0x0
 16e:	2e0080e7          	jalr	736(ra) # 44a <exit>
      printf("wc: cannot open %s\n", argv[i]);
 172:	00093583          	ld	a1,0(s2)
 176:	00001517          	auipc	a0,0x1
 17a:	82250513          	addi	a0,a0,-2014 # 998 <malloc+0x12c>
 17e:	00000097          	auipc	ra,0x0
 182:	632080e7          	jalr	1586(ra) # 7b0 <printf>
      exit(1);
 186:	4505                	li	a0,1
 188:	00000097          	auipc	ra,0x0
 18c:	2c2080e7          	jalr	706(ra) # 44a <exit>

0000000000000190 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 190:	1141                	addi	sp,sp,-16
 192:	e406                	sd	ra,8(sp)
 194:	e022                	sd	s0,0(sp)
 196:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 198:	87aa                	mv	a5,a0
 19a:	0585                	addi	a1,a1,1
 19c:	0785                	addi	a5,a5,1
 19e:	fff5c703          	lbu	a4,-1(a1)
 1a2:	fee78fa3          	sb	a4,-1(a5)
 1a6:	fb75                	bnez	a4,19a <strcpy+0xa>
    ;
  return os;
}
 1a8:	60a2                	ld	ra,8(sp)
 1aa:	6402                	ld	s0,0(sp)
 1ac:	0141                	addi	sp,sp,16
 1ae:	8082                	ret

00000000000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	1141                	addi	sp,sp,-16
 1b2:	e406                	sd	ra,8(sp)
 1b4:	e022                	sd	s0,0(sp)
 1b6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	cb91                	beqz	a5,1d0 <strcmp+0x20>
 1be:	0005c703          	lbu	a4,0(a1)
 1c2:	00f71763          	bne	a4,a5,1d0 <strcmp+0x20>
    p++, q++;
 1c6:	0505                	addi	a0,a0,1
 1c8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	fbe5                	bnez	a5,1be <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1d0:	0005c503          	lbu	a0,0(a1)
}
 1d4:	40a7853b          	subw	a0,a5,a0
 1d8:	60a2                	ld	ra,8(sp)
 1da:	6402                	ld	s0,0(sp)
 1dc:	0141                	addi	sp,sp,16
 1de:	8082                	ret

00000000000001e0 <strlen>:

uint
strlen(const char *s)
{
 1e0:	1141                	addi	sp,sp,-16
 1e2:	e406                	sd	ra,8(sp)
 1e4:	e022                	sd	s0,0(sp)
 1e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	cf99                	beqz	a5,20a <strlen+0x2a>
 1ee:	0505                	addi	a0,a0,1
 1f0:	87aa                	mv	a5,a0
 1f2:	86be                	mv	a3,a5
 1f4:	0785                	addi	a5,a5,1
 1f6:	fff7c703          	lbu	a4,-1(a5)
 1fa:	ff65                	bnez	a4,1f2 <strlen+0x12>
 1fc:	40a6853b          	subw	a0,a3,a0
 200:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 202:	60a2                	ld	ra,8(sp)
 204:	6402                	ld	s0,0(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret
  for(n = 0; s[n]; n++)
 20a:	4501                	li	a0,0
 20c:	bfdd                	j	202 <strlen+0x22>

000000000000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e406                	sd	ra,8(sp)
 212:	e022                	sd	s0,0(sp)
 214:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 216:	ca19                	beqz	a2,22c <memset+0x1e>
 218:	87aa                	mv	a5,a0
 21a:	1602                	slli	a2,a2,0x20
 21c:	9201                	srli	a2,a2,0x20
 21e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 222:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 226:	0785                	addi	a5,a5,1
 228:	fee79de3          	bne	a5,a4,222 <memset+0x14>
  }
  return dst;
}
 22c:	60a2                	ld	ra,8(sp)
 22e:	6402                	ld	s0,0(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret

0000000000000234 <strchr>:

char*
strchr(const char *s, char c)
{
 234:	1141                	addi	sp,sp,-16
 236:	e406                	sd	ra,8(sp)
 238:	e022                	sd	s0,0(sp)
 23a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 23c:	00054783          	lbu	a5,0(a0)
 240:	cf81                	beqz	a5,258 <strchr+0x24>
    if(*s == c)
 242:	00f58763          	beq	a1,a5,250 <strchr+0x1c>
  for(; *s; s++)
 246:	0505                	addi	a0,a0,1
 248:	00054783          	lbu	a5,0(a0)
 24c:	fbfd                	bnez	a5,242 <strchr+0xe>
      return (char*)s;
  return 0;
 24e:	4501                	li	a0,0
}
 250:	60a2                	ld	ra,8(sp)
 252:	6402                	ld	s0,0(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret
  return 0;
 258:	4501                	li	a0,0
 25a:	bfdd                	j	250 <strchr+0x1c>

000000000000025c <gets>:

char*
gets(char *buf, int max)
{
 25c:	7159                	addi	sp,sp,-112
 25e:	f486                	sd	ra,104(sp)
 260:	f0a2                	sd	s0,96(sp)
 262:	eca6                	sd	s1,88(sp)
 264:	e8ca                	sd	s2,80(sp)
 266:	e4ce                	sd	s3,72(sp)
 268:	e0d2                	sd	s4,64(sp)
 26a:	fc56                	sd	s5,56(sp)
 26c:	f85a                	sd	s6,48(sp)
 26e:	f45e                	sd	s7,40(sp)
 270:	f062                	sd	s8,32(sp)
 272:	ec66                	sd	s9,24(sp)
 274:	e86a                	sd	s10,16(sp)
 276:	1880                	addi	s0,sp,112
 278:	8caa                	mv	s9,a0
 27a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27c:	892a                	mv	s2,a0
 27e:	4481                	li	s1,0
    cc = read(0, &c, 1);
 280:	f9f40b13          	addi	s6,s0,-97
 284:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 286:	4ba9                	li	s7,10
 288:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 28a:	8d26                	mv	s10,s1
 28c:	0014899b          	addiw	s3,s1,1
 290:	84ce                	mv	s1,s3
 292:	0349d763          	bge	s3,s4,2c0 <gets+0x64>
    cc = read(0, &c, 1);
 296:	8656                	mv	a2,s5
 298:	85da                	mv	a1,s6
 29a:	4501                	li	a0,0
 29c:	00000097          	auipc	ra,0x0
 2a0:	1c6080e7          	jalr	454(ra) # 462 <read>
    if(cc < 1)
 2a4:	00a05e63          	blez	a0,2c0 <gets+0x64>
    buf[i++] = c;
 2a8:	f9f44783          	lbu	a5,-97(s0)
 2ac:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b0:	01778763          	beq	a5,s7,2be <gets+0x62>
 2b4:	0905                	addi	s2,s2,1
 2b6:	fd879ae3          	bne	a5,s8,28a <gets+0x2e>
    buf[i++] = c;
 2ba:	8d4e                	mv	s10,s3
 2bc:	a011                	j	2c0 <gets+0x64>
 2be:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 2c0:	9d66                	add	s10,s10,s9
 2c2:	000d0023          	sb	zero,0(s10)
  return buf;
}
 2c6:	8566                	mv	a0,s9
 2c8:	70a6                	ld	ra,104(sp)
 2ca:	7406                	ld	s0,96(sp)
 2cc:	64e6                	ld	s1,88(sp)
 2ce:	6946                	ld	s2,80(sp)
 2d0:	69a6                	ld	s3,72(sp)
 2d2:	6a06                	ld	s4,64(sp)
 2d4:	7ae2                	ld	s5,56(sp)
 2d6:	7b42                	ld	s6,48(sp)
 2d8:	7ba2                	ld	s7,40(sp)
 2da:	7c02                	ld	s8,32(sp)
 2dc:	6ce2                	ld	s9,24(sp)
 2de:	6d42                	ld	s10,16(sp)
 2e0:	6165                	addi	sp,sp,112
 2e2:	8082                	ret

00000000000002e4 <stat>:

int
stat(const char *n, struct stat *st)
{
 2e4:	1101                	addi	sp,sp,-32
 2e6:	ec06                	sd	ra,24(sp)
 2e8:	e822                	sd	s0,16(sp)
 2ea:	e04a                	sd	s2,0(sp)
 2ec:	1000                	addi	s0,sp,32
 2ee:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f0:	4581                	li	a1,0
 2f2:	00000097          	auipc	ra,0x0
 2f6:	198080e7          	jalr	408(ra) # 48a <open>
  if(fd < 0)
 2fa:	02054663          	bltz	a0,326 <stat+0x42>
 2fe:	e426                	sd	s1,8(sp)
 300:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 302:	85ca                	mv	a1,s2
 304:	00000097          	auipc	ra,0x0
 308:	19e080e7          	jalr	414(ra) # 4a2 <fstat>
 30c:	892a                	mv	s2,a0
  close(fd);
 30e:	8526                	mv	a0,s1
 310:	00000097          	auipc	ra,0x0
 314:	162080e7          	jalr	354(ra) # 472 <close>
  return r;
 318:	64a2                	ld	s1,8(sp)
}
 31a:	854a                	mv	a0,s2
 31c:	60e2                	ld	ra,24(sp)
 31e:	6442                	ld	s0,16(sp)
 320:	6902                	ld	s2,0(sp)
 322:	6105                	addi	sp,sp,32
 324:	8082                	ret
    return -1;
 326:	597d                	li	s2,-1
 328:	bfcd                	j	31a <stat+0x36>

000000000000032a <atoi>:

int
atoi(const char *s)
{
 32a:	1141                	addi	sp,sp,-16
 32c:	e406                	sd	ra,8(sp)
 32e:	e022                	sd	s0,0(sp)
 330:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 332:	00054683          	lbu	a3,0(a0)
 336:	fd06879b          	addiw	a5,a3,-48
 33a:	0ff7f793          	zext.b	a5,a5
 33e:	4625                	li	a2,9
 340:	02f66963          	bltu	a2,a5,372 <atoi+0x48>
 344:	872a                	mv	a4,a0
  n = 0;
 346:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 348:	0705                	addi	a4,a4,1
 34a:	0025179b          	slliw	a5,a0,0x2
 34e:	9fa9                	addw	a5,a5,a0
 350:	0017979b          	slliw	a5,a5,0x1
 354:	9fb5                	addw	a5,a5,a3
 356:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 35a:	00074683          	lbu	a3,0(a4)
 35e:	fd06879b          	addiw	a5,a3,-48
 362:	0ff7f793          	zext.b	a5,a5
 366:	fef671e3          	bgeu	a2,a5,348 <atoi+0x1e>
  return n;
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret
  n = 0;
 372:	4501                	li	a0,0
 374:	bfdd                	j	36a <atoi+0x40>

0000000000000376 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 376:	1141                	addi	sp,sp,-16
 378:	e406                	sd	ra,8(sp)
 37a:	e022                	sd	s0,0(sp)
 37c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 37e:	02b57563          	bgeu	a0,a1,3a8 <memmove+0x32>
    while(n-- > 0)
 382:	00c05f63          	blez	a2,3a0 <memmove+0x2a>
 386:	1602                	slli	a2,a2,0x20
 388:	9201                	srli	a2,a2,0x20
 38a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 38e:	872a                	mv	a4,a0
      *dst++ = *src++;
 390:	0585                	addi	a1,a1,1
 392:	0705                	addi	a4,a4,1
 394:	fff5c683          	lbu	a3,-1(a1)
 398:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 39c:	fee79ae3          	bne	a5,a4,390 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3a0:	60a2                	ld	ra,8(sp)
 3a2:	6402                	ld	s0,0(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret
    dst += n;
 3a8:	00c50733          	add	a4,a0,a2
    src += n;
 3ac:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ae:	fec059e3          	blez	a2,3a0 <memmove+0x2a>
 3b2:	fff6079b          	addiw	a5,a2,-1
 3b6:	1782                	slli	a5,a5,0x20
 3b8:	9381                	srli	a5,a5,0x20
 3ba:	fff7c793          	not	a5,a5
 3be:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3c0:	15fd                	addi	a1,a1,-1
 3c2:	177d                	addi	a4,a4,-1
 3c4:	0005c683          	lbu	a3,0(a1)
 3c8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3cc:	fef71ae3          	bne	a4,a5,3c0 <memmove+0x4a>
 3d0:	bfc1                	j	3a0 <memmove+0x2a>

00000000000003d2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3d2:	1141                	addi	sp,sp,-16
 3d4:	e406                	sd	ra,8(sp)
 3d6:	e022                	sd	s0,0(sp)
 3d8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3da:	ca0d                	beqz	a2,40c <memcmp+0x3a>
 3dc:	fff6069b          	addiw	a3,a2,-1
 3e0:	1682                	slli	a3,a3,0x20
 3e2:	9281                	srli	a3,a3,0x20
 3e4:	0685                	addi	a3,a3,1
 3e6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e8:	00054783          	lbu	a5,0(a0)
 3ec:	0005c703          	lbu	a4,0(a1)
 3f0:	00e79863          	bne	a5,a4,400 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 3f4:	0505                	addi	a0,a0,1
    p2++;
 3f6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3f8:	fed518e3          	bne	a0,a3,3e8 <memcmp+0x16>
  }
  return 0;
 3fc:	4501                	li	a0,0
 3fe:	a019                	j	404 <memcmp+0x32>
      return *p1 - *p2;
 400:	40e7853b          	subw	a0,a5,a4
}
 404:	60a2                	ld	ra,8(sp)
 406:	6402                	ld	s0,0(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret
  return 0;
 40c:	4501                	li	a0,0
 40e:	bfdd                	j	404 <memcmp+0x32>

0000000000000410 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 410:	1141                	addi	sp,sp,-16
 412:	e406                	sd	ra,8(sp)
 414:	e022                	sd	s0,0(sp)
 416:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 418:	00000097          	auipc	ra,0x0
 41c:	f5e080e7          	jalr	-162(ra) # 376 <memmove>
}
 420:	60a2                	ld	ra,8(sp)
 422:	6402                	ld	s0,0(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret

0000000000000428 <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 428:	1141                	addi	sp,sp,-16
 42a:	e406                	sd	ra,8(sp)
 42c:	e022                	sd	s0,0(sp)
 42e:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 430:	040007b7          	lui	a5,0x4000
 434:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffeddc>
 436:	07b2                	slli	a5,a5,0xc
}
 438:	4388                	lw	a0,0(a5)
 43a:	60a2                	ld	ra,8(sp)
 43c:	6402                	ld	s0,0(sp)
 43e:	0141                	addi	sp,sp,16
 440:	8082                	ret

0000000000000442 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 442:	4885                	li	a7,1
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <exit>:
.global exit
exit:
 li a7, SYS_exit
 44a:	4889                	li	a7,2
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <wait>:
.global wait
wait:
 li a7, SYS_wait
 452:	488d                	li	a7,3
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 45a:	4891                	li	a7,4
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <read>:
.global read
read:
 li a7, SYS_read
 462:	4895                	li	a7,5
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <write>:
.global write
write:
 li a7, SYS_write
 46a:	48c1                	li	a7,16
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <close>:
.global close
close:
 li a7, SYS_close
 472:	48d5                	li	a7,21
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <kill>:
.global kill
kill:
 li a7, SYS_kill
 47a:	4899                	li	a7,6
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <exec>:
.global exec
exec:
 li a7, SYS_exec
 482:	489d                	li	a7,7
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <open>:
.global open
open:
 li a7, SYS_open
 48a:	48bd                	li	a7,15
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 492:	48c5                	li	a7,17
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 49a:	48c9                	li	a7,18
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4a2:	48a1                	li	a7,8
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <link>:
.global link
link:
 li a7, SYS_link
 4aa:	48cd                	li	a7,19
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4b2:	48d1                	li	a7,20
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4ba:	48a5                	li	a7,9
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4c2:	48a9                	li	a7,10
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4ca:	48ad                	li	a7,11
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4d2:	48b1                	li	a7,12
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4da:	48b5                	li	a7,13
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4e2:	48b9                	li	a7,14
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <connect>:
.global connect
connect:
 li a7, SYS_connect
 4ea:	48f5                	li	a7,29
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 4f2:	48f9                	li	a7,30
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4fa:	1101                	addi	sp,sp,-32
 4fc:	ec06                	sd	ra,24(sp)
 4fe:	e822                	sd	s0,16(sp)
 500:	1000                	addi	s0,sp,32
 502:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 506:	4605                	li	a2,1
 508:	fef40593          	addi	a1,s0,-17
 50c:	00000097          	auipc	ra,0x0
 510:	f5e080e7          	jalr	-162(ra) # 46a <write>
}
 514:	60e2                	ld	ra,24(sp)
 516:	6442                	ld	s0,16(sp)
 518:	6105                	addi	sp,sp,32
 51a:	8082                	ret

000000000000051c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 51c:	7139                	addi	sp,sp,-64
 51e:	fc06                	sd	ra,56(sp)
 520:	f822                	sd	s0,48(sp)
 522:	f426                	sd	s1,40(sp)
 524:	f04a                	sd	s2,32(sp)
 526:	ec4e                	sd	s3,24(sp)
 528:	0080                	addi	s0,sp,64
 52a:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 52c:	c299                	beqz	a3,532 <printint+0x16>
 52e:	0805c063          	bltz	a1,5ae <printint+0x92>
  neg = 0;
 532:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 534:	fc040313          	addi	t1,s0,-64
  neg = 0;
 538:	869a                	mv	a3,t1
  i = 0;
 53a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 53c:	00000817          	auipc	a6,0x0
 540:	4d480813          	addi	a6,a6,1236 # a10 <digits>
 544:	88be                	mv	a7,a5
 546:	0017851b          	addiw	a0,a5,1
 54a:	87aa                	mv	a5,a0
 54c:	02c5f73b          	remuw	a4,a1,a2
 550:	1702                	slli	a4,a4,0x20
 552:	9301                	srli	a4,a4,0x20
 554:	9742                	add	a4,a4,a6
 556:	00074703          	lbu	a4,0(a4)
 55a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 55e:	872e                	mv	a4,a1
 560:	02c5d5bb          	divuw	a1,a1,a2
 564:	0685                	addi	a3,a3,1
 566:	fcc77fe3          	bgeu	a4,a2,544 <printint+0x28>
  if(neg)
 56a:	000e0c63          	beqz	t3,582 <printint+0x66>
    buf[i++] = '-';
 56e:	fd050793          	addi	a5,a0,-48
 572:	00878533          	add	a0,a5,s0
 576:	02d00793          	li	a5,45
 57a:	fef50823          	sb	a5,-16(a0)
 57e:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 582:	fff7899b          	addiw	s3,a5,-1
 586:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 58a:	fff4c583          	lbu	a1,-1(s1)
 58e:	854a                	mv	a0,s2
 590:	00000097          	auipc	ra,0x0
 594:	f6a080e7          	jalr	-150(ra) # 4fa <putc>
  while(--i >= 0)
 598:	39fd                	addiw	s3,s3,-1
 59a:	14fd                	addi	s1,s1,-1
 59c:	fe09d7e3          	bgez	s3,58a <printint+0x6e>
}
 5a0:	70e2                	ld	ra,56(sp)
 5a2:	7442                	ld	s0,48(sp)
 5a4:	74a2                	ld	s1,40(sp)
 5a6:	7902                	ld	s2,32(sp)
 5a8:	69e2                	ld	s3,24(sp)
 5aa:	6121                	addi	sp,sp,64
 5ac:	8082                	ret
    x = -xx;
 5ae:	40b005bb          	negw	a1,a1
    neg = 1;
 5b2:	4e05                	li	t3,1
    x = -xx;
 5b4:	b741                	j	534 <printint+0x18>

00000000000005b6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5b6:	715d                	addi	sp,sp,-80
 5b8:	e486                	sd	ra,72(sp)
 5ba:	e0a2                	sd	s0,64(sp)
 5bc:	f84a                	sd	s2,48(sp)
 5be:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c0:	0005c903          	lbu	s2,0(a1)
 5c4:	1a090a63          	beqz	s2,778 <vprintf+0x1c2>
 5c8:	fc26                	sd	s1,56(sp)
 5ca:	f44e                	sd	s3,40(sp)
 5cc:	f052                	sd	s4,32(sp)
 5ce:	ec56                	sd	s5,24(sp)
 5d0:	e85a                	sd	s6,16(sp)
 5d2:	e45e                	sd	s7,8(sp)
 5d4:	8aaa                	mv	s5,a0
 5d6:	8bb2                	mv	s7,a2
 5d8:	00158493          	addi	s1,a1,1
  state = 0;
 5dc:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5de:	02500a13          	li	s4,37
 5e2:	4b55                	li	s6,21
 5e4:	a839                	j	602 <vprintf+0x4c>
        putc(fd, c);
 5e6:	85ca                	mv	a1,s2
 5e8:	8556                	mv	a0,s5
 5ea:	00000097          	auipc	ra,0x0
 5ee:	f10080e7          	jalr	-240(ra) # 4fa <putc>
 5f2:	a019                	j	5f8 <vprintf+0x42>
    } else if(state == '%'){
 5f4:	01498d63          	beq	s3,s4,60e <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5f8:	0485                	addi	s1,s1,1
 5fa:	fff4c903          	lbu	s2,-1(s1)
 5fe:	16090763          	beqz	s2,76c <vprintf+0x1b6>
    if(state == 0){
 602:	fe0999e3          	bnez	s3,5f4 <vprintf+0x3e>
      if(c == '%'){
 606:	ff4910e3          	bne	s2,s4,5e6 <vprintf+0x30>
        state = '%';
 60a:	89d2                	mv	s3,s4
 60c:	b7f5                	j	5f8 <vprintf+0x42>
      if(c == 'd'){
 60e:	13490463          	beq	s2,s4,736 <vprintf+0x180>
 612:	f9d9079b          	addiw	a5,s2,-99
 616:	0ff7f793          	zext.b	a5,a5
 61a:	12fb6763          	bltu	s6,a5,748 <vprintf+0x192>
 61e:	f9d9079b          	addiw	a5,s2,-99
 622:	0ff7f713          	zext.b	a4,a5
 626:	12eb6163          	bltu	s6,a4,748 <vprintf+0x192>
 62a:	00271793          	slli	a5,a4,0x2
 62e:	00000717          	auipc	a4,0x0
 632:	38a70713          	addi	a4,a4,906 # 9b8 <malloc+0x14c>
 636:	97ba                	add	a5,a5,a4
 638:	439c                	lw	a5,0(a5)
 63a:	97ba                	add	a5,a5,a4
 63c:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 63e:	008b8913          	addi	s2,s7,8
 642:	4685                	li	a3,1
 644:	4629                	li	a2,10
 646:	000ba583          	lw	a1,0(s7)
 64a:	8556                	mv	a0,s5
 64c:	00000097          	auipc	ra,0x0
 650:	ed0080e7          	jalr	-304(ra) # 51c <printint>
 654:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 656:	4981                	li	s3,0
 658:	b745                	j	5f8 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 65a:	008b8913          	addi	s2,s7,8
 65e:	4681                	li	a3,0
 660:	4629                	li	a2,10
 662:	000ba583          	lw	a1,0(s7)
 666:	8556                	mv	a0,s5
 668:	00000097          	auipc	ra,0x0
 66c:	eb4080e7          	jalr	-332(ra) # 51c <printint>
 670:	8bca                	mv	s7,s2
      state = 0;
 672:	4981                	li	s3,0
 674:	b751                	j	5f8 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 676:	008b8913          	addi	s2,s7,8
 67a:	4681                	li	a3,0
 67c:	4641                	li	a2,16
 67e:	000ba583          	lw	a1,0(s7)
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	e98080e7          	jalr	-360(ra) # 51c <printint>
 68c:	8bca                	mv	s7,s2
      state = 0;
 68e:	4981                	li	s3,0
 690:	b7a5                	j	5f8 <vprintf+0x42>
 692:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 694:	008b8c13          	addi	s8,s7,8
 698:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 69c:	03000593          	li	a1,48
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	e58080e7          	jalr	-424(ra) # 4fa <putc>
  putc(fd, 'x');
 6aa:	07800593          	li	a1,120
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e4a080e7          	jalr	-438(ra) # 4fa <putc>
 6b8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ba:	00000b97          	auipc	s7,0x0
 6be:	356b8b93          	addi	s7,s7,854 # a10 <digits>
 6c2:	03c9d793          	srli	a5,s3,0x3c
 6c6:	97de                	add	a5,a5,s7
 6c8:	0007c583          	lbu	a1,0(a5)
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e2c080e7          	jalr	-468(ra) # 4fa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d6:	0992                	slli	s3,s3,0x4
 6d8:	397d                	addiw	s2,s2,-1
 6da:	fe0914e3          	bnez	s2,6c2 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6de:	8be2                	mv	s7,s8
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	6c02                	ld	s8,0(sp)
 6e4:	bf11                	j	5f8 <vprintf+0x42>
        s = va_arg(ap, char*);
 6e6:	008b8993          	addi	s3,s7,8
 6ea:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6ee:	02090163          	beqz	s2,710 <vprintf+0x15a>
        while(*s != 0){
 6f2:	00094583          	lbu	a1,0(s2)
 6f6:	c9a5                	beqz	a1,766 <vprintf+0x1b0>
          putc(fd, *s);
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	e00080e7          	jalr	-512(ra) # 4fa <putc>
          s++;
 702:	0905                	addi	s2,s2,1
        while(*s != 0){
 704:	00094583          	lbu	a1,0(s2)
 708:	f9e5                	bnez	a1,6f8 <vprintf+0x142>
        s = va_arg(ap, char*);
 70a:	8bce                	mv	s7,s3
      state = 0;
 70c:	4981                	li	s3,0
 70e:	b5ed                	j	5f8 <vprintf+0x42>
          s = "(null)";
 710:	00000917          	auipc	s2,0x0
 714:	2a090913          	addi	s2,s2,672 # 9b0 <malloc+0x144>
        while(*s != 0){
 718:	02800593          	li	a1,40
 71c:	bff1                	j	6f8 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 71e:	008b8913          	addi	s2,s7,8
 722:	000bc583          	lbu	a1,0(s7)
 726:	8556                	mv	a0,s5
 728:	00000097          	auipc	ra,0x0
 72c:	dd2080e7          	jalr	-558(ra) # 4fa <putc>
 730:	8bca                	mv	s7,s2
      state = 0;
 732:	4981                	li	s3,0
 734:	b5d1                	j	5f8 <vprintf+0x42>
        putc(fd, c);
 736:	02500593          	li	a1,37
 73a:	8556                	mv	a0,s5
 73c:	00000097          	auipc	ra,0x0
 740:	dbe080e7          	jalr	-578(ra) # 4fa <putc>
      state = 0;
 744:	4981                	li	s3,0
 746:	bd4d                	j	5f8 <vprintf+0x42>
        putc(fd, '%');
 748:	02500593          	li	a1,37
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	dac080e7          	jalr	-596(ra) # 4fa <putc>
        putc(fd, c);
 756:	85ca                	mv	a1,s2
 758:	8556                	mv	a0,s5
 75a:	00000097          	auipc	ra,0x0
 75e:	da0080e7          	jalr	-608(ra) # 4fa <putc>
      state = 0;
 762:	4981                	li	s3,0
 764:	bd51                	j	5f8 <vprintf+0x42>
        s = va_arg(ap, char*);
 766:	8bce                	mv	s7,s3
      state = 0;
 768:	4981                	li	s3,0
 76a:	b579                	j	5f8 <vprintf+0x42>
 76c:	74e2                	ld	s1,56(sp)
 76e:	79a2                	ld	s3,40(sp)
 770:	7a02                	ld	s4,32(sp)
 772:	6ae2                	ld	s5,24(sp)
 774:	6b42                	ld	s6,16(sp)
 776:	6ba2                	ld	s7,8(sp)
    }
  }
}
 778:	60a6                	ld	ra,72(sp)
 77a:	6406                	ld	s0,64(sp)
 77c:	7942                	ld	s2,48(sp)
 77e:	6161                	addi	sp,sp,80
 780:	8082                	ret

0000000000000782 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 782:	715d                	addi	sp,sp,-80
 784:	ec06                	sd	ra,24(sp)
 786:	e822                	sd	s0,16(sp)
 788:	1000                	addi	s0,sp,32
 78a:	e010                	sd	a2,0(s0)
 78c:	e414                	sd	a3,8(s0)
 78e:	e818                	sd	a4,16(s0)
 790:	ec1c                	sd	a5,24(s0)
 792:	03043023          	sd	a6,32(s0)
 796:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 79a:	8622                	mv	a2,s0
 79c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a0:	00000097          	auipc	ra,0x0
 7a4:	e16080e7          	jalr	-490(ra) # 5b6 <vprintf>
}
 7a8:	60e2                	ld	ra,24(sp)
 7aa:	6442                	ld	s0,16(sp)
 7ac:	6161                	addi	sp,sp,80
 7ae:	8082                	ret

00000000000007b0 <printf>:

void
printf(const char *fmt, ...)
{
 7b0:	711d                	addi	sp,sp,-96
 7b2:	ec06                	sd	ra,24(sp)
 7b4:	e822                	sd	s0,16(sp)
 7b6:	1000                	addi	s0,sp,32
 7b8:	e40c                	sd	a1,8(s0)
 7ba:	e810                	sd	a2,16(s0)
 7bc:	ec14                	sd	a3,24(s0)
 7be:	f018                	sd	a4,32(s0)
 7c0:	f41c                	sd	a5,40(s0)
 7c2:	03043823          	sd	a6,48(s0)
 7c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ca:	00840613          	addi	a2,s0,8
 7ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7d2:	85aa                	mv	a1,a0
 7d4:	4505                	li	a0,1
 7d6:	00000097          	auipc	ra,0x0
 7da:	de0080e7          	jalr	-544(ra) # 5b6 <vprintf>
}
 7de:	60e2                	ld	ra,24(sp)
 7e0:	6442                	ld	s0,16(sp)
 7e2:	6125                	addi	sp,sp,96
 7e4:	8082                	ret

00000000000007e6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e6:	1141                	addi	sp,sp,-16
 7e8:	e406                	sd	ra,8(sp)
 7ea:	e022                	sd	s0,0(sp)
 7ec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f2:	00000797          	auipc	a5,0x0
 7f6:	2367b783          	ld	a5,566(a5) # a28 <freep>
 7fa:	a02d                	j	824 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7fc:	4618                	lw	a4,8(a2)
 7fe:	9f2d                	addw	a4,a4,a1
 800:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 804:	6398                	ld	a4,0(a5)
 806:	6310                	ld	a2,0(a4)
 808:	a83d                	j	846 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 80a:	ff852703          	lw	a4,-8(a0)
 80e:	9f31                	addw	a4,a4,a2
 810:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 812:	ff053683          	ld	a3,-16(a0)
 816:	a091                	j	85a <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 818:	6398                	ld	a4,0(a5)
 81a:	00e7e463          	bltu	a5,a4,822 <free+0x3c>
 81e:	00e6ea63          	bltu	a3,a4,832 <free+0x4c>
{
 822:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 824:	fed7fae3          	bgeu	a5,a3,818 <free+0x32>
 828:	6398                	ld	a4,0(a5)
 82a:	00e6e463          	bltu	a3,a4,832 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82e:	fee7eae3          	bltu	a5,a4,822 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 832:	ff852583          	lw	a1,-8(a0)
 836:	6390                	ld	a2,0(a5)
 838:	02059813          	slli	a6,a1,0x20
 83c:	01c85713          	srli	a4,a6,0x1c
 840:	9736                	add	a4,a4,a3
 842:	fae60de3          	beq	a2,a4,7fc <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 846:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 84a:	4790                	lw	a2,8(a5)
 84c:	02061593          	slli	a1,a2,0x20
 850:	01c5d713          	srli	a4,a1,0x1c
 854:	973e                	add	a4,a4,a5
 856:	fae68ae3          	beq	a3,a4,80a <free+0x24>
    p->s.ptr = bp->s.ptr;
 85a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 85c:	00000717          	auipc	a4,0x0
 860:	1cf73623          	sd	a5,460(a4) # a28 <freep>
}
 864:	60a2                	ld	ra,8(sp)
 866:	6402                	ld	s0,0(sp)
 868:	0141                	addi	sp,sp,16
 86a:	8082                	ret

000000000000086c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 86c:	7139                	addi	sp,sp,-64
 86e:	fc06                	sd	ra,56(sp)
 870:	f822                	sd	s0,48(sp)
 872:	f04a                	sd	s2,32(sp)
 874:	ec4e                	sd	s3,24(sp)
 876:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 878:	02051993          	slli	s3,a0,0x20
 87c:	0209d993          	srli	s3,s3,0x20
 880:	09bd                	addi	s3,s3,15
 882:	0049d993          	srli	s3,s3,0x4
 886:	2985                	addiw	s3,s3,1
 888:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 88a:	00000517          	auipc	a0,0x0
 88e:	19e53503          	ld	a0,414(a0) # a28 <freep>
 892:	c905                	beqz	a0,8c2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 894:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 896:	4798                	lw	a4,8(a5)
 898:	09377a63          	bgeu	a4,s3,92c <malloc+0xc0>
 89c:	f426                	sd	s1,40(sp)
 89e:	e852                	sd	s4,16(sp)
 8a0:	e456                	sd	s5,8(sp)
 8a2:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8a4:	8a4e                	mv	s4,s3
 8a6:	6705                	lui	a4,0x1
 8a8:	00e9f363          	bgeu	s3,a4,8ae <malloc+0x42>
 8ac:	6a05                	lui	s4,0x1
 8ae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8b2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b6:	00000497          	auipc	s1,0x0
 8ba:	17248493          	addi	s1,s1,370 # a28 <freep>
  if(p == (char*)-1)
 8be:	5afd                	li	s5,-1
 8c0:	a089                	j	902 <malloc+0x96>
 8c2:	f426                	sd	s1,40(sp)
 8c4:	e852                	sd	s4,16(sp)
 8c6:	e456                	sd	s5,8(sp)
 8c8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ca:	00000797          	auipc	a5,0x0
 8ce:	36678793          	addi	a5,a5,870 # c30 <base>
 8d2:	00000717          	auipc	a4,0x0
 8d6:	14f73b23          	sd	a5,342(a4) # a28 <freep>
 8da:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8dc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8e0:	b7d1                	j	8a4 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	e118                	sd	a4,0(a0)
 8e6:	a8b9                	j	944 <malloc+0xd8>
  hp->s.size = nu;
 8e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ec:	0541                	addi	a0,a0,16
 8ee:	00000097          	auipc	ra,0x0
 8f2:	ef8080e7          	jalr	-264(ra) # 7e6 <free>
  return freep;
 8f6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8f8:	c135                	beqz	a0,95c <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8fc:	4798                	lw	a4,8(a5)
 8fe:	03277363          	bgeu	a4,s2,924 <malloc+0xb8>
    if(p == freep)
 902:	6098                	ld	a4,0(s1)
 904:	853e                	mv	a0,a5
 906:	fef71ae3          	bne	a4,a5,8fa <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 90a:	8552                	mv	a0,s4
 90c:	00000097          	auipc	ra,0x0
 910:	bc6080e7          	jalr	-1082(ra) # 4d2 <sbrk>
  if(p == (char*)-1)
 914:	fd551ae3          	bne	a0,s5,8e8 <malloc+0x7c>
        return 0;
 918:	4501                	li	a0,0
 91a:	74a2                	ld	s1,40(sp)
 91c:	6a42                	ld	s4,16(sp)
 91e:	6aa2                	ld	s5,8(sp)
 920:	6b02                	ld	s6,0(sp)
 922:	a03d                	j	950 <malloc+0xe4>
 924:	74a2                	ld	s1,40(sp)
 926:	6a42                	ld	s4,16(sp)
 928:	6aa2                	ld	s5,8(sp)
 92a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 92c:	fae90be3          	beq	s2,a4,8e2 <malloc+0x76>
        p->s.size -= nunits;
 930:	4137073b          	subw	a4,a4,s3
 934:	c798                	sw	a4,8(a5)
        p += p->s.size;
 936:	02071693          	slli	a3,a4,0x20
 93a:	01c6d713          	srli	a4,a3,0x1c
 93e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 940:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 944:	00000717          	auipc	a4,0x0
 948:	0ea73223          	sd	a0,228(a4) # a28 <freep>
      return (void*)(p + 1);
 94c:	01078513          	addi	a0,a5,16
  }
}
 950:	70e2                	ld	ra,56(sp)
 952:	7442                	ld	s0,48(sp)
 954:	7902                	ld	s2,32(sp)
 956:	69e2                	ld	s3,24(sp)
 958:	6121                	addi	sp,sp,64
 95a:	8082                	ret
 95c:	74a2                	ld	s1,40(sp)
 95e:	6a42                	ld	s4,16(sp)
 960:	6aa2                	ld	s5,8(sp)
 962:	6b02                	ld	s6,0(sp)
 964:	b7f5                	j	950 <malloc+0xe4>
