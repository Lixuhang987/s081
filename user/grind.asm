
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       8:	611c                	ld	a5,0(a0)
       a:	0017d693          	srli	a3,a5,0x1
       e:	c0000737          	lui	a4,0xc0000
      12:	0705                	addi	a4,a4,1 # ffffffffc0000001 <__global_pointer$+0xffffffffbfffe018>
      14:	1706                	slli	a4,a4,0x21
      16:	0725                	addi	a4,a4,9
      18:	02e6b733          	mulhu	a4,a3,a4
      1c:	8375                	srli	a4,a4,0x1d
      1e:	01e71693          	slli	a3,a4,0x1e
      22:	40e68733          	sub	a4,a3,a4
      26:	0706                	slli	a4,a4,0x1
      28:	8f99                	sub	a5,a5,a4
      2a:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      2c:	1fe406b7          	lui	a3,0x1fe40
      30:	b7968693          	addi	a3,a3,-1159 # 1fe3fb79 <__global_pointer$+0x1fe3db90>
      34:	41a70737          	lui	a4,0x41a70
      38:	5af70713          	addi	a4,a4,1455 # 41a705af <__global_pointer$+0x41a6e5c6>
      3c:	1702                	slli	a4,a4,0x20
      3e:	9736                	add	a4,a4,a3
      40:	02e79733          	mulh	a4,a5,a4
      44:	873d                	srai	a4,a4,0xf
      46:	43f7d693          	srai	a3,a5,0x3f
      4a:	8f15                	sub	a4,a4,a3
      4c:	66fd                	lui	a3,0x1f
      4e:	31d68693          	addi	a3,a3,797 # 1f31d <__global_pointer$+0x1d334>
      52:	02d706b3          	mul	a3,a4,a3
      56:	8f95                	sub	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      58:	6691                	lui	a3,0x4
      5a:	1a768693          	addi	a3,a3,423 # 41a7 <__global_pointer$+0x21be>
      5e:	02d787b3          	mul	a5,a5,a3
      62:	76fd                	lui	a3,0xfffff
      64:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffd503>
      68:	02d70733          	mul	a4,a4,a3
      6c:	97ba                	add	a5,a5,a4
    if (x < 0)
      6e:	0007ca63          	bltz	a5,82 <do_rand+0x82>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      72:	17fd                	addi	a5,a5,-1
    *ctx = x;
      74:	e11c                	sd	a5,0(a0)
    return (x);
}
      76:	0007851b          	sext.w	a0,a5
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
        x += 0x7fffffff;
      82:	80000737          	lui	a4,0x80000
      86:	fff74713          	not	a4,a4
      8a:	97ba                	add	a5,a5,a4
      8c:	b7dd                	j	72 <do_rand+0x72>

000000000000008e <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      8e:	1141                	addi	sp,sp,-16
      90:	e406                	sd	ra,8(sp)
      92:	e022                	sd	s0,0(sp)
      94:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      96:	00001517          	auipc	a0,0x1
      9a:	75a50513          	addi	a0,a0,1882 # 17f0 <rand_next>
      9e:	00000097          	auipc	ra,0x0
      a2:	f62080e7          	jalr	-158(ra) # 0 <do_rand>
}
      a6:	60a2                	ld	ra,8(sp)
      a8:	6402                	ld	s0,0(sp)
      aa:	0141                	addi	sp,sp,16
      ac:	8082                	ret

00000000000000ae <go>:

