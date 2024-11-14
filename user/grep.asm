
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	711d                	addi	sp,sp,-96
 11c:	ec86                	sd	ra,88(sp)
 11e:	e8a2                	sd	s0,80(sp)
 120:	e4a6                	sd	s1,72(sp)
 122:	e0ca                	sd	s2,64(sp)
 124:	fc4e                	sd	s3,56(sp)
 126:	f852                	sd	s4,48(sp)
 128:	f456                	sd	s5,40(sp)
 12a:	f05a                	sd	s6,32(sp)
 12c:	ec5e                	sd	s7,24(sp)
 12e:	e862                	sd	s8,16(sp)
 130:	e466                	sd	s9,8(sp)
 132:	e06a                	sd	s10,0(sp)
 134:	1080                	addi	s0,sp,96
 136:	8aaa                	mv	s5,a0
 138:	8cae                	mv	s9,a1
  m = 0;
 13a:	4b01                	li	s6,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13c:	3ff00d13          	li	s10,1023
 140:	00001b97          	auipc	s7,0x1
 144:	a00b8b93          	addi	s7,s7,-1536 # b40 <buf>
    while((q = strchr(p, '\n')) != 0){
 148:	49a9                	li	s3,10
        write(1, p, q+1 - p);
 14a:	4c05                	li	s8,1
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 14c:	a099                	j	192 <grep+0x78>
      p = q+1;
 14e:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 152:	85ce                	mv	a1,s3
 154:	854a                	mv	a0,s2
 156:	00000097          	auipc	ra,0x0
 15a:	200080e7          	jalr	512(ra) # 356 <strchr>
 15e:	84aa                	mv	s1,a0
 160:	c51d                	beqz	a0,18e <grep+0x74>
      *q = 0;
 162:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 166:	85ca                	mv	a1,s2
 168:	8556                	mv	a0,s5
 16a:	00000097          	auipc	ra,0x0
 16e:	f62080e7          	jalr	-158(ra) # cc <match>
 172:	dd71                	beqz	a0,14e <grep+0x34>
        *q = '\n';
 174:	01348023          	sb	s3,0(s1)
        write(1, p, q+1 - p);
 178:	00148613          	addi	a2,s1,1
 17c:	4126063b          	subw	a2,a2,s2
 180:	85ca                	mv	a1,s2
 182:	8562                	mv	a0,s8
 184:	00000097          	auipc	ra,0x0
 188:	408080e7          	jalr	1032(ra) # 58c <write>
 18c:	b7c9                	j	14e <grep+0x34>
    if(m > 0){
 18e:	03604663          	bgtz	s6,1ba <grep+0xa0>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 192:	416d063b          	subw	a2,s10,s6
 196:	016b85b3          	add	a1,s7,s6
 19a:	8566                	mv	a0,s9
 19c:	00000097          	auipc	ra,0x0
 1a0:	3e8080e7          	jalr	1000(ra) # 584 <read>
 1a4:	02a05a63          	blez	a0,1d8 <grep+0xbe>
    m += n;
 1a8:	00ab0a3b          	addw	s4,s6,a0
 1ac:	8b52                	mv	s6,s4
    buf[m] = '\0';
 1ae:	014b87b3          	add	a5,s7,s4
 1b2:	00078023          	sb	zero,0(a5)
    p = buf;
 1b6:	895e                	mv	s2,s7
    while((q = strchr(p, '\n')) != 0){
 1b8:	bf69                	j	152 <grep+0x38>
      m -= p - buf;
 1ba:	00001517          	auipc	a0,0x1
 1be:	98650513          	addi	a0,a0,-1658 # b40 <buf>
 1c2:	40a907b3          	sub	a5,s2,a0
 1c6:	40fa063b          	subw	a2,s4,a5
 1ca:	8b32                	mv	s6,a2
      memmove(buf, p, m);
 1cc:	85ca                	mv	a1,s2
 1ce:	00000097          	auipc	ra,0x0
 1d2:	2ca080e7          	jalr	714(ra) # 498 <memmove>
 1d6:	bf75                	j	192 <grep+0x78>
}
 1d8:	60e6                	ld	ra,88(sp)
 1da:	6446                	ld	s0,80(sp)
 1dc:	64a6                	ld	s1,72(sp)
 1de:	6906                	ld	s2,64(sp)
 1e0:	79e2                	ld	s3,56(sp)
 1e2:	7a42                	ld	s4,48(sp)
 1e4:	7aa2                	ld	s5,40(sp)
 1e6:	7b02                	ld	s6,32(sp)
 1e8:	6be2                	ld	s7,24(sp)
 1ea:	6c42                	ld	s8,16(sp)
 1ec:	6ca2                	ld	s9,8(sp)
 1ee:	6d02                	ld	s10,0(sp)
 1f0:	6125                	addi	sp,sp,96
 1f2:	8082                	ret

00000000000001f4 <main>:
{
 1f4:	7179                	addi	sp,sp,-48
 1f6:	f406                	sd	ra,40(sp)
 1f8:	f022                	sd	s0,32(sp)
 1fa:	ec26                	sd	s1,24(sp)
 1fc:	e84a                	sd	s2,16(sp)
 1fe:	e44e                	sd	s3,8(sp)
 200:	e052                	sd	s4,0(sp)
 202:	1800                	addi	s0,sp,48
  if(argc <= 1){
 204:	4785                	li	a5,1
 206:	04a7de63          	bge	a5,a0,262 <main+0x6e>
  pattern = argv[1];
 20a:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 20e:	4789                	li	a5,2
 210:	06a7d763          	bge	a5,a0,27e <main+0x8a>
 214:	01058913          	addi	s2,a1,16
 218:	ffd5099b          	addiw	s3,a0,-3
 21c:	02099793          	slli	a5,s3,0x20
 220:	01d7d993          	srli	s3,a5,0x1d
 224:	05e1                	addi	a1,a1,24
 226:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 228:	4581                	li	a1,0
 22a:	00093503          	ld	a0,0(s2)
 22e:	00000097          	auipc	ra,0x0
 232:	37e080e7          	jalr	894(ra) # 5ac <open>
 236:	84aa                	mv	s1,a0
 238:	04054e63          	bltz	a0,294 <main+0xa0>
    grep(pattern, fd);
 23c:	85aa                	mv	a1,a0
 23e:	8552                	mv	a0,s4
 240:	00000097          	auipc	ra,0x0
 244:	eda080e7          	jalr	-294(ra) # 11a <grep>
    close(fd);
 248:	8526                	mv	a0,s1
 24a:	00000097          	auipc	ra,0x0
 24e:	34a080e7          	jalr	842(ra) # 594 <close>
  for(i = 2; i < argc; i++){
 252:	0921                	addi	s2,s2,8
 254:	fd391ae3          	bne	s2,s3,228 <main+0x34>
  exit(0);
 258:	4501                	li	a0,0
 25a:	00000097          	auipc	ra,0x0
 25e:	312080e7          	jalr	786(ra) # 56c <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 262:	00001597          	auipc	a1,0x1
 266:	82658593          	addi	a1,a1,-2010 # a88 <malloc+0xfa>
 26a:	4509                	li	a0,2
 26c:	00000097          	auipc	ra,0x0
 270:	638080e7          	jalr	1592(ra) # 8a4 <fprintf>
    exit(1);
 274:	4505                	li	a0,1
 276:	00000097          	auipc	ra,0x0
 27a:	2f6080e7          	jalr	758(ra) # 56c <exit>
    grep(pattern, 0);
 27e:	4581                	li	a1,0
 280:	8552                	mv	a0,s4
 282:	00000097          	auipc	ra,0x0
 286:	e98080e7          	jalr	-360(ra) # 11a <grep>
    exit(0);
 28a:	4501                	li	a0,0
 28c:	00000097          	auipc	ra,0x0
 290:	2e0080e7          	jalr	736(ra) # 56c <exit>
      printf("grep: cannot open %s\n", argv[i]);
 294:	00093583          	ld	a1,0(s2)
 298:	00001517          	auipc	a0,0x1
 29c:	81050513          	addi	a0,a0,-2032 # aa8 <malloc+0x11a>
 2a0:	00000097          	auipc	ra,0x0
 2a4:	632080e7          	jalr	1586(ra) # 8d2 <printf>
      exit(1);
 2a8:	4505                	li	a0,1
 2aa:	00000097          	auipc	ra,0x0
 2ae:	2c2080e7          	jalr	706(ra) # 56c <exit>

00000000000002b2 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ba:	87aa                	mv	a5,a0
 2bc:	0585                	addi	a1,a1,1
 2be:	0785                	addi	a5,a5,1
 2c0:	fff5c703          	lbu	a4,-1(a1)
 2c4:	fee78fa3          	sb	a4,-1(a5)
 2c8:	fb75                	bnez	a4,2bc <strcpy+0xa>
    ;
  return os;
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret

00000000000002d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e406                	sd	ra,8(sp)
 2d6:	e022                	sd	s0,0(sp)
 2d8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2da:	00054783          	lbu	a5,0(a0)
 2de:	cb91                	beqz	a5,2f2 <strcmp+0x20>
 2e0:	0005c703          	lbu	a4,0(a1)
 2e4:	00f71763          	bne	a4,a5,2f2 <strcmp+0x20>
    p++, q++;
 2e8:	0505                	addi	a0,a0,1
 2ea:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ec:	00054783          	lbu	a5,0(a0)
 2f0:	fbe5                	bnez	a5,2e0 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2f2:	0005c503          	lbu	a0,0(a1)
}
 2f6:	40a7853b          	subw	a0,a5,a0
 2fa:	60a2                	ld	ra,8(sp)
 2fc:	6402                	ld	s0,0(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret

0000000000000302 <strlen>:

uint
strlen(const char *s)
{
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 30a:	00054783          	lbu	a5,0(a0)
 30e:	cf99                	beqz	a5,32c <strlen+0x2a>
 310:	0505                	addi	a0,a0,1
 312:	87aa                	mv	a5,a0
 314:	86be                	mv	a3,a5
 316:	0785                	addi	a5,a5,1
 318:	fff7c703          	lbu	a4,-1(a5)
 31c:	ff65                	bnez	a4,314 <strlen+0x12>
 31e:	40a6853b          	subw	a0,a3,a0
 322:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 324:	60a2                	ld	ra,8(sp)
 326:	6402                	ld	s0,0(sp)
 328:	0141                	addi	sp,sp,16
 32a:	8082                	ret
  for(n = 0; s[n]; n++)
 32c:	4501                	li	a0,0
 32e:	bfdd                	j	324 <strlen+0x22>

0000000000000330 <memset>:

void*
memset(void *dst, int c, uint n)
{
 330:	1141                	addi	sp,sp,-16
 332:	e406                	sd	ra,8(sp)
 334:	e022                	sd	s0,0(sp)
 336:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 338:	ca19                	beqz	a2,34e <memset+0x1e>
 33a:	87aa                	mv	a5,a0
 33c:	1602                	slli	a2,a2,0x20
 33e:	9201                	srli	a2,a2,0x20
 340:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 344:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 348:	0785                	addi	a5,a5,1
 34a:	fee79de3          	bne	a5,a4,344 <memset+0x14>
  }
  return dst;
}
 34e:	60a2                	ld	ra,8(sp)
 350:	6402                	ld	s0,0(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <strchr>:

char*
strchr(const char *s, char c)
{
 356:	1141                	addi	sp,sp,-16
 358:	e406                	sd	ra,8(sp)
 35a:	e022                	sd	s0,0(sp)
 35c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 35e:	00054783          	lbu	a5,0(a0)
 362:	cf81                	beqz	a5,37a <strchr+0x24>
    if(*s == c)
 364:	00f58763          	beq	a1,a5,372 <strchr+0x1c>
  for(; *s; s++)
 368:	0505                	addi	a0,a0,1
 36a:	00054783          	lbu	a5,0(a0)
 36e:	fbfd                	bnez	a5,364 <strchr+0xe>
      return (char*)s;
  return 0;
 370:	4501                	li	a0,0
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret
  return 0;
 37a:	4501                	li	a0,0
 37c:	bfdd                	j	372 <strchr+0x1c>

000000000000037e <gets>:

char*
gets(char *buf, int max)
{
 37e:	7159                	addi	sp,sp,-112
 380:	f486                	sd	ra,104(sp)
 382:	f0a2                	sd	s0,96(sp)
 384:	eca6                	sd	s1,88(sp)
 386:	e8ca                	sd	s2,80(sp)
 388:	e4ce                	sd	s3,72(sp)
 38a:	e0d2                	sd	s4,64(sp)
 38c:	fc56                	sd	s5,56(sp)
 38e:	f85a                	sd	s6,48(sp)
 390:	f45e                	sd	s7,40(sp)
 392:	f062                	sd	s8,32(sp)
 394:	ec66                	sd	s9,24(sp)
 396:	e86a                	sd	s10,16(sp)
 398:	1880                	addi	s0,sp,112
 39a:	8caa                	mv	s9,a0
 39c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 39e:	892a                	mv	s2,a0
 3a0:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3a2:	f9f40b13          	addi	s6,s0,-97
 3a6:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3a8:	4ba9                	li	s7,10
 3aa:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 3ac:	8d26                	mv	s10,s1
 3ae:	0014899b          	addiw	s3,s1,1
 3b2:	84ce                	mv	s1,s3
 3b4:	0349d763          	bge	s3,s4,3e2 <gets+0x64>
    cc = read(0, &c, 1);
 3b8:	8656                	mv	a2,s5
 3ba:	85da                	mv	a1,s6
 3bc:	4501                	li	a0,0
 3be:	00000097          	auipc	ra,0x0
 3c2:	1c6080e7          	jalr	454(ra) # 584 <read>
    if(cc < 1)
 3c6:	00a05e63          	blez	a0,3e2 <gets+0x64>
    buf[i++] = c;
 3ca:	f9f44783          	lbu	a5,-97(s0)
 3ce:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3d2:	01778763          	beq	a5,s7,3e0 <gets+0x62>
 3d6:	0905                	addi	s2,s2,1
 3d8:	fd879ae3          	bne	a5,s8,3ac <gets+0x2e>
    buf[i++] = c;
 3dc:	8d4e                	mv	s10,s3
 3de:	a011                	j	3e2 <gets+0x64>
 3e0:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 3e2:	9d66                	add	s10,s10,s9
 3e4:	000d0023          	sb	zero,0(s10)
  return buf;
}
 3e8:	8566                	mv	a0,s9
 3ea:	70a6                	ld	ra,104(sp)
 3ec:	7406                	ld	s0,96(sp)
 3ee:	64e6                	ld	s1,88(sp)
 3f0:	6946                	ld	s2,80(sp)
 3f2:	69a6                	ld	s3,72(sp)
 3f4:	6a06                	ld	s4,64(sp)
 3f6:	7ae2                	ld	s5,56(sp)
 3f8:	7b42                	ld	s6,48(sp)
 3fa:	7ba2                	ld	s7,40(sp)
 3fc:	7c02                	ld	s8,32(sp)
 3fe:	6ce2                	ld	s9,24(sp)
 400:	6d42                	ld	s10,16(sp)
 402:	6165                	addi	sp,sp,112
 404:	8082                	ret

0000000000000406 <stat>:

int
stat(const char *n, struct stat *st)
{
 406:	1101                	addi	sp,sp,-32
 408:	ec06                	sd	ra,24(sp)
 40a:	e822                	sd	s0,16(sp)
 40c:	e04a                	sd	s2,0(sp)
 40e:	1000                	addi	s0,sp,32
 410:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 412:	4581                	li	a1,0
 414:	00000097          	auipc	ra,0x0
 418:	198080e7          	jalr	408(ra) # 5ac <open>
  if(fd < 0)
 41c:	02054663          	bltz	a0,448 <stat+0x42>
 420:	e426                	sd	s1,8(sp)
 422:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 424:	85ca                	mv	a1,s2
 426:	00000097          	auipc	ra,0x0
 42a:	19e080e7          	jalr	414(ra) # 5c4 <fstat>
 42e:	892a                	mv	s2,a0
  close(fd);
 430:	8526                	mv	a0,s1
 432:	00000097          	auipc	ra,0x0
 436:	162080e7          	jalr	354(ra) # 594 <close>
  return r;
 43a:	64a2                	ld	s1,8(sp)
}
 43c:	854a                	mv	a0,s2
 43e:	60e2                	ld	ra,24(sp)
 440:	6442                	ld	s0,16(sp)
 442:	6902                	ld	s2,0(sp)
 444:	6105                	addi	sp,sp,32
 446:	8082                	ret
    return -1;
 448:	597d                	li	s2,-1
 44a:	bfcd                	j	43c <stat+0x36>

000000000000044c <atoi>:

int
atoi(const char *s)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e406                	sd	ra,8(sp)
 450:	e022                	sd	s0,0(sp)
 452:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 454:	00054683          	lbu	a3,0(a0)
 458:	fd06879b          	addiw	a5,a3,-48
 45c:	0ff7f793          	zext.b	a5,a5
 460:	4625                	li	a2,9
 462:	02f66963          	bltu	a2,a5,494 <atoi+0x48>
 466:	872a                	mv	a4,a0
  n = 0;
 468:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 46a:	0705                	addi	a4,a4,1
 46c:	0025179b          	slliw	a5,a0,0x2
 470:	9fa9                	addw	a5,a5,a0
 472:	0017979b          	slliw	a5,a5,0x1
 476:	9fb5                	addw	a5,a5,a3
 478:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 47c:	00074683          	lbu	a3,0(a4)
 480:	fd06879b          	addiw	a5,a3,-48
 484:	0ff7f793          	zext.b	a5,a5
 488:	fef671e3          	bgeu	a2,a5,46a <atoi+0x1e>
  return n;
}
 48c:	60a2                	ld	ra,8(sp)
 48e:	6402                	ld	s0,0(sp)
 490:	0141                	addi	sp,sp,16
 492:	8082                	ret
  n = 0;
 494:	4501                	li	a0,0
 496:	bfdd                	j	48c <atoi+0x40>

0000000000000498 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e406                	sd	ra,8(sp)
 49c:	e022                	sd	s0,0(sp)
 49e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4a0:	02b57563          	bgeu	a0,a1,4ca <memmove+0x32>
    while(n-- > 0)
 4a4:	00c05f63          	blez	a2,4c2 <memmove+0x2a>
 4a8:	1602                	slli	a2,a2,0x20
 4aa:	9201                	srli	a2,a2,0x20
 4ac:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4b0:	872a                	mv	a4,a0
      *dst++ = *src++;
 4b2:	0585                	addi	a1,a1,1
 4b4:	0705                	addi	a4,a4,1
 4b6:	fff5c683          	lbu	a3,-1(a1)
 4ba:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4be:	fee79ae3          	bne	a5,a4,4b2 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4c2:	60a2                	ld	ra,8(sp)
 4c4:	6402                	ld	s0,0(sp)
 4c6:	0141                	addi	sp,sp,16
 4c8:	8082                	ret
    dst += n;
 4ca:	00c50733          	add	a4,a0,a2
    src += n;
 4ce:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4d0:	fec059e3          	blez	a2,4c2 <memmove+0x2a>
 4d4:	fff6079b          	addiw	a5,a2,-1
 4d8:	1782                	slli	a5,a5,0x20
 4da:	9381                	srli	a5,a5,0x20
 4dc:	fff7c793          	not	a5,a5
 4e0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4e2:	15fd                	addi	a1,a1,-1
 4e4:	177d                	addi	a4,a4,-1
 4e6:	0005c683          	lbu	a3,0(a1)
 4ea:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4ee:	fef71ae3          	bne	a4,a5,4e2 <memmove+0x4a>
 4f2:	bfc1                	j	4c2 <memmove+0x2a>

00000000000004f4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4f4:	1141                	addi	sp,sp,-16
 4f6:	e406                	sd	ra,8(sp)
 4f8:	e022                	sd	s0,0(sp)
 4fa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4fc:	ca0d                	beqz	a2,52e <memcmp+0x3a>
 4fe:	fff6069b          	addiw	a3,a2,-1
 502:	1682                	slli	a3,a3,0x20
 504:	9281                	srli	a3,a3,0x20
 506:	0685                	addi	a3,a3,1
 508:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 50a:	00054783          	lbu	a5,0(a0)
 50e:	0005c703          	lbu	a4,0(a1)
 512:	00e79863          	bne	a5,a4,522 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 516:	0505                	addi	a0,a0,1
    p2++;
 518:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 51a:	fed518e3          	bne	a0,a3,50a <memcmp+0x16>
  }
  return 0;
 51e:	4501                	li	a0,0
 520:	a019                	j	526 <memcmp+0x32>
      return *p1 - *p2;
 522:	40e7853b          	subw	a0,a5,a4
}
 526:	60a2                	ld	ra,8(sp)
 528:	6402                	ld	s0,0(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
  return 0;
 52e:	4501                	li	a0,0
 530:	bfdd                	j	526 <memcmp+0x32>

0000000000000532 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 532:	1141                	addi	sp,sp,-16
 534:	e406                	sd	ra,8(sp)
 536:	e022                	sd	s0,0(sp)
 538:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 53a:	00000097          	auipc	ra,0x0
 53e:	f5e080e7          	jalr	-162(ra) # 498 <memmove>
}
 542:	60a2                	ld	ra,8(sp)
 544:	6402                	ld	s0,0(sp)
 546:	0141                	addi	sp,sp,16
 548:	8082                	ret

000000000000054a <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
 54a:	1141                	addi	sp,sp,-16
 54c:	e406                	sd	ra,8(sp)
 54e:	e022                	sd	s0,0(sp)
 550:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
 552:	040007b7          	lui	a5,0x4000
 556:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffeccc>
 558:	07b2                	slli	a5,a5,0xc
}
 55a:	4388                	lw	a0,0(a5)
 55c:	60a2                	ld	ra,8(sp)
 55e:	6402                	ld	s0,0(sp)
 560:	0141                	addi	sp,sp,16
 562:	8082                	ret

0000000000000564 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 564:	4885                	li	a7,1
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <exit>:
.global exit
exit:
 li a7, SYS_exit
 56c:	4889                	li	a7,2
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <wait>:
.global wait
wait:
 li a7, SYS_wait
 574:	488d                	li	a7,3
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 57c:	4891                	li	a7,4
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <read>:
.global read
read:
 li a7, SYS_read
 584:	4895                	li	a7,5
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <write>:
.global write
write:
 li a7, SYS_write
 58c:	48c1                	li	a7,16
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <close>:
.global close
close:
 li a7, SYS_close
 594:	48d5                	li	a7,21
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <kill>:
.global kill
kill:
 li a7, SYS_kill
 59c:	4899                	li	a7,6
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5a4:	489d                	li	a7,7
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <open>:
.global open
open:
 li a7, SYS_open
 5ac:	48bd                	li	a7,15
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5b4:	48c5                	li	a7,17
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5bc:	48c9                	li	a7,18
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5c4:	48a1                	li	a7,8
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <link>:
.global link
link:
 li a7, SYS_link
 5cc:	48cd                	li	a7,19
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5d4:	48d1                	li	a7,20
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5dc:	48a5                	li	a7,9
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5e4:	48a9                	li	a7,10
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ec:	48ad                	li	a7,11
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5f4:	48b1                	li	a7,12
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5fc:	48b5                	li	a7,13
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 604:	48b9                	li	a7,14
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <connect>:
.global connect
connect:
 li a7, SYS_connect
 60c:	48f5                	li	a7,29
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
 614:	48f9                	li	a7,30
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 61c:	1101                	addi	sp,sp,-32
 61e:	ec06                	sd	ra,24(sp)
 620:	e822                	sd	s0,16(sp)
 622:	1000                	addi	s0,sp,32
 624:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 628:	4605                	li	a2,1
 62a:	fef40593          	addi	a1,s0,-17
 62e:	00000097          	auipc	ra,0x0
 632:	f5e080e7          	jalr	-162(ra) # 58c <write>
}
 636:	60e2                	ld	ra,24(sp)
 638:	6442                	ld	s0,16(sp)
 63a:	6105                	addi	sp,sp,32
 63c:	8082                	ret

000000000000063e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 63e:	7139                	addi	sp,sp,-64
 640:	fc06                	sd	ra,56(sp)
 642:	f822                	sd	s0,48(sp)
 644:	f426                	sd	s1,40(sp)
 646:	f04a                	sd	s2,32(sp)
 648:	ec4e                	sd	s3,24(sp)
 64a:	0080                	addi	s0,sp,64
 64c:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 64e:	c299                	beqz	a3,654 <printint+0x16>
 650:	0805c063          	bltz	a1,6d0 <printint+0x92>
  neg = 0;
 654:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 656:	fc040313          	addi	t1,s0,-64
  neg = 0;
 65a:	869a                	mv	a3,t1
  i = 0;
 65c:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 65e:	00000817          	auipc	a6,0x0
 662:	4c280813          	addi	a6,a6,1218 # b20 <digits>
 666:	88be                	mv	a7,a5
 668:	0017851b          	addiw	a0,a5,1
 66c:	87aa                	mv	a5,a0
 66e:	02c5f73b          	remuw	a4,a1,a2
 672:	1702                	slli	a4,a4,0x20
 674:	9301                	srli	a4,a4,0x20
 676:	9742                	add	a4,a4,a6
 678:	00074703          	lbu	a4,0(a4)
 67c:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 680:	872e                	mv	a4,a1
 682:	02c5d5bb          	divuw	a1,a1,a2
 686:	0685                	addi	a3,a3,1
 688:	fcc77fe3          	bgeu	a4,a2,666 <printint+0x28>
  if(neg)
 68c:	000e0c63          	beqz	t3,6a4 <printint+0x66>
    buf[i++] = '-';
 690:	fd050793          	addi	a5,a0,-48
 694:	00878533          	add	a0,a5,s0
 698:	02d00793          	li	a5,45
 69c:	fef50823          	sb	a5,-16(a0)
 6a0:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 6a4:	fff7899b          	addiw	s3,a5,-1
 6a8:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 6ac:	fff4c583          	lbu	a1,-1(s1)
 6b0:	854a                	mv	a0,s2
 6b2:	00000097          	auipc	ra,0x0
 6b6:	f6a080e7          	jalr	-150(ra) # 61c <putc>
  while(--i >= 0)
 6ba:	39fd                	addiw	s3,s3,-1
 6bc:	14fd                	addi	s1,s1,-1
 6be:	fe09d7e3          	bgez	s3,6ac <printint+0x6e>
}
 6c2:	70e2                	ld	ra,56(sp)
 6c4:	7442                	ld	s0,48(sp)
 6c6:	74a2                	ld	s1,40(sp)
 6c8:	7902                	ld	s2,32(sp)
 6ca:	69e2                	ld	s3,24(sp)
 6cc:	6121                	addi	sp,sp,64
 6ce:	8082                	ret
    x = -xx;
 6d0:	40b005bb          	negw	a1,a1
    neg = 1;
 6d4:	4e05                	li	t3,1
    x = -xx;
 6d6:	b741                	j	656 <printint+0x18>

00000000000006d8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6d8:	715d                	addi	sp,sp,-80
 6da:	e486                	sd	ra,72(sp)
 6dc:	e0a2                	sd	s0,64(sp)
 6de:	f84a                	sd	s2,48(sp)
 6e0:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6e2:	0005c903          	lbu	s2,0(a1)
 6e6:	1a090a63          	beqz	s2,89a <vprintf+0x1c2>
 6ea:	fc26                	sd	s1,56(sp)
 6ec:	f44e                	sd	s3,40(sp)
 6ee:	f052                	sd	s4,32(sp)
 6f0:	ec56                	sd	s5,24(sp)
 6f2:	e85a                	sd	s6,16(sp)
 6f4:	e45e                	sd	s7,8(sp)
 6f6:	8aaa                	mv	s5,a0
 6f8:	8bb2                	mv	s7,a2
 6fa:	00158493          	addi	s1,a1,1
  state = 0;
 6fe:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 700:	02500a13          	li	s4,37
 704:	4b55                	li	s6,21
 706:	a839                	j	724 <vprintf+0x4c>
        putc(fd, c);
 708:	85ca                	mv	a1,s2
 70a:	8556                	mv	a0,s5
 70c:	00000097          	auipc	ra,0x0
 710:	f10080e7          	jalr	-240(ra) # 61c <putc>
 714:	a019                	j	71a <vprintf+0x42>
    } else if(state == '%'){
 716:	01498d63          	beq	s3,s4,730 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 71a:	0485                	addi	s1,s1,1
 71c:	fff4c903          	lbu	s2,-1(s1)
 720:	16090763          	beqz	s2,88e <vprintf+0x1b6>
    if(state == 0){
 724:	fe0999e3          	bnez	s3,716 <vprintf+0x3e>
      if(c == '%'){
 728:	ff4910e3          	bne	s2,s4,708 <vprintf+0x30>
        state = '%';
 72c:	89d2                	mv	s3,s4
 72e:	b7f5                	j	71a <vprintf+0x42>
      if(c == 'd'){
 730:	13490463          	beq	s2,s4,858 <vprintf+0x180>
 734:	f9d9079b          	addiw	a5,s2,-99
 738:	0ff7f793          	zext.b	a5,a5
 73c:	12fb6763          	bltu	s6,a5,86a <vprintf+0x192>
 740:	f9d9079b          	addiw	a5,s2,-99
 744:	0ff7f713          	zext.b	a4,a5
 748:	12eb6163          	bltu	s6,a4,86a <vprintf+0x192>
 74c:	00271793          	slli	a5,a4,0x2
 750:	00000717          	auipc	a4,0x0
 754:	37870713          	addi	a4,a4,888 # ac8 <malloc+0x13a>
 758:	97ba                	add	a5,a5,a4
 75a:	439c                	lw	a5,0(a5)
 75c:	97ba                	add	a5,a5,a4
 75e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 760:	008b8913          	addi	s2,s7,8
 764:	4685                	li	a3,1
 766:	4629                	li	a2,10
 768:	000ba583          	lw	a1,0(s7)
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	ed0080e7          	jalr	-304(ra) # 63e <printint>
 776:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 778:	4981                	li	s3,0
 77a:	b745                	j	71a <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 77c:	008b8913          	addi	s2,s7,8
 780:	4681                	li	a3,0
 782:	4629                	li	a2,10
 784:	000ba583          	lw	a1,0(s7)
 788:	8556                	mv	a0,s5
 78a:	00000097          	auipc	ra,0x0
 78e:	eb4080e7          	jalr	-332(ra) # 63e <printint>
 792:	8bca                	mv	s7,s2
      state = 0;
 794:	4981                	li	s3,0
 796:	b751                	j	71a <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 798:	008b8913          	addi	s2,s7,8
 79c:	4681                	li	a3,0
 79e:	4641                	li	a2,16
 7a0:	000ba583          	lw	a1,0(s7)
 7a4:	8556                	mv	a0,s5
 7a6:	00000097          	auipc	ra,0x0
 7aa:	e98080e7          	jalr	-360(ra) # 63e <printint>
 7ae:	8bca                	mv	s7,s2
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	b7a5                	j	71a <vprintf+0x42>
 7b4:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7b6:	008b8c13          	addi	s8,s7,8
 7ba:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7be:	03000593          	li	a1,48
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e58080e7          	jalr	-424(ra) # 61c <putc>
  putc(fd, 'x');
 7cc:	07800593          	li	a1,120
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	e4a080e7          	jalr	-438(ra) # 61c <putc>
 7da:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7dc:	00000b97          	auipc	s7,0x0
 7e0:	344b8b93          	addi	s7,s7,836 # b20 <digits>
 7e4:	03c9d793          	srli	a5,s3,0x3c
 7e8:	97de                	add	a5,a5,s7
 7ea:	0007c583          	lbu	a1,0(a5)
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	e2c080e7          	jalr	-468(ra) # 61c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f8:	0992                	slli	s3,s3,0x4
 7fa:	397d                	addiw	s2,s2,-1
 7fc:	fe0914e3          	bnez	s2,7e4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 800:	8be2                	mv	s7,s8
      state = 0;
 802:	4981                	li	s3,0
 804:	6c02                	ld	s8,0(sp)
 806:	bf11                	j	71a <vprintf+0x42>
        s = va_arg(ap, char*);
 808:	008b8993          	addi	s3,s7,8
 80c:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 810:	02090163          	beqz	s2,832 <vprintf+0x15a>
        while(*s != 0){
 814:	00094583          	lbu	a1,0(s2)
 818:	c9a5                	beqz	a1,888 <vprintf+0x1b0>
          putc(fd, *s);
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	e00080e7          	jalr	-512(ra) # 61c <putc>
          s++;
 824:	0905                	addi	s2,s2,1
        while(*s != 0){
 826:	00094583          	lbu	a1,0(s2)
 82a:	f9e5                	bnez	a1,81a <vprintf+0x142>
        s = va_arg(ap, char*);
 82c:	8bce                	mv	s7,s3
      state = 0;
 82e:	4981                	li	s3,0
 830:	b5ed                	j	71a <vprintf+0x42>
          s = "(null)";
 832:	00000917          	auipc	s2,0x0
 836:	28e90913          	addi	s2,s2,654 # ac0 <malloc+0x132>
        while(*s != 0){
 83a:	02800593          	li	a1,40
 83e:	bff1                	j	81a <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 840:	008b8913          	addi	s2,s7,8
 844:	000bc583          	lbu	a1,0(s7)
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	dd2080e7          	jalr	-558(ra) # 61c <putc>
 852:	8bca                	mv	s7,s2
      state = 0;
 854:	4981                	li	s3,0
 856:	b5d1                	j	71a <vprintf+0x42>
        putc(fd, c);
 858:	02500593          	li	a1,37
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	dbe080e7          	jalr	-578(ra) # 61c <putc>
      state = 0;
 866:	4981                	li	s3,0
 868:	bd4d                	j	71a <vprintf+0x42>
        putc(fd, '%');
 86a:	02500593          	li	a1,37
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	dac080e7          	jalr	-596(ra) # 61c <putc>
        putc(fd, c);
 878:	85ca                	mv	a1,s2
 87a:	8556                	mv	a0,s5
 87c:	00000097          	auipc	ra,0x0
 880:	da0080e7          	jalr	-608(ra) # 61c <putc>
      state = 0;
 884:	4981                	li	s3,0
 886:	bd51                	j	71a <vprintf+0x42>
        s = va_arg(ap, char*);
 888:	8bce                	mv	s7,s3
      state = 0;
 88a:	4981                	li	s3,0
 88c:	b579                	j	71a <vprintf+0x42>
 88e:	74e2                	ld	s1,56(sp)
 890:	79a2                	ld	s3,40(sp)
 892:	7a02                	ld	s4,32(sp)
 894:	6ae2                	ld	s5,24(sp)
 896:	6b42                	ld	s6,16(sp)
 898:	6ba2                	ld	s7,8(sp)
    }
  }
}
 89a:	60a6                	ld	ra,72(sp)
 89c:	6406                	ld	s0,64(sp)
 89e:	7942                	ld	s2,48(sp)
 8a0:	6161                	addi	sp,sp,80
 8a2:	8082                	ret

00000000000008a4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8a4:	715d                	addi	sp,sp,-80
 8a6:	ec06                	sd	ra,24(sp)
 8a8:	e822                	sd	s0,16(sp)
 8aa:	1000                	addi	s0,sp,32
 8ac:	e010                	sd	a2,0(s0)
 8ae:	e414                	sd	a3,8(s0)
 8b0:	e818                	sd	a4,16(s0)
 8b2:	ec1c                	sd	a5,24(s0)
 8b4:	03043023          	sd	a6,32(s0)
 8b8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8bc:	8622                	mv	a2,s0
 8be:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8c2:	00000097          	auipc	ra,0x0
 8c6:	e16080e7          	jalr	-490(ra) # 6d8 <vprintf>
}
 8ca:	60e2                	ld	ra,24(sp)
 8cc:	6442                	ld	s0,16(sp)
 8ce:	6161                	addi	sp,sp,80
 8d0:	8082                	ret

00000000000008d2 <printf>:

void
printf(const char *fmt, ...)
{
 8d2:	711d                	addi	sp,sp,-96
 8d4:	ec06                	sd	ra,24(sp)
 8d6:	e822                	sd	s0,16(sp)
 8d8:	1000                	addi	s0,sp,32
 8da:	e40c                	sd	a1,8(s0)
 8dc:	e810                	sd	a2,16(s0)
 8de:	ec14                	sd	a3,24(s0)
 8e0:	f018                	sd	a4,32(s0)
 8e2:	f41c                	sd	a5,40(s0)
 8e4:	03043823          	sd	a6,48(s0)
 8e8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ec:	00840613          	addi	a2,s0,8
 8f0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8f4:	85aa                	mv	a1,a0
 8f6:	4505                	li	a0,1
 8f8:	00000097          	auipc	ra,0x0
 8fc:	de0080e7          	jalr	-544(ra) # 6d8 <vprintf>
}
 900:	60e2                	ld	ra,24(sp)
 902:	6442                	ld	s0,16(sp)
 904:	6125                	addi	sp,sp,96
 906:	8082                	ret

0000000000000908 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 908:	1141                	addi	sp,sp,-16
 90a:	e406                	sd	ra,8(sp)
 90c:	e022                	sd	s0,0(sp)
 90e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 910:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 914:	00000797          	auipc	a5,0x0
 918:	2247b783          	ld	a5,548(a5) # b38 <freep>
 91c:	a02d                	j	946 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 91e:	4618                	lw	a4,8(a2)
 920:	9f2d                	addw	a4,a4,a1
 922:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 926:	6398                	ld	a4,0(a5)
 928:	6310                	ld	a2,0(a4)
 92a:	a83d                	j	968 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 92c:	ff852703          	lw	a4,-8(a0)
 930:	9f31                	addw	a4,a4,a2
 932:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 934:	ff053683          	ld	a3,-16(a0)
 938:	a091                	j	97c <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93a:	6398                	ld	a4,0(a5)
 93c:	00e7e463          	bltu	a5,a4,944 <free+0x3c>
 940:	00e6ea63          	bltu	a3,a4,954 <free+0x4c>
{
 944:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 946:	fed7fae3          	bgeu	a5,a3,93a <free+0x32>
 94a:	6398                	ld	a4,0(a5)
 94c:	00e6e463          	bltu	a3,a4,954 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 950:	fee7eae3          	bltu	a5,a4,944 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 954:	ff852583          	lw	a1,-8(a0)
 958:	6390                	ld	a2,0(a5)
 95a:	02059813          	slli	a6,a1,0x20
 95e:	01c85713          	srli	a4,a6,0x1c
 962:	9736                	add	a4,a4,a3
 964:	fae60de3          	beq	a2,a4,91e <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 968:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 96c:	4790                	lw	a2,8(a5)
 96e:	02061593          	slli	a1,a2,0x20
 972:	01c5d713          	srli	a4,a1,0x1c
 976:	973e                	add	a4,a4,a5
 978:	fae68ae3          	beq	a3,a4,92c <free+0x24>
    p->s.ptr = bp->s.ptr;
 97c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 97e:	00000717          	auipc	a4,0x0
 982:	1af73d23          	sd	a5,442(a4) # b38 <freep>
}
 986:	60a2                	ld	ra,8(sp)
 988:	6402                	ld	s0,0(sp)
 98a:	0141                	addi	sp,sp,16
 98c:	8082                	ret

000000000000098e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 98e:	7139                	addi	sp,sp,-64
 990:	fc06                	sd	ra,56(sp)
 992:	f822                	sd	s0,48(sp)
 994:	f04a                	sd	s2,32(sp)
 996:	ec4e                	sd	s3,24(sp)
 998:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99a:	02051993          	slli	s3,a0,0x20
 99e:	0209d993          	srli	s3,s3,0x20
 9a2:	09bd                	addi	s3,s3,15
 9a4:	0049d993          	srli	s3,s3,0x4
 9a8:	2985                	addiw	s3,s3,1
 9aa:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 9ac:	00000517          	auipc	a0,0x0
 9b0:	18c53503          	ld	a0,396(a0) # b38 <freep>
 9b4:	c905                	beqz	a0,9e4 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b8:	4798                	lw	a4,8(a5)
 9ba:	09377a63          	bgeu	a4,s3,a4e <malloc+0xc0>
 9be:	f426                	sd	s1,40(sp)
 9c0:	e852                	sd	s4,16(sp)
 9c2:	e456                	sd	s5,8(sp)
 9c4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9c6:	8a4e                	mv	s4,s3
 9c8:	6705                	lui	a4,0x1
 9ca:	00e9f363          	bgeu	s3,a4,9d0 <malloc+0x42>
 9ce:	6a05                	lui	s4,0x1
 9d0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9d4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9d8:	00000497          	auipc	s1,0x0
 9dc:	16048493          	addi	s1,s1,352 # b38 <freep>
  if(p == (char*)-1)
 9e0:	5afd                	li	s5,-1
 9e2:	a089                	j	a24 <malloc+0x96>
 9e4:	f426                	sd	s1,40(sp)
 9e6:	e852                	sd	s4,16(sp)
 9e8:	e456                	sd	s5,8(sp)
 9ea:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9ec:	00000797          	auipc	a5,0x0
 9f0:	55478793          	addi	a5,a5,1364 # f40 <base>
 9f4:	00000717          	auipc	a4,0x0
 9f8:	14f73223          	sd	a5,324(a4) # b38 <freep>
 9fc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9fe:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a02:	b7d1                	j	9c6 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 a04:	6398                	ld	a4,0(a5)
 a06:	e118                	sd	a4,0(a0)
 a08:	a8b9                	j	a66 <malloc+0xd8>
  hp->s.size = nu;
 a0a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a0e:	0541                	addi	a0,a0,16
 a10:	00000097          	auipc	ra,0x0
 a14:	ef8080e7          	jalr	-264(ra) # 908 <free>
  return freep;
 a18:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a1a:	c135                	beqz	a0,a7e <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1e:	4798                	lw	a4,8(a5)
 a20:	03277363          	bgeu	a4,s2,a46 <malloc+0xb8>
    if(p == freep)
 a24:	6098                	ld	a4,0(s1)
 a26:	853e                	mv	a0,a5
 a28:	fef71ae3          	bne	a4,a5,a1c <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a2c:	8552                	mv	a0,s4
 a2e:	00000097          	auipc	ra,0x0
 a32:	bc6080e7          	jalr	-1082(ra) # 5f4 <sbrk>
  if(p == (char*)-1)
 a36:	fd551ae3          	bne	a0,s5,a0a <malloc+0x7c>
        return 0;
 a3a:	4501                	li	a0,0
 a3c:	74a2                	ld	s1,40(sp)
 a3e:	6a42                	ld	s4,16(sp)
 a40:	6aa2                	ld	s5,8(sp)
 a42:	6b02                	ld	s6,0(sp)
 a44:	a03d                	j	a72 <malloc+0xe4>
 a46:	74a2                	ld	s1,40(sp)
 a48:	6a42                	ld	s4,16(sp)
 a4a:	6aa2                	ld	s5,8(sp)
 a4c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a4e:	fae90be3          	beq	s2,a4,a04 <malloc+0x76>
        p->s.size -= nunits;
 a52:	4137073b          	subw	a4,a4,s3
 a56:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a58:	02071693          	slli	a3,a4,0x20
 a5c:	01c6d713          	srli	a4,a3,0x1c
 a60:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a62:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a66:	00000717          	auipc	a4,0x0
 a6a:	0ca73923          	sd	a0,210(a4) # b38 <freep>
      return (void*)(p + 1);
 a6e:	01078513          	addi	a0,a5,16
  }
}
 a72:	70e2                	ld	ra,56(sp)
 a74:	7442                	ld	s0,48(sp)
 a76:	7902                	ld	s2,32(sp)
 a78:	69e2                	ld	s3,24(sp)
 a7a:	6121                	addi	sp,sp,64
 a7c:	8082                	ret
 a7e:	74a2                	ld	s1,40(sp)
 a80:	6a42                	ld	s4,16(sp)
 a82:	6aa2                	ld	s5,8(sp)
 a84:	6b02                	ld	s6,0(sp)
 a86:	b7f5                	j	a72 <malloc+0xe4>