void
go(int which_child)
{
      ae:	7171                	addi	sp,sp,-176
      b0:	f506                	sd	ra,168(sp)
      b2:	f122                	sd	s0,160(sp)
      b4:	ed26                	sd	s1,152(sp)
      b6:	1900                	addi	s0,sp,176
      b8:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      ba:	4501                	li	a0,0
      bc:	00001097          	auipc	ra,0x1
      c0:	ebe080e7          	jalr	-322(ra) # f7a <sbrk>
      c4:	f4a43c23          	sd	a0,-168(s0)
  uint64 iters = 0;

  mkdir("grindir");
      c8:	00001517          	auipc	a0,0x1
      cc:	34850513          	addi	a0,a0,840 # 1410 <malloc+0xfc>
      d0:	00001097          	auipc	ra,0x1
      d4:	e8a080e7          	jalr	-374(ra) # f5a <mkdir>
  if(chdir("grindir") != 0){
      d8:	00001517          	auipc	a0,0x1
      dc:	33850513          	addi	a0,a0,824 # 1410 <malloc+0xfc>
      e0:	00001097          	auipc	ra,0x1
      e4:	e82080e7          	jalr	-382(ra) # f62 <chdir>
      e8:	c905                	beqz	a0,118 <go+0x6a>
      ea:	e94a                	sd	s2,144(sp)
      ec:	e54e                	sd	s3,136(sp)
      ee:	e152                	sd	s4,128(sp)
      f0:	fcd6                	sd	s5,120(sp)
      f2:	f8da                	sd	s6,112(sp)
      f4:	f4de                	sd	s7,104(sp)
      f6:	f0e2                	sd	s8,96(sp)
      f8:	ece6                	sd	s9,88(sp)
      fa:	e8ea                	sd	s10,80(sp)
      fc:	e4ee                	sd	s11,72(sp)
    printf("grind: chdir grindir failed\n");
      fe:	00001517          	auipc	a0,0x1
     102:	31a50513          	addi	a0,a0,794 # 1418 <malloc+0x104>
     106:	00001097          	auipc	ra,0x1
     10a:	152080e7          	jalr	338(ra) # 1258 <printf>
    exit(1);
     10e:	4505                	li	a0,1
     110:	00001097          	auipc	ra,0x1
     114:	de2080e7          	jalr	-542(ra) # ef2 <exit>
     118:	e94a                	sd	s2,144(sp)
     11a:	e54e                	sd	s3,136(sp)
     11c:	e152                	sd	s4,128(sp)
     11e:	fcd6                	sd	s5,120(sp)
     120:	f8da                	sd	s6,112(sp)
     122:	f4de                	sd	s7,104(sp)
     124:	f0e2                	sd	s8,96(sp)
     126:	ece6                	sd	s9,88(sp)
     128:	e8ea                	sd	s10,80(sp)
     12a:	e4ee                	sd	s11,72(sp)
  }
  chdir("/");
     12c:	00001517          	auipc	a0,0x1
     130:	31450513          	addi	a0,a0,788 # 1440 <malloc+0x12c>
     134:	00001097          	auipc	ra,0x1
     138:	e2e080e7          	jalr	-466(ra) # f62 <chdir>
     13c:	00001c17          	auipc	s8,0x1
     140:	314c0c13          	addi	s8,s8,788 # 1450 <malloc+0x13c>
     144:	c489                	beqz	s1,14e <go+0xa0>
     146:	00001c17          	auipc	s8,0x1
     14a:	302c0c13          	addi	s8,s8,770 # 1448 <malloc+0x134>
  uint64 iters = 0;
     14e:	4481                	li	s1,0
  int fd = -1;
     150:	5cfd                	li	s9,-1
  
  while(1){
    iters++;
    if((iters % 500) == 0)
     152:	e353f7b7          	lui	a5,0xe353f
     156:	7cf78793          	addi	a5,a5,1999 # ffffffffe353f7cf <__global_pointer$+0xffffffffe353d7e6>
     15a:	20c4a9b7          	lui	s3,0x20c4a
     15e:	ba698993          	addi	s3,s3,-1114 # 20c49ba6 <__global_pointer$+0x20c47bbd>
     162:	1982                	slli	s3,s3,0x20
     164:	99be                	add	s3,s3,a5
     166:	1f400b13          	li	s6,500
      write(1, which_child?"B":"A", 1);
     16a:	4b85                	li	s7,1
    int what = rand() % 23;
     16c:	b2164a37          	lui	s4,0xb2164
     170:	2c9a0a13          	addi	s4,s4,713 # ffffffffb21642c9 <__global_pointer$+0xffffffffb21622e0>
     174:	4ad9                	li	s5,22
     176:	00001917          	auipc	s2,0x1
     17a:	5aa90913          	addi	s2,s2,1450 # 1720 <malloc+0x40c>
      close(fd1);
      unlink("c");
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     17e:	f6840d93          	addi	s11,s0,-152
     182:	a839                	j	1a0 <go+0xf2>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     184:	20200593          	li	a1,514
     188:	00001517          	auipc	a0,0x1
     18c:	2d050513          	addi	a0,a0,720 # 1458 <malloc+0x144>
     190:	00001097          	auipc	ra,0x1
     194:	da2080e7          	jalr	-606(ra) # f32 <open>
     198:	00001097          	auipc	ra,0x1
     19c:	d82080e7          	jalr	-638(ra) # f1a <close>
    iters++;
     1a0:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     1a2:	0024d793          	srli	a5,s1,0x2
     1a6:	0337b7b3          	mulhu	a5,a5,s3
     1aa:	8391                	srli	a5,a5,0x4
     1ac:	036787b3          	mul	a5,a5,s6
     1b0:	00f49963          	bne	s1,a5,1c2 <go+0x114>
      write(1, which_child?"B":"A", 1);
     1b4:	865e                	mv	a2,s7
     1b6:	85e2                	mv	a1,s8
     1b8:	855e                	mv	a0,s7
     1ba:	00001097          	auipc	ra,0x1
     1be:	d58080e7          	jalr	-680(ra) # f12 <write>
    int what = rand() % 23;
     1c2:	00000097          	auipc	ra,0x0
     1c6:	ecc080e7          	jalr	-308(ra) # 8e <rand>
     1ca:	034507b3          	mul	a5,a0,s4
     1ce:	9381                	srli	a5,a5,0x20
     1d0:	9fa9                	addw	a5,a5,a0
     1d2:	4047d79b          	sraiw	a5,a5,0x4
     1d6:	41f5571b          	sraiw	a4,a0,0x1f
     1da:	9f99                	subw	a5,a5,a4
     1dc:	0017971b          	slliw	a4,a5,0x1
     1e0:	9f3d                	addw	a4,a4,a5
     1e2:	0037171b          	slliw	a4,a4,0x3
     1e6:	40f707bb          	subw	a5,a4,a5
     1ea:	9d1d                	subw	a0,a0,a5
     1ec:	faaaeae3          	bltu	s5,a0,1a0 <go+0xf2>
     1f0:	02051793          	slli	a5,a0,0x20
     1f4:	01e7d513          	srli	a0,a5,0x1e
     1f8:	954a                	add	a0,a0,s2
     1fa:	411c                	lw	a5,0(a0)
     1fc:	97ca                	add	a5,a5,s2
     1fe:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     200:	20200593          	li	a1,514
     204:	00001517          	auipc	a0,0x1
     208:	26450513          	addi	a0,a0,612 # 1468 <malloc+0x154>
     20c:	00001097          	auipc	ra,0x1
     210:	d26080e7          	jalr	-730(ra) # f32 <open>
     214:	00001097          	auipc	ra,0x1
     218:	d06080e7          	jalr	-762(ra) # f1a <close>
     21c:	b751                	j	1a0 <go+0xf2>
      unlink("grindir/../a");
     21e:	00001517          	auipc	a0,0x1
     222:	23a50513          	addi	a0,a0,570 # 1458 <malloc+0x144>
     226:	00001097          	auipc	ra,0x1
     22a:	d1c080e7          	jalr	-740(ra) # f42 <unlink>
     22e:	bf8d                	j	1a0 <go+0xf2>
      if(chdir("grindir") != 0){
     230:	00001517          	auipc	a0,0x1
     234:	1e050513          	addi	a0,a0,480 # 1410 <malloc+0xfc>
     238:	00001097          	auipc	ra,0x1
     23c:	d2a080e7          	jalr	-726(ra) # f62 <chdir>
     240:	e115                	bnez	a0,264 <go+0x1b6>
      unlink("../b");
     242:	00001517          	auipc	a0,0x1
     246:	23e50513          	addi	a0,a0,574 # 1480 <malloc+0x16c>
     24a:	00001097          	auipc	ra,0x1
     24e:	cf8080e7          	jalr	-776(ra) # f42 <unlink>
      chdir("/");
     252:	00001517          	auipc	a0,0x1
     256:	1ee50513          	addi	a0,a0,494 # 1440 <malloc+0x12c>
     25a:	00001097          	auipc	ra,0x1
     25e:	d08080e7          	jalr	-760(ra) # f62 <chdir>
     262:	bf3d                	j	1a0 <go+0xf2>
        printf("grind: chdir grindir failed\n");
     264:	00001517          	auipc	a0,0x1
     268:	1b450513          	addi	a0,a0,436 # 1418 <malloc+0x104>
     26c:	00001097          	auipc	ra,0x1
     270:	fec080e7          	jalr	-20(ra) # 1258 <printf>
        exit(1);
     274:	4505                	li	a0,1
     276:	00001097          	auipc	ra,0x1
     27a:	c7c080e7          	jalr	-900(ra) # ef2 <exit>
      close(fd);
     27e:	8566                	mv	a0,s9
     280:	00001097          	auipc	ra,0x1
     284:	c9a080e7          	jalr	-870(ra) # f1a <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     288:	20200593          	li	a1,514
     28c:	00001517          	auipc	a0,0x1
     290:	1fc50513          	addi	a0,a0,508 # 1488 <malloc+0x174>
     294:	00001097          	auipc	ra,0x1
     298:	c9e080e7          	jalr	-866(ra) # f32 <open>
     29c:	8caa                	mv	s9,a0
     29e:	b709                	j	1a0 <go+0xf2>
      close(fd);
     2a0:	8566                	mv	a0,s9
     2a2:	00001097          	auipc	ra,0x1
     2a6:	c78080e7          	jalr	-904(ra) # f1a <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     2aa:	20200593          	li	a1,514
     2ae:	00001517          	auipc	a0,0x1
     2b2:	1ea50513          	addi	a0,a0,490 # 1498 <malloc+0x184>
     2b6:	00001097          	auipc	ra,0x1
     2ba:	c7c080e7          	jalr	-900(ra) # f32 <open>
     2be:	8caa                	mv	s9,a0
     2c0:	b5c5                	j	1a0 <go+0xf2>
      write(fd, buf, sizeof(buf));
     2c2:	3e700613          	li	a2,999
     2c6:	00001597          	auipc	a1,0x1
     2ca:	53a58593          	addi	a1,a1,1338 # 1800 <buf.0>
     2ce:	8566                	mv	a0,s9
     2d0:	00001097          	auipc	ra,0x1
     2d4:	c42080e7          	jalr	-958(ra) # f12 <write>
     2d8:	b5e1                	j	1a0 <go+0xf2>
      read(fd, buf, sizeof(buf));
     2da:	3e700613          	li	a2,999
     2de:	00001597          	auipc	a1,0x1
     2e2:	52258593          	addi	a1,a1,1314 # 1800 <buf.0>
     2e6:	8566                	mv	a0,s9
     2e8:	00001097          	auipc	ra,0x1
     2ec:	c22080e7          	jalr	-990(ra) # f0a <read>
     2f0:	bd45                	j	1a0 <go+0xf2>
      mkdir("grindir/../a");
     2f2:	00001517          	auipc	a0,0x1
     2f6:	16650513          	addi	a0,a0,358 # 1458 <malloc+0x144>
     2fa:	00001097          	auipc	ra,0x1
     2fe:	c60080e7          	jalr	-928(ra) # f5a <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     302:	20200593          	li	a1,514
     306:	00001517          	auipc	a0,0x1
     30a:	1aa50513          	addi	a0,a0,426 # 14b0 <malloc+0x19c>
     30e:	00001097          	auipc	ra,0x1
     312:	c24080e7          	jalr	-988(ra) # f32 <open>
     316:	00001097          	auipc	ra,0x1
     31a:	c04080e7          	jalr	-1020(ra) # f1a <close>
      unlink("a/a");
     31e:	00001517          	auipc	a0,0x1
     322:	1a250513          	addi	a0,a0,418 # 14c0 <malloc+0x1ac>
     326:	00001097          	auipc	ra,0x1
     32a:	c1c080e7          	jalr	-996(ra) # f42 <unlink>
     32e:	bd8d                	j	1a0 <go+0xf2>
      mkdir("/../b");
     330:	00001517          	auipc	a0,0x1
     334:	19850513          	addi	a0,a0,408 # 14c8 <malloc+0x1b4>
     338:	00001097          	auipc	ra,0x1
     33c:	c22080e7          	jalr	-990(ra) # f5a <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     340:	20200593          	li	a1,514
     344:	00001517          	auipc	a0,0x1
     348:	18c50513          	addi	a0,a0,396 # 14d0 <malloc+0x1bc>
     34c:	00001097          	auipc	ra,0x1
     350:	be6080e7          	jalr	-1050(ra) # f32 <open>
     354:	00001097          	auipc	ra,0x1
     358:	bc6080e7          	jalr	-1082(ra) # f1a <close>
      unlink("b/b");
     35c:	00001517          	auipc	a0,0x1
     360:	18450513          	addi	a0,a0,388 # 14e0 <malloc+0x1cc>
     364:	00001097          	auipc	ra,0x1
     368:	bde080e7          	jalr	-1058(ra) # f42 <unlink>
     36c:	bd15                	j	1a0 <go+0xf2>
      unlink("b");
     36e:	00001517          	auipc	a0,0x1
     372:	17a50513          	addi	a0,a0,378 # 14e8 <malloc+0x1d4>
     376:	00001097          	auipc	ra,0x1
     37a:	bcc080e7          	jalr	-1076(ra) # f42 <unlink>
      link("../grindir/./../a", "../b");
     37e:	00001597          	auipc	a1,0x1
     382:	10258593          	addi	a1,a1,258 # 1480 <malloc+0x16c>
     386:	00001517          	auipc	a0,0x1
     38a:	16a50513          	addi	a0,a0,362 # 14f0 <malloc+0x1dc>
     38e:	00001097          	auipc	ra,0x1
     392:	bc4080e7          	jalr	-1084(ra) # f52 <link>
     396:	b529                	j	1a0 <go+0xf2>
      unlink("../grindir/../a");
     398:	00001517          	auipc	a0,0x1
     39c:	17050513          	addi	a0,a0,368 # 1508 <malloc+0x1f4>
     3a0:	00001097          	auipc	ra,0x1
     3a4:	ba2080e7          	jalr	-1118(ra) # f42 <unlink>
      link(".././b", "/grindir/../a");
     3a8:	00001597          	auipc	a1,0x1
     3ac:	0e058593          	addi	a1,a1,224 # 1488 <malloc+0x174>
     3b0:	00001517          	auipc	a0,0x1
     3b4:	16850513          	addi	a0,a0,360 # 1518 <malloc+0x204>
     3b8:	00001097          	auipc	ra,0x1
     3bc:	b9a080e7          	jalr	-1126(ra) # f52 <link>
     3c0:	b3c5                	j	1a0 <go+0xf2>
      int pid = fork();
     3c2:	00001097          	auipc	ra,0x1
     3c6:	b28080e7          	jalr	-1240(ra) # eea <fork>
      if(pid == 0){
     3ca:	c909                	beqz	a0,3dc <go+0x32e>
      } else if(pid < 0){
     3cc:	00054c63          	bltz	a0,3e4 <go+0x336>
      wait(0);
     3d0:	4501                	li	a0,0
     3d2:	00001097          	auipc	ra,0x1
     3d6:	b28080e7          	jalr	-1240(ra) # efa <wait>
     3da:	b3d9                	j	1a0 <go+0xf2>
        exit(0);
     3dc:	00001097          	auipc	ra,0x1
     3e0:	b16080e7          	jalr	-1258(ra) # ef2 <exit>
        printf("grind: fork failed\n");
     3e4:	00001517          	auipc	a0,0x1
     3e8:	13c50513          	addi	a0,a0,316 # 1520 <malloc+0x20c>
     3ec:	00001097          	auipc	ra,0x1
     3f0:	e6c080e7          	jalr	-404(ra) # 1258 <printf>
        exit(1);
     3f4:	4505                	li	a0,1
     3f6:	00001097          	auipc	ra,0x1
     3fa:	afc080e7          	jalr	-1284(ra) # ef2 <exit>
      int pid = fork();
     3fe:	00001097          	auipc	ra,0x1
     402:	aec080e7          	jalr	-1300(ra) # eea <fork>
      if(pid == 0){
     406:	c909                	beqz	a0,418 <go+0x36a>
      } else if(pid < 0){
     408:	02054563          	bltz	a0,432 <go+0x384>
      wait(0);
     40c:	4501                	li	a0,0
     40e:	00001097          	auipc	ra,0x1
     412:	aec080e7          	jalr	-1300(ra) # efa <wait>
     416:	b369                	j	1a0 <go+0xf2>
        fork();
     418:	00001097          	auipc	ra,0x1
     41c:	ad2080e7          	jalr	-1326(ra) # eea <fork>
        fork();
     420:	00001097          	auipc	ra,0x1
     424:	aca080e7          	jalr	-1334(ra) # eea <fork>
        exit(0);
     428:	4501                	li	a0,0
     42a:	00001097          	auipc	ra,0x1
     42e:	ac8080e7          	jalr	-1336(ra) # ef2 <exit>
        printf("grind: fork failed\n");
     432:	00001517          	auipc	a0,0x1
     436:	0ee50513          	addi	a0,a0,238 # 1520 <malloc+0x20c>
     43a:	00001097          	auipc	ra,0x1
     43e:	e1e080e7          	jalr	-482(ra) # 1258 <printf>
        exit(1);
     442:	4505                	li	a0,1
     444:	00001097          	auipc	ra,0x1
     448:	aae080e7          	jalr	-1362(ra) # ef2 <exit>
      sbrk(6011);
     44c:	6505                	lui	a0,0x1
     44e:	77b50513          	addi	a0,a0,1915 # 177b <malloc+0x467>
     452:	00001097          	auipc	ra,0x1
     456:	b28080e7          	jalr	-1240(ra) # f7a <sbrk>
     45a:	b399                	j	1a0 <go+0xf2>
      if(sbrk(0) > break0)
     45c:	4501                	li	a0,0
     45e:	00001097          	auipc	ra,0x1
     462:	b1c080e7          	jalr	-1252(ra) # f7a <sbrk>
     466:	f5843783          	ld	a5,-168(s0)
     46a:	d2a7fbe3          	bgeu	a5,a0,1a0 <go+0xf2>
        sbrk(-(sbrk(0) - break0));
     46e:	4501                	li	a0,0
     470:	00001097          	auipc	ra,0x1
     474:	b0a080e7          	jalr	-1270(ra) # f7a <sbrk>
     478:	f5843783          	ld	a5,-168(s0)
     47c:	40a7853b          	subw	a0,a5,a0
     480:	00001097          	auipc	ra,0x1
     484:	afa080e7          	jalr	-1286(ra) # f7a <sbrk>
     488:	bb21                	j	1a0 <go+0xf2>
      int pid = fork();
     48a:	00001097          	auipc	ra,0x1
     48e:	a60080e7          	jalr	-1440(ra) # eea <fork>
     492:	8d2a                	mv	s10,a0
      if(pid == 0){
     494:	c51d                	beqz	a0,4c2 <go+0x414>
      } else if(pid < 0){
     496:	04054963          	bltz	a0,4e8 <go+0x43a>
      if(chdir("../grindir/..") != 0){
     49a:	00001517          	auipc	a0,0x1
     49e:	0a650513          	addi	a0,a0,166 # 1540 <malloc+0x22c>
     4a2:	00001097          	auipc	ra,0x1
     4a6:	ac0080e7          	jalr	-1344(ra) # f62 <chdir>
     4aa:	ed21                	bnez	a0,502 <go+0x454>
      kill(pid);
     4ac:	856a                	mv	a0,s10
     4ae:	00001097          	auipc	ra,0x1
     4b2:	a74080e7          	jalr	-1420(ra) # f22 <kill>
      wait(0);
     4b6:	4501                	li	a0,0
     4b8:	00001097          	auipc	ra,0x1
     4bc:	a42080e7          	jalr	-1470(ra) # efa <wait>
     4c0:	b1c5                	j	1a0 <go+0xf2>
        close(open("a", O_CREATE|O_RDWR));
     4c2:	20200593          	li	a1,514
     4c6:	00001517          	auipc	a0,0x1
     4ca:	07250513          	addi	a0,a0,114 # 1538 <malloc+0x224>
     4ce:	00001097          	auipc	ra,0x1
     4d2:	a64080e7          	jalr	-1436(ra) # f32 <open>
     4d6:	00001097          	auipc	ra,0x1
     4da:	a44080e7          	jalr	-1468(ra) # f1a <close>
        exit(0);
     4de:	4501                	li	a0,0
     4e0:	00001097          	auipc	ra,0x1
     4e4:	a12080e7          	jalr	-1518(ra) # ef2 <exit>
        printf("grind: fork failed\n");
     4e8:	00001517          	auipc	a0,0x1
     4ec:	03850513          	addi	a0,a0,56 # 1520 <malloc+0x20c>
     4f0:	00001097          	auipc	ra,0x1
     4f4:	d68080e7          	jalr	-664(ra) # 1258 <printf>
        exit(1);
     4f8:	4505                	li	a0,1
     4fa:	00001097          	auipc	ra,0x1
     4fe:	9f8080e7          	jalr	-1544(ra) # ef2 <exit>
        printf("grind: chdir failed\n");
     502:	00001517          	auipc	a0,0x1
     506:	04e50513          	addi	a0,a0,78 # 1550 <malloc+0x23c>
     50a:	00001097          	auipc	ra,0x1
     50e:	d4e080e7          	jalr	-690(ra) # 1258 <printf>
        exit(1);
     512:	4505                	li	a0,1
     514:	00001097          	auipc	ra,0x1
     518:	9de080e7          	jalr	-1570(ra) # ef2 <exit>
      int pid = fork();
     51c:	00001097          	auipc	ra,0x1
     520:	9ce080e7          	jalr	-1586(ra) # eea <fork>
      if(pid == 0){
     524:	c909                	beqz	a0,536 <go+0x488>
      } else if(pid < 0){
     526:	02054563          	bltz	a0,550 <go+0x4a2>
      wait(0);
     52a:	4501                	li	a0,0
     52c:	00001097          	auipc	ra,0x1
     530:	9ce080e7          	jalr	-1586(ra) # efa <wait>
     534:	b1b5                	j	1a0 <go+0xf2>
        kill(getpid());
     536:	00001097          	auipc	ra,0x1
     53a:	a3c080e7          	jalr	-1476(ra) # f72 <getpid>
     53e:	00001097          	auipc	ra,0x1
     542:	9e4080e7          	jalr	-1564(ra) # f22 <kill>
        exit(0);
     546:	4501                	li	a0,0
     548:	00001097          	auipc	ra,0x1
     54c:	9aa080e7          	jalr	-1622(ra) # ef2 <exit>
        printf("grind: fork failed\n");
     550:	00001517          	auipc	a0,0x1
     554:	fd050513          	addi	a0,a0,-48 # 1520 <malloc+0x20c>
     558:	00001097          	auipc	ra,0x1
     55c:	d00080e7          	jalr	-768(ra) # 1258 <printf>
        exit(1);
     560:	4505                	li	a0,1
     562:	00001097          	auipc	ra,0x1
     566:	990080e7          	jalr	-1648(ra) # ef2 <exit>
      if(pipe(fds) < 0){
     56a:	f7840513          	addi	a0,s0,-136
     56e:	00001097          	auipc	ra,0x1
     572:	994080e7          	jalr	-1644(ra) # f02 <pipe>
     576:	02054b63          	bltz	a0,5ac <go+0x4fe>
      int pid = fork();
     57a:	00001097          	auipc	ra,0x1
     57e:	970080e7          	jalr	-1680(ra) # eea <fork>
      if(pid == 0){
     582:	c131                	beqz	a0,5c6 <go+0x518>
      } else if(pid < 0){
     584:	0a054a63          	bltz	a0,638 <go+0x58a>
      close(fds[0]);
     588:	f7842503          	lw	a0,-136(s0)
     58c:	00001097          	auipc	ra,0x1
     590:	98e080e7          	jalr	-1650(ra) # f1a <close>
      close(fds[1]);
     594:	f7c42503          	lw	a0,-132(s0)
     598:	00001097          	auipc	ra,0x1
     59c:	982080e7          	jalr	-1662(ra) # f1a <close>
      wait(0);
     5a0:	4501                	li	a0,0
     5a2:	00001097          	auipc	ra,0x1
     5a6:	958080e7          	jalr	-1704(ra) # efa <wait>
     5aa:	bedd                	j	1a0 <go+0xf2>
        printf("grind: pipe failed\n");
     5ac:	00001517          	auipc	a0,0x1
     5b0:	fbc50513          	addi	a0,a0,-68 # 1568 <malloc+0x254>
     5b4:	00001097          	auipc	ra,0x1
     5b8:	ca4080e7          	jalr	-860(ra) # 1258 <printf>
        exit(1);
     5bc:	4505                	li	a0,1
     5be:	00001097          	auipc	ra,0x1
     5c2:	934080e7          	jalr	-1740(ra) # ef2 <exit>
        fork();
     5c6:	00001097          	auipc	ra,0x1
     5ca:	924080e7          	jalr	-1756(ra) # eea <fork>
        fork();
     5ce:	00001097          	auipc	ra,0x1
     5d2:	91c080e7          	jalr	-1764(ra) # eea <fork>
        if(write(fds[1], "x", 1) != 1)
     5d6:	4605                	li	a2,1
     5d8:	00001597          	auipc	a1,0x1
     5dc:	fa858593          	addi	a1,a1,-88 # 1580 <malloc+0x26c>
     5e0:	f7c42503          	lw	a0,-132(s0)
     5e4:	00001097          	auipc	ra,0x1
     5e8:	92e080e7          	jalr	-1746(ra) # f12 <write>
     5ec:	4785                	li	a5,1
     5ee:	02f51363          	bne	a0,a5,614 <go+0x566>
        if(read(fds[0], &c, 1) != 1)
     5f2:	4605                	li	a2,1
     5f4:	f7040593          	addi	a1,s0,-144
     5f8:	f7842503          	lw	a0,-136(s0)
     5fc:	00001097          	auipc	ra,0x1
     600:	90e080e7          	jalr	-1778(ra) # f0a <read>
     604:	4785                	li	a5,1
     606:	02f51063          	bne	a0,a5,626 <go+0x578>
        exit(0);
     60a:	4501                	li	a0,0
     60c:	00001097          	auipc	ra,0x1
     610:	8e6080e7          	jalr	-1818(ra) # ef2 <exit>
          printf("grind: pipe write failed\n");
     614:	00001517          	auipc	a0,0x1
     618:	f7450513          	addi	a0,a0,-140 # 1588 <malloc+0x274>
     61c:	00001097          	auipc	ra,0x1
     620:	c3c080e7          	jalr	-964(ra) # 1258 <printf>
     624:	b7f9                	j	5f2 <go+0x544>
          printf("grind: pipe read failed\n");
     626:	00001517          	auipc	a0,0x1
     62a:	f8250513          	addi	a0,a0,-126 # 15a8 <malloc+0x294>
     62e:	00001097          	auipc	ra,0x1
     632:	c2a080e7          	jalr	-982(ra) # 1258 <printf>
     636:	bfd1                	j	60a <go+0x55c>
        printf("grind: fork failed\n");
     638:	00001517          	auipc	a0,0x1
     63c:	ee850513          	addi	a0,a0,-280 # 1520 <malloc+0x20c>
     640:	00001097          	auipc	ra,0x1
     644:	c18080e7          	jalr	-1000(ra) # 1258 <printf>
        exit(1);
     648:	4505                	li	a0,1
     64a:	00001097          	auipc	ra,0x1
     64e:	8a8080e7          	jalr	-1880(ra) # ef2 <exit>
      int pid = fork();
     652:	00001097          	auipc	ra,0x1
     656:	898080e7          	jalr	-1896(ra) # eea <fork>
      if(pid == 0){
     65a:	c909                	beqz	a0,66c <go+0x5be>
      } else if(pid < 0){
     65c:	06054f63          	bltz	a0,6da <go+0x62c>
      wait(0);
     660:	4501                	li	a0,0
     662:	00001097          	auipc	ra,0x1
     666:	898080e7          	jalr	-1896(ra) # efa <wait>
     66a:	be1d                	j	1a0 <go+0xf2>
        unlink("a");
     66c:	00001517          	auipc	a0,0x1
     670:	ecc50513          	addi	a0,a0,-308 # 1538 <malloc+0x224>
     674:	00001097          	auipc	ra,0x1
     678:	8ce080e7          	jalr	-1842(ra) # f42 <unlink>
        mkdir("a");
     67c:	00001517          	auipc	a0,0x1
     680:	ebc50513          	addi	a0,a0,-324 # 1538 <malloc+0x224>
     684:	00001097          	auipc	ra,0x1
     688:	8d6080e7          	jalr	-1834(ra) # f5a <mkdir>
        chdir("a");
     68c:	00001517          	auipc	a0,0x1
     690:	eac50513          	addi	a0,a0,-340 # 1538 <malloc+0x224>
     694:	00001097          	auipc	ra,0x1
     698:	8ce080e7          	jalr	-1842(ra) # f62 <chdir>
        unlink("../a");
     69c:	00001517          	auipc	a0,0x1
     6a0:	f2c50513          	addi	a0,a0,-212 # 15c8 <malloc+0x2b4>
     6a4:	00001097          	auipc	ra,0x1
     6a8:	89e080e7          	jalr	-1890(ra) # f42 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     6ac:	20200593          	li	a1,514
     6b0:	00001517          	auipc	a0,0x1
     6b4:	ed050513          	addi	a0,a0,-304 # 1580 <malloc+0x26c>
     6b8:	00001097          	auipc	ra,0x1
     6bc:	87a080e7          	jalr	-1926(ra) # f32 <open>
        unlink("x");
     6c0:	00001517          	auipc	a0,0x1
     6c4:	ec050513          	addi	a0,a0,-320 # 1580 <malloc+0x26c>
     6c8:	00001097          	auipc	ra,0x1
     6cc:	87a080e7          	jalr	-1926(ra) # f42 <unlink>
        exit(0);
     6d0:	4501                	li	a0,0
     6d2:	00001097          	auipc	ra,0x1
     6d6:	820080e7          	jalr	-2016(ra) # ef2 <exit>
        printf("grind: fork failed\n");
     6da:	00001517          	auipc	a0,0x1
     6de:	e4650513          	addi	a0,a0,-442 # 1520 <malloc+0x20c>
     6e2:	00001097          	auipc	ra,0x1
     6e6:	b76080e7          	jalr	-1162(ra) # 1258 <printf>
        exit(1);
     6ea:	4505                	li	a0,1
     6ec:	00001097          	auipc	ra,0x1
     6f0:	806080e7          	jalr	-2042(ra) # ef2 <exit>
      unlink("c");
     6f4:	00001517          	auipc	a0,0x1
     6f8:	edc50513          	addi	a0,a0,-292 # 15d0 <malloc+0x2bc>
     6fc:	00001097          	auipc	ra,0x1
     700:	846080e7          	jalr	-1978(ra) # f42 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     704:	20200593          	li	a1,514
     708:	00001517          	auipc	a0,0x1
     70c:	ec850513          	addi	a0,a0,-312 # 15d0 <malloc+0x2bc>
     710:	00001097          	auipc	ra,0x1
     714:	822080e7          	jalr	-2014(ra) # f32 <open>
     718:	8d2a                	mv	s10,a0
      if(fd1 < 0){
     71a:	04054d63          	bltz	a0,774 <go+0x6c6>
      if(write(fd1, "x", 1) != 1){
     71e:	865e                	mv	a2,s7
     720:	00001597          	auipc	a1,0x1
     724:	e6058593          	addi	a1,a1,-416 # 1580 <malloc+0x26c>
     728:	00000097          	auipc	ra,0x0
     72c:	7ea080e7          	jalr	2026(ra) # f12 <write>
     730:	05751f63          	bne	a0,s7,78e <go+0x6e0>
      if(fstat(fd1, &st) != 0){
     734:	f7840593          	addi	a1,s0,-136
     738:	856a                	mv	a0,s10
     73a:	00001097          	auipc	ra,0x1
     73e:	810080e7          	jalr	-2032(ra) # f4a <fstat>
     742:	e13d                	bnez	a0,7a8 <go+0x6fa>
      if(st.size != 1){
     744:	f8843583          	ld	a1,-120(s0)
     748:	07759d63          	bne	a1,s7,7c2 <go+0x714>
      if(st.ino > 200){
     74c:	f7c42583          	lw	a1,-132(s0)
     750:	0c800793          	li	a5,200
     754:	08b7e563          	bltu	a5,a1,7de <go+0x730>
      close(fd1);
     758:	856a                	mv	a0,s10
     75a:	00000097          	auipc	ra,0x0
     75e:	7c0080e7          	jalr	1984(ra) # f1a <close>
      unlink("c");
     762:	00001517          	auipc	a0,0x1
     766:	e6e50513          	addi	a0,a0,-402 # 15d0 <malloc+0x2bc>
     76a:	00000097          	auipc	ra,0x0
     76e:	7d8080e7          	jalr	2008(ra) # f42 <unlink>
     772:	b43d                	j	1a0 <go+0xf2>
        printf("grind: create c failed\n");
     774:	00001517          	auipc	a0,0x1
     778:	e6450513          	addi	a0,a0,-412 # 15d8 <malloc+0x2c4>
     77c:	00001097          	auipc	ra,0x1
     780:	adc080e7          	jalr	-1316(ra) # 1258 <printf>
        exit(1);
     784:	4505                	li	a0,1
     786:	00000097          	auipc	ra,0x0
     78a:	76c080e7          	jalr	1900(ra) # ef2 <exit>
        printf("grind: write c failed\n");
     78e:	00001517          	auipc	a0,0x1
     792:	e6250513          	addi	a0,a0,-414 # 15f0 <malloc+0x2dc>
     796:	00001097          	auipc	ra,0x1
     79a:	ac2080e7          	jalr	-1342(ra) # 1258 <printf>
        exit(1);
     79e:	4505                	li	a0,1
     7a0:	00000097          	auipc	ra,0x0
     7a4:	752080e7          	jalr	1874(ra) # ef2 <exit>
        printf("grind: fstat failed\n");
     7a8:	00001517          	auipc	a0,0x1
     7ac:	e6050513          	addi	a0,a0,-416 # 1608 <malloc+0x2f4>
     7b0:	00001097          	auipc	ra,0x1
     7b4:	aa8080e7          	jalr	-1368(ra) # 1258 <printf>
        exit(1);
     7b8:	4505                	li	a0,1
     7ba:	00000097          	auipc	ra,0x0
     7be:	738080e7          	jalr	1848(ra) # ef2 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     7c2:	2581                	sext.w	a1,a1
     7c4:	00001517          	auipc	a0,0x1
     7c8:	e5c50513          	addi	a0,a0,-420 # 1620 <malloc+0x30c>
     7cc:	00001097          	auipc	ra,0x1
     7d0:	a8c080e7          	jalr	-1396(ra) # 1258 <printf>
        exit(1);
     7d4:	4505                	li	a0,1
     7d6:	00000097          	auipc	ra,0x0
     7da:	71c080e7          	jalr	1820(ra) # ef2 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     7de:	00001517          	auipc	a0,0x1
     7e2:	e6a50513          	addi	a0,a0,-406 # 1648 <malloc+0x334>
     7e6:	00001097          	auipc	ra,0x1
     7ea:	a72080e7          	jalr	-1422(ra) # 1258 <printf>
        exit(1);
     7ee:	4505                	li	a0,1
     7f0:	00000097          	auipc	ra,0x0
     7f4:	702080e7          	jalr	1794(ra) # ef2 <exit>
      if(pipe(aa) < 0){
     7f8:	856e                	mv	a0,s11
     7fa:	00000097          	auipc	ra,0x0
     7fe:	708080e7          	jalr	1800(ra) # f02 <pipe>
     802:	10054063          	bltz	a0,902 <go+0x854>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     806:	f7040513          	addi	a0,s0,-144
     80a:	00000097          	auipc	ra,0x0
     80e:	6f8080e7          	jalr	1784(ra) # f02 <pipe>
     812:	10054663          	bltz	a0,91e <go+0x870>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     816:	00000097          	auipc	ra,0x0
     81a:	6d4080e7          	jalr	1748(ra) # eea <fork>
      if(pid1 == 0){
     81e:	10050e63          	beqz	a0,93a <go+0x88c>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     822:	1c054663          	bltz	a0,9ee <go+0x940>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     826:	00000097          	auipc	ra,0x0
     82a:	6c4080e7          	jalr	1732(ra) # eea <fork>
      if(pid2 == 0){
     82e:	1c050e63          	beqz	a0,a0a <go+0x95c>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     832:	2a054a63          	bltz	a0,ae6 <go+0xa38>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     836:	f6842503          	lw	a0,-152(s0)
     83a:	00000097          	auipc	ra,0x0
     83e:	6e0080e7          	jalr	1760(ra) # f1a <close>
      close(aa[1]);
     842:	f6c42503          	lw	a0,-148(s0)
     846:	00000097          	auipc	ra,0x0
     84a:	6d4080e7          	jalr	1748(ra) # f1a <close>
      close(bb[1]);
     84e:	f7442503          	lw	a0,-140(s0)
     852:	00000097          	auipc	ra,0x0
     856:	6c8080e7          	jalr	1736(ra) # f1a <close>
      char buf[4] = { 0, 0, 0, 0 };
     85a:	f6042023          	sw	zero,-160(s0)
      read(bb[0], buf+0, 1);
     85e:	865e                	mv	a2,s7
     860:	f6040593          	addi	a1,s0,-160
     864:	f7042503          	lw	a0,-144(s0)
     868:	00000097          	auipc	ra,0x0
     86c:	6a2080e7          	jalr	1698(ra) # f0a <read>
      read(bb[0], buf+1, 1);
     870:	865e                	mv	a2,s7
     872:	f6140593          	addi	a1,s0,-159
     876:	f7042503          	lw	a0,-144(s0)
     87a:	00000097          	auipc	ra,0x0
     87e:	690080e7          	jalr	1680(ra) # f0a <read>
      read(bb[0], buf+2, 1);
     882:	865e                	mv	a2,s7
     884:	f6240593          	addi	a1,s0,-158
     888:	f7042503          	lw	a0,-144(s0)
     88c:	00000097          	auipc	ra,0x0
     890:	67e080e7          	jalr	1662(ra) # f0a <read>
      close(bb[0]);
     894:	f7042503          	lw	a0,-144(s0)
     898:	00000097          	auipc	ra,0x0
     89c:	682080e7          	jalr	1666(ra) # f1a <close>
      int st1, st2;
      wait(&st1);
     8a0:	f6440513          	addi	a0,s0,-156
     8a4:	00000097          	auipc	ra,0x0
     8a8:	656080e7          	jalr	1622(ra) # efa <wait>
      wait(&st2);
     8ac:	f7840513          	addi	a0,s0,-136
     8b0:	00000097          	auipc	ra,0x0
     8b4:	64a080e7          	jalr	1610(ra) # efa <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     8b8:	f6442783          	lw	a5,-156(s0)
     8bc:	f7842703          	lw	a4,-136(s0)
     8c0:	8fd9                	or	a5,a5,a4
     8c2:	ef89                	bnez	a5,8dc <go+0x82e>
     8c4:	00001597          	auipc	a1,0x1
     8c8:	e2458593          	addi	a1,a1,-476 # 16e8 <malloc+0x3d4>
     8cc:	f6040513          	addi	a0,s0,-160
     8d0:	00000097          	auipc	ra,0x0
     8d4:	388080e7          	jalr	904(ra) # c58 <strcmp>
     8d8:	8c0504e3          	beqz	a0,1a0 <go+0xf2>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     8dc:	f6040693          	addi	a3,s0,-160
     8e0:	f7842603          	lw	a2,-136(s0)
     8e4:	f6442583          	lw	a1,-156(s0)
     8e8:	00001517          	auipc	a0,0x1
     8ec:	e0850513          	addi	a0,a0,-504 # 16f0 <malloc+0x3dc>
     8f0:	00001097          	auipc	ra,0x1
     8f4:	968080e7          	jalr	-1688(ra) # 1258 <printf>
        exit(1);
     8f8:	4505                	li	a0,1
     8fa:	00000097          	auipc	ra,0x0
     8fe:	5f8080e7          	jalr	1528(ra) # ef2 <exit>
        fprintf(2, "grind: pipe failed\n");
     902:	00001597          	auipc	a1,0x1
     906:	c6658593          	addi	a1,a1,-922 # 1568 <malloc+0x254>
     90a:	4509                	li	a0,2
     90c:	00001097          	auipc	ra,0x1
     910:	91e080e7          	jalr	-1762(ra) # 122a <fprintf>
        exit(1);
     914:	4505                	li	a0,1
     916:	00000097          	auipc	ra,0x0
     91a:	5dc080e7          	jalr	1500(ra) # ef2 <exit>
        fprintf(2, "grind: pipe failed\n");
     91e:	00001597          	auipc	a1,0x1
     922:	c4a58593          	addi	a1,a1,-950 # 1568 <malloc+0x254>
     926:	4509                	li	a0,2
     928:	00001097          	auipc	ra,0x1
     92c:	902080e7          	jalr	-1790(ra) # 122a <fprintf>
        exit(1);
     930:	4505                	li	a0,1
     932:	00000097          	auipc	ra,0x0
     936:	5c0080e7          	jalr	1472(ra) # ef2 <exit>
        close(bb[0]);
     93a:	f7042503          	lw	a0,-144(s0)
     93e:	00000097          	auipc	ra,0x0
     942:	5dc080e7          	jalr	1500(ra) # f1a <close>
        close(bb[1]);
     946:	f7442503          	lw	a0,-140(s0)
     94a:	00000097          	auipc	ra,0x0
     94e:	5d0080e7          	jalr	1488(ra) # f1a <close>
        close(aa[0]);
     952:	f6842503          	lw	a0,-152(s0)
     956:	00000097          	auipc	ra,0x0
     95a:	5c4080e7          	jalr	1476(ra) # f1a <close>
        close(1);
     95e:	4505                	li	a0,1
     960:	00000097          	auipc	ra,0x0
     964:	5ba080e7          	jalr	1466(ra) # f1a <close>
        if(dup(aa[1]) != 1){
     968:	f6c42503          	lw	a0,-148(s0)
     96c:	00000097          	auipc	ra,0x0
     970:	5fe080e7          	jalr	1534(ra) # f6a <dup>
     974:	4785                	li	a5,1
     976:	02f50063          	beq	a0,a5,996 <go+0x8e8>
          fprintf(2, "grind: dup failed\n");
     97a:	00001597          	auipc	a1,0x1
     97e:	cf658593          	addi	a1,a1,-778 # 1670 <malloc+0x35c>
     982:	4509                	li	a0,2
     984:	00001097          	auipc	ra,0x1
     988:	8a6080e7          	jalr	-1882(ra) # 122a <fprintf>
          exit(1);
     98c:	4505                	li	a0,1
     98e:	00000097          	auipc	ra,0x0
     992:	564080e7          	jalr	1380(ra) # ef2 <exit>
        close(aa[1]);
     996:	f6c42503          	lw	a0,-148(s0)
     99a:	00000097          	auipc	ra,0x0
     99e:	580080e7          	jalr	1408(ra) # f1a <close>
        char *args[3] = { "echo", "hi", 0 };
     9a2:	00001797          	auipc	a5,0x1
     9a6:	ce678793          	addi	a5,a5,-794 # 1688 <malloc+0x374>
     9aa:	f6f43c23          	sd	a5,-136(s0)
     9ae:	00001797          	auipc	a5,0x1
     9b2:	ce278793          	addi	a5,a5,-798 # 1690 <malloc+0x37c>
     9b6:	f8f43023          	sd	a5,-128(s0)
     9ba:	f8043423          	sd	zero,-120(s0)
        exec("grindir/../echo", args);
     9be:	f7840593          	addi	a1,s0,-136
     9c2:	00001517          	auipc	a0,0x1
     9c6:	cd650513          	addi	a0,a0,-810 # 1698 <malloc+0x384>
     9ca:	00000097          	auipc	ra,0x0
     9ce:	560080e7          	jalr	1376(ra) # f2a <exec>
        fprintf(2, "grind: echo: not found\n");
     9d2:	00001597          	auipc	a1,0x1
     9d6:	cd658593          	addi	a1,a1,-810 # 16a8 <malloc+0x394>
     9da:	4509                	li	a0,2
     9dc:	00001097          	auipc	ra,0x1
     9e0:	84e080e7          	jalr	-1970(ra) # 122a <fprintf>
        exit(2);
     9e4:	4509                	li	a0,2
     9e6:	00000097          	auipc	ra,0x0
     9ea:	50c080e7          	jalr	1292(ra) # ef2 <exit>
        fprintf(2, "grind: fork failed\n");
     9ee:	00001597          	auipc	a1,0x1
     9f2:	b3258593          	addi	a1,a1,-1230 # 1520 <malloc+0x20c>
     9f6:	4509                	li	a0,2
     9f8:	00001097          	auipc	ra,0x1
     9fc:	832080e7          	jalr	-1998(ra) # 122a <fprintf>
        exit(3);
     a00:	450d                	li	a0,3
     a02:	00000097          	auipc	ra,0x0
     a06:	4f0080e7          	jalr	1264(ra) # ef2 <exit>
        close(aa[1]);
     a0a:	f6c42503          	lw	a0,-148(s0)
     a0e:	00000097          	auipc	ra,0x0
     a12:	50c080e7          	jalr	1292(ra) # f1a <close>
        close(bb[0]);
     a16:	f7042503          	lw	a0,-144(s0)
     a1a:	00000097          	auipc	ra,0x0
     a1e:	500080e7          	jalr	1280(ra) # f1a <close>
        close(0);
     a22:	4501                	li	a0,0
     a24:	00000097          	auipc	ra,0x0
     a28:	4f6080e7          	jalr	1270(ra) # f1a <close>
        if(dup(aa[0]) != 0){
     a2c:	f6842503          	lw	a0,-152(s0)
     a30:	00000097          	auipc	ra,0x0
     a34:	53a080e7          	jalr	1338(ra) # f6a <dup>
     a38:	cd19                	beqz	a0,a56 <go+0x9a8>
          fprintf(2, "grind: dup failed\n");
     a3a:	00001597          	auipc	a1,0x1
     a3e:	c3658593          	addi	a1,a1,-970 # 1670 <malloc+0x35c>
     a42:	4509                	li	a0,2
     a44:	00000097          	auipc	ra,0x0
     a48:	7e6080e7          	jalr	2022(ra) # 122a <fprintf>
          exit(4);
     a4c:	4511                	li	a0,4
     a4e:	00000097          	auipc	ra,0x0
     a52:	4a4080e7          	jalr	1188(ra) # ef2 <exit>
        close(aa[0]);
     a56:	f6842503          	lw	a0,-152(s0)
     a5a:	00000097          	auipc	ra,0x0
     a5e:	4c0080e7          	jalr	1216(ra) # f1a <close>
        close(1);
     a62:	4505                	li	a0,1
     a64:	00000097          	auipc	ra,0x0
     a68:	4b6080e7          	jalr	1206(ra) # f1a <close>
        if(dup(bb[1]) != 1){
     a6c:	f7442503          	lw	a0,-140(s0)
     a70:	00000097          	auipc	ra,0x0
     a74:	4fa080e7          	jalr	1274(ra) # f6a <dup>
     a78:	4785                	li	a5,1
     a7a:	02f50063          	beq	a0,a5,a9a <go+0x9ec>
          fprintf(2, "grind: dup failed\n");
     a7e:	00001597          	auipc	a1,0x1
     a82:	bf258593          	addi	a1,a1,-1038 # 1670 <malloc+0x35c>
     a86:	4509                	li	a0,2
     a88:	00000097          	auipc	ra,0x0
     a8c:	7a2080e7          	jalr	1954(ra) # 122a <fprintf>
          exit(5);
     a90:	4515                	li	a0,5
     a92:	00000097          	auipc	ra,0x0
     a96:	460080e7          	jalr	1120(ra) # ef2 <exit>
        close(bb[1]);
     a9a:	f7442503          	lw	a0,-140(s0)
     a9e:	00000097          	auipc	ra,0x0
     aa2:	47c080e7          	jalr	1148(ra) # f1a <close>
        char *args[2] = { "cat", 0 };
     aa6:	00001797          	auipc	a5,0x1
     aaa:	c1a78793          	addi	a5,a5,-998 # 16c0 <malloc+0x3ac>
     aae:	f6f43c23          	sd	a5,-136(s0)
     ab2:	f8043023          	sd	zero,-128(s0)
        exec("/cat", args);
     ab6:	f7840593          	addi	a1,s0,-136
     aba:	00001517          	auipc	a0,0x1
     abe:	c0e50513          	addi	a0,a0,-1010 # 16c8 <malloc+0x3b4>
     ac2:	00000097          	auipc	ra,0x0
     ac6:	468080e7          	jalr	1128(ra) # f2a <exec>
        fprintf(2, "grind: cat: not found\n");
     aca:	00001597          	auipc	a1,0x1
     ace:	c0658593          	addi	a1,a1,-1018 # 16d0 <malloc+0x3bc>
     ad2:	4509                	li	a0,2
     ad4:	00000097          	auipc	ra,0x0
     ad8:	756080e7          	jalr	1878(ra) # 122a <fprintf>
        exit(6);
     adc:	4519                	li	a0,6
     ade:	00000097          	auipc	ra,0x0
     ae2:	414080e7          	jalr	1044(ra) # ef2 <exit>
        fprintf(2, "grind: fork failed\n");
     ae6:	00001597          	auipc	a1,0x1
     aea:	a3a58593          	addi	a1,a1,-1478 # 1520 <malloc+0x20c>
     aee:	4509                	li	a0,2
     af0:	00000097          	auipc	ra,0x0
     af4:	73a080e7          	jalr	1850(ra) # 122a <fprintf>
        exit(7);
     af8:	451d                	li	a0,7
     afa:	00000097          	auipc	ra,0x0
     afe:	3f8080e7          	jalr	1016(ra) # ef2 <exit>

0000000000000b02 <iter>:
  }
}

void
iter()
{
     b02:	7179                	addi	sp,sp,-48
     b04:	f406                	sd	ra,40(sp)
     b06:	f022                	sd	s0,32(sp)
     b08:	1800                	addi	s0,sp,48
  unlink("a");
     b0a:	00001517          	auipc	a0,0x1
     b0e:	a2e50513          	addi	a0,a0,-1490 # 1538 <malloc+0x224>
     b12:	00000097          	auipc	ra,0x0
     b16:	430080e7          	jalr	1072(ra) # f42 <unlink>
  unlink("b");
     b1a:	00001517          	auipc	a0,0x1
     b1e:	9ce50513          	addi	a0,a0,-1586 # 14e8 <malloc+0x1d4>
     b22:	00000097          	auipc	ra,0x0
     b26:	420080e7          	jalr	1056(ra) # f42 <unlink>
  
  int pid1 = fork();
     b2a:	00000097          	auipc	ra,0x0
     b2e:	3c0080e7          	jalr	960(ra) # eea <fork>
  if(pid1 < 0){
     b32:	02054063          	bltz	a0,b52 <iter+0x50>
     b36:	ec26                	sd	s1,24(sp)
     b38:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     b3a:	e91d                	bnez	a0,b70 <iter+0x6e>
     b3c:	e84a                	sd	s2,16(sp)
    rand_next = 31;
     b3e:	47fd                	li	a5,31
     b40:	00001717          	auipc	a4,0x1
     b44:	caf73823          	sd	a5,-848(a4) # 17f0 <rand_next>
    go(0);
     b48:	4501                	li	a0,0
     b4a:	fffff097          	auipc	ra,0xfffff
     b4e:	564080e7          	jalr	1380(ra) # ae <go>
     b52:	ec26                	sd	s1,24(sp)
     b54:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     b56:	00001517          	auipc	a0,0x1
     b5a:	9ca50513          	addi	a0,a0,-1590 # 1520 <malloc+0x20c>
     b5e:	00000097          	auipc	ra,0x0
     b62:	6fa080e7          	jalr	1786(ra) # 1258 <printf>
    exit(1);
     b66:	4505                	li	a0,1
     b68:	00000097          	auipc	ra,0x0
     b6c:	38a080e7          	jalr	906(ra) # ef2 <exit>
     b70:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     b72:	00000097          	auipc	ra,0x0
     b76:	378080e7          	jalr	888(ra) # eea <fork>
     b7a:	892a                	mv	s2,a0
  if(pid2 < 0){
     b7c:	00054f63          	bltz	a0,b9a <iter+0x98>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     b80:	e915                	bnez	a0,bb4 <iter+0xb2>
    rand_next = 7177;
     b82:	6789                	lui	a5,0x2
     b84:	c0978793          	addi	a5,a5,-1015 # 1c09 <__BSS_END__+0x11>
     b88:	00001717          	auipc	a4,0x1
     b8c:	c6f73423          	sd	a5,-920(a4) # 17f0 <rand_next>
    go(1);
     b90:	4505                	li	a0,1
     b92:	fffff097          	auipc	ra,0xfffff
     b96:	51c080e7          	jalr	1308(ra) # ae <go>
    printf("grind: fork failed\n");
     b9a:	00001517          	auipc	a0,0x1
     b9e:	98650513          	addi	a0,a0,-1658 # 1520 <malloc+0x20c>
     ba2:	00000097          	auipc	ra,0x0
     ba6:	6b6080e7          	jalr	1718(ra) # 1258 <printf>
    exit(1);
     baa:	4505                	li	a0,1
     bac:	00000097          	auipc	ra,0x0
     bb0:	346080e7          	jalr	838(ra) # ef2 <exit>
    exit(0);
  }

  int st1 = -1;
     bb4:	57fd                	li	a5,-1
     bb6:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     bba:	fdc40513          	addi	a0,s0,-36
     bbe:	00000097          	auipc	ra,0x0
     bc2:	33c080e7          	jalr	828(ra) # efa <wait>
  if(st1 != 0){
     bc6:	fdc42783          	lw	a5,-36(s0)
     bca:	ef99                	bnez	a5,be8 <iter+0xe6>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     bcc:	57fd                	li	a5,-1
     bce:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     bd2:	fd840513          	addi	a0,s0,-40
     bd6:	00000097          	auipc	ra,0x0
     bda:	324080e7          	jalr	804(ra) # efa <wait>

  exit(0);
     bde:	4501                	li	a0,0
     be0:	00000097          	auipc	ra,0x0
     be4:	312080e7          	jalr	786(ra) # ef2 <exit>
    kill(pid1);
     be8:	8526                	mv	a0,s1
     bea:	00000097          	auipc	ra,0x0
     bee:	338080e7          	jalr	824(ra) # f22 <kill>
    kill(pid2);
     bf2:	854a                	mv	a0,s2
     bf4:	00000097          	auipc	ra,0x0
     bf8:	32e080e7          	jalr	814(ra) # f22 <kill>
     bfc:	bfc1                	j	bcc <iter+0xca>

0000000000000bfe <main>:
}

int
main()
{
     bfe:	1101                	addi	sp,sp,-32
     c00:	ec06                	sd	ra,24(sp)
     c02:	e822                	sd	s0,16(sp)
     c04:	e426                	sd	s1,8(sp)
     c06:	1000                	addi	s0,sp,32
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     c08:	44d1                	li	s1,20
     c0a:	a811                	j	c1e <main+0x20>
      iter();
     c0c:	00000097          	auipc	ra,0x0
     c10:	ef6080e7          	jalr	-266(ra) # b02 <iter>
    sleep(20);
     c14:	8526                	mv	a0,s1
     c16:	00000097          	auipc	ra,0x0
     c1a:	36c080e7          	jalr	876(ra) # f82 <sleep>
    int pid = fork();
     c1e:	00000097          	auipc	ra,0x0
     c22:	2cc080e7          	jalr	716(ra) # eea <fork>
    if(pid == 0){
     c26:	d17d                	beqz	a0,c0c <main+0xe>
    if(pid > 0){
     c28:	fea056e3          	blez	a0,c14 <main+0x16>
      wait(0);
     c2c:	4501                	li	a0,0
     c2e:	00000097          	auipc	ra,0x0
     c32:	2cc080e7          	jalr	716(ra) # efa <wait>
     c36:	bff9                	j	c14 <main+0x16>

0000000000000c38 <strcpy>:



char*
strcpy(char *s, const char *t)
{
     c38:	1141                	addi	sp,sp,-16
     c3a:	e406                	sd	ra,8(sp)
     c3c:	e022                	sd	s0,0(sp)
     c3e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c40:	87aa                	mv	a5,a0
     c42:	0585                	addi	a1,a1,1
     c44:	0785                	addi	a5,a5,1
     c46:	fff5c703          	lbu	a4,-1(a1)
     c4a:	fee78fa3          	sb	a4,-1(a5)
     c4e:	fb75                	bnez	a4,c42 <strcpy+0xa>
    ;
  return os;
}
     c50:	60a2                	ld	ra,8(sp)
     c52:	6402                	ld	s0,0(sp)
     c54:	0141                	addi	sp,sp,16
     c56:	8082                	ret

0000000000000c58 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c58:	1141                	addi	sp,sp,-16
     c5a:	e406                	sd	ra,8(sp)
     c5c:	e022                	sd	s0,0(sp)
     c5e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     c60:	00054783          	lbu	a5,0(a0)
     c64:	cb91                	beqz	a5,c78 <strcmp+0x20>
     c66:	0005c703          	lbu	a4,0(a1)
     c6a:	00f71763          	bne	a4,a5,c78 <strcmp+0x20>
    p++, q++;
     c6e:	0505                	addi	a0,a0,1
     c70:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     c72:	00054783          	lbu	a5,0(a0)
     c76:	fbe5                	bnez	a5,c66 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     c78:	0005c503          	lbu	a0,0(a1)
}
     c7c:	40a7853b          	subw	a0,a5,a0
     c80:	60a2                	ld	ra,8(sp)
     c82:	6402                	ld	s0,0(sp)
     c84:	0141                	addi	sp,sp,16
     c86:	8082                	ret

0000000000000c88 <strlen>:

uint
strlen(const char *s)
{
     c88:	1141                	addi	sp,sp,-16
     c8a:	e406                	sd	ra,8(sp)
     c8c:	e022                	sd	s0,0(sp)
     c8e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     c90:	00054783          	lbu	a5,0(a0)
     c94:	cf99                	beqz	a5,cb2 <strlen+0x2a>
     c96:	0505                	addi	a0,a0,1
     c98:	87aa                	mv	a5,a0
     c9a:	86be                	mv	a3,a5
     c9c:	0785                	addi	a5,a5,1
     c9e:	fff7c703          	lbu	a4,-1(a5)
     ca2:	ff65                	bnez	a4,c9a <strlen+0x12>
     ca4:	40a6853b          	subw	a0,a3,a0
     ca8:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     caa:	60a2                	ld	ra,8(sp)
     cac:	6402                	ld	s0,0(sp)
     cae:	0141                	addi	sp,sp,16
     cb0:	8082                	ret
  for(n = 0; s[n]; n++)
     cb2:	4501                	li	a0,0
     cb4:	bfdd                	j	caa <strlen+0x22>

0000000000000cb6 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cb6:	1141                	addi	sp,sp,-16
     cb8:	e406                	sd	ra,8(sp)
     cba:	e022                	sd	s0,0(sp)
     cbc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     cbe:	ca19                	beqz	a2,cd4 <memset+0x1e>
     cc0:	87aa                	mv	a5,a0
     cc2:	1602                	slli	a2,a2,0x20
     cc4:	9201                	srli	a2,a2,0x20
     cc6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     cca:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     cce:	0785                	addi	a5,a5,1
     cd0:	fee79de3          	bne	a5,a4,cca <memset+0x14>
  }
  return dst;
}
     cd4:	60a2                	ld	ra,8(sp)
     cd6:	6402                	ld	s0,0(sp)
     cd8:	0141                	addi	sp,sp,16
     cda:	8082                	ret

0000000000000cdc <strchr>:

char*
strchr(const char *s, char c)
{
     cdc:	1141                	addi	sp,sp,-16
     cde:	e406                	sd	ra,8(sp)
     ce0:	e022                	sd	s0,0(sp)
     ce2:	0800                	addi	s0,sp,16
  for(; *s; s++)
     ce4:	00054783          	lbu	a5,0(a0)
     ce8:	cf81                	beqz	a5,d00 <strchr+0x24>
    if(*s == c)
     cea:	00f58763          	beq	a1,a5,cf8 <strchr+0x1c>
  for(; *s; s++)
     cee:	0505                	addi	a0,a0,1
     cf0:	00054783          	lbu	a5,0(a0)
     cf4:	fbfd                	bnez	a5,cea <strchr+0xe>
      return (char*)s;
  return 0;
     cf6:	4501                	li	a0,0
}
     cf8:	60a2                	ld	ra,8(sp)
     cfa:	6402                	ld	s0,0(sp)
     cfc:	0141                	addi	sp,sp,16
     cfe:	8082                	ret
  return 0;
     d00:	4501                	li	a0,0
     d02:	bfdd                	j	cf8 <strchr+0x1c>

0000000000000d04 <gets>:

char*
gets(char *buf, int max)
{
     d04:	7159                	addi	sp,sp,-112
     d06:	f486                	sd	ra,104(sp)
     d08:	f0a2                	sd	s0,96(sp)
     d0a:	eca6                	sd	s1,88(sp)
     d0c:	e8ca                	sd	s2,80(sp)
     d0e:	e4ce                	sd	s3,72(sp)
     d10:	e0d2                	sd	s4,64(sp)
     d12:	fc56                	sd	s5,56(sp)
     d14:	f85a                	sd	s6,48(sp)
     d16:	f45e                	sd	s7,40(sp)
     d18:	f062                	sd	s8,32(sp)
     d1a:	ec66                	sd	s9,24(sp)
     d1c:	e86a                	sd	s10,16(sp)
     d1e:	1880                	addi	s0,sp,112
     d20:	8caa                	mv	s9,a0
     d22:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d24:	892a                	mv	s2,a0
     d26:	4481                	li	s1,0
    cc = read(0, &c, 1);
     d28:	f9f40b13          	addi	s6,s0,-97
     d2c:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     d2e:	4ba9                	li	s7,10
     d30:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
     d32:	8d26                	mv	s10,s1
     d34:	0014899b          	addiw	s3,s1,1
     d38:	84ce                	mv	s1,s3
     d3a:	0349d763          	bge	s3,s4,d68 <gets+0x64>
    cc = read(0, &c, 1);
     d3e:	8656                	mv	a2,s5
     d40:	85da                	mv	a1,s6
     d42:	4501                	li	a0,0
     d44:	00000097          	auipc	ra,0x0
     d48:	1c6080e7          	jalr	454(ra) # f0a <read>
    if(cc < 1)
     d4c:	00a05e63          	blez	a0,d68 <gets+0x64>
    buf[i++] = c;
     d50:	f9f44783          	lbu	a5,-97(s0)
     d54:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     d58:	01778763          	beq	a5,s7,d66 <gets+0x62>
     d5c:	0905                	addi	s2,s2,1
     d5e:	fd879ae3          	bne	a5,s8,d32 <gets+0x2e>
    buf[i++] = c;
     d62:	8d4e                	mv	s10,s3
     d64:	a011                	j	d68 <gets+0x64>
     d66:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
     d68:	9d66                	add	s10,s10,s9
     d6a:	000d0023          	sb	zero,0(s10)
  return buf;
}
     d6e:	8566                	mv	a0,s9
     d70:	70a6                	ld	ra,104(sp)
     d72:	7406                	ld	s0,96(sp)
     d74:	64e6                	ld	s1,88(sp)
     d76:	6946                	ld	s2,80(sp)
     d78:	69a6                	ld	s3,72(sp)
     d7a:	6a06                	ld	s4,64(sp)
     d7c:	7ae2                	ld	s5,56(sp)
     d7e:	7b42                	ld	s6,48(sp)
     d80:	7ba2                	ld	s7,40(sp)
     d82:	7c02                	ld	s8,32(sp)
     d84:	6ce2                	ld	s9,24(sp)
     d86:	6d42                	ld	s10,16(sp)
     d88:	6165                	addi	sp,sp,112
     d8a:	8082                	ret

0000000000000d8c <stat>:

int
stat(const char *n, struct stat *st)
{
     d8c:	1101                	addi	sp,sp,-32
     d8e:	ec06                	sd	ra,24(sp)
     d90:	e822                	sd	s0,16(sp)
     d92:	e04a                	sd	s2,0(sp)
     d94:	1000                	addi	s0,sp,32
     d96:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d98:	4581                	li	a1,0
     d9a:	00000097          	auipc	ra,0x0
     d9e:	198080e7          	jalr	408(ra) # f32 <open>
  if(fd < 0)
     da2:	02054663          	bltz	a0,dce <stat+0x42>
     da6:	e426                	sd	s1,8(sp)
     da8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     daa:	85ca                	mv	a1,s2
     dac:	00000097          	auipc	ra,0x0
     db0:	19e080e7          	jalr	414(ra) # f4a <fstat>
     db4:	892a                	mv	s2,a0
  close(fd);
     db6:	8526                	mv	a0,s1
     db8:	00000097          	auipc	ra,0x0
     dbc:	162080e7          	jalr	354(ra) # f1a <close>
  return r;
     dc0:	64a2                	ld	s1,8(sp)
}
     dc2:	854a                	mv	a0,s2
     dc4:	60e2                	ld	ra,24(sp)
     dc6:	6442                	ld	s0,16(sp)
     dc8:	6902                	ld	s2,0(sp)
     dca:	6105                	addi	sp,sp,32
     dcc:	8082                	ret
    return -1;
     dce:	597d                	li	s2,-1
     dd0:	bfcd                	j	dc2 <stat+0x36>

0000000000000dd2 <atoi>:

int
atoi(const char *s)
{
     dd2:	1141                	addi	sp,sp,-16
     dd4:	e406                	sd	ra,8(sp)
     dd6:	e022                	sd	s0,0(sp)
     dd8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dda:	00054683          	lbu	a3,0(a0)
     dde:	fd06879b          	addiw	a5,a3,-48
     de2:	0ff7f793          	zext.b	a5,a5
     de6:	4625                	li	a2,9
     de8:	02f66963          	bltu	a2,a5,e1a <atoi+0x48>
     dec:	872a                	mv	a4,a0
  n = 0;
     dee:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     df0:	0705                	addi	a4,a4,1
     df2:	0025179b          	slliw	a5,a0,0x2
     df6:	9fa9                	addw	a5,a5,a0
     df8:	0017979b          	slliw	a5,a5,0x1
     dfc:	9fb5                	addw	a5,a5,a3
     dfe:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     e02:	00074683          	lbu	a3,0(a4)
     e06:	fd06879b          	addiw	a5,a3,-48
     e0a:	0ff7f793          	zext.b	a5,a5
     e0e:	fef671e3          	bgeu	a2,a5,df0 <atoi+0x1e>
  return n;
}
     e12:	60a2                	ld	ra,8(sp)
     e14:	6402                	ld	s0,0(sp)
     e16:	0141                	addi	sp,sp,16
     e18:	8082                	ret
  n = 0;
     e1a:	4501                	li	a0,0
     e1c:	bfdd                	j	e12 <atoi+0x40>

0000000000000e1e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     e1e:	1141                	addi	sp,sp,-16
     e20:	e406                	sd	ra,8(sp)
     e22:	e022                	sd	s0,0(sp)
     e24:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     e26:	02b57563          	bgeu	a0,a1,e50 <memmove+0x32>
    while(n-- > 0)
     e2a:	00c05f63          	blez	a2,e48 <memmove+0x2a>
     e2e:	1602                	slli	a2,a2,0x20
     e30:	9201                	srli	a2,a2,0x20
     e32:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     e36:	872a                	mv	a4,a0
      *dst++ = *src++;
     e38:	0585                	addi	a1,a1,1
     e3a:	0705                	addi	a4,a4,1
     e3c:	fff5c683          	lbu	a3,-1(a1)
     e40:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     e44:	fee79ae3          	bne	a5,a4,e38 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     e48:	60a2                	ld	ra,8(sp)
     e4a:	6402                	ld	s0,0(sp)
     e4c:	0141                	addi	sp,sp,16
     e4e:	8082                	ret
    dst += n;
     e50:	00c50733          	add	a4,a0,a2
    src += n;
     e54:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     e56:	fec059e3          	blez	a2,e48 <memmove+0x2a>
     e5a:	fff6079b          	addiw	a5,a2,-1
     e5e:	1782                	slli	a5,a5,0x20
     e60:	9381                	srli	a5,a5,0x20
     e62:	fff7c793          	not	a5,a5
     e66:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     e68:	15fd                	addi	a1,a1,-1
     e6a:	177d                	addi	a4,a4,-1
     e6c:	0005c683          	lbu	a3,0(a1)
     e70:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     e74:	fef71ae3          	bne	a4,a5,e68 <memmove+0x4a>
     e78:	bfc1                	j	e48 <memmove+0x2a>

0000000000000e7a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     e7a:	1141                	addi	sp,sp,-16
     e7c:	e406                	sd	ra,8(sp)
     e7e:	e022                	sd	s0,0(sp)
     e80:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     e82:	ca0d                	beqz	a2,eb4 <memcmp+0x3a>
     e84:	fff6069b          	addiw	a3,a2,-1
     e88:	1682                	slli	a3,a3,0x20
     e8a:	9281                	srli	a3,a3,0x20
     e8c:	0685                	addi	a3,a3,1
     e8e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     e90:	00054783          	lbu	a5,0(a0)
     e94:	0005c703          	lbu	a4,0(a1)
     e98:	00e79863          	bne	a5,a4,ea8 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
     e9c:	0505                	addi	a0,a0,1
    p2++;
     e9e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     ea0:	fed518e3          	bne	a0,a3,e90 <memcmp+0x16>
  }
  return 0;
     ea4:	4501                	li	a0,0
     ea6:	a019                	j	eac <memcmp+0x32>
      return *p1 - *p2;
     ea8:	40e7853b          	subw	a0,a5,a4
}
     eac:	60a2                	ld	ra,8(sp)
     eae:	6402                	ld	s0,0(sp)
     eb0:	0141                	addi	sp,sp,16
     eb2:	8082                	ret
  return 0;
     eb4:	4501                	li	a0,0
     eb6:	bfdd                	j	eac <memcmp+0x32>

0000000000000eb8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     eb8:	1141                	addi	sp,sp,-16
     eba:	e406                	sd	ra,8(sp)
     ebc:	e022                	sd	s0,0(sp)
     ebe:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     ec0:	00000097          	auipc	ra,0x0
     ec4:	f5e080e7          	jalr	-162(ra) # e1e <memmove>
}
     ec8:	60a2                	ld	ra,8(sp)
     eca:	6402                	ld	s0,0(sp)
     ecc:	0141                	addi	sp,sp,16
     ece:	8082                	ret

0000000000000ed0 <ugetpid>:


#ifdef LAB_PGTBL
int
ugetpid(void)
{
     ed0:	1141                	addi	sp,sp,-16
     ed2:	e406                	sd	ra,8(sp)
     ed4:	e022                	sd	s0,0(sp)
     ed6:	0800                	addi	s0,sp,16
  struct usyscall *u = (struct usyscall *)USYSCALL;
  return u->pid;
     ed8:	040007b7          	lui	a5,0x4000
     edc:	17f5                	addi	a5,a5,-3 # 3fffffd <__global_pointer$+0x3ffe014>
     ede:	07b2                	slli	a5,a5,0xc
}
     ee0:	4388                	lw	a0,0(a5)
     ee2:	60a2                	ld	ra,8(sp)
     ee4:	6402                	ld	s0,0(sp)
     ee6:	0141                	addi	sp,sp,16
     ee8:	8082                	ret

0000000000000eea <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     eea:	4885                	li	a7,1
 ecall
     eec:	00000073          	ecall
 ret
     ef0:	8082                	ret

0000000000000ef2 <exit>:
.global exit
exit:
 li a7, SYS_exit
     ef2:	4889                	li	a7,2
 ecall
     ef4:	00000073          	ecall
 ret
     ef8:	8082                	ret

0000000000000efa <wait>:
.global wait
wait:
 li a7, SYS_wait
     efa:	488d                	li	a7,3
 ecall
     efc:	00000073          	ecall
 ret
     f00:	8082                	ret

0000000000000f02 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     f02:	4891                	li	a7,4
 ecall
     f04:	00000073          	ecall
 ret
     f08:	8082                	ret

0000000000000f0a <read>:
.global read
read:
 li a7, SYS_read
     f0a:	4895                	li	a7,5
 ecall
     f0c:	00000073          	ecall
 ret
     f10:	8082                	ret

0000000000000f12 <write>:
.global write
write:
 li a7, SYS_write
     f12:	48c1                	li	a7,16
 ecall
     f14:	00000073          	ecall
 ret
     f18:	8082                	ret

0000000000000f1a <close>:
.global close
close:
 li a7, SYS_close
     f1a:	48d5                	li	a7,21
 ecall
     f1c:	00000073          	ecall
 ret
     f20:	8082                	ret

0000000000000f22 <kill>:
.global kill
kill:
 li a7, SYS_kill
     f22:	4899                	li	a7,6
 ecall
     f24:	00000073          	ecall
 ret
     f28:	8082                	ret

0000000000000f2a <exec>:
.global exec
exec:
 li a7, SYS_exec
     f2a:	489d                	li	a7,7
 ecall
     f2c:	00000073          	ecall
 ret
     f30:	8082                	ret

0000000000000f32 <open>:
.global open
open:
 li a7, SYS_open
     f32:	48bd                	li	a7,15
 ecall
     f34:	00000073          	ecall
 ret
     f38:	8082                	ret

0000000000000f3a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     f3a:	48c5                	li	a7,17
 ecall
     f3c:	00000073          	ecall
 ret
     f40:	8082                	ret

0000000000000f42 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     f42:	48c9                	li	a7,18
 ecall
     f44:	00000073          	ecall
 ret
     f48:	8082                	ret

0000000000000f4a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     f4a:	48a1                	li	a7,8
 ecall
     f4c:	00000073          	ecall
 ret
     f50:	8082                	ret

0000000000000f52 <link>:
.global link
link:
 li a7, SYS_link
     f52:	48cd                	li	a7,19
 ecall
     f54:	00000073          	ecall
 ret
     f58:	8082                	ret

0000000000000f5a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     f5a:	48d1                	li	a7,20
 ecall
     f5c:	00000073          	ecall
 ret
     f60:	8082                	ret

0000000000000f62 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     f62:	48a5                	li	a7,9
 ecall
     f64:	00000073          	ecall
 ret
     f68:	8082                	ret

0000000000000f6a <dup>:
.global dup
dup:
 li a7, SYS_dup
     f6a:	48a9                	li	a7,10
 ecall
     f6c:	00000073          	ecall
 ret
     f70:	8082                	ret

0000000000000f72 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     f72:	48ad                	li	a7,11
 ecall
     f74:	00000073          	ecall
 ret
     f78:	8082                	ret

0000000000000f7a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     f7a:	48b1                	li	a7,12
 ecall
     f7c:	00000073          	ecall
 ret
     f80:	8082                	ret

0000000000000f82 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     f82:	48b5                	li	a7,13
 ecall
     f84:	00000073          	ecall
 ret
     f88:	8082                	ret

0000000000000f8a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     f8a:	48b9                	li	a7,14
 ecall
     f8c:	00000073          	ecall
 ret
     f90:	8082                	ret

0000000000000f92 <connect>:
.global connect
connect:
 li a7, SYS_connect
     f92:	48f5                	li	a7,29
 ecall
     f94:	00000073          	ecall
 ret
     f98:	8082                	ret

0000000000000f9a <pgaccess>:
.global pgaccess
pgaccess:
 li a7, SYS_pgaccess
     f9a:	48f9                	li	a7,30
 ecall
     f9c:	00000073          	ecall
 ret
     fa0:	8082                	ret

0000000000000fa2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     fa2:	1101                	addi	sp,sp,-32
     fa4:	ec06                	sd	ra,24(sp)
     fa6:	e822                	sd	s0,16(sp)
     fa8:	1000                	addi	s0,sp,32
     faa:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     fae:	4605                	li	a2,1
     fb0:	fef40593          	addi	a1,s0,-17
     fb4:	00000097          	auipc	ra,0x0
     fb8:	f5e080e7          	jalr	-162(ra) # f12 <write>
}
     fbc:	60e2                	ld	ra,24(sp)
     fbe:	6442                	ld	s0,16(sp)
     fc0:	6105                	addi	sp,sp,32
     fc2:	8082                	ret

0000000000000fc4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     fc4:	7139                	addi	sp,sp,-64
     fc6:	fc06                	sd	ra,56(sp)
     fc8:	f822                	sd	s0,48(sp)
     fca:	f426                	sd	s1,40(sp)
     fcc:	f04a                	sd	s2,32(sp)
     fce:	ec4e                	sd	s3,24(sp)
     fd0:	0080                	addi	s0,sp,64
     fd2:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     fd4:	c299                	beqz	a3,fda <printint+0x16>
     fd6:	0805c063          	bltz	a1,1056 <printint+0x92>
  neg = 0;
     fda:	4e01                	li	t3,0
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     fdc:	fc040313          	addi	t1,s0,-64
  neg = 0;
     fe0:	869a                	mv	a3,t1
  i = 0;
     fe2:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     fe4:	00000817          	auipc	a6,0x0
     fe8:	7f480813          	addi	a6,a6,2036 # 17d8 <digits>
     fec:	88be                	mv	a7,a5
     fee:	0017851b          	addiw	a0,a5,1
     ff2:	87aa                	mv	a5,a0
     ff4:	02c5f73b          	remuw	a4,a1,a2
     ff8:	1702                	slli	a4,a4,0x20
     ffa:	9301                	srli	a4,a4,0x20
     ffc:	9742                	add	a4,a4,a6
     ffe:	00074703          	lbu	a4,0(a4)
    1002:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
    1006:	872e                	mv	a4,a1
    1008:	02c5d5bb          	divuw	a1,a1,a2
    100c:	0685                	addi	a3,a3,1
    100e:	fcc77fe3          	bgeu	a4,a2,fec <printint+0x28>
  if(neg)
    1012:	000e0c63          	beqz	t3,102a <printint+0x66>
    buf[i++] = '-';
    1016:	fd050793          	addi	a5,a0,-48
    101a:	00878533          	add	a0,a5,s0
    101e:	02d00793          	li	a5,45
    1022:	fef50823          	sb	a5,-16(a0)
    1026:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
    102a:	fff7899b          	addiw	s3,a5,-1
    102e:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
    1032:	fff4c583          	lbu	a1,-1(s1)
    1036:	854a                	mv	a0,s2
    1038:	00000097          	auipc	ra,0x0
    103c:	f6a080e7          	jalr	-150(ra) # fa2 <putc>
  while(--i >= 0)
    1040:	39fd                	addiw	s3,s3,-1
    1042:	14fd                	addi	s1,s1,-1
    1044:	fe09d7e3          	bgez	s3,1032 <printint+0x6e>
}
    1048:	70e2                	ld	ra,56(sp)
    104a:	7442                	ld	s0,48(sp)
    104c:	74a2                	ld	s1,40(sp)
    104e:	7902                	ld	s2,32(sp)
    1050:	69e2                	ld	s3,24(sp)
    1052:	6121                	addi	sp,sp,64
    1054:	8082                	ret
    x = -xx;
    1056:	40b005bb          	negw	a1,a1
    neg = 1;
    105a:	4e05                	li	t3,1
    x = -xx;
    105c:	b741                	j	fdc <printint+0x18>

000000000000105e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    105e:	715d                	addi	sp,sp,-80
    1060:	e486                	sd	ra,72(sp)
    1062:	e0a2                	sd	s0,64(sp)
    1064:	f84a                	sd	s2,48(sp)
    1066:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1068:	0005c903          	lbu	s2,0(a1)
    106c:	1a090a63          	beqz	s2,1220 <vprintf+0x1c2>
    1070:	fc26                	sd	s1,56(sp)
    1072:	f44e                	sd	s3,40(sp)
    1074:	f052                	sd	s4,32(sp)
    1076:	ec56                	sd	s5,24(sp)
    1078:	e85a                	sd	s6,16(sp)
    107a:	e45e                	sd	s7,8(sp)
    107c:	8aaa                	mv	s5,a0
    107e:	8bb2                	mv	s7,a2
    1080:	00158493          	addi	s1,a1,1
  state = 0;
    1084:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1086:	02500a13          	li	s4,37
    108a:	4b55                	li	s6,21
    108c:	a839                	j	10aa <vprintf+0x4c>
        putc(fd, c);
    108e:	85ca                	mv	a1,s2
    1090:	8556                	mv	a0,s5
    1092:	00000097          	auipc	ra,0x0
    1096:	f10080e7          	jalr	-240(ra) # fa2 <putc>
    109a:	a019                	j	10a0 <vprintf+0x42>
    } else if(state == '%'){
    109c:	01498d63          	beq	s3,s4,10b6 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    10a0:	0485                	addi	s1,s1,1
    10a2:	fff4c903          	lbu	s2,-1(s1)
    10a6:	16090763          	beqz	s2,1214 <vprintf+0x1b6>
    if(state == 0){
    10aa:	fe0999e3          	bnez	s3,109c <vprintf+0x3e>
      if(c == '%'){
    10ae:	ff4910e3          	bne	s2,s4,108e <vprintf+0x30>
        state = '%';
    10b2:	89d2                	mv	s3,s4
    10b4:	b7f5                	j	10a0 <vprintf+0x42>
      if(c == 'd'){
    10b6:	13490463          	beq	s2,s4,11de <vprintf+0x180>
    10ba:	f9d9079b          	addiw	a5,s2,-99
    10be:	0ff7f793          	zext.b	a5,a5
    10c2:	12fb6763          	bltu	s6,a5,11f0 <vprintf+0x192>
    10c6:	f9d9079b          	addiw	a5,s2,-99
    10ca:	0ff7f713          	zext.b	a4,a5
    10ce:	12eb6163          	bltu	s6,a4,11f0 <vprintf+0x192>
    10d2:	00271793          	slli	a5,a4,0x2
    10d6:	00000717          	auipc	a4,0x0
    10da:	6aa70713          	addi	a4,a4,1706 # 1780 <malloc+0x46c>
    10de:	97ba                	add	a5,a5,a4
    10e0:	439c                	lw	a5,0(a5)
    10e2:	97ba                	add	a5,a5,a4
    10e4:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    10e6:	008b8913          	addi	s2,s7,8
    10ea:	4685                	li	a3,1
    10ec:	4629                	li	a2,10
    10ee:	000ba583          	lw	a1,0(s7)
    10f2:	8556                	mv	a0,s5
    10f4:	00000097          	auipc	ra,0x0
    10f8:	ed0080e7          	jalr	-304(ra) # fc4 <printint>
    10fc:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10fe:	4981                	li	s3,0
    1100:	b745                	j	10a0 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1102:	008b8913          	addi	s2,s7,8
    1106:	4681                	li	a3,0
    1108:	4629                	li	a2,10
    110a:	000ba583          	lw	a1,0(s7)
    110e:	8556                	mv	a0,s5
    1110:	00000097          	auipc	ra,0x0
    1114:	eb4080e7          	jalr	-332(ra) # fc4 <printint>
    1118:	8bca                	mv	s7,s2
      state = 0;
    111a:	4981                	li	s3,0
    111c:	b751                	j	10a0 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    111e:	008b8913          	addi	s2,s7,8
    1122:	4681                	li	a3,0
    1124:	4641                	li	a2,16
    1126:	000ba583          	lw	a1,0(s7)
    112a:	8556                	mv	a0,s5
    112c:	00000097          	auipc	ra,0x0
    1130:	e98080e7          	jalr	-360(ra) # fc4 <printint>
    1134:	8bca                	mv	s7,s2
      state = 0;
    1136:	4981                	li	s3,0
    1138:	b7a5                	j	10a0 <vprintf+0x42>
    113a:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    113c:	008b8c13          	addi	s8,s7,8
    1140:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    1144:	03000593          	li	a1,48
    1148:	8556                	mv	a0,s5
    114a:	00000097          	auipc	ra,0x0
    114e:	e58080e7          	jalr	-424(ra) # fa2 <putc>
  putc(fd, 'x');
    1152:	07800593          	li	a1,120
    1156:	8556                	mv	a0,s5
    1158:	00000097          	auipc	ra,0x0
    115c:	e4a080e7          	jalr	-438(ra) # fa2 <putc>
    1160:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1162:	00000b97          	auipc	s7,0x0
    1166:	676b8b93          	addi	s7,s7,1654 # 17d8 <digits>
    116a:	03c9d793          	srli	a5,s3,0x3c
    116e:	97de                	add	a5,a5,s7
    1170:	0007c583          	lbu	a1,0(a5)
    1174:	8556                	mv	a0,s5
    1176:	00000097          	auipc	ra,0x0
    117a:	e2c080e7          	jalr	-468(ra) # fa2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    117e:	0992                	slli	s3,s3,0x4
    1180:	397d                	addiw	s2,s2,-1
    1182:	fe0914e3          	bnez	s2,116a <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
    1186:	8be2                	mv	s7,s8
      state = 0;
    1188:	4981                	li	s3,0
    118a:	6c02                	ld	s8,0(sp)
    118c:	bf11                	j	10a0 <vprintf+0x42>
        s = va_arg(ap, char*);
    118e:	008b8993          	addi	s3,s7,8
    1192:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    1196:	02090163          	beqz	s2,11b8 <vprintf+0x15a>
        while(*s != 0){
    119a:	00094583          	lbu	a1,0(s2)
    119e:	c9a5                	beqz	a1,120e <vprintf+0x1b0>
          putc(fd, *s);
    11a0:	8556                	mv	a0,s5
    11a2:	00000097          	auipc	ra,0x0
    11a6:	e00080e7          	jalr	-512(ra) # fa2 <putc>
          s++;
    11aa:	0905                	addi	s2,s2,1
        while(*s != 0){
    11ac:	00094583          	lbu	a1,0(s2)
    11b0:	f9e5                	bnez	a1,11a0 <vprintf+0x142>
        s = va_arg(ap, char*);
    11b2:	8bce                	mv	s7,s3
      state = 0;
    11b4:	4981                	li	s3,0
    11b6:	b5ed                	j	10a0 <vprintf+0x42>
          s = "(null)";
    11b8:	00000917          	auipc	s2,0x0
    11bc:	56090913          	addi	s2,s2,1376 # 1718 <malloc+0x404>
        while(*s != 0){
    11c0:	02800593          	li	a1,40
    11c4:	bff1                	j	11a0 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
    11c6:	008b8913          	addi	s2,s7,8
    11ca:	000bc583          	lbu	a1,0(s7)
    11ce:	8556                	mv	a0,s5
    11d0:	00000097          	auipc	ra,0x0
    11d4:	dd2080e7          	jalr	-558(ra) # fa2 <putc>
    11d8:	8bca                	mv	s7,s2
      state = 0;
    11da:	4981                	li	s3,0
    11dc:	b5d1                	j	10a0 <vprintf+0x42>
        putc(fd, c);
    11de:	02500593          	li	a1,37
    11e2:	8556                	mv	a0,s5
    11e4:	00000097          	auipc	ra,0x0
    11e8:	dbe080e7          	jalr	-578(ra) # fa2 <putc>
      state = 0;
    11ec:	4981                	li	s3,0
    11ee:	bd4d                	j	10a0 <vprintf+0x42>
        putc(fd, '%');
    11f0:	02500593          	li	a1,37
    11f4:	8556                	mv	a0,s5
    11f6:	00000097          	auipc	ra,0x0
    11fa:	dac080e7          	jalr	-596(ra) # fa2 <putc>
        putc(fd, c);
    11fe:	85ca                	mv	a1,s2
    1200:	8556                	mv	a0,s5
    1202:	00000097          	auipc	ra,0x0
    1206:	da0080e7          	jalr	-608(ra) # fa2 <putc>
      state = 0;
    120a:	4981                	li	s3,0
    120c:	bd51                	j	10a0 <vprintf+0x42>
        s = va_arg(ap, char*);
    120e:	8bce                	mv	s7,s3
      state = 0;
    1210:	4981                	li	s3,0
    1212:	b579                	j	10a0 <vprintf+0x42>
    1214:	74e2                	ld	s1,56(sp)
    1216:	79a2                	ld	s3,40(sp)
    1218:	7a02                	ld	s4,32(sp)
    121a:	6ae2                	ld	s5,24(sp)
    121c:	6b42                	ld	s6,16(sp)
    121e:	6ba2                	ld	s7,8(sp)
    }
  }
}
    1220:	60a6                	ld	ra,72(sp)
    1222:	6406                	ld	s0,64(sp)
    1224:	7942                	ld	s2,48(sp)
    1226:	6161                	addi	sp,sp,80
    1228:	8082                	ret

000000000000122a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    122a:	715d                	addi	sp,sp,-80
    122c:	ec06                	sd	ra,24(sp)
    122e:	e822                	sd	s0,16(sp)
    1230:	1000                	addi	s0,sp,32
    1232:	e010                	sd	a2,0(s0)
    1234:	e414                	sd	a3,8(s0)
    1236:	e818                	sd	a4,16(s0)
    1238:	ec1c                	sd	a5,24(s0)
    123a:	03043023          	sd	a6,32(s0)
    123e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1242:	8622                	mv	a2,s0
    1244:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1248:	00000097          	auipc	ra,0x0
    124c:	e16080e7          	jalr	-490(ra) # 105e <vprintf>
}
    1250:	60e2                	ld	ra,24(sp)
    1252:	6442                	ld	s0,16(sp)
    1254:	6161                	addi	sp,sp,80
    1256:	8082                	ret

0000000000001258 <printf>:

void
printf(const char *fmt, ...)
{
    1258:	711d                	addi	sp,sp,-96
    125a:	ec06                	sd	ra,24(sp)
    125c:	e822                	sd	s0,16(sp)
    125e:	1000                	addi	s0,sp,32
    1260:	e40c                	sd	a1,8(s0)
    1262:	e810                	sd	a2,16(s0)
    1264:	ec14                	sd	a3,24(s0)
    1266:	f018                	sd	a4,32(s0)
    1268:	f41c                	sd	a5,40(s0)
    126a:	03043823          	sd	a6,48(s0)
    126e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1272:	00840613          	addi	a2,s0,8
    1276:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    127a:	85aa                	mv	a1,a0
    127c:	4505                	li	a0,1
    127e:	00000097          	auipc	ra,0x0
    1282:	de0080e7          	jalr	-544(ra) # 105e <vprintf>
}
    1286:	60e2                	ld	ra,24(sp)
    1288:	6442                	ld	s0,16(sp)
    128a:	6125                	addi	sp,sp,96
    128c:	8082                	ret

000000000000128e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    128e:	1141                	addi	sp,sp,-16
    1290:	e406                	sd	ra,8(sp)
    1292:	e022                	sd	s0,0(sp)
    1294:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1296:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    129a:	00000797          	auipc	a5,0x0
    129e:	55e7b783          	ld	a5,1374(a5) # 17f8 <freep>
    12a2:	a02d                	j	12cc <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    12a4:	4618                	lw	a4,8(a2)
    12a6:	9f2d                	addw	a4,a4,a1
    12a8:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    12ac:	6398                	ld	a4,0(a5)
    12ae:	6310                	ld	a2,0(a4)
    12b0:	a83d                	j	12ee <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    12b2:	ff852703          	lw	a4,-8(a0)
    12b6:	9f31                	addw	a4,a4,a2
    12b8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    12ba:	ff053683          	ld	a3,-16(a0)
    12be:	a091                	j	1302 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12c0:	6398                	ld	a4,0(a5)
    12c2:	00e7e463          	bltu	a5,a4,12ca <free+0x3c>
    12c6:	00e6ea63          	bltu	a3,a4,12da <free+0x4c>
{
    12ca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12cc:	fed7fae3          	bgeu	a5,a3,12c0 <free+0x32>
    12d0:	6398                	ld	a4,0(a5)
    12d2:	00e6e463          	bltu	a3,a4,12da <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12d6:	fee7eae3          	bltu	a5,a4,12ca <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
    12da:	ff852583          	lw	a1,-8(a0)
    12de:	6390                	ld	a2,0(a5)
    12e0:	02059813          	slli	a6,a1,0x20
    12e4:	01c85713          	srli	a4,a6,0x1c
    12e8:	9736                	add	a4,a4,a3
    12ea:	fae60de3          	beq	a2,a4,12a4 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
    12ee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    12f2:	4790                	lw	a2,8(a5)
    12f4:	02061593          	slli	a1,a2,0x20
    12f8:	01c5d713          	srli	a4,a1,0x1c
    12fc:	973e                	add	a4,a4,a5
    12fe:	fae68ae3          	beq	a3,a4,12b2 <free+0x24>
    p->s.ptr = bp->s.ptr;
    1302:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1304:	00000717          	auipc	a4,0x0
    1308:	4ef73a23          	sd	a5,1268(a4) # 17f8 <freep>
}
    130c:	60a2                	ld	ra,8(sp)
    130e:	6402                	ld	s0,0(sp)
    1310:	0141                	addi	sp,sp,16
    1312:	8082                	ret

0000000000001314 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1314:	7139                	addi	sp,sp,-64
    1316:	fc06                	sd	ra,56(sp)
    1318:	f822                	sd	s0,48(sp)
    131a:	f04a                	sd	s2,32(sp)
    131c:	ec4e                	sd	s3,24(sp)
    131e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1320:	02051993          	slli	s3,a0,0x20
    1324:	0209d993          	srli	s3,s3,0x20
    1328:	09bd                	addi	s3,s3,15
    132a:	0049d993          	srli	s3,s3,0x4
    132e:	2985                	addiw	s3,s3,1
    1330:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    1332:	00000517          	auipc	a0,0x0
    1336:	4c653503          	ld	a0,1222(a0) # 17f8 <freep>
    133a:	c905                	beqz	a0,136a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    133c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    133e:	4798                	lw	a4,8(a5)
    1340:	09377a63          	bgeu	a4,s3,13d4 <malloc+0xc0>
    1344:	f426                	sd	s1,40(sp)
    1346:	e852                	sd	s4,16(sp)
    1348:	e456                	sd	s5,8(sp)
    134a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    134c:	8a4e                	mv	s4,s3
    134e:	6705                	lui	a4,0x1
    1350:	00e9f363          	bgeu	s3,a4,1356 <malloc+0x42>
    1354:	6a05                	lui	s4,0x1
    1356:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    135a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    135e:	00000497          	auipc	s1,0x0
    1362:	49a48493          	addi	s1,s1,1178 # 17f8 <freep>
  if(p == (char*)-1)
    1366:	5afd                	li	s5,-1
    1368:	a089                	j	13aa <malloc+0x96>
    136a:	f426                	sd	s1,40(sp)
    136c:	e852                	sd	s4,16(sp)
    136e:	e456                	sd	s5,8(sp)
    1370:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1372:	00001797          	auipc	a5,0x1
    1376:	87678793          	addi	a5,a5,-1930 # 1be8 <base>
    137a:	00000717          	auipc	a4,0x0
    137e:	46f73f23          	sd	a5,1150(a4) # 17f8 <freep>
    1382:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1384:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1388:	b7d1                	j	134c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    138a:	6398                	ld	a4,0(a5)
    138c:	e118                	sd	a4,0(a0)
    138e:	a8b9                	j	13ec <malloc+0xd8>
  hp->s.size = nu;
    1390:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1394:	0541                	addi	a0,a0,16
    1396:	00000097          	auipc	ra,0x0
    139a:	ef8080e7          	jalr	-264(ra) # 128e <free>
  return freep;
    139e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    13a0:	c135                	beqz	a0,1404 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    13a4:	4798                	lw	a4,8(a5)
    13a6:	03277363          	bgeu	a4,s2,13cc <malloc+0xb8>
    if(p == freep)
    13aa:	6098                	ld	a4,0(s1)
    13ac:	853e                	mv	a0,a5
    13ae:	fef71ae3          	bne	a4,a5,13a2 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    13b2:	8552                	mv	a0,s4
    13b4:	00000097          	auipc	ra,0x0
    13b8:	bc6080e7          	jalr	-1082(ra) # f7a <sbrk>
  if(p == (char*)-1)
    13bc:	fd551ae3          	bne	a0,s5,1390 <malloc+0x7c>
        return 0;
    13c0:	4501                	li	a0,0
    13c2:	74a2                	ld	s1,40(sp)
    13c4:	6a42                	ld	s4,16(sp)
    13c6:	6aa2                	ld	s5,8(sp)
    13c8:	6b02                	ld	s6,0(sp)
    13ca:	a03d                	j	13f8 <malloc+0xe4>
    13cc:	74a2                	ld	s1,40(sp)
    13ce:	6a42                	ld	s4,16(sp)
    13d0:	6aa2                	ld	s5,8(sp)
    13d2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    13d4:	fae90be3          	beq	s2,a4,138a <malloc+0x76>
        p->s.size -= nunits;
    13d8:	4137073b          	subw	a4,a4,s3
    13dc:	c798                	sw	a4,8(a5)
        p += p->s.size;
    13de:	02071693          	slli	a3,a4,0x20
    13e2:	01c6d713          	srli	a4,a3,0x1c
    13e6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    13e8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    13ec:	00000717          	auipc	a4,0x0
    13f0:	40a73623          	sd	a0,1036(a4) # 17f8 <freep>
      return (void*)(p + 1);
    13f4:	01078513          	addi	a0,a5,16
  }
}
    13f8:	70e2                	ld	ra,56(sp)
    13fa:	7442                	ld	s0,48(sp)
    13fc:	7902                	ld	s2,32(sp)
    13fe:	69e2                	ld	s3,24(sp)
    1400:	6121                	addi	sp,sp,64
    1402:	8082                	ret
    1404:	74a2                	ld	s1,40(sp)
    1406:	6a42                	ld	s4,16(sp)
    1408:	6aa2                	ld	s5,8(sp)
    140a:	6b02                	ld	s6,0(sp)
    140c:	b7f5                	j	13f8 <malloc+0xe4>
