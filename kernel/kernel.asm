
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0001e117          	auipc	sp,0x1e
    80000004:	14010113          	addi	sp,sp,320 # 8001e140 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	211050ef          	jal	80005a26 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00026797          	auipc	a5,0x26
    80000034:	21078793          	addi	a5,a5,528 # 80026240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	132080e7          	jalr	306(ra) # 8000017a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	fe090913          	addi	s2,s2,-32 # 80009030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	418080e7          	jalr	1048(ra) # 80006472 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	4b4080e7          	jalr	1204(ra) # 80006522 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f7e50513          	addi	a0,a0,-130 # 80008000 <etext>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	e68080e7          	jalr	-408(ra) # 80005ef2 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000009c:	6785                	lui	a5,0x1
    8000009e:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a2:	00e504b3          	add	s1,a0,a4
    800000a6:	777d                	lui	a4,0xfffff
    800000a8:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000aa:	94be                	add	s1,s1,a5
    800000ac:	0295e463          	bltu	a1,s1,800000d4 <freerange+0x42>
    800000b0:	e84a                	sd	s2,16(sp)
    800000b2:	e44e                	sd	s3,8(sp)
    800000b4:	e052                	sd	s4,0(sp)
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	89be                	mv	s3,a5
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
    800000ce:	6942                	ld	s2,16(sp)
    800000d0:	69a2                	ld	s3,8(sp)
    800000d2:	6a02                	ld	s4,0(sp)
}
    800000d4:	70a2                	ld	ra,40(sp)
    800000d6:	7402                	ld	s0,32(sp)
    800000d8:	64e2                	ld	s1,24(sp)
    800000da:	6145                	addi	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	addi	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f2a58593          	addi	a1,a1,-214 # 80008010 <etext+0x10>
    800000ee:	00009517          	auipc	a0,0x9
    800000f2:	f4250513          	addi	a0,a0,-190 # 80009030 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	2e8080e7          	jalr	744(ra) # 800063de <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	slli	a1,a1,0x1b
    80000102:	00026517          	auipc	a0,0x26
    80000106:	13e50513          	addi	a0,a0,318 # 80026240 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	addi	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	addi	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	00009497          	auipc	s1,0x9
    80000128:	f0c48493          	addi	s1,s1,-244 # 80009030 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	344080e7          	jalr	836(ra) # 80006472 <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	00009517          	auipc	a0,0x9
    80000140:	ef450513          	addi	a0,a0,-268 # 80009030 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	3dc080e7          	jalr	988(ra) # 80006522 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	026080e7          	jalr	38(ra) # 8000017a <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	addi	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	00009517          	auipc	a0,0x9
    8000016c:	ec850513          	addi	a0,a0,-312 # 80009030 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	3b2080e7          	jalr	946(ra) # 80006522 <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000017a:	1141                	addi	sp,sp,-16
    8000017c:	e406                	sd	ra,8(sp)
    8000017e:	e022                	sd	s0,0(sp)
    80000180:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000182:	ca19                	beqz	a2,80000198 <memset+0x1e>
    80000184:	87aa                	mv	a5,a0
    80000186:	1602                	slli	a2,a2,0x20
    80000188:	9201                	srli	a2,a2,0x20
    8000018a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000018e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000192:	0785                	addi	a5,a5,1
    80000194:	fee79de3          	bne	a5,a4,8000018e <memset+0x14>
  }
  return dst;
}
    80000198:	60a2                	ld	ra,8(sp)
    8000019a:	6402                	ld	s0,0(sp)
    8000019c:	0141                	addi	sp,sp,16
    8000019e:	8082                	ret

00000000800001a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800001a0:	1141                	addi	sp,sp,-16
    800001a2:	e406                	sd	ra,8(sp)
    800001a4:	e022                	sd	s0,0(sp)
    800001a6:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a8:	ca0d                	beqz	a2,800001da <memcmp+0x3a>
    800001aa:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001ae:	1682                	slli	a3,a3,0x20
    800001b0:	9281                	srli	a3,a3,0x20
    800001b2:	0685                	addi	a3,a3,1
    800001b4:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b6:	00054783          	lbu	a5,0(a0)
    800001ba:	0005c703          	lbu	a4,0(a1)
    800001be:	00e79863          	bne	a5,a4,800001ce <memcmp+0x2e>
      return *s1 - *s2;
    s1++, s2++;
    800001c2:	0505                	addi	a0,a0,1
    800001c4:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c6:	fed518e3          	bne	a0,a3,800001b6 <memcmp+0x16>
  }

  return 0;
    800001ca:	4501                	li	a0,0
    800001cc:	a019                	j	800001d2 <memcmp+0x32>
      return *s1 - *s2;
    800001ce:	40e7853b          	subw	a0,a5,a4
}
    800001d2:	60a2                	ld	ra,8(sp)
    800001d4:	6402                	ld	s0,0(sp)
    800001d6:	0141                	addi	sp,sp,16
    800001d8:	8082                	ret
  return 0;
    800001da:	4501                	li	a0,0
    800001dc:	bfdd                	j	800001d2 <memcmp+0x32>

00000000800001de <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001de:	1141                	addi	sp,sp,-16
    800001e0:	e406                	sd	ra,8(sp)
    800001e2:	e022                	sd	s0,0(sp)
    800001e4:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001e6:	c205                	beqz	a2,80000206 <memmove+0x28>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001e8:	02a5e363          	bltu	a1,a0,8000020e <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001ec:	1602                	slli	a2,a2,0x20
    800001ee:	9201                	srli	a2,a2,0x20
    800001f0:	00c587b3          	add	a5,a1,a2
{
    800001f4:	872a                	mv	a4,a0
      *d++ = *s++;
    800001f6:	0585                	addi	a1,a1,1
    800001f8:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffd8dc1>
    800001fa:	fff5c683          	lbu	a3,-1(a1)
    800001fe:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    80000202:	feb79ae3          	bne	a5,a1,800001f6 <memmove+0x18>

  return dst;
}
    80000206:	60a2                	ld	ra,8(sp)
    80000208:	6402                	ld	s0,0(sp)
    8000020a:	0141                	addi	sp,sp,16
    8000020c:	8082                	ret
  if(s < d && s + n > d){
    8000020e:	02061693          	slli	a3,a2,0x20
    80000212:	9281                	srli	a3,a3,0x20
    80000214:	00d58733          	add	a4,a1,a3
    80000218:	fce57ae3          	bgeu	a0,a4,800001ec <memmove+0xe>
    d += n;
    8000021c:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    8000021e:	fff6079b          	addiw	a5,a2,-1
    80000222:	1782                	slli	a5,a5,0x20
    80000224:	9381                	srli	a5,a5,0x20
    80000226:	fff7c793          	not	a5,a5
    8000022a:	97ba                	add	a5,a5,a4
      *--d = *--s;
    8000022c:	177d                	addi	a4,a4,-1
    8000022e:	16fd                	addi	a3,a3,-1
    80000230:	00074603          	lbu	a2,0(a4)
    80000234:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000238:	fee79ae3          	bne	a5,a4,8000022c <memmove+0x4e>
    8000023c:	b7e9                	j	80000206 <memmove+0x28>

000000008000023e <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8000023e:	1141                	addi	sp,sp,-16
    80000240:	e406                	sd	ra,8(sp)
    80000242:	e022                	sd	s0,0(sp)
    80000244:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000246:	00000097          	auipc	ra,0x0
    8000024a:	f98080e7          	jalr	-104(ra) # 800001de <memmove>
}
    8000024e:	60a2                	ld	ra,8(sp)
    80000250:	6402                	ld	s0,0(sp)
    80000252:	0141                	addi	sp,sp,16
    80000254:	8082                	ret

0000000080000256 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000256:	1141                	addi	sp,sp,-16
    80000258:	e406                	sd	ra,8(sp)
    8000025a:	e022                	sd	s0,0(sp)
    8000025c:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000025e:	ce11                	beqz	a2,8000027a <strncmp+0x24>
    80000260:	00054783          	lbu	a5,0(a0)
    80000264:	cf89                	beqz	a5,8000027e <strncmp+0x28>
    80000266:	0005c703          	lbu	a4,0(a1)
    8000026a:	00f71a63          	bne	a4,a5,8000027e <strncmp+0x28>
    n--, p++, q++;
    8000026e:	367d                	addiw	a2,a2,-1
    80000270:	0505                	addi	a0,a0,1
    80000272:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000274:	f675                	bnez	a2,80000260 <strncmp+0xa>
  if(n == 0)
    return 0;
    80000276:	4501                	li	a0,0
    80000278:	a801                	j	80000288 <strncmp+0x32>
    8000027a:	4501                	li	a0,0
    8000027c:	a031                	j	80000288 <strncmp+0x32>
  return (uchar)*p - (uchar)*q;
    8000027e:	00054503          	lbu	a0,0(a0)
    80000282:	0005c783          	lbu	a5,0(a1)
    80000286:	9d1d                	subw	a0,a0,a5
}
    80000288:	60a2                	ld	ra,8(sp)
    8000028a:	6402                	ld	s0,0(sp)
    8000028c:	0141                	addi	sp,sp,16
    8000028e:	8082                	ret

0000000080000290 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000290:	1141                	addi	sp,sp,-16
    80000292:	e406                	sd	ra,8(sp)
    80000294:	e022                	sd	s0,0(sp)
    80000296:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000298:	87aa                	mv	a5,a0
    8000029a:	86b2                	mv	a3,a2
    8000029c:	367d                	addiw	a2,a2,-1
    8000029e:	02d05563          	blez	a3,800002c8 <strncpy+0x38>
    800002a2:	0785                	addi	a5,a5,1
    800002a4:	0005c703          	lbu	a4,0(a1)
    800002a8:	fee78fa3          	sb	a4,-1(a5)
    800002ac:	0585                	addi	a1,a1,1
    800002ae:	f775                	bnez	a4,8000029a <strncpy+0xa>
    ;
  while(n-- > 0)
    800002b0:	873e                	mv	a4,a5
    800002b2:	00c05b63          	blez	a2,800002c8 <strncpy+0x38>
    800002b6:	9fb5                	addw	a5,a5,a3
    800002b8:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    800002ba:	0705                	addi	a4,a4,1
    800002bc:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002c0:	40e786bb          	subw	a3,a5,a4
    800002c4:	fed04be3          	bgtz	a3,800002ba <strncpy+0x2a>
  return os;
}
    800002c8:	60a2                	ld	ra,8(sp)
    800002ca:	6402                	ld	s0,0(sp)
    800002cc:	0141                	addi	sp,sp,16
    800002ce:	8082                	ret

00000000800002d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002d0:	1141                	addi	sp,sp,-16
    800002d2:	e406                	sd	ra,8(sp)
    800002d4:	e022                	sd	s0,0(sp)
    800002d6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002d8:	02c05363          	blez	a2,800002fe <safestrcpy+0x2e>
    800002dc:	fff6069b          	addiw	a3,a2,-1
    800002e0:	1682                	slli	a3,a3,0x20
    800002e2:	9281                	srli	a3,a3,0x20
    800002e4:	96ae                	add	a3,a3,a1
    800002e6:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002e8:	00d58963          	beq	a1,a3,800002fa <safestrcpy+0x2a>
    800002ec:	0585                	addi	a1,a1,1
    800002ee:	0785                	addi	a5,a5,1
    800002f0:	fff5c703          	lbu	a4,-1(a1)
    800002f4:	fee78fa3          	sb	a4,-1(a5)
    800002f8:	fb65                	bnez	a4,800002e8 <safestrcpy+0x18>
    ;
  *s = 0;
    800002fa:	00078023          	sb	zero,0(a5)
  return os;
}
    800002fe:	60a2                	ld	ra,8(sp)
    80000300:	6402                	ld	s0,0(sp)
    80000302:	0141                	addi	sp,sp,16
    80000304:	8082                	ret

0000000080000306 <strlen>:

int
strlen(const char *s)
{
    80000306:	1141                	addi	sp,sp,-16
    80000308:	e406                	sd	ra,8(sp)
    8000030a:	e022                	sd	s0,0(sp)
    8000030c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    8000030e:	00054783          	lbu	a5,0(a0)
    80000312:	cf99                	beqz	a5,80000330 <strlen+0x2a>
    80000314:	0505                	addi	a0,a0,1
    80000316:	87aa                	mv	a5,a0
    80000318:	86be                	mv	a3,a5
    8000031a:	0785                	addi	a5,a5,1
    8000031c:	fff7c703          	lbu	a4,-1(a5)
    80000320:	ff65                	bnez	a4,80000318 <strlen+0x12>
    80000322:	40a6853b          	subw	a0,a3,a0
    80000326:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    80000328:	60a2                	ld	ra,8(sp)
    8000032a:	6402                	ld	s0,0(sp)
    8000032c:	0141                	addi	sp,sp,16
    8000032e:	8082                	ret
  for(n = 0; s[n]; n++)
    80000330:	4501                	li	a0,0
    80000332:	bfdd                	j	80000328 <strlen+0x22>

0000000080000334 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000334:	1141                	addi	sp,sp,-16
    80000336:	e406                	sd	ra,8(sp)
    80000338:	e022                	sd	s0,0(sp)
    8000033a:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000033c:	00001097          	auipc	ra,0x1
    80000340:	c1c080e7          	jalr	-996(ra) # 80000f58 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000344:	00009717          	auipc	a4,0x9
    80000348:	cbc70713          	addi	a4,a4,-836 # 80009000 <started>
  if(cpuid() == 0){
    8000034c:	c139                	beqz	a0,80000392 <main+0x5e>
    while(started == 0)
    8000034e:	431c                	lw	a5,0(a4)
    80000350:	2781                	sext.w	a5,a5
    80000352:	dff5                	beqz	a5,8000034e <main+0x1a>
      ;
    __sync_synchronize();
    80000354:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000358:	00001097          	auipc	ra,0x1
    8000035c:	c00080e7          	jalr	-1024(ra) # 80000f58 <cpuid>
    80000360:	85aa                	mv	a1,a0
    80000362:	00008517          	auipc	a0,0x8
    80000366:	cd650513          	addi	a0,a0,-810 # 80008038 <etext+0x38>
    8000036a:	00006097          	auipc	ra,0x6
    8000036e:	bd2080e7          	jalr	-1070(ra) # 80005f3c <printf>
    kvminithart();    // turn on paging
    80000372:	00000097          	auipc	ra,0x0
    80000376:	0d8080e7          	jalr	216(ra) # 8000044a <kvminithart>
    trapinithart();   // install kernel trap vector
    8000037a:	00002097          	auipc	ra,0x2
    8000037e:	918080e7          	jalr	-1768(ra) # 80001c92 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000382:	00005097          	auipc	ra,0x5
    80000386:	072080e7          	jalr	114(ra) # 800053f4 <plicinithart>
  }

  scheduler();        
    8000038a:	00001097          	auipc	ra,0x1
    8000038e:	1ca080e7          	jalr	458(ra) # 80001554 <scheduler>
    consoleinit();
    80000392:	00006097          	auipc	ra,0x6
    80000396:	a82080e7          	jalr	-1406(ra) # 80005e14 <consoleinit>
    printfinit();
    8000039a:	00006097          	auipc	ra,0x6
    8000039e:	dac080e7          	jalr	-596(ra) # 80006146 <printfinit>
    printf("\n");
    800003a2:	00008517          	auipc	a0,0x8
    800003a6:	c7650513          	addi	a0,a0,-906 # 80008018 <etext+0x18>
    800003aa:	00006097          	auipc	ra,0x6
    800003ae:	b92080e7          	jalr	-1134(ra) # 80005f3c <printf>
    printf("xv6 kernel is booting\n");
    800003b2:	00008517          	auipc	a0,0x8
    800003b6:	c6e50513          	addi	a0,a0,-914 # 80008020 <etext+0x20>
    800003ba:	00006097          	auipc	ra,0x6
    800003be:	b82080e7          	jalr	-1150(ra) # 80005f3c <printf>
    printf("\n");
    800003c2:	00008517          	auipc	a0,0x8
    800003c6:	c5650513          	addi	a0,a0,-938 # 80008018 <etext+0x18>
    800003ca:	00006097          	auipc	ra,0x6
    800003ce:	b72080e7          	jalr	-1166(ra) # 80005f3c <printf>
    kinit();         // physical page allocator
    800003d2:	00000097          	auipc	ra,0x0
    800003d6:	d0c080e7          	jalr	-756(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    800003da:	00000097          	auipc	ra,0x0
    800003de:	326080e7          	jalr	806(ra) # 80000700 <kvminit>
    kvminithart();   // turn on paging
    800003e2:	00000097          	auipc	ra,0x0
    800003e6:	068080e7          	jalr	104(ra) # 8000044a <kvminithart>
    procinit();      // process table
    800003ea:	00001097          	auipc	ra,0x1
    800003ee:	ab8080e7          	jalr	-1352(ra) # 80000ea2 <procinit>
    trapinit();      // trap vectors
    800003f2:	00002097          	auipc	ra,0x2
    800003f6:	878080e7          	jalr	-1928(ra) # 80001c6a <trapinit>
    trapinithart();  // install kernel trap vector
    800003fa:	00002097          	auipc	ra,0x2
    800003fe:	898080e7          	jalr	-1896(ra) # 80001c92 <trapinithart>
    plicinit();      // set up interrupt controller
    80000402:	00005097          	auipc	ra,0x5
    80000406:	fd8080e7          	jalr	-40(ra) # 800053da <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000040a:	00005097          	auipc	ra,0x5
    8000040e:	fea080e7          	jalr	-22(ra) # 800053f4 <plicinithart>
    binit();         // buffer cache
    80000412:	00002097          	auipc	ra,0x2
    80000416:	09a080e7          	jalr	154(ra) # 800024ac <binit>
    iinit();         // inode table
    8000041a:	00002097          	auipc	ra,0x2
    8000041e:	708080e7          	jalr	1800(ra) # 80002b22 <iinit>
    fileinit();      // file table
    80000422:	00003097          	auipc	ra,0x3
    80000426:	6d2080e7          	jalr	1746(ra) # 80003af4 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000042a:	00005097          	auipc	ra,0x5
    8000042e:	0ea080e7          	jalr	234(ra) # 80005514 <virtio_disk_init>
    userinit();      // first user process
    80000432:	00001097          	auipc	ra,0x1
    80000436:	ee6080e7          	jalr	-282(ra) # 80001318 <userinit>
    __sync_synchronize();
    8000043a:	0330000f          	fence	rw,rw
    started = 1;
    8000043e:	4785                	li	a5,1
    80000440:	00009717          	auipc	a4,0x9
    80000444:	bcf72023          	sw	a5,-1088(a4) # 80009000 <started>
    80000448:	b789                	j	8000038a <main+0x56>

000000008000044a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000044a:	1141                	addi	sp,sp,-16
    8000044c:	e406                	sd	ra,8(sp)
    8000044e:	e022                	sd	s0,0(sp)
    80000450:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000452:	00009797          	auipc	a5,0x9
    80000456:	bb67b783          	ld	a5,-1098(a5) # 80009008 <kernel_pagetable>
    8000045a:	83b1                	srli	a5,a5,0xc
    8000045c:	577d                	li	a4,-1
    8000045e:	177e                	slli	a4,a4,0x3f
    80000460:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    80000462:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000466:	12000073          	sfence.vma
  sfence_vma();
}
    8000046a:	60a2                	ld	ra,8(sp)
    8000046c:	6402                	ld	s0,0(sp)
    8000046e:	0141                	addi	sp,sp,16
    80000470:	8082                	ret

0000000080000472 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000472:	7139                	addi	sp,sp,-64
    80000474:	fc06                	sd	ra,56(sp)
    80000476:	f822                	sd	s0,48(sp)
    80000478:	f426                	sd	s1,40(sp)
    8000047a:	f04a                	sd	s2,32(sp)
    8000047c:	ec4e                	sd	s3,24(sp)
    8000047e:	e852                	sd	s4,16(sp)
    80000480:	e456                	sd	s5,8(sp)
    80000482:	e05a                	sd	s6,0(sp)
    80000484:	0080                	addi	s0,sp,64
    80000486:	84aa                	mv	s1,a0
    80000488:	89ae                	mv	s3,a1
    8000048a:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    8000048c:	57fd                	li	a5,-1
    8000048e:	83e9                	srli	a5,a5,0x1a
    80000490:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000492:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000494:	04b7e263          	bltu	a5,a1,800004d8 <walk+0x66>
    pte_t *pte = &pagetable[PX(level, va)];
    80000498:	0149d933          	srl	s2,s3,s4
    8000049c:	1ff97913          	andi	s2,s2,511
    800004a0:	090e                	slli	s2,s2,0x3
    800004a2:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004a4:	00093483          	ld	s1,0(s2)
    800004a8:	0014f793          	andi	a5,s1,1
    800004ac:	cf95                	beqz	a5,800004e8 <walk+0x76>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004ae:	80a9                	srli	s1,s1,0xa
    800004b0:	04b2                	slli	s1,s1,0xc
  for(int level = 2; level > 0; level--) {
    800004b2:	3a5d                	addiw	s4,s4,-9
    800004b4:	ff6a12e3          	bne	s4,s6,80000498 <walk+0x26>
        return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
    800004b8:	00c9d513          	srli	a0,s3,0xc
    800004bc:	1ff57513          	andi	a0,a0,511
    800004c0:	050e                	slli	a0,a0,0x3
    800004c2:	9526                	add	a0,a0,s1
}
    800004c4:	70e2                	ld	ra,56(sp)
    800004c6:	7442                	ld	s0,48(sp)
    800004c8:	74a2                	ld	s1,40(sp)
    800004ca:	7902                	ld	s2,32(sp)
    800004cc:	69e2                	ld	s3,24(sp)
    800004ce:	6a42                	ld	s4,16(sp)
    800004d0:	6aa2                	ld	s5,8(sp)
    800004d2:	6b02                	ld	s6,0(sp)
    800004d4:	6121                	addi	sp,sp,64
    800004d6:	8082                	ret
    panic("walk");
    800004d8:	00008517          	auipc	a0,0x8
    800004dc:	b7850513          	addi	a0,a0,-1160 # 80008050 <etext+0x50>
    800004e0:	00006097          	auipc	ra,0x6
    800004e4:	a12080e7          	jalr	-1518(ra) # 80005ef2 <panic>
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800004e8:	020a8663          	beqz	s5,80000514 <walk+0xa2>
    800004ec:	00000097          	auipc	ra,0x0
    800004f0:	c2e080e7          	jalr	-978(ra) # 8000011a <kalloc>
    800004f4:	84aa                	mv	s1,a0
    800004f6:	d579                	beqz	a0,800004c4 <walk+0x52>
      memset(pagetable, 0, PGSIZE);
    800004f8:	6605                	lui	a2,0x1
    800004fa:	4581                	li	a1,0
    800004fc:	00000097          	auipc	ra,0x0
    80000500:	c7e080e7          	jalr	-898(ra) # 8000017a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000504:	00c4d793          	srli	a5,s1,0xc
    80000508:	07aa                	slli	a5,a5,0xa
    8000050a:	0017e793          	ori	a5,a5,1
    8000050e:	00f93023          	sd	a5,0(s2)
    80000512:	b745                	j	800004b2 <walk+0x40>
        return 0;
    80000514:	4501                	li	a0,0
    80000516:	b77d                	j	800004c4 <walk+0x52>

0000000080000518 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000518:	57fd                	li	a5,-1
    8000051a:	83e9                	srli	a5,a5,0x1a
    8000051c:	00b7f463          	bgeu	a5,a1,80000524 <walkaddr+0xc>
    return 0;
    80000520:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000522:	8082                	ret
{
    80000524:	1141                	addi	sp,sp,-16
    80000526:	e406                	sd	ra,8(sp)
    80000528:	e022                	sd	s0,0(sp)
    8000052a:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000052c:	4601                	li	a2,0
    8000052e:	00000097          	auipc	ra,0x0
    80000532:	f44080e7          	jalr	-188(ra) # 80000472 <walk>
  if(pte == 0)
    80000536:	c105                	beqz	a0,80000556 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000538:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000053a:	0117f693          	andi	a3,a5,17
    8000053e:	4745                	li	a4,17
    return 0;
    80000540:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000542:	00e68663          	beq	a3,a4,8000054e <walkaddr+0x36>
}
    80000546:	60a2                	ld	ra,8(sp)
    80000548:	6402                	ld	s0,0(sp)
    8000054a:	0141                	addi	sp,sp,16
    8000054c:	8082                	ret
  pa = PTE2PA(*pte);
    8000054e:	83a9                	srli	a5,a5,0xa
    80000550:	00c79513          	slli	a0,a5,0xc
  return pa;
    80000554:	bfcd                	j	80000546 <walkaddr+0x2e>
    return 0;
    80000556:	4501                	li	a0,0
    80000558:	b7fd                	j	80000546 <walkaddr+0x2e>

000000008000055a <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000055a:	715d                	addi	sp,sp,-80
    8000055c:	e486                	sd	ra,72(sp)
    8000055e:	e0a2                	sd	s0,64(sp)
    80000560:	fc26                	sd	s1,56(sp)
    80000562:	f84a                	sd	s2,48(sp)
    80000564:	f44e                	sd	s3,40(sp)
    80000566:	f052                	sd	s4,32(sp)
    80000568:	ec56                	sd	s5,24(sp)
    8000056a:	e85a                	sd	s6,16(sp)
    8000056c:	e45e                	sd	s7,8(sp)
    8000056e:	e062                	sd	s8,0(sp)
    80000570:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80000572:	ca21                	beqz	a2,800005c2 <mappages+0x68>
    80000574:	8aaa                	mv	s5,a0
    80000576:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    80000578:	777d                	lui	a4,0xfffff
    8000057a:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    8000057e:	fff58993          	addi	s3,a1,-1
    80000582:	99b2                	add	s3,s3,a2
    80000584:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    80000588:	893e                	mv	s2,a5
    8000058a:	40f68a33          	sub	s4,a3,a5
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    8000058e:	4b85                	li	s7,1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000590:	6c05                	lui	s8,0x1
    80000592:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    80000596:	865e                	mv	a2,s7
    80000598:	85ca                	mv	a1,s2
    8000059a:	8556                	mv	a0,s5
    8000059c:	00000097          	auipc	ra,0x0
    800005a0:	ed6080e7          	jalr	-298(ra) # 80000472 <walk>
    800005a4:	cd1d                	beqz	a0,800005e2 <mappages+0x88>
    if(*pte & PTE_V)
    800005a6:	611c                	ld	a5,0(a0)
    800005a8:	8b85                	andi	a5,a5,1
    800005aa:	e785                	bnez	a5,800005d2 <mappages+0x78>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005ac:	80b1                	srli	s1,s1,0xc
    800005ae:	04aa                	slli	s1,s1,0xa
    800005b0:	0164e4b3          	or	s1,s1,s6
    800005b4:	0014e493          	ori	s1,s1,1
    800005b8:	e104                	sd	s1,0(a0)
    if(a == last)
    800005ba:	05390163          	beq	s2,s3,800005fc <mappages+0xa2>
    a += PGSIZE;
    800005be:	9962                	add	s2,s2,s8
    if((pte = walk(pagetable, a, 1)) == 0)
    800005c0:	bfc9                	j	80000592 <mappages+0x38>
    panic("mappages: size");
    800005c2:	00008517          	auipc	a0,0x8
    800005c6:	a9650513          	addi	a0,a0,-1386 # 80008058 <etext+0x58>
    800005ca:	00006097          	auipc	ra,0x6
    800005ce:	928080e7          	jalr	-1752(ra) # 80005ef2 <panic>
      panic("mappages: remap");
    800005d2:	00008517          	auipc	a0,0x8
    800005d6:	a9650513          	addi	a0,a0,-1386 # 80008068 <etext+0x68>
    800005da:	00006097          	auipc	ra,0x6
    800005de:	918080e7          	jalr	-1768(ra) # 80005ef2 <panic>
      return -1;
    800005e2:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800005e4:	60a6                	ld	ra,72(sp)
    800005e6:	6406                	ld	s0,64(sp)
    800005e8:	74e2                	ld	s1,56(sp)
    800005ea:	7942                	ld	s2,48(sp)
    800005ec:	79a2                	ld	s3,40(sp)
    800005ee:	7a02                	ld	s4,32(sp)
    800005f0:	6ae2                	ld	s5,24(sp)
    800005f2:	6b42                	ld	s6,16(sp)
    800005f4:	6ba2                	ld	s7,8(sp)
    800005f6:	6c02                	ld	s8,0(sp)
    800005f8:	6161                	addi	sp,sp,80
    800005fa:	8082                	ret
  return 0;
    800005fc:	4501                	li	a0,0
    800005fe:	b7dd                	j	800005e4 <mappages+0x8a>

0000000080000600 <kvmmap>:
{
    80000600:	1141                	addi	sp,sp,-16
    80000602:	e406                	sd	ra,8(sp)
    80000604:	e022                	sd	s0,0(sp)
    80000606:	0800                	addi	s0,sp,16
    80000608:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000060a:	86b2                	mv	a3,a2
    8000060c:	863e                	mv	a2,a5
    8000060e:	00000097          	auipc	ra,0x0
    80000612:	f4c080e7          	jalr	-180(ra) # 8000055a <mappages>
    80000616:	e509                	bnez	a0,80000620 <kvmmap+0x20>
}
    80000618:	60a2                	ld	ra,8(sp)
    8000061a:	6402                	ld	s0,0(sp)
    8000061c:	0141                	addi	sp,sp,16
    8000061e:	8082                	ret
    panic("kvmmap");
    80000620:	00008517          	auipc	a0,0x8
    80000624:	a5850513          	addi	a0,a0,-1448 # 80008078 <etext+0x78>
    80000628:	00006097          	auipc	ra,0x6
    8000062c:	8ca080e7          	jalr	-1846(ra) # 80005ef2 <panic>

0000000080000630 <kvmmake>:
{
    80000630:	1101                	addi	sp,sp,-32
    80000632:	ec06                	sd	ra,24(sp)
    80000634:	e822                	sd	s0,16(sp)
    80000636:	e426                	sd	s1,8(sp)
    80000638:	e04a                	sd	s2,0(sp)
    8000063a:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000063c:	00000097          	auipc	ra,0x0
    80000640:	ade080e7          	jalr	-1314(ra) # 8000011a <kalloc>
    80000644:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000646:	6605                	lui	a2,0x1
    80000648:	4581                	li	a1,0
    8000064a:	00000097          	auipc	ra,0x0
    8000064e:	b30080e7          	jalr	-1232(ra) # 8000017a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000652:	4719                	li	a4,6
    80000654:	6685                	lui	a3,0x1
    80000656:	10000637          	lui	a2,0x10000
    8000065a:	85b2                	mv	a1,a2
    8000065c:	8526                	mv	a0,s1
    8000065e:	00000097          	auipc	ra,0x0
    80000662:	fa2080e7          	jalr	-94(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000666:	4719                	li	a4,6
    80000668:	6685                	lui	a3,0x1
    8000066a:	10001637          	lui	a2,0x10001
    8000066e:	85b2                	mv	a1,a2
    80000670:	8526                	mv	a0,s1
    80000672:	00000097          	auipc	ra,0x0
    80000676:	f8e080e7          	jalr	-114(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    8000067a:	4719                	li	a4,6
    8000067c:	004006b7          	lui	a3,0x400
    80000680:	0c000637          	lui	a2,0xc000
    80000684:	85b2                	mv	a1,a2
    80000686:	8526                	mv	a0,s1
    80000688:	00000097          	auipc	ra,0x0
    8000068c:	f78080e7          	jalr	-136(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000690:	00008917          	auipc	s2,0x8
    80000694:	97090913          	addi	s2,s2,-1680 # 80008000 <etext>
    80000698:	4729                	li	a4,10
    8000069a:	80008697          	auipc	a3,0x80008
    8000069e:	96668693          	addi	a3,a3,-1690 # 8000 <_entry-0x7fff8000>
    800006a2:	4605                	li	a2,1
    800006a4:	067e                	slli	a2,a2,0x1f
    800006a6:	85b2                	mv	a1,a2
    800006a8:	8526                	mv	a0,s1
    800006aa:	00000097          	auipc	ra,0x0
    800006ae:	f56080e7          	jalr	-170(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006b2:	4719                	li	a4,6
    800006b4:	46c5                	li	a3,17
    800006b6:	06ee                	slli	a3,a3,0x1b
    800006b8:	412686b3          	sub	a3,a3,s2
    800006bc:	864a                	mv	a2,s2
    800006be:	85ca                	mv	a1,s2
    800006c0:	8526                	mv	a0,s1
    800006c2:	00000097          	auipc	ra,0x0
    800006c6:	f3e080e7          	jalr	-194(ra) # 80000600 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006ca:	4729                	li	a4,10
    800006cc:	6685                	lui	a3,0x1
    800006ce:	00007617          	auipc	a2,0x7
    800006d2:	93260613          	addi	a2,a2,-1742 # 80007000 <_trampoline>
    800006d6:	040005b7          	lui	a1,0x4000
    800006da:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800006dc:	05b2                	slli	a1,a1,0xc
    800006de:	8526                	mv	a0,s1
    800006e0:	00000097          	auipc	ra,0x0
    800006e4:	f20080e7          	jalr	-224(ra) # 80000600 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006e8:	8526                	mv	a0,s1
    800006ea:	00000097          	auipc	ra,0x0
    800006ee:	710080e7          	jalr	1808(ra) # 80000dfa <proc_mapstacks>
}
    800006f2:	8526                	mv	a0,s1
    800006f4:	60e2                	ld	ra,24(sp)
    800006f6:	6442                	ld	s0,16(sp)
    800006f8:	64a2                	ld	s1,8(sp)
    800006fa:	6902                	ld	s2,0(sp)
    800006fc:	6105                	addi	sp,sp,32
    800006fe:	8082                	ret

0000000080000700 <kvminit>:
{
    80000700:	1141                	addi	sp,sp,-16
    80000702:	e406                	sd	ra,8(sp)
    80000704:	e022                	sd	s0,0(sp)
    80000706:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000708:	00000097          	auipc	ra,0x0
    8000070c:	f28080e7          	jalr	-216(ra) # 80000630 <kvmmake>
    80000710:	00009797          	auipc	a5,0x9
    80000714:	8ea7bc23          	sd	a0,-1800(a5) # 80009008 <kernel_pagetable>
}
    80000718:	60a2                	ld	ra,8(sp)
    8000071a:	6402                	ld	s0,0(sp)
    8000071c:	0141                	addi	sp,sp,16
    8000071e:	8082                	ret

0000000080000720 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000720:	715d                	addi	sp,sp,-80
    80000722:	e486                	sd	ra,72(sp)
    80000724:	e0a2                	sd	s0,64(sp)
    80000726:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000728:	03459793          	slli	a5,a1,0x34
    8000072c:	e39d                	bnez	a5,80000752 <uvmunmap+0x32>
    8000072e:	f84a                	sd	s2,48(sp)
    80000730:	f44e                	sd	s3,40(sp)
    80000732:	f052                	sd	s4,32(sp)
    80000734:	ec56                	sd	s5,24(sp)
    80000736:	e85a                	sd	s6,16(sp)
    80000738:	e45e                	sd	s7,8(sp)
    8000073a:	8a2a                	mv	s4,a0
    8000073c:	892e                	mv	s2,a1
    8000073e:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000740:	0632                	slli	a2,a2,0xc
    80000742:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000746:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000748:	6b05                	lui	s6,0x1
    8000074a:	0935fb63          	bgeu	a1,s3,800007e0 <uvmunmap+0xc0>
    8000074e:	fc26                	sd	s1,56(sp)
    80000750:	a8a9                	j	800007aa <uvmunmap+0x8a>
    80000752:	fc26                	sd	s1,56(sp)
    80000754:	f84a                	sd	s2,48(sp)
    80000756:	f44e                	sd	s3,40(sp)
    80000758:	f052                	sd	s4,32(sp)
    8000075a:	ec56                	sd	s5,24(sp)
    8000075c:	e85a                	sd	s6,16(sp)
    8000075e:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    80000760:	00008517          	auipc	a0,0x8
    80000764:	92050513          	addi	a0,a0,-1760 # 80008080 <etext+0x80>
    80000768:	00005097          	auipc	ra,0x5
    8000076c:	78a080e7          	jalr	1930(ra) # 80005ef2 <panic>
      panic("uvmunmap: walk");
    80000770:	00008517          	auipc	a0,0x8
    80000774:	92850513          	addi	a0,a0,-1752 # 80008098 <etext+0x98>
    80000778:	00005097          	auipc	ra,0x5
    8000077c:	77a080e7          	jalr	1914(ra) # 80005ef2 <panic>
      panic("uvmunmap: not mapped");
    80000780:	00008517          	auipc	a0,0x8
    80000784:	92850513          	addi	a0,a0,-1752 # 800080a8 <etext+0xa8>
    80000788:	00005097          	auipc	ra,0x5
    8000078c:	76a080e7          	jalr	1898(ra) # 80005ef2 <panic>
      panic("uvmunmap: not a leaf");
    80000790:	00008517          	auipc	a0,0x8
    80000794:	93050513          	addi	a0,a0,-1744 # 800080c0 <etext+0xc0>
    80000798:	00005097          	auipc	ra,0x5
    8000079c:	75a080e7          	jalr	1882(ra) # 80005ef2 <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800007a0:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007a4:	995a                	add	s2,s2,s6
    800007a6:	03397c63          	bgeu	s2,s3,800007de <uvmunmap+0xbe>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007aa:	4601                	li	a2,0
    800007ac:	85ca                	mv	a1,s2
    800007ae:	8552                	mv	a0,s4
    800007b0:	00000097          	auipc	ra,0x0
    800007b4:	cc2080e7          	jalr	-830(ra) # 80000472 <walk>
    800007b8:	84aa                	mv	s1,a0
    800007ba:	d95d                	beqz	a0,80000770 <uvmunmap+0x50>
    if((*pte & PTE_V) == 0)
    800007bc:	6108                	ld	a0,0(a0)
    800007be:	00157793          	andi	a5,a0,1
    800007c2:	dfdd                	beqz	a5,80000780 <uvmunmap+0x60>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007c4:	3ff57793          	andi	a5,a0,1023
    800007c8:	fd7784e3          	beq	a5,s7,80000790 <uvmunmap+0x70>
    if(do_free){
    800007cc:	fc0a8ae3          	beqz	s5,800007a0 <uvmunmap+0x80>
      uint64 pa = PTE2PA(*pte);
    800007d0:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800007d2:	0532                	slli	a0,a0,0xc
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	848080e7          	jalr	-1976(ra) # 8000001c <kfree>
    800007dc:	b7d1                	j	800007a0 <uvmunmap+0x80>
    800007de:	74e2                	ld	s1,56(sp)
    800007e0:	7942                	ld	s2,48(sp)
    800007e2:	79a2                	ld	s3,40(sp)
    800007e4:	7a02                	ld	s4,32(sp)
    800007e6:	6ae2                	ld	s5,24(sp)
    800007e8:	6b42                	ld	s6,16(sp)
    800007ea:	6ba2                	ld	s7,8(sp)
  }
}
    800007ec:	60a6                	ld	ra,72(sp)
    800007ee:	6406                	ld	s0,64(sp)
    800007f0:	6161                	addi	sp,sp,80
    800007f2:	8082                	ret

00000000800007f4 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007f4:	1101                	addi	sp,sp,-32
    800007f6:	ec06                	sd	ra,24(sp)
    800007f8:	e822                	sd	s0,16(sp)
    800007fa:	e426                	sd	s1,8(sp)
    800007fc:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007fe:	00000097          	auipc	ra,0x0
    80000802:	91c080e7          	jalr	-1764(ra) # 8000011a <kalloc>
    80000806:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000808:	c519                	beqz	a0,80000816 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000080a:	6605                	lui	a2,0x1
    8000080c:	4581                	li	a1,0
    8000080e:	00000097          	auipc	ra,0x0
    80000812:	96c080e7          	jalr	-1684(ra) # 8000017a <memset>
  return pagetable;
}
    80000816:	8526                	mv	a0,s1
    80000818:	60e2                	ld	ra,24(sp)
    8000081a:	6442                	ld	s0,16(sp)
    8000081c:	64a2                	ld	s1,8(sp)
    8000081e:	6105                	addi	sp,sp,32
    80000820:	8082                	ret

0000000080000822 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    80000822:	7179                	addi	sp,sp,-48
    80000824:	f406                	sd	ra,40(sp)
    80000826:	f022                	sd	s0,32(sp)
    80000828:	ec26                	sd	s1,24(sp)
    8000082a:	e84a                	sd	s2,16(sp)
    8000082c:	e44e                	sd	s3,8(sp)
    8000082e:	e052                	sd	s4,0(sp)
    80000830:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000832:	6785                	lui	a5,0x1
    80000834:	04f67863          	bgeu	a2,a5,80000884 <uvminit+0x62>
    80000838:	8a2a                	mv	s4,a0
    8000083a:	89ae                	mv	s3,a1
    8000083c:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    8000083e:	00000097          	auipc	ra,0x0
    80000842:	8dc080e7          	jalr	-1828(ra) # 8000011a <kalloc>
    80000846:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000848:	6605                	lui	a2,0x1
    8000084a:	4581                	li	a1,0
    8000084c:	00000097          	auipc	ra,0x0
    80000850:	92e080e7          	jalr	-1746(ra) # 8000017a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000854:	4779                	li	a4,30
    80000856:	86ca                	mv	a3,s2
    80000858:	6605                	lui	a2,0x1
    8000085a:	4581                	li	a1,0
    8000085c:	8552                	mv	a0,s4
    8000085e:	00000097          	auipc	ra,0x0
    80000862:	cfc080e7          	jalr	-772(ra) # 8000055a <mappages>
  memmove(mem, src, sz);
    80000866:	8626                	mv	a2,s1
    80000868:	85ce                	mv	a1,s3
    8000086a:	854a                	mv	a0,s2
    8000086c:	00000097          	auipc	ra,0x0
    80000870:	972080e7          	jalr	-1678(ra) # 800001de <memmove>
}
    80000874:	70a2                	ld	ra,40(sp)
    80000876:	7402                	ld	s0,32(sp)
    80000878:	64e2                	ld	s1,24(sp)
    8000087a:	6942                	ld	s2,16(sp)
    8000087c:	69a2                	ld	s3,8(sp)
    8000087e:	6a02                	ld	s4,0(sp)
    80000880:	6145                	addi	sp,sp,48
    80000882:	8082                	ret
    panic("inituvm: more than a page");
    80000884:	00008517          	auipc	a0,0x8
    80000888:	85450513          	addi	a0,a0,-1964 # 800080d8 <etext+0xd8>
    8000088c:	00005097          	auipc	ra,0x5
    80000890:	666080e7          	jalr	1638(ra) # 80005ef2 <panic>

0000000080000894 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000894:	1101                	addi	sp,sp,-32
    80000896:	ec06                	sd	ra,24(sp)
    80000898:	e822                	sd	s0,16(sp)
    8000089a:	e426                	sd	s1,8(sp)
    8000089c:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    8000089e:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800008a0:	00b67d63          	bgeu	a2,a1,800008ba <uvmdealloc+0x26>
    800008a4:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800008a6:	6785                	lui	a5,0x1
    800008a8:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008aa:	00f60733          	add	a4,a2,a5
    800008ae:	76fd                	lui	a3,0xfffff
    800008b0:	8f75                	and	a4,a4,a3
    800008b2:	97ae                	add	a5,a5,a1
    800008b4:	8ff5                	and	a5,a5,a3
    800008b6:	00f76863          	bltu	a4,a5,800008c6 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800008ba:	8526                	mv	a0,s1
    800008bc:	60e2                	ld	ra,24(sp)
    800008be:	6442                	ld	s0,16(sp)
    800008c0:	64a2                	ld	s1,8(sp)
    800008c2:	6105                	addi	sp,sp,32
    800008c4:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008c6:	8f99                	sub	a5,a5,a4
    800008c8:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008ca:	4685                	li	a3,1
    800008cc:	0007861b          	sext.w	a2,a5
    800008d0:	85ba                	mv	a1,a4
    800008d2:	00000097          	auipc	ra,0x0
    800008d6:	e4e080e7          	jalr	-434(ra) # 80000720 <uvmunmap>
    800008da:	b7c5                	j	800008ba <uvmdealloc+0x26>

00000000800008dc <uvmalloc>:
  if(newsz < oldsz)
    800008dc:	0ab66e63          	bltu	a2,a1,80000998 <uvmalloc+0xbc>
{
    800008e0:	715d                	addi	sp,sp,-80
    800008e2:	e486                	sd	ra,72(sp)
    800008e4:	e0a2                	sd	s0,64(sp)
    800008e6:	f052                	sd	s4,32(sp)
    800008e8:	ec56                	sd	s5,24(sp)
    800008ea:	e85a                	sd	s6,16(sp)
    800008ec:	0880                	addi	s0,sp,80
    800008ee:	8b2a                	mv	s6,a0
    800008f0:	8ab2                	mv	s5,a2
  oldsz = PGROUNDUP(oldsz);
    800008f2:	6785                	lui	a5,0x1
    800008f4:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008f6:	95be                	add	a1,a1,a5
    800008f8:	77fd                	lui	a5,0xfffff
    800008fa:	00f5fa33          	and	s4,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008fe:	08ca7f63          	bgeu	s4,a2,8000099c <uvmalloc+0xc0>
    80000902:	fc26                	sd	s1,56(sp)
    80000904:	f84a                	sd	s2,48(sp)
    80000906:	f44e                	sd	s3,40(sp)
    80000908:	e45e                	sd	s7,8(sp)
    8000090a:	8952                	mv	s2,s4
    memset(mem, 0, PGSIZE);
    8000090c:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    8000090e:	4bf9                	li	s7,30
    mem = kalloc();
    80000910:	00000097          	auipc	ra,0x0
    80000914:	80a080e7          	jalr	-2038(ra) # 8000011a <kalloc>
    80000918:	84aa                	mv	s1,a0
    if(mem == 0){
    8000091a:	c915                	beqz	a0,8000094e <uvmalloc+0x72>
    memset(mem, 0, PGSIZE);
    8000091c:	864e                	mv	a2,s3
    8000091e:	4581                	li	a1,0
    80000920:	00000097          	auipc	ra,0x0
    80000924:	85a080e7          	jalr	-1958(ra) # 8000017a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80000928:	875e                	mv	a4,s7
    8000092a:	86a6                	mv	a3,s1
    8000092c:	864e                	mv	a2,s3
    8000092e:	85ca                	mv	a1,s2
    80000930:	855a                	mv	a0,s6
    80000932:	00000097          	auipc	ra,0x0
    80000936:	c28080e7          	jalr	-984(ra) # 8000055a <mappages>
    8000093a:	ed0d                	bnez	a0,80000974 <uvmalloc+0x98>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000093c:	994e                	add	s2,s2,s3
    8000093e:	fd5969e3          	bltu	s2,s5,80000910 <uvmalloc+0x34>
  return newsz;
    80000942:	8556                	mv	a0,s5
    80000944:	74e2                	ld	s1,56(sp)
    80000946:	7942                	ld	s2,48(sp)
    80000948:	79a2                	ld	s3,40(sp)
    8000094a:	6ba2                	ld	s7,8(sp)
    8000094c:	a829                	j	80000966 <uvmalloc+0x8a>
      uvmdealloc(pagetable, a, oldsz);
    8000094e:	8652                	mv	a2,s4
    80000950:	85ca                	mv	a1,s2
    80000952:	855a                	mv	a0,s6
    80000954:	00000097          	auipc	ra,0x0
    80000958:	f40080e7          	jalr	-192(ra) # 80000894 <uvmdealloc>
      return 0;
    8000095c:	4501                	li	a0,0
    8000095e:	74e2                	ld	s1,56(sp)
    80000960:	7942                	ld	s2,48(sp)
    80000962:	79a2                	ld	s3,40(sp)
    80000964:	6ba2                	ld	s7,8(sp)
}
    80000966:	60a6                	ld	ra,72(sp)
    80000968:	6406                	ld	s0,64(sp)
    8000096a:	7a02                	ld	s4,32(sp)
    8000096c:	6ae2                	ld	s5,24(sp)
    8000096e:	6b42                	ld	s6,16(sp)
    80000970:	6161                	addi	sp,sp,80
    80000972:	8082                	ret
      kfree(mem);
    80000974:	8526                	mv	a0,s1
    80000976:	fffff097          	auipc	ra,0xfffff
    8000097a:	6a6080e7          	jalr	1702(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    8000097e:	8652                	mv	a2,s4
    80000980:	85ca                	mv	a1,s2
    80000982:	855a                	mv	a0,s6
    80000984:	00000097          	auipc	ra,0x0
    80000988:	f10080e7          	jalr	-240(ra) # 80000894 <uvmdealloc>
      return 0;
    8000098c:	4501                	li	a0,0
    8000098e:	74e2                	ld	s1,56(sp)
    80000990:	7942                	ld	s2,48(sp)
    80000992:	79a2                	ld	s3,40(sp)
    80000994:	6ba2                	ld	s7,8(sp)
    80000996:	bfc1                	j	80000966 <uvmalloc+0x8a>
    return oldsz;
    80000998:	852e                	mv	a0,a1
}
    8000099a:	8082                	ret
  return newsz;
    8000099c:	8532                	mv	a0,a2
    8000099e:	b7e1                	j	80000966 <uvmalloc+0x8a>

00000000800009a0 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800009a0:	7179                	addi	sp,sp,-48
    800009a2:	f406                	sd	ra,40(sp)
    800009a4:	f022                	sd	s0,32(sp)
    800009a6:	ec26                	sd	s1,24(sp)
    800009a8:	e84a                	sd	s2,16(sp)
    800009aa:	e44e                	sd	s3,8(sp)
    800009ac:	e052                	sd	s4,0(sp)
    800009ae:	1800                	addi	s0,sp,48
    800009b0:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800009b2:	84aa                	mv	s1,a0
    800009b4:	6905                	lui	s2,0x1
    800009b6:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009b8:	4985                	li	s3,1
    800009ba:	a829                	j	800009d4 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800009bc:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800009be:	00c79513          	slli	a0,a5,0xc
    800009c2:	00000097          	auipc	ra,0x0
    800009c6:	fde080e7          	jalr	-34(ra) # 800009a0 <freewalk>
      pagetable[i] = 0;
    800009ca:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800009ce:	04a1                	addi	s1,s1,8
    800009d0:	03248163          	beq	s1,s2,800009f2 <freewalk+0x52>
    pte_t pte = pagetable[i];
    800009d4:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009d6:	00f7f713          	andi	a4,a5,15
    800009da:	ff3701e3          	beq	a4,s3,800009bc <freewalk+0x1c>
    } else if(pte & PTE_V){
    800009de:	8b85                	andi	a5,a5,1
    800009e0:	d7fd                	beqz	a5,800009ce <freewalk+0x2e>
      panic("freewalk: leaf");
    800009e2:	00007517          	auipc	a0,0x7
    800009e6:	71650513          	addi	a0,a0,1814 # 800080f8 <etext+0xf8>
    800009ea:	00005097          	auipc	ra,0x5
    800009ee:	508080e7          	jalr	1288(ra) # 80005ef2 <panic>
    }
  }
  kfree((void*)pagetable);
    800009f2:	8552                	mv	a0,s4
    800009f4:	fffff097          	auipc	ra,0xfffff
    800009f8:	628080e7          	jalr	1576(ra) # 8000001c <kfree>
}
    800009fc:	70a2                	ld	ra,40(sp)
    800009fe:	7402                	ld	s0,32(sp)
    80000a00:	64e2                	ld	s1,24(sp)
    80000a02:	6942                	ld	s2,16(sp)
    80000a04:	69a2                	ld	s3,8(sp)
    80000a06:	6a02                	ld	s4,0(sp)
    80000a08:	6145                	addi	sp,sp,48
    80000a0a:	8082                	ret

0000000080000a0c <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000a0c:	1101                	addi	sp,sp,-32
    80000a0e:	ec06                	sd	ra,24(sp)
    80000a10:	e822                	sd	s0,16(sp)
    80000a12:	e426                	sd	s1,8(sp)
    80000a14:	1000                	addi	s0,sp,32
    80000a16:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a18:	e999                	bnez	a1,80000a2e <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a1a:	8526                	mv	a0,s1
    80000a1c:	00000097          	auipc	ra,0x0
    80000a20:	f84080e7          	jalr	-124(ra) # 800009a0 <freewalk>
}
    80000a24:	60e2                	ld	ra,24(sp)
    80000a26:	6442                	ld	s0,16(sp)
    80000a28:	64a2                	ld	s1,8(sp)
    80000a2a:	6105                	addi	sp,sp,32
    80000a2c:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000a2e:	6785                	lui	a5,0x1
    80000a30:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a32:	95be                	add	a1,a1,a5
    80000a34:	4685                	li	a3,1
    80000a36:	00c5d613          	srli	a2,a1,0xc
    80000a3a:	4581                	li	a1,0
    80000a3c:	00000097          	auipc	ra,0x0
    80000a40:	ce4080e7          	jalr	-796(ra) # 80000720 <uvmunmap>
    80000a44:	bfd9                	j	80000a1a <uvmfree+0xe>

0000000080000a46 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a46:	ca69                	beqz	a2,80000b18 <uvmcopy+0xd2>
{
    80000a48:	715d                	addi	sp,sp,-80
    80000a4a:	e486                	sd	ra,72(sp)
    80000a4c:	e0a2                	sd	s0,64(sp)
    80000a4e:	fc26                	sd	s1,56(sp)
    80000a50:	f84a                	sd	s2,48(sp)
    80000a52:	f44e                	sd	s3,40(sp)
    80000a54:	f052                	sd	s4,32(sp)
    80000a56:	ec56                	sd	s5,24(sp)
    80000a58:	e85a                	sd	s6,16(sp)
    80000a5a:	e45e                	sd	s7,8(sp)
    80000a5c:	e062                	sd	s8,0(sp)
    80000a5e:	0880                	addi	s0,sp,80
    80000a60:	8baa                	mv	s7,a0
    80000a62:	8b2e                	mv	s6,a1
    80000a64:	8ab2                	mv	s5,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a66:	4981                	li	s3,0
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a68:	6a05                	lui	s4,0x1
    if((pte = walk(old, i, 0)) == 0)
    80000a6a:	4601                	li	a2,0
    80000a6c:	85ce                	mv	a1,s3
    80000a6e:	855e                	mv	a0,s7
    80000a70:	00000097          	auipc	ra,0x0
    80000a74:	a02080e7          	jalr	-1534(ra) # 80000472 <walk>
    80000a78:	c529                	beqz	a0,80000ac2 <uvmcopy+0x7c>
    if((*pte & PTE_V) == 0)
    80000a7a:	6118                	ld	a4,0(a0)
    80000a7c:	00177793          	andi	a5,a4,1
    80000a80:	cba9                	beqz	a5,80000ad2 <uvmcopy+0x8c>
    pa = PTE2PA(*pte);
    80000a82:	00a75593          	srli	a1,a4,0xa
    80000a86:	00c59c13          	slli	s8,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a8a:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a8e:	fffff097          	auipc	ra,0xfffff
    80000a92:	68c080e7          	jalr	1676(ra) # 8000011a <kalloc>
    80000a96:	892a                	mv	s2,a0
    80000a98:	c931                	beqz	a0,80000aec <uvmcopy+0xa6>
    memmove(mem, (char*)pa, PGSIZE);
    80000a9a:	8652                	mv	a2,s4
    80000a9c:	85e2                	mv	a1,s8
    80000a9e:	fffff097          	auipc	ra,0xfffff
    80000aa2:	740080e7          	jalr	1856(ra) # 800001de <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000aa6:	8726                	mv	a4,s1
    80000aa8:	86ca                	mv	a3,s2
    80000aaa:	8652                	mv	a2,s4
    80000aac:	85ce                	mv	a1,s3
    80000aae:	855a                	mv	a0,s6
    80000ab0:	00000097          	auipc	ra,0x0
    80000ab4:	aaa080e7          	jalr	-1366(ra) # 8000055a <mappages>
    80000ab8:	e50d                	bnez	a0,80000ae2 <uvmcopy+0x9c>
  for(i = 0; i < sz; i += PGSIZE){
    80000aba:	99d2                	add	s3,s3,s4
    80000abc:	fb59e7e3          	bltu	s3,s5,80000a6a <uvmcopy+0x24>
    80000ac0:	a081                	j	80000b00 <uvmcopy+0xba>
      panic("uvmcopy: pte should exist");
    80000ac2:	00007517          	auipc	a0,0x7
    80000ac6:	64650513          	addi	a0,a0,1606 # 80008108 <etext+0x108>
    80000aca:	00005097          	auipc	ra,0x5
    80000ace:	428080e7          	jalr	1064(ra) # 80005ef2 <panic>
      panic("uvmcopy: page not present");
    80000ad2:	00007517          	auipc	a0,0x7
    80000ad6:	65650513          	addi	a0,a0,1622 # 80008128 <etext+0x128>
    80000ada:	00005097          	auipc	ra,0x5
    80000ade:	418080e7          	jalr	1048(ra) # 80005ef2 <panic>
      kfree(mem);
    80000ae2:	854a                	mv	a0,s2
    80000ae4:	fffff097          	auipc	ra,0xfffff
    80000ae8:	538080e7          	jalr	1336(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aec:	4685                	li	a3,1
    80000aee:	00c9d613          	srli	a2,s3,0xc
    80000af2:	4581                	li	a1,0
    80000af4:	855a                	mv	a0,s6
    80000af6:	00000097          	auipc	ra,0x0
    80000afa:	c2a080e7          	jalr	-982(ra) # 80000720 <uvmunmap>
  return -1;
    80000afe:	557d                	li	a0,-1
}
    80000b00:	60a6                	ld	ra,72(sp)
    80000b02:	6406                	ld	s0,64(sp)
    80000b04:	74e2                	ld	s1,56(sp)
    80000b06:	7942                	ld	s2,48(sp)
    80000b08:	79a2                	ld	s3,40(sp)
    80000b0a:	7a02                	ld	s4,32(sp)
    80000b0c:	6ae2                	ld	s5,24(sp)
    80000b0e:	6b42                	ld	s6,16(sp)
    80000b10:	6ba2                	ld	s7,8(sp)
    80000b12:	6c02                	ld	s8,0(sp)
    80000b14:	6161                	addi	sp,sp,80
    80000b16:	8082                	ret
  return 0;
    80000b18:	4501                	li	a0,0
}
    80000b1a:	8082                	ret

0000000080000b1c <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b1c:	1141                	addi	sp,sp,-16
    80000b1e:	e406                	sd	ra,8(sp)
    80000b20:	e022                	sd	s0,0(sp)
    80000b22:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b24:	4601                	li	a2,0
    80000b26:	00000097          	auipc	ra,0x0
    80000b2a:	94c080e7          	jalr	-1716(ra) # 80000472 <walk>
  if(pte == 0)
    80000b2e:	c901                	beqz	a0,80000b3e <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000b30:	611c                	ld	a5,0(a0)
    80000b32:	9bbd                	andi	a5,a5,-17
    80000b34:	e11c                	sd	a5,0(a0)
}
    80000b36:	60a2                	ld	ra,8(sp)
    80000b38:	6402                	ld	s0,0(sp)
    80000b3a:	0141                	addi	sp,sp,16
    80000b3c:	8082                	ret
    panic("uvmclear");
    80000b3e:	00007517          	auipc	a0,0x7
    80000b42:	60a50513          	addi	a0,a0,1546 # 80008148 <etext+0x148>
    80000b46:	00005097          	auipc	ra,0x5
    80000b4a:	3ac080e7          	jalr	940(ra) # 80005ef2 <panic>

0000000080000b4e <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b4e:	c6bd                	beqz	a3,80000bbc <copyout+0x6e>
{
    80000b50:	715d                	addi	sp,sp,-80
    80000b52:	e486                	sd	ra,72(sp)
    80000b54:	e0a2                	sd	s0,64(sp)
    80000b56:	fc26                	sd	s1,56(sp)
    80000b58:	f84a                	sd	s2,48(sp)
    80000b5a:	f44e                	sd	s3,40(sp)
    80000b5c:	f052                	sd	s4,32(sp)
    80000b5e:	ec56                	sd	s5,24(sp)
    80000b60:	e85a                	sd	s6,16(sp)
    80000b62:	e45e                	sd	s7,8(sp)
    80000b64:	e062                	sd	s8,0(sp)
    80000b66:	0880                	addi	s0,sp,80
    80000b68:	8b2a                	mv	s6,a0
    80000b6a:	8c2e                	mv	s8,a1
    80000b6c:	8a32                	mv	s4,a2
    80000b6e:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b70:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b72:	6a85                	lui	s5,0x1
    80000b74:	a015                	j	80000b98 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b76:	9562                	add	a0,a0,s8
    80000b78:	0004861b          	sext.w	a2,s1
    80000b7c:	85d2                	mv	a1,s4
    80000b7e:	41250533          	sub	a0,a0,s2
    80000b82:	fffff097          	auipc	ra,0xfffff
    80000b86:	65c080e7          	jalr	1628(ra) # 800001de <memmove>

    len -= n;
    80000b8a:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b8e:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b90:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b94:	02098263          	beqz	s3,80000bb8 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b98:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b9c:	85ca                	mv	a1,s2
    80000b9e:	855a                	mv	a0,s6
    80000ba0:	00000097          	auipc	ra,0x0
    80000ba4:	978080e7          	jalr	-1672(ra) # 80000518 <walkaddr>
    if(pa0 == 0)
    80000ba8:	cd01                	beqz	a0,80000bc0 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000baa:	418904b3          	sub	s1,s2,s8
    80000bae:	94d6                	add	s1,s1,s5
    if(n > len)
    80000bb0:	fc99f3e3          	bgeu	s3,s1,80000b76 <copyout+0x28>
    80000bb4:	84ce                	mv	s1,s3
    80000bb6:	b7c1                	j	80000b76 <copyout+0x28>
  }
  return 0;
    80000bb8:	4501                	li	a0,0
    80000bba:	a021                	j	80000bc2 <copyout+0x74>
    80000bbc:	4501                	li	a0,0
}
    80000bbe:	8082                	ret
      return -1;
    80000bc0:	557d                	li	a0,-1
}
    80000bc2:	60a6                	ld	ra,72(sp)
    80000bc4:	6406                	ld	s0,64(sp)
    80000bc6:	74e2                	ld	s1,56(sp)
    80000bc8:	7942                	ld	s2,48(sp)
    80000bca:	79a2                	ld	s3,40(sp)
    80000bcc:	7a02                	ld	s4,32(sp)
    80000bce:	6ae2                	ld	s5,24(sp)
    80000bd0:	6b42                	ld	s6,16(sp)
    80000bd2:	6ba2                	ld	s7,8(sp)
    80000bd4:	6c02                	ld	s8,0(sp)
    80000bd6:	6161                	addi	sp,sp,80
    80000bd8:	8082                	ret

0000000080000bda <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000bda:	caa5                	beqz	a3,80000c4a <copyin+0x70>
{
    80000bdc:	715d                	addi	sp,sp,-80
    80000bde:	e486                	sd	ra,72(sp)
    80000be0:	e0a2                	sd	s0,64(sp)
    80000be2:	fc26                	sd	s1,56(sp)
    80000be4:	f84a                	sd	s2,48(sp)
    80000be6:	f44e                	sd	s3,40(sp)
    80000be8:	f052                	sd	s4,32(sp)
    80000bea:	ec56                	sd	s5,24(sp)
    80000bec:	e85a                	sd	s6,16(sp)
    80000bee:	e45e                	sd	s7,8(sp)
    80000bf0:	e062                	sd	s8,0(sp)
    80000bf2:	0880                	addi	s0,sp,80
    80000bf4:	8b2a                	mv	s6,a0
    80000bf6:	8a2e                	mv	s4,a1
    80000bf8:	8c32                	mv	s8,a2
    80000bfa:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bfc:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bfe:	6a85                	lui	s5,0x1
    80000c00:	a01d                	j	80000c26 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000c02:	018505b3          	add	a1,a0,s8
    80000c06:	0004861b          	sext.w	a2,s1
    80000c0a:	412585b3          	sub	a1,a1,s2
    80000c0e:	8552                	mv	a0,s4
    80000c10:	fffff097          	auipc	ra,0xfffff
    80000c14:	5ce080e7          	jalr	1486(ra) # 800001de <memmove>

    len -= n;
    80000c18:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c1c:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000c1e:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c22:	02098263          	beqz	s3,80000c46 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c26:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c2a:	85ca                	mv	a1,s2
    80000c2c:	855a                	mv	a0,s6
    80000c2e:	00000097          	auipc	ra,0x0
    80000c32:	8ea080e7          	jalr	-1814(ra) # 80000518 <walkaddr>
    if(pa0 == 0)
    80000c36:	cd01                	beqz	a0,80000c4e <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000c38:	418904b3          	sub	s1,s2,s8
    80000c3c:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c3e:	fc99f2e3          	bgeu	s3,s1,80000c02 <copyin+0x28>
    80000c42:	84ce                	mv	s1,s3
    80000c44:	bf7d                	j	80000c02 <copyin+0x28>
  }
  return 0;
    80000c46:	4501                	li	a0,0
    80000c48:	a021                	j	80000c50 <copyin+0x76>
    80000c4a:	4501                	li	a0,0
}
    80000c4c:	8082                	ret
      return -1;
    80000c4e:	557d                	li	a0,-1
}
    80000c50:	60a6                	ld	ra,72(sp)
    80000c52:	6406                	ld	s0,64(sp)
    80000c54:	74e2                	ld	s1,56(sp)
    80000c56:	7942                	ld	s2,48(sp)
    80000c58:	79a2                	ld	s3,40(sp)
    80000c5a:	7a02                	ld	s4,32(sp)
    80000c5c:	6ae2                	ld	s5,24(sp)
    80000c5e:	6b42                	ld	s6,16(sp)
    80000c60:	6ba2                	ld	s7,8(sp)
    80000c62:	6c02                	ld	s8,0(sp)
    80000c64:	6161                	addi	sp,sp,80
    80000c66:	8082                	ret

0000000080000c68 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80000c68:	715d                	addi	sp,sp,-80
    80000c6a:	e486                	sd	ra,72(sp)
    80000c6c:	e0a2                	sd	s0,64(sp)
    80000c6e:	fc26                	sd	s1,56(sp)
    80000c70:	f84a                	sd	s2,48(sp)
    80000c72:	f44e                	sd	s3,40(sp)
    80000c74:	f052                	sd	s4,32(sp)
    80000c76:	ec56                	sd	s5,24(sp)
    80000c78:	e85a                	sd	s6,16(sp)
    80000c7a:	e45e                	sd	s7,8(sp)
    80000c7c:	0880                	addi	s0,sp,80
    80000c7e:	8aaa                	mv	s5,a0
    80000c80:	89ae                	mv	s3,a1
    80000c82:	8bb2                	mv	s7,a2
    80000c84:	84b6                	mv	s1,a3
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    va0 = PGROUNDDOWN(srcva);
    80000c86:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c88:	6a05                	lui	s4,0x1
    80000c8a:	a02d                	j	80000cb4 <copyinstr+0x4c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c8c:	00078023          	sb	zero,0(a5)
    80000c90:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c92:	0017c793          	xori	a5,a5,1
    80000c96:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c9a:	60a6                	ld	ra,72(sp)
    80000c9c:	6406                	ld	s0,64(sp)
    80000c9e:	74e2                	ld	s1,56(sp)
    80000ca0:	7942                	ld	s2,48(sp)
    80000ca2:	79a2                	ld	s3,40(sp)
    80000ca4:	7a02                	ld	s4,32(sp)
    80000ca6:	6ae2                	ld	s5,24(sp)
    80000ca8:	6b42                	ld	s6,16(sp)
    80000caa:	6ba2                	ld	s7,8(sp)
    80000cac:	6161                	addi	sp,sp,80
    80000cae:	8082                	ret
    srcva = va0 + PGSIZE;
    80000cb0:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    80000cb4:	c8a1                	beqz	s1,80000d04 <copyinstr+0x9c>
    va0 = PGROUNDDOWN(srcva);
    80000cb6:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80000cba:	85ca                	mv	a1,s2
    80000cbc:	8556                	mv	a0,s5
    80000cbe:	00000097          	auipc	ra,0x0
    80000cc2:	85a080e7          	jalr	-1958(ra) # 80000518 <walkaddr>
    if(pa0 == 0)
    80000cc6:	c129                	beqz	a0,80000d08 <copyinstr+0xa0>
    n = PGSIZE - (srcva - va0);
    80000cc8:	41790633          	sub	a2,s2,s7
    80000ccc:	9652                	add	a2,a2,s4
    if(n > max)
    80000cce:	00c4f363          	bgeu	s1,a2,80000cd4 <copyinstr+0x6c>
    80000cd2:	8626                	mv	a2,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000cd4:	412b8bb3          	sub	s7,s7,s2
    80000cd8:	9baa                	add	s7,s7,a0
    while(n > 0){
    80000cda:	da79                	beqz	a2,80000cb0 <copyinstr+0x48>
    80000cdc:	87ce                	mv	a5,s3
      if(*p == '\0'){
    80000cde:	413b86b3          	sub	a3,s7,s3
    while(n > 0){
    80000ce2:	964e                	add	a2,a2,s3
    80000ce4:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000ce6:	00f68733          	add	a4,a3,a5
    80000cea:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd8dc0>
    80000cee:	df59                	beqz	a4,80000c8c <copyinstr+0x24>
        *dst = *p;
    80000cf0:	00e78023          	sb	a4,0(a5)
      dst++;
    80000cf4:	0785                	addi	a5,a5,1
    while(n > 0){
    80000cf6:	fec797e3          	bne	a5,a2,80000ce4 <copyinstr+0x7c>
    80000cfa:	14fd                	addi	s1,s1,-1
    80000cfc:	94ce                	add	s1,s1,s3
      --max;
    80000cfe:	8c8d                	sub	s1,s1,a1
    80000d00:	89be                	mv	s3,a5
    80000d02:	b77d                	j	80000cb0 <copyinstr+0x48>
    80000d04:	4781                	li	a5,0
    80000d06:	b771                	j	80000c92 <copyinstr+0x2a>
      return -1;
    80000d08:	557d                	li	a0,-1
    80000d0a:	bf41                	j	80000c9a <copyinstr+0x32>

0000000080000d0c <helpvmprint>:

void
helpvmprint(pagetable_t pagetable, int depth)
{
    80000d0c:	715d                	addi	sp,sp,-80
    80000d0e:	e486                	sd	ra,72(sp)
    80000d10:	e0a2                	sd	s0,64(sp)
    80000d12:	fc26                	sd	s1,56(sp)
    80000d14:	f84a                	sd	s2,48(sp)
    80000d16:	f44e                	sd	s3,40(sp)
    80000d18:	f052                	sd	s4,32(sp)
    80000d1a:	ec56                	sd	s5,24(sp)
    80000d1c:	e85a                	sd	s6,16(sp)
    80000d1e:	e45e                	sd	s7,8(sp)
    80000d20:	e062                	sd	s8,0(sp)
    80000d22:	0880                	addi	s0,sp,80
    80000d24:	8aae                	mv	s5,a1
  for(int i = 0; i < 512; i++ )
    80000d26:	89aa                	mv	s3,a0
    80000d28:	4901                	li	s2,0
    if(pte & PTE_V)
    {
      for (int k = 0; k < depth; k++ )
        printf(" ..");
      if(pte & (PTE_X|PTE_R|PTE_W))
        printf("%d: pte %p pa %p \n", i, pte, PTE2PA(pte));
    80000d2a:	00007c17          	auipc	s8,0x7
    80000d2e:	436c0c13          	addi	s8,s8,1078 # 80008160 <etext+0x160>
        printf(" ..");
    80000d32:	00007b17          	auipc	s6,0x7
    80000d36:	426b0b13          	addi	s6,s6,1062 # 80008158 <etext+0x158>
  for(int i = 0; i < 512; i++ )
    80000d3a:	20000b93          	li	s7,512
    80000d3e:	a815                	j	80000d72 <helpvmprint+0x66>
      else{
        printf("%d: pte %p pa %p\n", i, pte, PTE2PA(pte));
    80000d40:	00aa5493          	srli	s1,s4,0xa
    80000d44:	04b2                	slli	s1,s1,0xc
    80000d46:	86a6                	mv	a3,s1
    80000d48:	8652                	mv	a2,s4
    80000d4a:	85ca                	mv	a1,s2
    80000d4c:	00007517          	auipc	a0,0x7
    80000d50:	42c50513          	addi	a0,a0,1068 # 80008178 <etext+0x178>
    80000d54:	00005097          	auipc	ra,0x5
    80000d58:	1e8080e7          	jalr	488(ra) # 80005f3c <printf>
        helpvmprint((pagetable_t)PTE2PA(pte), depth + 1);
    80000d5c:	001a859b          	addiw	a1,s5,1 # 1001 <_entry-0x7fffefff>
    80000d60:	8526                	mv	a0,s1
    80000d62:	00000097          	auipc	ra,0x0
    80000d66:	faa080e7          	jalr	-86(ra) # 80000d0c <helpvmprint>
  for(int i = 0; i < 512; i++ )
    80000d6a:	2905                	addiw	s2,s2,1 # 1001 <_entry-0x7fffefff>
    80000d6c:	09a1                	addi	s3,s3,8 # 1008 <_entry-0x7fffeff8>
    80000d6e:	05790063          	beq	s2,s7,80000dae <helpvmprint+0xa2>
    pte_t pte = pagetable[i];
    80000d72:	0009ba03          	ld	s4,0(s3)
    if(pte & PTE_V)
    80000d76:	001a7793          	andi	a5,s4,1
    80000d7a:	dbe5                	beqz	a5,80000d6a <helpvmprint+0x5e>
      for (int k = 0; k < depth; k++ )
    80000d7c:	01505b63          	blez	s5,80000d92 <helpvmprint+0x86>
    80000d80:	4481                	li	s1,0
        printf(" ..");
    80000d82:	855a                	mv	a0,s6
    80000d84:	00005097          	auipc	ra,0x5
    80000d88:	1b8080e7          	jalr	440(ra) # 80005f3c <printf>
      for (int k = 0; k < depth; k++ )
    80000d8c:	2485                	addiw	s1,s1,1
    80000d8e:	fe9a9ae3          	bne	s5,s1,80000d82 <helpvmprint+0x76>
      if(pte & (PTE_X|PTE_R|PTE_W))
    80000d92:	00ea7793          	andi	a5,s4,14
    80000d96:	d7cd                	beqz	a5,80000d40 <helpvmprint+0x34>
        printf("%d: pte %p pa %p \n", i, pte, PTE2PA(pte));
    80000d98:	00aa5693          	srli	a3,s4,0xa
    80000d9c:	06b2                	slli	a3,a3,0xc
    80000d9e:	8652                	mv	a2,s4
    80000da0:	85ca                	mv	a1,s2
    80000da2:	8562                	mv	a0,s8
    80000da4:	00005097          	auipc	ra,0x5
    80000da8:	198080e7          	jalr	408(ra) # 80005f3c <printf>
    80000dac:	bf7d                	j	80000d6a <helpvmprint+0x5e>
      }
    }
  }
}
    80000dae:	60a6                	ld	ra,72(sp)
    80000db0:	6406                	ld	s0,64(sp)
    80000db2:	74e2                	ld	s1,56(sp)
    80000db4:	7942                	ld	s2,48(sp)
    80000db6:	79a2                	ld	s3,40(sp)
    80000db8:	7a02                	ld	s4,32(sp)
    80000dba:	6ae2                	ld	s5,24(sp)
    80000dbc:	6b42                	ld	s6,16(sp)
    80000dbe:	6ba2                	ld	s7,8(sp)
    80000dc0:	6c02                	ld	s8,0(sp)
    80000dc2:	6161                	addi	sp,sp,80
    80000dc4:	8082                	ret

0000000080000dc6 <vmprint>:

void
vmprint(pagetable_t pagetable)
{
    80000dc6:	1101                	addi	sp,sp,-32
    80000dc8:	ec06                	sd	ra,24(sp)
    80000dca:	e822                	sd	s0,16(sp)
    80000dcc:	e426                	sd	s1,8(sp)
    80000dce:	1000                	addi	s0,sp,32
    80000dd0:	84aa                	mv	s1,a0
  printf("page table %p\n", (uint64)pagetable);
    80000dd2:	85aa                	mv	a1,a0
    80000dd4:	00007517          	auipc	a0,0x7
    80000dd8:	3bc50513          	addi	a0,a0,956 # 80008190 <etext+0x190>
    80000ddc:	00005097          	auipc	ra,0x5
    80000de0:	160080e7          	jalr	352(ra) # 80005f3c <printf>
  helpvmprint(pagetable, 1);
    80000de4:	4585                	li	a1,1
    80000de6:	8526                	mv	a0,s1
    80000de8:	00000097          	auipc	ra,0x0
    80000dec:	f24080e7          	jalr	-220(ra) # 80000d0c <helpvmprint>
}
    80000df0:	60e2                	ld	ra,24(sp)
    80000df2:	6442                	ld	s0,16(sp)
    80000df4:	64a2                	ld	s1,8(sp)
    80000df6:	6105                	addi	sp,sp,32
    80000df8:	8082                	ret

0000000080000dfa <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000dfa:	715d                	addi	sp,sp,-80
    80000dfc:	e486                	sd	ra,72(sp)
    80000dfe:	e0a2                	sd	s0,64(sp)
    80000e00:	fc26                	sd	s1,56(sp)
    80000e02:	f84a                	sd	s2,48(sp)
    80000e04:	f44e                	sd	s3,40(sp)
    80000e06:	f052                	sd	s4,32(sp)
    80000e08:	ec56                	sd	s5,24(sp)
    80000e0a:	e85a                	sd	s6,16(sp)
    80000e0c:	e45e                	sd	s7,8(sp)
    80000e0e:	e062                	sd	s8,0(sp)
    80000e10:	0880                	addi	s0,sp,80
    80000e12:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e14:	00008497          	auipc	s1,0x8
    80000e18:	66c48493          	addi	s1,s1,1644 # 80009480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000e1c:	8c26                	mv	s8,s1
    80000e1e:	e9bd37b7          	lui	a5,0xe9bd3
    80000e22:	7a778793          	addi	a5,a5,1959 # ffffffffe9bd37a7 <end+0xffffffff69bad567>
    80000e26:	d37a7937          	lui	s2,0xd37a7
    80000e2a:	f4e90913          	addi	s2,s2,-178 # ffffffffd37a6f4e <end+0xffffffff53780d0e>
    80000e2e:	1902                	slli	s2,s2,0x20
    80000e30:	993e                	add	s2,s2,a5
    80000e32:	010009b7          	lui	s3,0x1000
    80000e36:	19fd                	addi	s3,s3,-1 # ffffff <_entry-0x7f000001>
    80000e38:	09ba                	slli	s3,s3,0xe
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000e3a:	4b99                	li	s7,6
    80000e3c:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e3e:	0000ea97          	auipc	s5,0xe
    80000e42:	242a8a93          	addi	s5,s5,578 # 8000f080 <tickslock>
    char *pa = kalloc();
    80000e46:	fffff097          	auipc	ra,0xfffff
    80000e4a:	2d4080e7          	jalr	724(ra) # 8000011a <kalloc>
    80000e4e:	862a                	mv	a2,a0
    if(pa == 0)
    80000e50:	c129                	beqz	a0,80000e92 <proc_mapstacks+0x98>
    uint64 va = KSTACK((int) (p - proc));
    80000e52:	418485b3          	sub	a1,s1,s8
    80000e56:	8591                	srai	a1,a1,0x4
    80000e58:	032585b3          	mul	a1,a1,s2
    80000e5c:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000e60:	875e                	mv	a4,s7
    80000e62:	86da                	mv	a3,s6
    80000e64:	40b985b3          	sub	a1,s3,a1
    80000e68:	8552                	mv	a0,s4
    80000e6a:	fffff097          	auipc	ra,0xfffff
    80000e6e:	796080e7          	jalr	1942(ra) # 80000600 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e72:	17048493          	addi	s1,s1,368
    80000e76:	fd5498e3          	bne	s1,s5,80000e46 <proc_mapstacks+0x4c>
  }
}
    80000e7a:	60a6                	ld	ra,72(sp)
    80000e7c:	6406                	ld	s0,64(sp)
    80000e7e:	74e2                	ld	s1,56(sp)
    80000e80:	7942                	ld	s2,48(sp)
    80000e82:	79a2                	ld	s3,40(sp)
    80000e84:	7a02                	ld	s4,32(sp)
    80000e86:	6ae2                	ld	s5,24(sp)
    80000e88:	6b42                	ld	s6,16(sp)
    80000e8a:	6ba2                	ld	s7,8(sp)
    80000e8c:	6c02                	ld	s8,0(sp)
    80000e8e:	6161                	addi	sp,sp,80
    80000e90:	8082                	ret
      panic("kalloc");
    80000e92:	00007517          	auipc	a0,0x7
    80000e96:	30e50513          	addi	a0,a0,782 # 800081a0 <etext+0x1a0>
    80000e9a:	00005097          	auipc	ra,0x5
    80000e9e:	058080e7          	jalr	88(ra) # 80005ef2 <panic>

0000000080000ea2 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000ea2:	7139                	addi	sp,sp,-64
    80000ea4:	fc06                	sd	ra,56(sp)
    80000ea6:	f822                	sd	s0,48(sp)
    80000ea8:	f426                	sd	s1,40(sp)
    80000eaa:	f04a                	sd	s2,32(sp)
    80000eac:	ec4e                	sd	s3,24(sp)
    80000eae:	e852                	sd	s4,16(sp)
    80000eb0:	e456                	sd	s5,8(sp)
    80000eb2:	e05a                	sd	s6,0(sp)
    80000eb4:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000eb6:	00007597          	auipc	a1,0x7
    80000eba:	2f258593          	addi	a1,a1,754 # 800081a8 <etext+0x1a8>
    80000ebe:	00008517          	auipc	a0,0x8
    80000ec2:	19250513          	addi	a0,a0,402 # 80009050 <pid_lock>
    80000ec6:	00005097          	auipc	ra,0x5
    80000eca:	518080e7          	jalr	1304(ra) # 800063de <initlock>
  initlock(&wait_lock, "wait_lock");
    80000ece:	00007597          	auipc	a1,0x7
    80000ed2:	2e258593          	addi	a1,a1,738 # 800081b0 <etext+0x1b0>
    80000ed6:	00008517          	auipc	a0,0x8
    80000eda:	19250513          	addi	a0,a0,402 # 80009068 <wait_lock>
    80000ede:	00005097          	auipc	ra,0x5
    80000ee2:	500080e7          	jalr	1280(ra) # 800063de <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ee6:	00008497          	auipc	s1,0x8
    80000eea:	59a48493          	addi	s1,s1,1434 # 80009480 <proc>
      initlock(&p->lock, "proc");
    80000eee:	00007a97          	auipc	s5,0x7
    80000ef2:	2d2a8a93          	addi	s5,s5,722 # 800081c0 <etext+0x1c0>
      p->kstack = KSTACK((int) (p - proc));
    80000ef6:	8a26                	mv	s4,s1
    80000ef8:	e9bd37b7          	lui	a5,0xe9bd3
    80000efc:	7a778793          	addi	a5,a5,1959 # ffffffffe9bd37a7 <end+0xffffffff69bad567>
    80000f00:	d37a7937          	lui	s2,0xd37a7
    80000f04:	f4e90913          	addi	s2,s2,-178 # ffffffffd37a6f4e <end+0xffffffff53780d0e>
    80000f08:	1902                	slli	s2,s2,0x20
    80000f0a:	993e                	add	s2,s2,a5
    80000f0c:	010009b7          	lui	s3,0x1000
    80000f10:	19fd                	addi	s3,s3,-1 # ffffff <_entry-0x7f000001>
    80000f12:	09ba                	slli	s3,s3,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f14:	0000eb17          	auipc	s6,0xe
    80000f18:	16cb0b13          	addi	s6,s6,364 # 8000f080 <tickslock>
      initlock(&p->lock, "proc");
    80000f1c:	85d6                	mv	a1,s5
    80000f1e:	8526                	mv	a0,s1
    80000f20:	00005097          	auipc	ra,0x5
    80000f24:	4be080e7          	jalr	1214(ra) # 800063de <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000f28:	414487b3          	sub	a5,s1,s4
    80000f2c:	8791                	srai	a5,a5,0x4
    80000f2e:	032787b3          	mul	a5,a5,s2
    80000f32:	00d7979b          	slliw	a5,a5,0xd
    80000f36:	40f987b3          	sub	a5,s3,a5
    80000f3a:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f3c:	17048493          	addi	s1,s1,368
    80000f40:	fd649ee3          	bne	s1,s6,80000f1c <procinit+0x7a>
  }
}
    80000f44:	70e2                	ld	ra,56(sp)
    80000f46:	7442                	ld	s0,48(sp)
    80000f48:	74a2                	ld	s1,40(sp)
    80000f4a:	7902                	ld	s2,32(sp)
    80000f4c:	69e2                	ld	s3,24(sp)
    80000f4e:	6a42                	ld	s4,16(sp)
    80000f50:	6aa2                	ld	s5,8(sp)
    80000f52:	6b02                	ld	s6,0(sp)
    80000f54:	6121                	addi	sp,sp,64
    80000f56:	8082                	ret

0000000080000f58 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000f58:	1141                	addi	sp,sp,-16
    80000f5a:	e406                	sd	ra,8(sp)
    80000f5c:	e022                	sd	s0,0(sp)
    80000f5e:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000f60:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000f62:	2501                	sext.w	a0,a0
    80000f64:	60a2                	ld	ra,8(sp)
    80000f66:	6402                	ld	s0,0(sp)
    80000f68:	0141                	addi	sp,sp,16
    80000f6a:	8082                	ret

0000000080000f6c <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80000f6c:	1141                	addi	sp,sp,-16
    80000f6e:	e406                	sd	ra,8(sp)
    80000f70:	e022                	sd	s0,0(sp)
    80000f72:	0800                	addi	s0,sp,16
    80000f74:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000f76:	2781                	sext.w	a5,a5
    80000f78:	079e                	slli	a5,a5,0x7
  return c;
}
    80000f7a:	00008517          	auipc	a0,0x8
    80000f7e:	10650513          	addi	a0,a0,262 # 80009080 <cpus>
    80000f82:	953e                	add	a0,a0,a5
    80000f84:	60a2                	ld	ra,8(sp)
    80000f86:	6402                	ld	s0,0(sp)
    80000f88:	0141                	addi	sp,sp,16
    80000f8a:	8082                	ret

0000000080000f8c <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80000f8c:	1101                	addi	sp,sp,-32
    80000f8e:	ec06                	sd	ra,24(sp)
    80000f90:	e822                	sd	s0,16(sp)
    80000f92:	e426                	sd	s1,8(sp)
    80000f94:	1000                	addi	s0,sp,32
  push_off();
    80000f96:	00005097          	auipc	ra,0x5
    80000f9a:	490080e7          	jalr	1168(ra) # 80006426 <push_off>
    80000f9e:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000fa0:	2781                	sext.w	a5,a5
    80000fa2:	079e                	slli	a5,a5,0x7
    80000fa4:	00008717          	auipc	a4,0x8
    80000fa8:	0ac70713          	addi	a4,a4,172 # 80009050 <pid_lock>
    80000fac:	97ba                	add	a5,a5,a4
    80000fae:	7b84                	ld	s1,48(a5)
  pop_off();
    80000fb0:	00005097          	auipc	ra,0x5
    80000fb4:	516080e7          	jalr	1302(ra) # 800064c6 <pop_off>
  return p;
}
    80000fb8:	8526                	mv	a0,s1
    80000fba:	60e2                	ld	ra,24(sp)
    80000fbc:	6442                	ld	s0,16(sp)
    80000fbe:	64a2                	ld	s1,8(sp)
    80000fc0:	6105                	addi	sp,sp,32
    80000fc2:	8082                	ret

0000000080000fc4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000fc4:	1141                	addi	sp,sp,-16
    80000fc6:	e406                	sd	ra,8(sp)
    80000fc8:	e022                	sd	s0,0(sp)
    80000fca:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000fcc:	00000097          	auipc	ra,0x0
    80000fd0:	fc0080e7          	jalr	-64(ra) # 80000f8c <myproc>
    80000fd4:	00005097          	auipc	ra,0x5
    80000fd8:	54e080e7          	jalr	1358(ra) # 80006522 <release>

  if (first) {
    80000fdc:	00008797          	auipc	a5,0x8
    80000fe0:	8c47a783          	lw	a5,-1852(a5) # 800088a0 <first.1>
    80000fe4:	eb89                	bnez	a5,80000ff6 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000fe6:	00001097          	auipc	ra,0x1
    80000fea:	cc8080e7          	jalr	-824(ra) # 80001cae <usertrapret>
}
    80000fee:	60a2                	ld	ra,8(sp)
    80000ff0:	6402                	ld	s0,0(sp)
    80000ff2:	0141                	addi	sp,sp,16
    80000ff4:	8082                	ret
    first = 0;
    80000ff6:	00008797          	auipc	a5,0x8
    80000ffa:	8a07a523          	sw	zero,-1878(a5) # 800088a0 <first.1>
    fsinit(ROOTDEV);
    80000ffe:	4505                	li	a0,1
    80001000:	00002097          	auipc	ra,0x2
    80001004:	aa2080e7          	jalr	-1374(ra) # 80002aa2 <fsinit>
    80001008:	bff9                	j	80000fe6 <forkret+0x22>

000000008000100a <allocpid>:
allocpid() {
    8000100a:	1101                	addi	sp,sp,-32
    8000100c:	ec06                	sd	ra,24(sp)
    8000100e:	e822                	sd	s0,16(sp)
    80001010:	e426                	sd	s1,8(sp)
    80001012:	e04a                	sd	s2,0(sp)
    80001014:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001016:	00008917          	auipc	s2,0x8
    8000101a:	03a90913          	addi	s2,s2,58 # 80009050 <pid_lock>
    8000101e:	854a                	mv	a0,s2
    80001020:	00005097          	auipc	ra,0x5
    80001024:	452080e7          	jalr	1106(ra) # 80006472 <acquire>
  pid = nextpid;
    80001028:	00008797          	auipc	a5,0x8
    8000102c:	87c78793          	addi	a5,a5,-1924 # 800088a4 <nextpid>
    80001030:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001032:	0014871b          	addiw	a4,s1,1
    80001036:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001038:	854a                	mv	a0,s2
    8000103a:	00005097          	auipc	ra,0x5
    8000103e:	4e8080e7          	jalr	1256(ra) # 80006522 <release>
}
    80001042:	8526                	mv	a0,s1
    80001044:	60e2                	ld	ra,24(sp)
    80001046:	6442                	ld	s0,16(sp)
    80001048:	64a2                	ld	s1,8(sp)
    8000104a:	6902                	ld	s2,0(sp)
    8000104c:	6105                	addi	sp,sp,32
    8000104e:	8082                	ret

0000000080001050 <proc_pagetable>:
{
    80001050:	1101                	addi	sp,sp,-32
    80001052:	ec06                	sd	ra,24(sp)
    80001054:	e822                	sd	s0,16(sp)
    80001056:	e426                	sd	s1,8(sp)
    80001058:	e04a                	sd	s2,0(sp)
    8000105a:	1000                	addi	s0,sp,32
    8000105c:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    8000105e:	fffff097          	auipc	ra,0xfffff
    80001062:	796080e7          	jalr	1942(ra) # 800007f4 <uvmcreate>
    80001066:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001068:	c525                	beqz	a0,800010d0 <proc_pagetable+0x80>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    8000106a:	4729                	li	a4,10
    8000106c:	00006697          	auipc	a3,0x6
    80001070:	f9468693          	addi	a3,a3,-108 # 80007000 <_trampoline>
    80001074:	6605                	lui	a2,0x1
    80001076:	040005b7          	lui	a1,0x4000
    8000107a:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000107c:	05b2                	slli	a1,a1,0xc
    8000107e:	fffff097          	auipc	ra,0xfffff
    80001082:	4dc080e7          	jalr	1244(ra) # 8000055a <mappages>
    80001086:	04054c63          	bltz	a0,800010de <proc_pagetable+0x8e>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    8000108a:	4719                	li	a4,6
    8000108c:	05893683          	ld	a3,88(s2)
    80001090:	6605                	lui	a2,0x1
    80001092:	020005b7          	lui	a1,0x2000
    80001096:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001098:	05b6                	slli	a1,a1,0xd
    8000109a:	8526                	mv	a0,s1
    8000109c:	fffff097          	auipc	ra,0xfffff
    800010a0:	4be080e7          	jalr	1214(ra) # 8000055a <mappages>
    800010a4:	04054563          	bltz	a0,800010ee <proc_pagetable+0x9e>
  if(mappages(pagetable, USYSCALL, PGSIZE,
    800010a8:	4749                	li	a4,18
    800010aa:	16893683          	ld	a3,360(s2)
    800010ae:	6605                	lui	a2,0x1
    800010b0:	040005b7          	lui	a1,0x4000
    800010b4:	15f5                	addi	a1,a1,-3 # 3fffffd <_entry-0x7c000003>
    800010b6:	05b2                	slli	a1,a1,0xc
    800010b8:	8526                	mv	a0,s1
    800010ba:	fffff097          	auipc	ra,0xfffff
    800010be:	4a0080e7          	jalr	1184(ra) # 8000055a <mappages>
    800010c2:	04054963          	bltz	a0,80001114 <proc_pagetable+0xc4>
  p->usyscall->pid = p->pid;
    800010c6:	16893783          	ld	a5,360(s2)
    800010ca:	03092703          	lw	a4,48(s2)
    800010ce:	c398                	sw	a4,0(a5)
}
    800010d0:	8526                	mv	a0,s1
    800010d2:	60e2                	ld	ra,24(sp)
    800010d4:	6442                	ld	s0,16(sp)
    800010d6:	64a2                	ld	s1,8(sp)
    800010d8:	6902                	ld	s2,0(sp)
    800010da:	6105                	addi	sp,sp,32
    800010dc:	8082                	ret
    uvmfree(pagetable, 0);
    800010de:	4581                	li	a1,0
    800010e0:	8526                	mv	a0,s1
    800010e2:	00000097          	auipc	ra,0x0
    800010e6:	92a080e7          	jalr	-1750(ra) # 80000a0c <uvmfree>
    return 0;
    800010ea:	4481                	li	s1,0
    800010ec:	b7d5                	j	800010d0 <proc_pagetable+0x80>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    800010ee:	4681                	li	a3,0
    800010f0:	4605                	li	a2,1
    800010f2:	040005b7          	lui	a1,0x4000
    800010f6:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800010f8:	05b2                	slli	a1,a1,0xc
    800010fa:	8526                	mv	a0,s1
    800010fc:	fffff097          	auipc	ra,0xfffff
    80001100:	624080e7          	jalr	1572(ra) # 80000720 <uvmunmap>
    uvmfree(pagetable, 0);
    80001104:	4581                	li	a1,0
    80001106:	8526                	mv	a0,s1
    80001108:	00000097          	auipc	ra,0x0
    8000110c:	904080e7          	jalr	-1788(ra) # 80000a0c <uvmfree>
    return 0;
    80001110:	4481                	li	s1,0
    80001112:	bf7d                	j	800010d0 <proc_pagetable+0x80>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001114:	4681                	li	a3,0
    80001116:	4605                	li	a2,1
    80001118:	040005b7          	lui	a1,0x4000
    8000111c:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000111e:	05b2                	slli	a1,a1,0xc
    80001120:	8526                	mv	a0,s1
    80001122:	fffff097          	auipc	ra,0xfffff
    80001126:	5fe080e7          	jalr	1534(ra) # 80000720 <uvmunmap>
    uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000112a:	4681                	li	a3,0
    8000112c:	4605                	li	a2,1
    8000112e:	020005b7          	lui	a1,0x2000
    80001132:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001134:	05b6                	slli	a1,a1,0xd
    80001136:	8526                	mv	a0,s1
    80001138:	fffff097          	auipc	ra,0xfffff
    8000113c:	5e8080e7          	jalr	1512(ra) # 80000720 <uvmunmap>
    uvmfree(pagetable, 0);
    80001140:	4581                	li	a1,0
    80001142:	8526                	mv	a0,s1
    80001144:	00000097          	auipc	ra,0x0
    80001148:	8c8080e7          	jalr	-1848(ra) # 80000a0c <uvmfree>
    return 0;
    8000114c:	4481                	li	s1,0
    8000114e:	b749                	j	800010d0 <proc_pagetable+0x80>

0000000080001150 <proc_freepagetable>:
{
    80001150:	1101                	addi	sp,sp,-32
    80001152:	ec06                	sd	ra,24(sp)
    80001154:	e822                	sd	s0,16(sp)
    80001156:	e426                	sd	s1,8(sp)
    80001158:	e04a                	sd	s2,0(sp)
    8000115a:	1000                	addi	s0,sp,32
    8000115c:	84aa                	mv	s1,a0
    8000115e:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001160:	4681                	li	a3,0
    80001162:	4605                	li	a2,1
    80001164:	040005b7          	lui	a1,0x4000
    80001168:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000116a:	05b2                	slli	a1,a1,0xc
    8000116c:	fffff097          	auipc	ra,0xfffff
    80001170:	5b4080e7          	jalr	1460(ra) # 80000720 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001174:	4681                	li	a3,0
    80001176:	4605                	li	a2,1
    80001178:	020005b7          	lui	a1,0x2000
    8000117c:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    8000117e:	05b6                	slli	a1,a1,0xd
    80001180:	8526                	mv	a0,s1
    80001182:	fffff097          	auipc	ra,0xfffff
    80001186:	59e080e7          	jalr	1438(ra) # 80000720 <uvmunmap>
  uvmunmap(pagetable, USYSCALL, 1, 0);
    8000118a:	4681                	li	a3,0
    8000118c:	4605                	li	a2,1
    8000118e:	040005b7          	lui	a1,0x4000
    80001192:	15f5                	addi	a1,a1,-3 # 3fffffd <_entry-0x7c000003>
    80001194:	05b2                	slli	a1,a1,0xc
    80001196:	8526                	mv	a0,s1
    80001198:	fffff097          	auipc	ra,0xfffff
    8000119c:	588080e7          	jalr	1416(ra) # 80000720 <uvmunmap>
  uvmfree(pagetable, sz);
    800011a0:	85ca                	mv	a1,s2
    800011a2:	8526                	mv	a0,s1
    800011a4:	00000097          	auipc	ra,0x0
    800011a8:	868080e7          	jalr	-1944(ra) # 80000a0c <uvmfree>
}
    800011ac:	60e2                	ld	ra,24(sp)
    800011ae:	6442                	ld	s0,16(sp)
    800011b0:	64a2                	ld	s1,8(sp)
    800011b2:	6902                	ld	s2,0(sp)
    800011b4:	6105                	addi	sp,sp,32
    800011b6:	8082                	ret

00000000800011b8 <freeproc>:
{
    800011b8:	1101                	addi	sp,sp,-32
    800011ba:	ec06                	sd	ra,24(sp)
    800011bc:	e822                	sd	s0,16(sp)
    800011be:	e426                	sd	s1,8(sp)
    800011c0:	1000                	addi	s0,sp,32
    800011c2:	84aa                	mv	s1,a0
  if(p->trapframe)
    800011c4:	6d28                	ld	a0,88(a0)
    800011c6:	c509                	beqz	a0,800011d0 <freeproc+0x18>
    kfree((void*)p->trapframe);
    800011c8:	fffff097          	auipc	ra,0xfffff
    800011cc:	e54080e7          	jalr	-428(ra) # 8000001c <kfree>
  p->trapframe = 0;
    800011d0:	0404bc23          	sd	zero,88(s1)
  if(p->usyscall)
    800011d4:	1684b503          	ld	a0,360(s1)
    800011d8:	c509                	beqz	a0,800011e2 <freeproc+0x2a>
    kfree((void*)p->usyscall);
    800011da:	fffff097          	auipc	ra,0xfffff
    800011de:	e42080e7          	jalr	-446(ra) # 8000001c <kfree>
  p->usyscall = 0;
    800011e2:	1604b423          	sd	zero,360(s1)
  if(p->pagetable)
    800011e6:	68a8                	ld	a0,80(s1)
    800011e8:	c511                	beqz	a0,800011f4 <freeproc+0x3c>
    proc_freepagetable(p->pagetable, p->sz);
    800011ea:	64ac                	ld	a1,72(s1)
    800011ec:	00000097          	auipc	ra,0x0
    800011f0:	f64080e7          	jalr	-156(ra) # 80001150 <proc_freepagetable>
  p->pagetable = 0;
    800011f4:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    800011f8:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    800011fc:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001200:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001204:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001208:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    8000120c:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001210:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001214:	0004ac23          	sw	zero,24(s1)
}
    80001218:	60e2                	ld	ra,24(sp)
    8000121a:	6442                	ld	s0,16(sp)
    8000121c:	64a2                	ld	s1,8(sp)
    8000121e:	6105                	addi	sp,sp,32
    80001220:	8082                	ret

0000000080001222 <allocproc>:
{
    80001222:	1101                	addi	sp,sp,-32
    80001224:	ec06                	sd	ra,24(sp)
    80001226:	e822                	sd	s0,16(sp)
    80001228:	e426                	sd	s1,8(sp)
    8000122a:	e04a                	sd	s2,0(sp)
    8000122c:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000122e:	00008497          	auipc	s1,0x8
    80001232:	25248493          	addi	s1,s1,594 # 80009480 <proc>
    80001236:	0000e917          	auipc	s2,0xe
    8000123a:	e4a90913          	addi	s2,s2,-438 # 8000f080 <tickslock>
    acquire(&p->lock);
    8000123e:	8526                	mv	a0,s1
    80001240:	00005097          	auipc	ra,0x5
    80001244:	232080e7          	jalr	562(ra) # 80006472 <acquire>
    if(p->state == UNUSED) {
    80001248:	4c9c                	lw	a5,24(s1)
    8000124a:	cf81                	beqz	a5,80001262 <allocproc+0x40>
      release(&p->lock);
    8000124c:	8526                	mv	a0,s1
    8000124e:	00005097          	auipc	ra,0x5
    80001252:	2d4080e7          	jalr	724(ra) # 80006522 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001256:	17048493          	addi	s1,s1,368
    8000125a:	ff2492e3          	bne	s1,s2,8000123e <allocproc+0x1c>
  return 0;
    8000125e:	4481                	li	s1,0
    80001260:	a08d                	j	800012c2 <allocproc+0xa0>
  p->pid = allocpid();
    80001262:	00000097          	auipc	ra,0x0
    80001266:	da8080e7          	jalr	-600(ra) # 8000100a <allocpid>
    8000126a:	d888                	sw	a0,48(s1)
  p->state = USED;
    8000126c:	4785                	li	a5,1
    8000126e:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001270:	fffff097          	auipc	ra,0xfffff
    80001274:	eaa080e7          	jalr	-342(ra) # 8000011a <kalloc>
    80001278:	892a                	mv	s2,a0
    8000127a:	eca8                	sd	a0,88(s1)
    8000127c:	c931                	beqz	a0,800012d0 <allocproc+0xae>
  if((p->usyscall = (struct usyscall *)kalloc()) == 0)
    8000127e:	fffff097          	auipc	ra,0xfffff
    80001282:	e9c080e7          	jalr	-356(ra) # 8000011a <kalloc>
    80001286:	892a                	mv	s2,a0
    80001288:	16a4b423          	sd	a0,360(s1)
    8000128c:	cd31                	beqz	a0,800012e8 <allocproc+0xc6>
  p->pagetable = proc_pagetable(p);
    8000128e:	8526                	mv	a0,s1
    80001290:	00000097          	auipc	ra,0x0
    80001294:	dc0080e7          	jalr	-576(ra) # 80001050 <proc_pagetable>
    80001298:	892a                	mv	s2,a0
    8000129a:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    8000129c:	c135                	beqz	a0,80001300 <allocproc+0xde>
  memset(&p->context, 0, sizeof(p->context));
    8000129e:	07000613          	li	a2,112
    800012a2:	4581                	li	a1,0
    800012a4:	06048513          	addi	a0,s1,96
    800012a8:	fffff097          	auipc	ra,0xfffff
    800012ac:	ed2080e7          	jalr	-302(ra) # 8000017a <memset>
  p->context.ra = (uint64)forkret;
    800012b0:	00000797          	auipc	a5,0x0
    800012b4:	d1478793          	addi	a5,a5,-748 # 80000fc4 <forkret>
    800012b8:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800012ba:	60bc                	ld	a5,64(s1)
    800012bc:	6705                	lui	a4,0x1
    800012be:	97ba                	add	a5,a5,a4
    800012c0:	f4bc                	sd	a5,104(s1)
}
    800012c2:	8526                	mv	a0,s1
    800012c4:	60e2                	ld	ra,24(sp)
    800012c6:	6442                	ld	s0,16(sp)
    800012c8:	64a2                	ld	s1,8(sp)
    800012ca:	6902                	ld	s2,0(sp)
    800012cc:	6105                	addi	sp,sp,32
    800012ce:	8082                	ret
    freeproc(p);
    800012d0:	8526                	mv	a0,s1
    800012d2:	00000097          	auipc	ra,0x0
    800012d6:	ee6080e7          	jalr	-282(ra) # 800011b8 <freeproc>
    release(&p->lock);
    800012da:	8526                	mv	a0,s1
    800012dc:	00005097          	auipc	ra,0x5
    800012e0:	246080e7          	jalr	582(ra) # 80006522 <release>
    return 0;
    800012e4:	84ca                	mv	s1,s2
    800012e6:	bff1                	j	800012c2 <allocproc+0xa0>
    freeproc(p);
    800012e8:	8526                	mv	a0,s1
    800012ea:	00000097          	auipc	ra,0x0
    800012ee:	ece080e7          	jalr	-306(ra) # 800011b8 <freeproc>
    release(&p->lock);
    800012f2:	8526                	mv	a0,s1
    800012f4:	00005097          	auipc	ra,0x5
    800012f8:	22e080e7          	jalr	558(ra) # 80006522 <release>
    return 0;
    800012fc:	84ca                	mv	s1,s2
    800012fe:	b7d1                	j	800012c2 <allocproc+0xa0>
    freeproc(p);
    80001300:	8526                	mv	a0,s1
    80001302:	00000097          	auipc	ra,0x0
    80001306:	eb6080e7          	jalr	-330(ra) # 800011b8 <freeproc>
    release(&p->lock);
    8000130a:	8526                	mv	a0,s1
    8000130c:	00005097          	auipc	ra,0x5
    80001310:	216080e7          	jalr	534(ra) # 80006522 <release>
    return 0;
    80001314:	84ca                	mv	s1,s2
    80001316:	b775                	j	800012c2 <allocproc+0xa0>

0000000080001318 <userinit>:
{
    80001318:	1101                	addi	sp,sp,-32
    8000131a:	ec06                	sd	ra,24(sp)
    8000131c:	e822                	sd	s0,16(sp)
    8000131e:	e426                	sd	s1,8(sp)
    80001320:	1000                	addi	s0,sp,32
  p = allocproc();
    80001322:	00000097          	auipc	ra,0x0
    80001326:	f00080e7          	jalr	-256(ra) # 80001222 <allocproc>
    8000132a:	84aa                	mv	s1,a0
  initproc = p;
    8000132c:	00008797          	auipc	a5,0x8
    80001330:	cea7b223          	sd	a0,-796(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001334:	03400613          	li	a2,52
    80001338:	00007597          	auipc	a1,0x7
    8000133c:	57858593          	addi	a1,a1,1400 # 800088b0 <initcode>
    80001340:	6928                	ld	a0,80(a0)
    80001342:	fffff097          	auipc	ra,0xfffff
    80001346:	4e0080e7          	jalr	1248(ra) # 80000822 <uvminit>
  p->sz = PGSIZE;
    8000134a:	6785                	lui	a5,0x1
    8000134c:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    8000134e:	6cb8                	ld	a4,88(s1)
    80001350:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001354:	6cb8                	ld	a4,88(s1)
    80001356:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001358:	4641                	li	a2,16
    8000135a:	00007597          	auipc	a1,0x7
    8000135e:	e6e58593          	addi	a1,a1,-402 # 800081c8 <etext+0x1c8>
    80001362:	15848513          	addi	a0,s1,344
    80001366:	fffff097          	auipc	ra,0xfffff
    8000136a:	f6a080e7          	jalr	-150(ra) # 800002d0 <safestrcpy>
  p->cwd = namei("/");
    8000136e:	00007517          	auipc	a0,0x7
    80001372:	e6a50513          	addi	a0,a0,-406 # 800081d8 <etext+0x1d8>
    80001376:	00002097          	auipc	ra,0x2
    8000137a:	18c080e7          	jalr	396(ra) # 80003502 <namei>
    8000137e:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001382:	478d                	li	a5,3
    80001384:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001386:	8526                	mv	a0,s1
    80001388:	00005097          	auipc	ra,0x5
    8000138c:	19a080e7          	jalr	410(ra) # 80006522 <release>
}
    80001390:	60e2                	ld	ra,24(sp)
    80001392:	6442                	ld	s0,16(sp)
    80001394:	64a2                	ld	s1,8(sp)
    80001396:	6105                	addi	sp,sp,32
    80001398:	8082                	ret

000000008000139a <growproc>:
{
    8000139a:	1101                	addi	sp,sp,-32
    8000139c:	ec06                	sd	ra,24(sp)
    8000139e:	e822                	sd	s0,16(sp)
    800013a0:	e426                	sd	s1,8(sp)
    800013a2:	e04a                	sd	s2,0(sp)
    800013a4:	1000                	addi	s0,sp,32
    800013a6:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800013a8:	00000097          	auipc	ra,0x0
    800013ac:	be4080e7          	jalr	-1052(ra) # 80000f8c <myproc>
    800013b0:	892a                	mv	s2,a0
  sz = p->sz;
    800013b2:	652c                	ld	a1,72(a0)
    800013b4:	0005879b          	sext.w	a5,a1
  if(n > 0){
    800013b8:	00904f63          	bgtz	s1,800013d6 <growproc+0x3c>
  } else if(n < 0){
    800013bc:	0204cd63          	bltz	s1,800013f6 <growproc+0x5c>
  p->sz = sz;
    800013c0:	1782                	slli	a5,a5,0x20
    800013c2:	9381                	srli	a5,a5,0x20
    800013c4:	04f93423          	sd	a5,72(s2)
  return 0;
    800013c8:	4501                	li	a0,0
}
    800013ca:	60e2                	ld	ra,24(sp)
    800013cc:	6442                	ld	s0,16(sp)
    800013ce:	64a2                	ld	s1,8(sp)
    800013d0:	6902                	ld	s2,0(sp)
    800013d2:	6105                	addi	sp,sp,32
    800013d4:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800013d6:	00f4863b          	addw	a2,s1,a5
    800013da:	1602                	slli	a2,a2,0x20
    800013dc:	9201                	srli	a2,a2,0x20
    800013de:	1582                	slli	a1,a1,0x20
    800013e0:	9181                	srli	a1,a1,0x20
    800013e2:	6928                	ld	a0,80(a0)
    800013e4:	fffff097          	auipc	ra,0xfffff
    800013e8:	4f8080e7          	jalr	1272(ra) # 800008dc <uvmalloc>
    800013ec:	0005079b          	sext.w	a5,a0
    800013f0:	fbe1                	bnez	a5,800013c0 <growproc+0x26>
      return -1;
    800013f2:	557d                	li	a0,-1
    800013f4:	bfd9                	j	800013ca <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800013f6:	00f4863b          	addw	a2,s1,a5
    800013fa:	1602                	slli	a2,a2,0x20
    800013fc:	9201                	srli	a2,a2,0x20
    800013fe:	1582                	slli	a1,a1,0x20
    80001400:	9181                	srli	a1,a1,0x20
    80001402:	6928                	ld	a0,80(a0)
    80001404:	fffff097          	auipc	ra,0xfffff
    80001408:	490080e7          	jalr	1168(ra) # 80000894 <uvmdealloc>
    8000140c:	0005079b          	sext.w	a5,a0
    80001410:	bf45                	j	800013c0 <growproc+0x26>

0000000080001412 <fork>:
{
    80001412:	7139                	addi	sp,sp,-64
    80001414:	fc06                	sd	ra,56(sp)
    80001416:	f822                	sd	s0,48(sp)
    80001418:	f04a                	sd	s2,32(sp)
    8000141a:	e456                	sd	s5,8(sp)
    8000141c:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    8000141e:	00000097          	auipc	ra,0x0
    80001422:	b6e080e7          	jalr	-1170(ra) # 80000f8c <myproc>
    80001426:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001428:	00000097          	auipc	ra,0x0
    8000142c:	dfa080e7          	jalr	-518(ra) # 80001222 <allocproc>
    80001430:	12050063          	beqz	a0,80001550 <fork+0x13e>
    80001434:	e852                	sd	s4,16(sp)
    80001436:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001438:	048ab603          	ld	a2,72(s5)
    8000143c:	692c                	ld	a1,80(a0)
    8000143e:	050ab503          	ld	a0,80(s5)
    80001442:	fffff097          	auipc	ra,0xfffff
    80001446:	604080e7          	jalr	1540(ra) # 80000a46 <uvmcopy>
    8000144a:	04054a63          	bltz	a0,8000149e <fork+0x8c>
    8000144e:	f426                	sd	s1,40(sp)
    80001450:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    80001452:	048ab783          	ld	a5,72(s5)
    80001456:	04fa3423          	sd	a5,72(s4) # 1048 <_entry-0x7fffefb8>
  *(np->trapframe) = *(p->trapframe);
    8000145a:	058ab683          	ld	a3,88(s5)
    8000145e:	87b6                	mv	a5,a3
    80001460:	058a3703          	ld	a4,88(s4)
    80001464:	12068693          	addi	a3,a3,288
    80001468:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    8000146c:	6788                	ld	a0,8(a5)
    8000146e:	6b8c                	ld	a1,16(a5)
    80001470:	6f90                	ld	a2,24(a5)
    80001472:	01073023          	sd	a6,0(a4)
    80001476:	e708                	sd	a0,8(a4)
    80001478:	eb0c                	sd	a1,16(a4)
    8000147a:	ef10                	sd	a2,24(a4)
    8000147c:	02078793          	addi	a5,a5,32
    80001480:	02070713          	addi	a4,a4,32
    80001484:	fed792e3          	bne	a5,a3,80001468 <fork+0x56>
  np->trapframe->a0 = 0;
    80001488:	058a3783          	ld	a5,88(s4)
    8000148c:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001490:	0d0a8493          	addi	s1,s5,208
    80001494:	0d0a0913          	addi	s2,s4,208
    80001498:	150a8993          	addi	s3,s5,336
    8000149c:	a015                	j	800014c0 <fork+0xae>
    freeproc(np);
    8000149e:	8552                	mv	a0,s4
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	d18080e7          	jalr	-744(ra) # 800011b8 <freeproc>
    release(&np->lock);
    800014a8:	8552                	mv	a0,s4
    800014aa:	00005097          	auipc	ra,0x5
    800014ae:	078080e7          	jalr	120(ra) # 80006522 <release>
    return -1;
    800014b2:	597d                	li	s2,-1
    800014b4:	6a42                	ld	s4,16(sp)
    800014b6:	a071                	j	80001542 <fork+0x130>
  for(i = 0; i < NOFILE; i++)
    800014b8:	04a1                	addi	s1,s1,8
    800014ba:	0921                	addi	s2,s2,8
    800014bc:	01348b63          	beq	s1,s3,800014d2 <fork+0xc0>
    if(p->ofile[i])
    800014c0:	6088                	ld	a0,0(s1)
    800014c2:	d97d                	beqz	a0,800014b8 <fork+0xa6>
      np->ofile[i] = filedup(p->ofile[i]);
    800014c4:	00002097          	auipc	ra,0x2
    800014c8:	6c2080e7          	jalr	1730(ra) # 80003b86 <filedup>
    800014cc:	00a93023          	sd	a0,0(s2)
    800014d0:	b7e5                	j	800014b8 <fork+0xa6>
  np->cwd = idup(p->cwd);
    800014d2:	150ab503          	ld	a0,336(s5)
    800014d6:	00002097          	auipc	ra,0x2
    800014da:	802080e7          	jalr	-2046(ra) # 80002cd8 <idup>
    800014de:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800014e2:	4641                	li	a2,16
    800014e4:	158a8593          	addi	a1,s5,344
    800014e8:	158a0513          	addi	a0,s4,344
    800014ec:	fffff097          	auipc	ra,0xfffff
    800014f0:	de4080e7          	jalr	-540(ra) # 800002d0 <safestrcpy>
  pid = np->pid;
    800014f4:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    800014f8:	8552                	mv	a0,s4
    800014fa:	00005097          	auipc	ra,0x5
    800014fe:	028080e7          	jalr	40(ra) # 80006522 <release>
  acquire(&wait_lock);
    80001502:	00008497          	auipc	s1,0x8
    80001506:	b6648493          	addi	s1,s1,-1178 # 80009068 <wait_lock>
    8000150a:	8526                	mv	a0,s1
    8000150c:	00005097          	auipc	ra,0x5
    80001510:	f66080e7          	jalr	-154(ra) # 80006472 <acquire>
  np->parent = p;
    80001514:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001518:	8526                	mv	a0,s1
    8000151a:	00005097          	auipc	ra,0x5
    8000151e:	008080e7          	jalr	8(ra) # 80006522 <release>
  acquire(&np->lock);
    80001522:	8552                	mv	a0,s4
    80001524:	00005097          	auipc	ra,0x5
    80001528:	f4e080e7          	jalr	-178(ra) # 80006472 <acquire>
  np->state = RUNNABLE;
    8000152c:	478d                	li	a5,3
    8000152e:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001532:	8552                	mv	a0,s4
    80001534:	00005097          	auipc	ra,0x5
    80001538:	fee080e7          	jalr	-18(ra) # 80006522 <release>
  return pid;
    8000153c:	74a2                	ld	s1,40(sp)
    8000153e:	69e2                	ld	s3,24(sp)
    80001540:	6a42                	ld	s4,16(sp)
}
    80001542:	854a                	mv	a0,s2
    80001544:	70e2                	ld	ra,56(sp)
    80001546:	7442                	ld	s0,48(sp)
    80001548:	7902                	ld	s2,32(sp)
    8000154a:	6aa2                	ld	s5,8(sp)
    8000154c:	6121                	addi	sp,sp,64
    8000154e:	8082                	ret
    return -1;
    80001550:	597d                	li	s2,-1
    80001552:	bfc5                	j	80001542 <fork+0x130>

0000000080001554 <scheduler>:
{
    80001554:	7139                	addi	sp,sp,-64
    80001556:	fc06                	sd	ra,56(sp)
    80001558:	f822                	sd	s0,48(sp)
    8000155a:	f426                	sd	s1,40(sp)
    8000155c:	f04a                	sd	s2,32(sp)
    8000155e:	ec4e                	sd	s3,24(sp)
    80001560:	e852                	sd	s4,16(sp)
    80001562:	e456                	sd	s5,8(sp)
    80001564:	e05a                	sd	s6,0(sp)
    80001566:	0080                	addi	s0,sp,64
    80001568:	8792                	mv	a5,tp
  int id = r_tp();
    8000156a:	2781                	sext.w	a5,a5
  c->proc = 0;
    8000156c:	00779a93          	slli	s5,a5,0x7
    80001570:	00008717          	auipc	a4,0x8
    80001574:	ae070713          	addi	a4,a4,-1312 # 80009050 <pid_lock>
    80001578:	9756                	add	a4,a4,s5
    8000157a:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    8000157e:	00008717          	auipc	a4,0x8
    80001582:	b0a70713          	addi	a4,a4,-1270 # 80009088 <cpus+0x8>
    80001586:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001588:	498d                	li	s3,3
        p->state = RUNNING;
    8000158a:	4b11                	li	s6,4
        c->proc = p;
    8000158c:	079e                	slli	a5,a5,0x7
    8000158e:	00008a17          	auipc	s4,0x8
    80001592:	ac2a0a13          	addi	s4,s4,-1342 # 80009050 <pid_lock>
    80001596:	9a3e                	add	s4,s4,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001598:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000159c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800015a0:	10079073          	csrw	sstatus,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    800015a4:	00008497          	auipc	s1,0x8
    800015a8:	edc48493          	addi	s1,s1,-292 # 80009480 <proc>
    800015ac:	0000e917          	auipc	s2,0xe
    800015b0:	ad490913          	addi	s2,s2,-1324 # 8000f080 <tickslock>
    800015b4:	a811                	j	800015c8 <scheduler+0x74>
      release(&p->lock);
    800015b6:	8526                	mv	a0,s1
    800015b8:	00005097          	auipc	ra,0x5
    800015bc:	f6a080e7          	jalr	-150(ra) # 80006522 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800015c0:	17048493          	addi	s1,s1,368
    800015c4:	fd248ae3          	beq	s1,s2,80001598 <scheduler+0x44>
      acquire(&p->lock);
    800015c8:	8526                	mv	a0,s1
    800015ca:	00005097          	auipc	ra,0x5
    800015ce:	ea8080e7          	jalr	-344(ra) # 80006472 <acquire>
      if(p->state == RUNNABLE) {
    800015d2:	4c9c                	lw	a5,24(s1)
    800015d4:	ff3791e3          	bne	a5,s3,800015b6 <scheduler+0x62>
        p->state = RUNNING;
    800015d8:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800015dc:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800015e0:	06048593          	addi	a1,s1,96
    800015e4:	8556                	mv	a0,s5
    800015e6:	00000097          	auipc	ra,0x0
    800015ea:	61a080e7          	jalr	1562(ra) # 80001c00 <swtch>
        c->proc = 0;
    800015ee:	020a3823          	sd	zero,48(s4)
    800015f2:	b7d1                	j	800015b6 <scheduler+0x62>

00000000800015f4 <sched>:
{
    800015f4:	7179                	addi	sp,sp,-48
    800015f6:	f406                	sd	ra,40(sp)
    800015f8:	f022                	sd	s0,32(sp)
    800015fa:	ec26                	sd	s1,24(sp)
    800015fc:	e84a                	sd	s2,16(sp)
    800015fe:	e44e                	sd	s3,8(sp)
    80001600:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001602:	00000097          	auipc	ra,0x0
    80001606:	98a080e7          	jalr	-1654(ra) # 80000f8c <myproc>
    8000160a:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000160c:	00005097          	auipc	ra,0x5
    80001610:	dec080e7          	jalr	-532(ra) # 800063f8 <holding>
    80001614:	c93d                	beqz	a0,8000168a <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001616:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80001618:	2781                	sext.w	a5,a5
    8000161a:	079e                	slli	a5,a5,0x7
    8000161c:	00008717          	auipc	a4,0x8
    80001620:	a3470713          	addi	a4,a4,-1484 # 80009050 <pid_lock>
    80001624:	97ba                	add	a5,a5,a4
    80001626:	0a87a703          	lw	a4,168(a5)
    8000162a:	4785                	li	a5,1
    8000162c:	06f71763          	bne	a4,a5,8000169a <sched+0xa6>
  if(p->state == RUNNING)
    80001630:	4c98                	lw	a4,24(s1)
    80001632:	4791                	li	a5,4
    80001634:	06f70b63          	beq	a4,a5,800016aa <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001638:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000163c:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000163e:	efb5                	bnez	a5,800016ba <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001640:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001642:	00008917          	auipc	s2,0x8
    80001646:	a0e90913          	addi	s2,s2,-1522 # 80009050 <pid_lock>
    8000164a:	2781                	sext.w	a5,a5
    8000164c:	079e                	slli	a5,a5,0x7
    8000164e:	97ca                	add	a5,a5,s2
    80001650:	0ac7a983          	lw	s3,172(a5)
    80001654:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001656:	2781                	sext.w	a5,a5
    80001658:	079e                	slli	a5,a5,0x7
    8000165a:	00008597          	auipc	a1,0x8
    8000165e:	a2e58593          	addi	a1,a1,-1490 # 80009088 <cpus+0x8>
    80001662:	95be                	add	a1,a1,a5
    80001664:	06048513          	addi	a0,s1,96
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	598080e7          	jalr	1432(ra) # 80001c00 <swtch>
    80001670:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001672:	2781                	sext.w	a5,a5
    80001674:	079e                	slli	a5,a5,0x7
    80001676:	993e                	add	s2,s2,a5
    80001678:	0b392623          	sw	s3,172(s2)
}
    8000167c:	70a2                	ld	ra,40(sp)
    8000167e:	7402                	ld	s0,32(sp)
    80001680:	64e2                	ld	s1,24(sp)
    80001682:	6942                	ld	s2,16(sp)
    80001684:	69a2                	ld	s3,8(sp)
    80001686:	6145                	addi	sp,sp,48
    80001688:	8082                	ret
    panic("sched p->lock");
    8000168a:	00007517          	auipc	a0,0x7
    8000168e:	b5650513          	addi	a0,a0,-1194 # 800081e0 <etext+0x1e0>
    80001692:	00005097          	auipc	ra,0x5
    80001696:	860080e7          	jalr	-1952(ra) # 80005ef2 <panic>
    panic("sched locks");
    8000169a:	00007517          	auipc	a0,0x7
    8000169e:	b5650513          	addi	a0,a0,-1194 # 800081f0 <etext+0x1f0>
    800016a2:	00005097          	auipc	ra,0x5
    800016a6:	850080e7          	jalr	-1968(ra) # 80005ef2 <panic>
    panic("sched running");
    800016aa:	00007517          	auipc	a0,0x7
    800016ae:	b5650513          	addi	a0,a0,-1194 # 80008200 <etext+0x200>
    800016b2:	00005097          	auipc	ra,0x5
    800016b6:	840080e7          	jalr	-1984(ra) # 80005ef2 <panic>
    panic("sched interruptible");
    800016ba:	00007517          	auipc	a0,0x7
    800016be:	b5650513          	addi	a0,a0,-1194 # 80008210 <etext+0x210>
    800016c2:	00005097          	auipc	ra,0x5
    800016c6:	830080e7          	jalr	-2000(ra) # 80005ef2 <panic>

00000000800016ca <yield>:
{
    800016ca:	1101                	addi	sp,sp,-32
    800016cc:	ec06                	sd	ra,24(sp)
    800016ce:	e822                	sd	s0,16(sp)
    800016d0:	e426                	sd	s1,8(sp)
    800016d2:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800016d4:	00000097          	auipc	ra,0x0
    800016d8:	8b8080e7          	jalr	-1864(ra) # 80000f8c <myproc>
    800016dc:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800016de:	00005097          	auipc	ra,0x5
    800016e2:	d94080e7          	jalr	-620(ra) # 80006472 <acquire>
  p->state = RUNNABLE;
    800016e6:	478d                	li	a5,3
    800016e8:	cc9c                	sw	a5,24(s1)
  sched();
    800016ea:	00000097          	auipc	ra,0x0
    800016ee:	f0a080e7          	jalr	-246(ra) # 800015f4 <sched>
  release(&p->lock);
    800016f2:	8526                	mv	a0,s1
    800016f4:	00005097          	auipc	ra,0x5
    800016f8:	e2e080e7          	jalr	-466(ra) # 80006522 <release>
}
    800016fc:	60e2                	ld	ra,24(sp)
    800016fe:	6442                	ld	s0,16(sp)
    80001700:	64a2                	ld	s1,8(sp)
    80001702:	6105                	addi	sp,sp,32
    80001704:	8082                	ret

0000000080001706 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001706:	7179                	addi	sp,sp,-48
    80001708:	f406                	sd	ra,40(sp)
    8000170a:	f022                	sd	s0,32(sp)
    8000170c:	ec26                	sd	s1,24(sp)
    8000170e:	e84a                	sd	s2,16(sp)
    80001710:	e44e                	sd	s3,8(sp)
    80001712:	1800                	addi	s0,sp,48
    80001714:	89aa                	mv	s3,a0
    80001716:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001718:	00000097          	auipc	ra,0x0
    8000171c:	874080e7          	jalr	-1932(ra) # 80000f8c <myproc>
    80001720:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001722:	00005097          	auipc	ra,0x5
    80001726:	d50080e7          	jalr	-688(ra) # 80006472 <acquire>
  release(lk);
    8000172a:	854a                	mv	a0,s2
    8000172c:	00005097          	auipc	ra,0x5
    80001730:	df6080e7          	jalr	-522(ra) # 80006522 <release>

  // Go to sleep.
  p->chan = chan;
    80001734:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001738:	4789                	li	a5,2
    8000173a:	cc9c                	sw	a5,24(s1)

  sched();
    8000173c:	00000097          	auipc	ra,0x0
    80001740:	eb8080e7          	jalr	-328(ra) # 800015f4 <sched>

  // Tidy up.
  p->chan = 0;
    80001744:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001748:	8526                	mv	a0,s1
    8000174a:	00005097          	auipc	ra,0x5
    8000174e:	dd8080e7          	jalr	-552(ra) # 80006522 <release>
  acquire(lk);
    80001752:	854a                	mv	a0,s2
    80001754:	00005097          	auipc	ra,0x5
    80001758:	d1e080e7          	jalr	-738(ra) # 80006472 <acquire>
}
    8000175c:	70a2                	ld	ra,40(sp)
    8000175e:	7402                	ld	s0,32(sp)
    80001760:	64e2                	ld	s1,24(sp)
    80001762:	6942                	ld	s2,16(sp)
    80001764:	69a2                	ld	s3,8(sp)
    80001766:	6145                	addi	sp,sp,48
    80001768:	8082                	ret

000000008000176a <wait>:
{
    8000176a:	715d                	addi	sp,sp,-80
    8000176c:	e486                	sd	ra,72(sp)
    8000176e:	e0a2                	sd	s0,64(sp)
    80001770:	fc26                	sd	s1,56(sp)
    80001772:	f84a                	sd	s2,48(sp)
    80001774:	f44e                	sd	s3,40(sp)
    80001776:	f052                	sd	s4,32(sp)
    80001778:	ec56                	sd	s5,24(sp)
    8000177a:	e85a                	sd	s6,16(sp)
    8000177c:	e45e                	sd	s7,8(sp)
    8000177e:	0880                	addi	s0,sp,80
    80001780:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001782:	00000097          	auipc	ra,0x0
    80001786:	80a080e7          	jalr	-2038(ra) # 80000f8c <myproc>
    8000178a:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000178c:	00008517          	auipc	a0,0x8
    80001790:	8dc50513          	addi	a0,a0,-1828 # 80009068 <wait_lock>
    80001794:	00005097          	auipc	ra,0x5
    80001798:	cde080e7          	jalr	-802(ra) # 80006472 <acquire>
        if(np->state == ZOMBIE){
    8000179c:	4a15                	li	s4,5
        havekids = 1;
    8000179e:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    800017a0:	0000e997          	auipc	s3,0xe
    800017a4:	8e098993          	addi	s3,s3,-1824 # 8000f080 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800017a8:	00008b97          	auipc	s7,0x8
    800017ac:	8c0b8b93          	addi	s7,s7,-1856 # 80009068 <wait_lock>
    800017b0:	a875                	j	8000186c <wait+0x102>
          pid = np->pid;
    800017b2:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800017b6:	000b0e63          	beqz	s6,800017d2 <wait+0x68>
    800017ba:	4691                	li	a3,4
    800017bc:	02c48613          	addi	a2,s1,44
    800017c0:	85da                	mv	a1,s6
    800017c2:	05093503          	ld	a0,80(s2)
    800017c6:	fffff097          	auipc	ra,0xfffff
    800017ca:	388080e7          	jalr	904(ra) # 80000b4e <copyout>
    800017ce:	04054063          	bltz	a0,8000180e <wait+0xa4>
          freeproc(np);
    800017d2:	8526                	mv	a0,s1
    800017d4:	00000097          	auipc	ra,0x0
    800017d8:	9e4080e7          	jalr	-1564(ra) # 800011b8 <freeproc>
          release(&np->lock);
    800017dc:	8526                	mv	a0,s1
    800017de:	00005097          	auipc	ra,0x5
    800017e2:	d44080e7          	jalr	-700(ra) # 80006522 <release>
          release(&wait_lock);
    800017e6:	00008517          	auipc	a0,0x8
    800017ea:	88250513          	addi	a0,a0,-1918 # 80009068 <wait_lock>
    800017ee:	00005097          	auipc	ra,0x5
    800017f2:	d34080e7          	jalr	-716(ra) # 80006522 <release>
}
    800017f6:	854e                	mv	a0,s3
    800017f8:	60a6                	ld	ra,72(sp)
    800017fa:	6406                	ld	s0,64(sp)
    800017fc:	74e2                	ld	s1,56(sp)
    800017fe:	7942                	ld	s2,48(sp)
    80001800:	79a2                	ld	s3,40(sp)
    80001802:	7a02                	ld	s4,32(sp)
    80001804:	6ae2                	ld	s5,24(sp)
    80001806:	6b42                	ld	s6,16(sp)
    80001808:	6ba2                	ld	s7,8(sp)
    8000180a:	6161                	addi	sp,sp,80
    8000180c:	8082                	ret
            release(&np->lock);
    8000180e:	8526                	mv	a0,s1
    80001810:	00005097          	auipc	ra,0x5
    80001814:	d12080e7          	jalr	-750(ra) # 80006522 <release>
            release(&wait_lock);
    80001818:	00008517          	auipc	a0,0x8
    8000181c:	85050513          	addi	a0,a0,-1968 # 80009068 <wait_lock>
    80001820:	00005097          	auipc	ra,0x5
    80001824:	d02080e7          	jalr	-766(ra) # 80006522 <release>
            return -1;
    80001828:	59fd                	li	s3,-1
    8000182a:	b7f1                	j	800017f6 <wait+0x8c>
    for(np = proc; np < &proc[NPROC]; np++){
    8000182c:	17048493          	addi	s1,s1,368
    80001830:	03348463          	beq	s1,s3,80001858 <wait+0xee>
      if(np->parent == p){
    80001834:	7c9c                	ld	a5,56(s1)
    80001836:	ff279be3          	bne	a5,s2,8000182c <wait+0xc2>
        acquire(&np->lock);
    8000183a:	8526                	mv	a0,s1
    8000183c:	00005097          	auipc	ra,0x5
    80001840:	c36080e7          	jalr	-970(ra) # 80006472 <acquire>
        if(np->state == ZOMBIE){
    80001844:	4c9c                	lw	a5,24(s1)
    80001846:	f74786e3          	beq	a5,s4,800017b2 <wait+0x48>
        release(&np->lock);
    8000184a:	8526                	mv	a0,s1
    8000184c:	00005097          	auipc	ra,0x5
    80001850:	cd6080e7          	jalr	-810(ra) # 80006522 <release>
        havekids = 1;
    80001854:	8756                	mv	a4,s5
    80001856:	bfd9                	j	8000182c <wait+0xc2>
    if(!havekids || p->killed){
    80001858:	c305                	beqz	a4,80001878 <wait+0x10e>
    8000185a:	02892783          	lw	a5,40(s2)
    8000185e:	ef89                	bnez	a5,80001878 <wait+0x10e>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001860:	85de                	mv	a1,s7
    80001862:	854a                	mv	a0,s2
    80001864:	00000097          	auipc	ra,0x0
    80001868:	ea2080e7          	jalr	-350(ra) # 80001706 <sleep>
    havekids = 0;
    8000186c:	4701                	li	a4,0
    for(np = proc; np < &proc[NPROC]; np++){
    8000186e:	00008497          	auipc	s1,0x8
    80001872:	c1248493          	addi	s1,s1,-1006 # 80009480 <proc>
    80001876:	bf7d                	j	80001834 <wait+0xca>
      release(&wait_lock);
    80001878:	00007517          	auipc	a0,0x7
    8000187c:	7f050513          	addi	a0,a0,2032 # 80009068 <wait_lock>
    80001880:	00005097          	auipc	ra,0x5
    80001884:	ca2080e7          	jalr	-862(ra) # 80006522 <release>
      return -1;
    80001888:	59fd                	li	s3,-1
    8000188a:	b7b5                	j	800017f6 <wait+0x8c>

000000008000188c <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000188c:	7139                	addi	sp,sp,-64
    8000188e:	fc06                	sd	ra,56(sp)
    80001890:	f822                	sd	s0,48(sp)
    80001892:	f426                	sd	s1,40(sp)
    80001894:	f04a                	sd	s2,32(sp)
    80001896:	ec4e                	sd	s3,24(sp)
    80001898:	e852                	sd	s4,16(sp)
    8000189a:	e456                	sd	s5,8(sp)
    8000189c:	0080                	addi	s0,sp,64
    8000189e:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800018a0:	00008497          	auipc	s1,0x8
    800018a4:	be048493          	addi	s1,s1,-1056 # 80009480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800018a8:	4989                	li	s3,2
        p->state = RUNNABLE;
    800018aa:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800018ac:	0000d917          	auipc	s2,0xd
    800018b0:	7d490913          	addi	s2,s2,2004 # 8000f080 <tickslock>
    800018b4:	a811                	j	800018c8 <wakeup+0x3c>
      }
      release(&p->lock);
    800018b6:	8526                	mv	a0,s1
    800018b8:	00005097          	auipc	ra,0x5
    800018bc:	c6a080e7          	jalr	-918(ra) # 80006522 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800018c0:	17048493          	addi	s1,s1,368
    800018c4:	03248663          	beq	s1,s2,800018f0 <wakeup+0x64>
    if(p != myproc()){
    800018c8:	fffff097          	auipc	ra,0xfffff
    800018cc:	6c4080e7          	jalr	1732(ra) # 80000f8c <myproc>
    800018d0:	fea488e3          	beq	s1,a0,800018c0 <wakeup+0x34>
      acquire(&p->lock);
    800018d4:	8526                	mv	a0,s1
    800018d6:	00005097          	auipc	ra,0x5
    800018da:	b9c080e7          	jalr	-1124(ra) # 80006472 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800018de:	4c9c                	lw	a5,24(s1)
    800018e0:	fd379be3          	bne	a5,s3,800018b6 <wakeup+0x2a>
    800018e4:	709c                	ld	a5,32(s1)
    800018e6:	fd4798e3          	bne	a5,s4,800018b6 <wakeup+0x2a>
        p->state = RUNNABLE;
    800018ea:	0154ac23          	sw	s5,24(s1)
    800018ee:	b7e1                	j	800018b6 <wakeup+0x2a>
    }
  }
}
    800018f0:	70e2                	ld	ra,56(sp)
    800018f2:	7442                	ld	s0,48(sp)
    800018f4:	74a2                	ld	s1,40(sp)
    800018f6:	7902                	ld	s2,32(sp)
    800018f8:	69e2                	ld	s3,24(sp)
    800018fa:	6a42                	ld	s4,16(sp)
    800018fc:	6aa2                	ld	s5,8(sp)
    800018fe:	6121                	addi	sp,sp,64
    80001900:	8082                	ret

0000000080001902 <reparent>:
{
    80001902:	7179                	addi	sp,sp,-48
    80001904:	f406                	sd	ra,40(sp)
    80001906:	f022                	sd	s0,32(sp)
    80001908:	ec26                	sd	s1,24(sp)
    8000190a:	e84a                	sd	s2,16(sp)
    8000190c:	e44e                	sd	s3,8(sp)
    8000190e:	e052                	sd	s4,0(sp)
    80001910:	1800                	addi	s0,sp,48
    80001912:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001914:	00008497          	auipc	s1,0x8
    80001918:	b6c48493          	addi	s1,s1,-1172 # 80009480 <proc>
      pp->parent = initproc;
    8000191c:	00007a17          	auipc	s4,0x7
    80001920:	6f4a0a13          	addi	s4,s4,1780 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001924:	0000d997          	auipc	s3,0xd
    80001928:	75c98993          	addi	s3,s3,1884 # 8000f080 <tickslock>
    8000192c:	a029                	j	80001936 <reparent+0x34>
    8000192e:	17048493          	addi	s1,s1,368
    80001932:	01348d63          	beq	s1,s3,8000194c <reparent+0x4a>
    if(pp->parent == p){
    80001936:	7c9c                	ld	a5,56(s1)
    80001938:	ff279be3          	bne	a5,s2,8000192e <reparent+0x2c>
      pp->parent = initproc;
    8000193c:	000a3503          	ld	a0,0(s4)
    80001940:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001942:	00000097          	auipc	ra,0x0
    80001946:	f4a080e7          	jalr	-182(ra) # 8000188c <wakeup>
    8000194a:	b7d5                	j	8000192e <reparent+0x2c>
}
    8000194c:	70a2                	ld	ra,40(sp)
    8000194e:	7402                	ld	s0,32(sp)
    80001950:	64e2                	ld	s1,24(sp)
    80001952:	6942                	ld	s2,16(sp)
    80001954:	69a2                	ld	s3,8(sp)
    80001956:	6a02                	ld	s4,0(sp)
    80001958:	6145                	addi	sp,sp,48
    8000195a:	8082                	ret

000000008000195c <exit>:
{
    8000195c:	7179                	addi	sp,sp,-48
    8000195e:	f406                	sd	ra,40(sp)
    80001960:	f022                	sd	s0,32(sp)
    80001962:	ec26                	sd	s1,24(sp)
    80001964:	e84a                	sd	s2,16(sp)
    80001966:	e44e                	sd	s3,8(sp)
    80001968:	e052                	sd	s4,0(sp)
    8000196a:	1800                	addi	s0,sp,48
    8000196c:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    8000196e:	fffff097          	auipc	ra,0xfffff
    80001972:	61e080e7          	jalr	1566(ra) # 80000f8c <myproc>
    80001976:	89aa                	mv	s3,a0
  if(p == initproc)
    80001978:	00007797          	auipc	a5,0x7
    8000197c:	6987b783          	ld	a5,1688(a5) # 80009010 <initproc>
    80001980:	0d050493          	addi	s1,a0,208
    80001984:	15050913          	addi	s2,a0,336
    80001988:	00a79d63          	bne	a5,a0,800019a2 <exit+0x46>
    panic("init exiting");
    8000198c:	00007517          	auipc	a0,0x7
    80001990:	89c50513          	addi	a0,a0,-1892 # 80008228 <etext+0x228>
    80001994:	00004097          	auipc	ra,0x4
    80001998:	55e080e7          	jalr	1374(ra) # 80005ef2 <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    8000199c:	04a1                	addi	s1,s1,8
    8000199e:	01248b63          	beq	s1,s2,800019b4 <exit+0x58>
    if(p->ofile[fd]){
    800019a2:	6088                	ld	a0,0(s1)
    800019a4:	dd65                	beqz	a0,8000199c <exit+0x40>
      fileclose(f);
    800019a6:	00002097          	auipc	ra,0x2
    800019aa:	232080e7          	jalr	562(ra) # 80003bd8 <fileclose>
      p->ofile[fd] = 0;
    800019ae:	0004b023          	sd	zero,0(s1)
    800019b2:	b7ed                	j	8000199c <exit+0x40>
  begin_op();
    800019b4:	00002097          	auipc	ra,0x2
    800019b8:	d54080e7          	jalr	-684(ra) # 80003708 <begin_op>
  iput(p->cwd);
    800019bc:	1509b503          	ld	a0,336(s3)
    800019c0:	00001097          	auipc	ra,0x1
    800019c4:	514080e7          	jalr	1300(ra) # 80002ed4 <iput>
  end_op();
    800019c8:	00002097          	auipc	ra,0x2
    800019cc:	dba080e7          	jalr	-582(ra) # 80003782 <end_op>
  p->cwd = 0;
    800019d0:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800019d4:	00007497          	auipc	s1,0x7
    800019d8:	69448493          	addi	s1,s1,1684 # 80009068 <wait_lock>
    800019dc:	8526                	mv	a0,s1
    800019de:	00005097          	auipc	ra,0x5
    800019e2:	a94080e7          	jalr	-1388(ra) # 80006472 <acquire>
  reparent(p);
    800019e6:	854e                	mv	a0,s3
    800019e8:	00000097          	auipc	ra,0x0
    800019ec:	f1a080e7          	jalr	-230(ra) # 80001902 <reparent>
  wakeup(p->parent);
    800019f0:	0389b503          	ld	a0,56(s3)
    800019f4:	00000097          	auipc	ra,0x0
    800019f8:	e98080e7          	jalr	-360(ra) # 8000188c <wakeup>
  acquire(&p->lock);
    800019fc:	854e                	mv	a0,s3
    800019fe:	00005097          	auipc	ra,0x5
    80001a02:	a74080e7          	jalr	-1420(ra) # 80006472 <acquire>
  p->xstate = status;
    80001a06:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001a0a:	4795                	li	a5,5
    80001a0c:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001a10:	8526                	mv	a0,s1
    80001a12:	00005097          	auipc	ra,0x5
    80001a16:	b10080e7          	jalr	-1264(ra) # 80006522 <release>
  sched();
    80001a1a:	00000097          	auipc	ra,0x0
    80001a1e:	bda080e7          	jalr	-1062(ra) # 800015f4 <sched>
  panic("zombie exit");
    80001a22:	00007517          	auipc	a0,0x7
    80001a26:	81650513          	addi	a0,a0,-2026 # 80008238 <etext+0x238>
    80001a2a:	00004097          	auipc	ra,0x4
    80001a2e:	4c8080e7          	jalr	1224(ra) # 80005ef2 <panic>

0000000080001a32 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001a32:	7179                	addi	sp,sp,-48
    80001a34:	f406                	sd	ra,40(sp)
    80001a36:	f022                	sd	s0,32(sp)
    80001a38:	ec26                	sd	s1,24(sp)
    80001a3a:	e84a                	sd	s2,16(sp)
    80001a3c:	e44e                	sd	s3,8(sp)
    80001a3e:	1800                	addi	s0,sp,48
    80001a40:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001a42:	00008497          	auipc	s1,0x8
    80001a46:	a3e48493          	addi	s1,s1,-1474 # 80009480 <proc>
    80001a4a:	0000d997          	auipc	s3,0xd
    80001a4e:	63698993          	addi	s3,s3,1590 # 8000f080 <tickslock>
    acquire(&p->lock);
    80001a52:	8526                	mv	a0,s1
    80001a54:	00005097          	auipc	ra,0x5
    80001a58:	a1e080e7          	jalr	-1506(ra) # 80006472 <acquire>
    if(p->pid == pid){
    80001a5c:	589c                	lw	a5,48(s1)
    80001a5e:	01278d63          	beq	a5,s2,80001a78 <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001a62:	8526                	mv	a0,s1
    80001a64:	00005097          	auipc	ra,0x5
    80001a68:	abe080e7          	jalr	-1346(ra) # 80006522 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a6c:	17048493          	addi	s1,s1,368
    80001a70:	ff3491e3          	bne	s1,s3,80001a52 <kill+0x20>
  }
  return -1;
    80001a74:	557d                	li	a0,-1
    80001a76:	a829                	j	80001a90 <kill+0x5e>
      p->killed = 1;
    80001a78:	4785                	li	a5,1
    80001a7a:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001a7c:	4c98                	lw	a4,24(s1)
    80001a7e:	4789                	li	a5,2
    80001a80:	00f70f63          	beq	a4,a5,80001a9e <kill+0x6c>
      release(&p->lock);
    80001a84:	8526                	mv	a0,s1
    80001a86:	00005097          	auipc	ra,0x5
    80001a8a:	a9c080e7          	jalr	-1380(ra) # 80006522 <release>
      return 0;
    80001a8e:	4501                	li	a0,0
}
    80001a90:	70a2                	ld	ra,40(sp)
    80001a92:	7402                	ld	s0,32(sp)
    80001a94:	64e2                	ld	s1,24(sp)
    80001a96:	6942                	ld	s2,16(sp)
    80001a98:	69a2                	ld	s3,8(sp)
    80001a9a:	6145                	addi	sp,sp,48
    80001a9c:	8082                	ret
        p->state = RUNNABLE;
    80001a9e:	478d                	li	a5,3
    80001aa0:	cc9c                	sw	a5,24(s1)
    80001aa2:	b7cd                	j	80001a84 <kill+0x52>

0000000080001aa4 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001aa4:	7179                	addi	sp,sp,-48
    80001aa6:	f406                	sd	ra,40(sp)
    80001aa8:	f022                	sd	s0,32(sp)
    80001aaa:	ec26                	sd	s1,24(sp)
    80001aac:	e84a                	sd	s2,16(sp)
    80001aae:	e44e                	sd	s3,8(sp)
    80001ab0:	e052                	sd	s4,0(sp)
    80001ab2:	1800                	addi	s0,sp,48
    80001ab4:	84aa                	mv	s1,a0
    80001ab6:	892e                	mv	s2,a1
    80001ab8:	89b2                	mv	s3,a2
    80001aba:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001abc:	fffff097          	auipc	ra,0xfffff
    80001ac0:	4d0080e7          	jalr	1232(ra) # 80000f8c <myproc>
  if(user_dst){
    80001ac4:	c08d                	beqz	s1,80001ae6 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001ac6:	86d2                	mv	a3,s4
    80001ac8:	864e                	mv	a2,s3
    80001aca:	85ca                	mv	a1,s2
    80001acc:	6928                	ld	a0,80(a0)
    80001ace:	fffff097          	auipc	ra,0xfffff
    80001ad2:	080080e7          	jalr	128(ra) # 80000b4e <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001ad6:	70a2                	ld	ra,40(sp)
    80001ad8:	7402                	ld	s0,32(sp)
    80001ada:	64e2                	ld	s1,24(sp)
    80001adc:	6942                	ld	s2,16(sp)
    80001ade:	69a2                	ld	s3,8(sp)
    80001ae0:	6a02                	ld	s4,0(sp)
    80001ae2:	6145                	addi	sp,sp,48
    80001ae4:	8082                	ret
    memmove((char *)dst, src, len);
    80001ae6:	000a061b          	sext.w	a2,s4
    80001aea:	85ce                	mv	a1,s3
    80001aec:	854a                	mv	a0,s2
    80001aee:	ffffe097          	auipc	ra,0xffffe
    80001af2:	6f0080e7          	jalr	1776(ra) # 800001de <memmove>
    return 0;
    80001af6:	8526                	mv	a0,s1
    80001af8:	bff9                	j	80001ad6 <either_copyout+0x32>

0000000080001afa <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001afa:	7179                	addi	sp,sp,-48
    80001afc:	f406                	sd	ra,40(sp)
    80001afe:	f022                	sd	s0,32(sp)
    80001b00:	ec26                	sd	s1,24(sp)
    80001b02:	e84a                	sd	s2,16(sp)
    80001b04:	e44e                	sd	s3,8(sp)
    80001b06:	e052                	sd	s4,0(sp)
    80001b08:	1800                	addi	s0,sp,48
    80001b0a:	892a                	mv	s2,a0
    80001b0c:	84ae                	mv	s1,a1
    80001b0e:	89b2                	mv	s3,a2
    80001b10:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001b12:	fffff097          	auipc	ra,0xfffff
    80001b16:	47a080e7          	jalr	1146(ra) # 80000f8c <myproc>
  if(user_src){
    80001b1a:	c08d                	beqz	s1,80001b3c <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001b1c:	86d2                	mv	a3,s4
    80001b1e:	864e                	mv	a2,s3
    80001b20:	85ca                	mv	a1,s2
    80001b22:	6928                	ld	a0,80(a0)
    80001b24:	fffff097          	auipc	ra,0xfffff
    80001b28:	0b6080e7          	jalr	182(ra) # 80000bda <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001b2c:	70a2                	ld	ra,40(sp)
    80001b2e:	7402                	ld	s0,32(sp)
    80001b30:	64e2                	ld	s1,24(sp)
    80001b32:	6942                	ld	s2,16(sp)
    80001b34:	69a2                	ld	s3,8(sp)
    80001b36:	6a02                	ld	s4,0(sp)
    80001b38:	6145                	addi	sp,sp,48
    80001b3a:	8082                	ret
    memmove(dst, (char*)src, len);
    80001b3c:	000a061b          	sext.w	a2,s4
    80001b40:	85ce                	mv	a1,s3
    80001b42:	854a                	mv	a0,s2
    80001b44:	ffffe097          	auipc	ra,0xffffe
    80001b48:	69a080e7          	jalr	1690(ra) # 800001de <memmove>
    return 0;
    80001b4c:	8526                	mv	a0,s1
    80001b4e:	bff9                	j	80001b2c <either_copyin+0x32>

0000000080001b50 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001b50:	715d                	addi	sp,sp,-80
    80001b52:	e486                	sd	ra,72(sp)
    80001b54:	e0a2                	sd	s0,64(sp)
    80001b56:	fc26                	sd	s1,56(sp)
    80001b58:	f84a                	sd	s2,48(sp)
    80001b5a:	f44e                	sd	s3,40(sp)
    80001b5c:	f052                	sd	s4,32(sp)
    80001b5e:	ec56                	sd	s5,24(sp)
    80001b60:	e85a                	sd	s6,16(sp)
    80001b62:	e45e                	sd	s7,8(sp)
    80001b64:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001b66:	00006517          	auipc	a0,0x6
    80001b6a:	4b250513          	addi	a0,a0,1202 # 80008018 <etext+0x18>
    80001b6e:	00004097          	auipc	ra,0x4
    80001b72:	3ce080e7          	jalr	974(ra) # 80005f3c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001b76:	00008497          	auipc	s1,0x8
    80001b7a:	a6248493          	addi	s1,s1,-1438 # 800095d8 <proc+0x158>
    80001b7e:	0000d917          	auipc	s2,0xd
    80001b82:	65a90913          	addi	s2,s2,1626 # 8000f1d8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001b86:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001b88:	00006997          	auipc	s3,0x6
    80001b8c:	6c098993          	addi	s3,s3,1728 # 80008248 <etext+0x248>
    printf("%d %s %s", p->pid, state, p->name);
    80001b90:	00006a97          	auipc	s5,0x6
    80001b94:	6c0a8a93          	addi	s5,s5,1728 # 80008250 <etext+0x250>
    printf("\n");
    80001b98:	00006a17          	auipc	s4,0x6
    80001b9c:	480a0a13          	addi	s4,s4,1152 # 80008018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ba0:	00007b97          	auipc	s7,0x7
    80001ba4:	ba8b8b93          	addi	s7,s7,-1112 # 80008748 <states.0>
    80001ba8:	a00d                	j	80001bca <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001baa:	ed86a583          	lw	a1,-296(a3)
    80001bae:	8556                	mv	a0,s5
    80001bb0:	00004097          	auipc	ra,0x4
    80001bb4:	38c080e7          	jalr	908(ra) # 80005f3c <printf>
    printf("\n");
    80001bb8:	8552                	mv	a0,s4
    80001bba:	00004097          	auipc	ra,0x4
    80001bbe:	382080e7          	jalr	898(ra) # 80005f3c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001bc2:	17048493          	addi	s1,s1,368
    80001bc6:	03248263          	beq	s1,s2,80001bea <procdump+0x9a>
    if(p->state == UNUSED)
    80001bca:	86a6                	mv	a3,s1
    80001bcc:	ec04a783          	lw	a5,-320(s1)
    80001bd0:	dbed                	beqz	a5,80001bc2 <procdump+0x72>
      state = "???";
    80001bd2:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001bd4:	fcfb6be3          	bltu	s6,a5,80001baa <procdump+0x5a>
    80001bd8:	02079713          	slli	a4,a5,0x20
    80001bdc:	01d75793          	srli	a5,a4,0x1d
    80001be0:	97de                	add	a5,a5,s7
    80001be2:	6390                	ld	a2,0(a5)
    80001be4:	f279                	bnez	a2,80001baa <procdump+0x5a>
      state = "???";
    80001be6:	864e                	mv	a2,s3
    80001be8:	b7c9                	j	80001baa <procdump+0x5a>
  }
}
    80001bea:	60a6                	ld	ra,72(sp)
    80001bec:	6406                	ld	s0,64(sp)
    80001bee:	74e2                	ld	s1,56(sp)
    80001bf0:	7942                	ld	s2,48(sp)
    80001bf2:	79a2                	ld	s3,40(sp)
    80001bf4:	7a02                	ld	s4,32(sp)
    80001bf6:	6ae2                	ld	s5,24(sp)
    80001bf8:	6b42                	ld	s6,16(sp)
    80001bfa:	6ba2                	ld	s7,8(sp)
    80001bfc:	6161                	addi	sp,sp,80
    80001bfe:	8082                	ret

0000000080001c00 <swtch>:
    80001c00:	00153023          	sd	ra,0(a0)
    80001c04:	00253423          	sd	sp,8(a0)
    80001c08:	e900                	sd	s0,16(a0)
    80001c0a:	ed04                	sd	s1,24(a0)
    80001c0c:	03253023          	sd	s2,32(a0)
    80001c10:	03353423          	sd	s3,40(a0)
    80001c14:	03453823          	sd	s4,48(a0)
    80001c18:	03553c23          	sd	s5,56(a0)
    80001c1c:	05653023          	sd	s6,64(a0)
    80001c20:	05753423          	sd	s7,72(a0)
    80001c24:	05853823          	sd	s8,80(a0)
    80001c28:	05953c23          	sd	s9,88(a0)
    80001c2c:	07a53023          	sd	s10,96(a0)
    80001c30:	07b53423          	sd	s11,104(a0)
    80001c34:	0005b083          	ld	ra,0(a1)
    80001c38:	0085b103          	ld	sp,8(a1)
    80001c3c:	6980                	ld	s0,16(a1)
    80001c3e:	6d84                	ld	s1,24(a1)
    80001c40:	0205b903          	ld	s2,32(a1)
    80001c44:	0285b983          	ld	s3,40(a1)
    80001c48:	0305ba03          	ld	s4,48(a1)
    80001c4c:	0385ba83          	ld	s5,56(a1)
    80001c50:	0405bb03          	ld	s6,64(a1)
    80001c54:	0485bb83          	ld	s7,72(a1)
    80001c58:	0505bc03          	ld	s8,80(a1)
    80001c5c:	0585bc83          	ld	s9,88(a1)
    80001c60:	0605bd03          	ld	s10,96(a1)
    80001c64:	0685bd83          	ld	s11,104(a1)
    80001c68:	8082                	ret

0000000080001c6a <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001c6a:	1141                	addi	sp,sp,-16
    80001c6c:	e406                	sd	ra,8(sp)
    80001c6e:	e022                	sd	s0,0(sp)
    80001c70:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001c72:	00006597          	auipc	a1,0x6
    80001c76:	61658593          	addi	a1,a1,1558 # 80008288 <etext+0x288>
    80001c7a:	0000d517          	auipc	a0,0xd
    80001c7e:	40650513          	addi	a0,a0,1030 # 8000f080 <tickslock>
    80001c82:	00004097          	auipc	ra,0x4
    80001c86:	75c080e7          	jalr	1884(ra) # 800063de <initlock>
}
    80001c8a:	60a2                	ld	ra,8(sp)
    80001c8c:	6402                	ld	s0,0(sp)
    80001c8e:	0141                	addi	sp,sp,16
    80001c90:	8082                	ret

0000000080001c92 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001c92:	1141                	addi	sp,sp,-16
    80001c94:	e406                	sd	ra,8(sp)
    80001c96:	e022                	sd	s0,0(sp)
    80001c98:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c9a:	00003797          	auipc	a5,0x3
    80001c9e:	68678793          	addi	a5,a5,1670 # 80005320 <kernelvec>
    80001ca2:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001ca6:	60a2                	ld	ra,8(sp)
    80001ca8:	6402                	ld	s0,0(sp)
    80001caa:	0141                	addi	sp,sp,16
    80001cac:	8082                	ret

0000000080001cae <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001cae:	1141                	addi	sp,sp,-16
    80001cb0:	e406                	sd	ra,8(sp)
    80001cb2:	e022                	sd	s0,0(sp)
    80001cb4:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001cb6:	fffff097          	auipc	ra,0xfffff
    80001cba:	2d6080e7          	jalr	726(ra) # 80000f8c <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001cbe:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001cc2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001cc4:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001cc8:	00005697          	auipc	a3,0x5
    80001ccc:	33868693          	addi	a3,a3,824 # 80007000 <_trampoline>
    80001cd0:	00005717          	auipc	a4,0x5
    80001cd4:	33070713          	addi	a4,a4,816 # 80007000 <_trampoline>
    80001cd8:	8f15                	sub	a4,a4,a3
    80001cda:	040007b7          	lui	a5,0x4000
    80001cde:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001ce0:	07b2                	slli	a5,a5,0xc
    80001ce2:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001ce4:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001ce8:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001cea:	18002673          	csrr	a2,satp
    80001cee:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001cf0:	6d30                	ld	a2,88(a0)
    80001cf2:	6138                	ld	a4,64(a0)
    80001cf4:	6585                	lui	a1,0x1
    80001cf6:	972e                	add	a4,a4,a1
    80001cf8:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001cfa:	6d38                	ld	a4,88(a0)
    80001cfc:	00000617          	auipc	a2,0x0
    80001d00:	14060613          	addi	a2,a2,320 # 80001e3c <usertrap>
    80001d04:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001d06:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001d08:	8612                	mv	a2,tp
    80001d0a:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d0c:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001d10:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001d14:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d18:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001d1c:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001d1e:	6f18                	ld	a4,24(a4)
    80001d20:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001d24:	692c                	ld	a1,80(a0)
    80001d26:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001d28:	00005717          	auipc	a4,0x5
    80001d2c:	36870713          	addi	a4,a4,872 # 80007090 <userret>
    80001d30:	8f15                	sub	a4,a4,a3
    80001d32:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001d34:	577d                	li	a4,-1
    80001d36:	177e                	slli	a4,a4,0x3f
    80001d38:	8dd9                	or	a1,a1,a4
    80001d3a:	02000537          	lui	a0,0x2000
    80001d3e:	157d                	addi	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001d40:	0536                	slli	a0,a0,0xd
    80001d42:	9782                	jalr	a5
}
    80001d44:	60a2                	ld	ra,8(sp)
    80001d46:	6402                	ld	s0,0(sp)
    80001d48:	0141                	addi	sp,sp,16
    80001d4a:	8082                	ret

0000000080001d4c <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001d4c:	1101                	addi	sp,sp,-32
    80001d4e:	ec06                	sd	ra,24(sp)
    80001d50:	e822                	sd	s0,16(sp)
    80001d52:	e426                	sd	s1,8(sp)
    80001d54:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001d56:	0000d497          	auipc	s1,0xd
    80001d5a:	32a48493          	addi	s1,s1,810 # 8000f080 <tickslock>
    80001d5e:	8526                	mv	a0,s1
    80001d60:	00004097          	auipc	ra,0x4
    80001d64:	712080e7          	jalr	1810(ra) # 80006472 <acquire>
  ticks++;
    80001d68:	00007517          	auipc	a0,0x7
    80001d6c:	2b050513          	addi	a0,a0,688 # 80009018 <ticks>
    80001d70:	411c                	lw	a5,0(a0)
    80001d72:	2785                	addiw	a5,a5,1
    80001d74:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001d76:	00000097          	auipc	ra,0x0
    80001d7a:	b16080e7          	jalr	-1258(ra) # 8000188c <wakeup>
  release(&tickslock);
    80001d7e:	8526                	mv	a0,s1
    80001d80:	00004097          	auipc	ra,0x4
    80001d84:	7a2080e7          	jalr	1954(ra) # 80006522 <release>
}
    80001d88:	60e2                	ld	ra,24(sp)
    80001d8a:	6442                	ld	s0,16(sp)
    80001d8c:	64a2                	ld	s1,8(sp)
    80001d8e:	6105                	addi	sp,sp,32
    80001d90:	8082                	ret

0000000080001d92 <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d92:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001d96:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001d98:	0a07d163          	bgez	a5,80001e3a <devintr+0xa8>
{
    80001d9c:	1101                	addi	sp,sp,-32
    80001d9e:	ec06                	sd	ra,24(sp)
    80001da0:	e822                	sd	s0,16(sp)
    80001da2:	1000                	addi	s0,sp,32
     (scause & 0xff) == 9){
    80001da4:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001da8:	46a5                	li	a3,9
    80001daa:	00d70c63          	beq	a4,a3,80001dc2 <devintr+0x30>
  } else if(scause == 0x8000000000000001L){
    80001dae:	577d                	li	a4,-1
    80001db0:	177e                	slli	a4,a4,0x3f
    80001db2:	0705                	addi	a4,a4,1
    return 0;
    80001db4:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001db6:	06e78163          	beq	a5,a4,80001e18 <devintr+0x86>
  }
}
    80001dba:	60e2                	ld	ra,24(sp)
    80001dbc:	6442                	ld	s0,16(sp)
    80001dbe:	6105                	addi	sp,sp,32
    80001dc0:	8082                	ret
    80001dc2:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001dc4:	00003097          	auipc	ra,0x3
    80001dc8:	668080e7          	jalr	1640(ra) # 8000542c <plic_claim>
    80001dcc:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001dce:	47a9                	li	a5,10
    80001dd0:	00f50963          	beq	a0,a5,80001de2 <devintr+0x50>
    } else if(irq == VIRTIO0_IRQ){
    80001dd4:	4785                	li	a5,1
    80001dd6:	00f50b63          	beq	a0,a5,80001dec <devintr+0x5a>
    return 1;
    80001dda:	4505                	li	a0,1
    } else if(irq){
    80001ddc:	ec89                	bnez	s1,80001df6 <devintr+0x64>
    80001dde:	64a2                	ld	s1,8(sp)
    80001de0:	bfe9                	j	80001dba <devintr+0x28>
      uartintr();
    80001de2:	00004097          	auipc	ra,0x4
    80001de6:	5ac080e7          	jalr	1452(ra) # 8000638e <uartintr>
    if(irq)
    80001dea:	a839                	j	80001e08 <devintr+0x76>
      virtio_disk_intr();
    80001dec:	00004097          	auipc	ra,0x4
    80001df0:	afa080e7          	jalr	-1286(ra) # 800058e6 <virtio_disk_intr>
    if(irq)
    80001df4:	a811                	j	80001e08 <devintr+0x76>
      printf("unexpected interrupt irq=%d\n", irq);
    80001df6:	85a6                	mv	a1,s1
    80001df8:	00006517          	auipc	a0,0x6
    80001dfc:	49850513          	addi	a0,a0,1176 # 80008290 <etext+0x290>
    80001e00:	00004097          	auipc	ra,0x4
    80001e04:	13c080e7          	jalr	316(ra) # 80005f3c <printf>
      plic_complete(irq);
    80001e08:	8526                	mv	a0,s1
    80001e0a:	00003097          	auipc	ra,0x3
    80001e0e:	646080e7          	jalr	1606(ra) # 80005450 <plic_complete>
    return 1;
    80001e12:	4505                	li	a0,1
    80001e14:	64a2                	ld	s1,8(sp)
    80001e16:	b755                	j	80001dba <devintr+0x28>
    if(cpuid() == 0){
    80001e18:	fffff097          	auipc	ra,0xfffff
    80001e1c:	140080e7          	jalr	320(ra) # 80000f58 <cpuid>
    80001e20:	c901                	beqz	a0,80001e30 <devintr+0x9e>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001e22:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001e26:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001e28:	14479073          	csrw	sip,a5
    return 2;
    80001e2c:	4509                	li	a0,2
    80001e2e:	b771                	j	80001dba <devintr+0x28>
      clockintr();
    80001e30:	00000097          	auipc	ra,0x0
    80001e34:	f1c080e7          	jalr	-228(ra) # 80001d4c <clockintr>
    80001e38:	b7ed                	j	80001e22 <devintr+0x90>
}
    80001e3a:	8082                	ret

0000000080001e3c <usertrap>:
{
    80001e3c:	1101                	addi	sp,sp,-32
    80001e3e:	ec06                	sd	ra,24(sp)
    80001e40:	e822                	sd	s0,16(sp)
    80001e42:	e426                	sd	s1,8(sp)
    80001e44:	e04a                	sd	s2,0(sp)
    80001e46:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e48:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001e4c:	1007f793          	andi	a5,a5,256
    80001e50:	e3ad                	bnez	a5,80001eb2 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001e52:	00003797          	auipc	a5,0x3
    80001e56:	4ce78793          	addi	a5,a5,1230 # 80005320 <kernelvec>
    80001e5a:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001e5e:	fffff097          	auipc	ra,0xfffff
    80001e62:	12e080e7          	jalr	302(ra) # 80000f8c <myproc>
    80001e66:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001e68:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e6a:	14102773          	csrr	a4,sepc
    80001e6e:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e70:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001e74:	47a1                	li	a5,8
    80001e76:	04f71c63          	bne	a4,a5,80001ece <usertrap+0x92>
    if(p->killed)
    80001e7a:	551c                	lw	a5,40(a0)
    80001e7c:	e3b9                	bnez	a5,80001ec2 <usertrap+0x86>
    p->trapframe->epc += 4;
    80001e7e:	6cb8                	ld	a4,88(s1)
    80001e80:	6f1c                	ld	a5,24(a4)
    80001e82:	0791                	addi	a5,a5,4
    80001e84:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e86:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001e8a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e8e:	10079073          	csrw	sstatus,a5
    syscall();
    80001e92:	00000097          	auipc	ra,0x0
    80001e96:	2e0080e7          	jalr	736(ra) # 80002172 <syscall>
  if(p->killed)
    80001e9a:	549c                	lw	a5,40(s1)
    80001e9c:	ebc1                	bnez	a5,80001f2c <usertrap+0xf0>
  usertrapret();
    80001e9e:	00000097          	auipc	ra,0x0
    80001ea2:	e10080e7          	jalr	-496(ra) # 80001cae <usertrapret>
}
    80001ea6:	60e2                	ld	ra,24(sp)
    80001ea8:	6442                	ld	s0,16(sp)
    80001eaa:	64a2                	ld	s1,8(sp)
    80001eac:	6902                	ld	s2,0(sp)
    80001eae:	6105                	addi	sp,sp,32
    80001eb0:	8082                	ret
    panic("usertrap: not from user mode");
    80001eb2:	00006517          	auipc	a0,0x6
    80001eb6:	3fe50513          	addi	a0,a0,1022 # 800082b0 <etext+0x2b0>
    80001eba:	00004097          	auipc	ra,0x4
    80001ebe:	038080e7          	jalr	56(ra) # 80005ef2 <panic>
      exit(-1);
    80001ec2:	557d                	li	a0,-1
    80001ec4:	00000097          	auipc	ra,0x0
    80001ec8:	a98080e7          	jalr	-1384(ra) # 8000195c <exit>
    80001ecc:	bf4d                	j	80001e7e <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80001ece:	00000097          	auipc	ra,0x0
    80001ed2:	ec4080e7          	jalr	-316(ra) # 80001d92 <devintr>
    80001ed6:	892a                	mv	s2,a0
    80001ed8:	c501                	beqz	a0,80001ee0 <usertrap+0xa4>
  if(p->killed)
    80001eda:	549c                	lw	a5,40(s1)
    80001edc:	c3a1                	beqz	a5,80001f1c <usertrap+0xe0>
    80001ede:	a815                	j	80001f12 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ee0:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001ee4:	5890                	lw	a2,48(s1)
    80001ee6:	00006517          	auipc	a0,0x6
    80001eea:	3ea50513          	addi	a0,a0,1002 # 800082d0 <etext+0x2d0>
    80001eee:	00004097          	auipc	ra,0x4
    80001ef2:	04e080e7          	jalr	78(ra) # 80005f3c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001ef6:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001efa:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001efe:	00006517          	auipc	a0,0x6
    80001f02:	40250513          	addi	a0,a0,1026 # 80008300 <etext+0x300>
    80001f06:	00004097          	auipc	ra,0x4
    80001f0a:	036080e7          	jalr	54(ra) # 80005f3c <printf>
    p->killed = 1;
    80001f0e:	4785                	li	a5,1
    80001f10:	d49c                	sw	a5,40(s1)
    exit(-1);
    80001f12:	557d                	li	a0,-1
    80001f14:	00000097          	auipc	ra,0x0
    80001f18:	a48080e7          	jalr	-1464(ra) # 8000195c <exit>
  if(which_dev == 2)
    80001f1c:	4789                	li	a5,2
    80001f1e:	f8f910e3          	bne	s2,a5,80001e9e <usertrap+0x62>
    yield();
    80001f22:	fffff097          	auipc	ra,0xfffff
    80001f26:	7a8080e7          	jalr	1960(ra) # 800016ca <yield>
    80001f2a:	bf95                	j	80001e9e <usertrap+0x62>
  int which_dev = 0;
    80001f2c:	4901                	li	s2,0
    80001f2e:	b7d5                	j	80001f12 <usertrap+0xd6>

0000000080001f30 <kerneltrap>:
{
    80001f30:	7179                	addi	sp,sp,-48
    80001f32:	f406                	sd	ra,40(sp)
    80001f34:	f022                	sd	s0,32(sp)
    80001f36:	ec26                	sd	s1,24(sp)
    80001f38:	e84a                	sd	s2,16(sp)
    80001f3a:	e44e                	sd	s3,8(sp)
    80001f3c:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001f3e:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f42:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001f46:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001f4a:	1004f793          	andi	a5,s1,256
    80001f4e:	cb85                	beqz	a5,80001f7e <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001f50:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001f54:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001f56:	ef85                	bnez	a5,80001f8e <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001f58:	00000097          	auipc	ra,0x0
    80001f5c:	e3a080e7          	jalr	-454(ra) # 80001d92 <devintr>
    80001f60:	cd1d                	beqz	a0,80001f9e <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001f62:	4789                	li	a5,2
    80001f64:	06f50a63          	beq	a0,a5,80001fd8 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001f68:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001f6c:	10049073          	csrw	sstatus,s1
}
    80001f70:	70a2                	ld	ra,40(sp)
    80001f72:	7402                	ld	s0,32(sp)
    80001f74:	64e2                	ld	s1,24(sp)
    80001f76:	6942                	ld	s2,16(sp)
    80001f78:	69a2                	ld	s3,8(sp)
    80001f7a:	6145                	addi	sp,sp,48
    80001f7c:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001f7e:	00006517          	auipc	a0,0x6
    80001f82:	3a250513          	addi	a0,a0,930 # 80008320 <etext+0x320>
    80001f86:	00004097          	auipc	ra,0x4
    80001f8a:	f6c080e7          	jalr	-148(ra) # 80005ef2 <panic>
    panic("kerneltrap: interrupts enabled");
    80001f8e:	00006517          	auipc	a0,0x6
    80001f92:	3ba50513          	addi	a0,a0,954 # 80008348 <etext+0x348>
    80001f96:	00004097          	auipc	ra,0x4
    80001f9a:	f5c080e7          	jalr	-164(ra) # 80005ef2 <panic>
    printf("scause %p\n", scause);
    80001f9e:	85ce                	mv	a1,s3
    80001fa0:	00006517          	auipc	a0,0x6
    80001fa4:	3c850513          	addi	a0,a0,968 # 80008368 <etext+0x368>
    80001fa8:	00004097          	auipc	ra,0x4
    80001fac:	f94080e7          	jalr	-108(ra) # 80005f3c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001fb0:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001fb4:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001fb8:	00006517          	auipc	a0,0x6
    80001fbc:	3c050513          	addi	a0,a0,960 # 80008378 <etext+0x378>
    80001fc0:	00004097          	auipc	ra,0x4
    80001fc4:	f7c080e7          	jalr	-132(ra) # 80005f3c <printf>
    panic("kerneltrap");
    80001fc8:	00006517          	auipc	a0,0x6
    80001fcc:	3c850513          	addi	a0,a0,968 # 80008390 <etext+0x390>
    80001fd0:	00004097          	auipc	ra,0x4
    80001fd4:	f22080e7          	jalr	-222(ra) # 80005ef2 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001fd8:	fffff097          	auipc	ra,0xfffff
    80001fdc:	fb4080e7          	jalr	-76(ra) # 80000f8c <myproc>
    80001fe0:	d541                	beqz	a0,80001f68 <kerneltrap+0x38>
    80001fe2:	fffff097          	auipc	ra,0xfffff
    80001fe6:	faa080e7          	jalr	-86(ra) # 80000f8c <myproc>
    80001fea:	4d18                	lw	a4,24(a0)
    80001fec:	4791                	li	a5,4
    80001fee:	f6f71de3          	bne	a4,a5,80001f68 <kerneltrap+0x38>
    yield();
    80001ff2:	fffff097          	auipc	ra,0xfffff
    80001ff6:	6d8080e7          	jalr	1752(ra) # 800016ca <yield>
    80001ffa:	b7bd                	j	80001f68 <kerneltrap+0x38>

0000000080001ffc <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001ffc:	1101                	addi	sp,sp,-32
    80001ffe:	ec06                	sd	ra,24(sp)
    80002000:	e822                	sd	s0,16(sp)
    80002002:	e426                	sd	s1,8(sp)
    80002004:	1000                	addi	s0,sp,32
    80002006:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002008:	fffff097          	auipc	ra,0xfffff
    8000200c:	f84080e7          	jalr	-124(ra) # 80000f8c <myproc>
  switch (n) {
    80002010:	4795                	li	a5,5
    80002012:	0497e163          	bltu	a5,s1,80002054 <argraw+0x58>
    80002016:	048a                	slli	s1,s1,0x2
    80002018:	00006717          	auipc	a4,0x6
    8000201c:	76070713          	addi	a4,a4,1888 # 80008778 <states.0+0x30>
    80002020:	94ba                	add	s1,s1,a4
    80002022:	409c                	lw	a5,0(s1)
    80002024:	97ba                	add	a5,a5,a4
    80002026:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002028:	6d3c                	ld	a5,88(a0)
    8000202a:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    8000202c:	60e2                	ld	ra,24(sp)
    8000202e:	6442                	ld	s0,16(sp)
    80002030:	64a2                	ld	s1,8(sp)
    80002032:	6105                	addi	sp,sp,32
    80002034:	8082                	ret
    return p->trapframe->a1;
    80002036:	6d3c                	ld	a5,88(a0)
    80002038:	7fa8                	ld	a0,120(a5)
    8000203a:	bfcd                	j	8000202c <argraw+0x30>
    return p->trapframe->a2;
    8000203c:	6d3c                	ld	a5,88(a0)
    8000203e:	63c8                	ld	a0,128(a5)
    80002040:	b7f5                	j	8000202c <argraw+0x30>
    return p->trapframe->a3;
    80002042:	6d3c                	ld	a5,88(a0)
    80002044:	67c8                	ld	a0,136(a5)
    80002046:	b7dd                	j	8000202c <argraw+0x30>
    return p->trapframe->a4;
    80002048:	6d3c                	ld	a5,88(a0)
    8000204a:	6bc8                	ld	a0,144(a5)
    8000204c:	b7c5                	j	8000202c <argraw+0x30>
    return p->trapframe->a5;
    8000204e:	6d3c                	ld	a5,88(a0)
    80002050:	6fc8                	ld	a0,152(a5)
    80002052:	bfe9                	j	8000202c <argraw+0x30>
  panic("argraw");
    80002054:	00006517          	auipc	a0,0x6
    80002058:	34c50513          	addi	a0,a0,844 # 800083a0 <etext+0x3a0>
    8000205c:	00004097          	auipc	ra,0x4
    80002060:	e96080e7          	jalr	-362(ra) # 80005ef2 <panic>

0000000080002064 <fetchaddr>:
{
    80002064:	1101                	addi	sp,sp,-32
    80002066:	ec06                	sd	ra,24(sp)
    80002068:	e822                	sd	s0,16(sp)
    8000206a:	e426                	sd	s1,8(sp)
    8000206c:	e04a                	sd	s2,0(sp)
    8000206e:	1000                	addi	s0,sp,32
    80002070:	84aa                	mv	s1,a0
    80002072:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002074:	fffff097          	auipc	ra,0xfffff
    80002078:	f18080e7          	jalr	-232(ra) # 80000f8c <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    8000207c:	653c                	ld	a5,72(a0)
    8000207e:	02f4f863          	bgeu	s1,a5,800020ae <fetchaddr+0x4a>
    80002082:	00848713          	addi	a4,s1,8
    80002086:	02e7e663          	bltu	a5,a4,800020b2 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    8000208a:	46a1                	li	a3,8
    8000208c:	8626                	mv	a2,s1
    8000208e:	85ca                	mv	a1,s2
    80002090:	6928                	ld	a0,80(a0)
    80002092:	fffff097          	auipc	ra,0xfffff
    80002096:	b48080e7          	jalr	-1208(ra) # 80000bda <copyin>
    8000209a:	00a03533          	snez	a0,a0
    8000209e:	40a0053b          	negw	a0,a0
}
    800020a2:	60e2                	ld	ra,24(sp)
    800020a4:	6442                	ld	s0,16(sp)
    800020a6:	64a2                	ld	s1,8(sp)
    800020a8:	6902                	ld	s2,0(sp)
    800020aa:	6105                	addi	sp,sp,32
    800020ac:	8082                	ret
    return -1;
    800020ae:	557d                	li	a0,-1
    800020b0:	bfcd                	j	800020a2 <fetchaddr+0x3e>
    800020b2:	557d                	li	a0,-1
    800020b4:	b7fd                	j	800020a2 <fetchaddr+0x3e>

00000000800020b6 <fetchstr>:
{
    800020b6:	7179                	addi	sp,sp,-48
    800020b8:	f406                	sd	ra,40(sp)
    800020ba:	f022                	sd	s0,32(sp)
    800020bc:	ec26                	sd	s1,24(sp)
    800020be:	e84a                	sd	s2,16(sp)
    800020c0:	e44e                	sd	s3,8(sp)
    800020c2:	1800                	addi	s0,sp,48
    800020c4:	892a                	mv	s2,a0
    800020c6:	84ae                	mv	s1,a1
    800020c8:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    800020ca:	fffff097          	auipc	ra,0xfffff
    800020ce:	ec2080e7          	jalr	-318(ra) # 80000f8c <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    800020d2:	86ce                	mv	a3,s3
    800020d4:	864a                	mv	a2,s2
    800020d6:	85a6                	mv	a1,s1
    800020d8:	6928                	ld	a0,80(a0)
    800020da:	fffff097          	auipc	ra,0xfffff
    800020de:	b8e080e7          	jalr	-1138(ra) # 80000c68 <copyinstr>
  if(err < 0)
    800020e2:	00054763          	bltz	a0,800020f0 <fetchstr+0x3a>
  return strlen(buf);
    800020e6:	8526                	mv	a0,s1
    800020e8:	ffffe097          	auipc	ra,0xffffe
    800020ec:	21e080e7          	jalr	542(ra) # 80000306 <strlen>
}
    800020f0:	70a2                	ld	ra,40(sp)
    800020f2:	7402                	ld	s0,32(sp)
    800020f4:	64e2                	ld	s1,24(sp)
    800020f6:	6942                	ld	s2,16(sp)
    800020f8:	69a2                	ld	s3,8(sp)
    800020fa:	6145                	addi	sp,sp,48
    800020fc:	8082                	ret

00000000800020fe <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    800020fe:	1101                	addi	sp,sp,-32
    80002100:	ec06                	sd	ra,24(sp)
    80002102:	e822                	sd	s0,16(sp)
    80002104:	e426                	sd	s1,8(sp)
    80002106:	1000                	addi	s0,sp,32
    80002108:	84ae                	mv	s1,a1
  *ip = argraw(n);
    8000210a:	00000097          	auipc	ra,0x0
    8000210e:	ef2080e7          	jalr	-270(ra) # 80001ffc <argraw>
    80002112:	c088                	sw	a0,0(s1)
  return 0;
}
    80002114:	4501                	li	a0,0
    80002116:	60e2                	ld	ra,24(sp)
    80002118:	6442                	ld	s0,16(sp)
    8000211a:	64a2                	ld	s1,8(sp)
    8000211c:	6105                	addi	sp,sp,32
    8000211e:	8082                	ret

0000000080002120 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002120:	1101                	addi	sp,sp,-32
    80002122:	ec06                	sd	ra,24(sp)
    80002124:	e822                	sd	s0,16(sp)
    80002126:	e426                	sd	s1,8(sp)
    80002128:	1000                	addi	s0,sp,32
    8000212a:	84ae                	mv	s1,a1
  *ip = argraw(n);
    8000212c:	00000097          	auipc	ra,0x0
    80002130:	ed0080e7          	jalr	-304(ra) # 80001ffc <argraw>
    80002134:	e088                	sd	a0,0(s1)
  return 0;
}
    80002136:	4501                	li	a0,0
    80002138:	60e2                	ld	ra,24(sp)
    8000213a:	6442                	ld	s0,16(sp)
    8000213c:	64a2                	ld	s1,8(sp)
    8000213e:	6105                	addi	sp,sp,32
    80002140:	8082                	ret

0000000080002142 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002142:	1101                	addi	sp,sp,-32
    80002144:	ec06                	sd	ra,24(sp)
    80002146:	e822                	sd	s0,16(sp)
    80002148:	e426                	sd	s1,8(sp)
    8000214a:	e04a                	sd	s2,0(sp)
    8000214c:	1000                	addi	s0,sp,32
    8000214e:	84ae                	mv	s1,a1
    80002150:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002152:	00000097          	auipc	ra,0x0
    80002156:	eaa080e7          	jalr	-342(ra) # 80001ffc <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    8000215a:	864a                	mv	a2,s2
    8000215c:	85a6                	mv	a1,s1
    8000215e:	00000097          	auipc	ra,0x0
    80002162:	f58080e7          	jalr	-168(ra) # 800020b6 <fetchstr>
}
    80002166:	60e2                	ld	ra,24(sp)
    80002168:	6442                	ld	s0,16(sp)
    8000216a:	64a2                	ld	s1,8(sp)
    8000216c:	6902                	ld	s2,0(sp)
    8000216e:	6105                	addi	sp,sp,32
    80002170:	8082                	ret

0000000080002172 <syscall>:



void
syscall(void)
{
    80002172:	1101                	addi	sp,sp,-32
    80002174:	ec06                	sd	ra,24(sp)
    80002176:	e822                	sd	s0,16(sp)
    80002178:	e426                	sd	s1,8(sp)
    8000217a:	e04a                	sd	s2,0(sp)
    8000217c:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    8000217e:	fffff097          	auipc	ra,0xfffff
    80002182:	e0e080e7          	jalr	-498(ra) # 80000f8c <myproc>
    80002186:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002188:	05853903          	ld	s2,88(a0)
    8000218c:	0a893783          	ld	a5,168(s2)
    80002190:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002194:	37fd                	addiw	a5,a5,-1
    80002196:	4775                	li	a4,29
    80002198:	00f76f63          	bltu	a4,a5,800021b6 <syscall+0x44>
    8000219c:	00369713          	slli	a4,a3,0x3
    800021a0:	00006797          	auipc	a5,0x6
    800021a4:	5f078793          	addi	a5,a5,1520 # 80008790 <syscalls>
    800021a8:	97ba                	add	a5,a5,a4
    800021aa:	639c                	ld	a5,0(a5)
    800021ac:	c789                	beqz	a5,800021b6 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    800021ae:	9782                	jalr	a5
    800021b0:	06a93823          	sd	a0,112(s2)
    800021b4:	a839                	j	800021d2 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    800021b6:	15848613          	addi	a2,s1,344
    800021ba:	588c                	lw	a1,48(s1)
    800021bc:	00006517          	auipc	a0,0x6
    800021c0:	1ec50513          	addi	a0,a0,492 # 800083a8 <etext+0x3a8>
    800021c4:	00004097          	auipc	ra,0x4
    800021c8:	d78080e7          	jalr	-648(ra) # 80005f3c <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800021cc:	6cbc                	ld	a5,88(s1)
    800021ce:	577d                	li	a4,-1
    800021d0:	fbb8                	sd	a4,112(a5)
  }
}
    800021d2:	60e2                	ld	ra,24(sp)
    800021d4:	6442                	ld	s0,16(sp)
    800021d6:	64a2                	ld	s1,8(sp)
    800021d8:	6902                	ld	s2,0(sp)
    800021da:	6105                	addi	sp,sp,32
    800021dc:	8082                	ret

00000000800021de <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800021de:	1101                	addi	sp,sp,-32
    800021e0:	ec06                	sd	ra,24(sp)
    800021e2:	e822                	sd	s0,16(sp)
    800021e4:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800021e6:	fec40593          	addi	a1,s0,-20
    800021ea:	4501                	li	a0,0
    800021ec:	00000097          	auipc	ra,0x0
    800021f0:	f12080e7          	jalr	-238(ra) # 800020fe <argint>
    return -1;
    800021f4:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800021f6:	00054963          	bltz	a0,80002208 <sys_exit+0x2a>
  exit(n);
    800021fa:	fec42503          	lw	a0,-20(s0)
    800021fe:	fffff097          	auipc	ra,0xfffff
    80002202:	75e080e7          	jalr	1886(ra) # 8000195c <exit>
  return 0;  // not reached
    80002206:	4781                	li	a5,0
}
    80002208:	853e                	mv	a0,a5
    8000220a:	60e2                	ld	ra,24(sp)
    8000220c:	6442                	ld	s0,16(sp)
    8000220e:	6105                	addi	sp,sp,32
    80002210:	8082                	ret

0000000080002212 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002212:	1141                	addi	sp,sp,-16
    80002214:	e406                	sd	ra,8(sp)
    80002216:	e022                	sd	s0,0(sp)
    80002218:	0800                	addi	s0,sp,16
  return myproc()->pid;
    8000221a:	fffff097          	auipc	ra,0xfffff
    8000221e:	d72080e7          	jalr	-654(ra) # 80000f8c <myproc>
}
    80002222:	5908                	lw	a0,48(a0)
    80002224:	60a2                	ld	ra,8(sp)
    80002226:	6402                	ld	s0,0(sp)
    80002228:	0141                	addi	sp,sp,16
    8000222a:	8082                	ret

000000008000222c <sys_fork>:

uint64
sys_fork(void)
{
    8000222c:	1141                	addi	sp,sp,-16
    8000222e:	e406                	sd	ra,8(sp)
    80002230:	e022                	sd	s0,0(sp)
    80002232:	0800                	addi	s0,sp,16
  return fork();
    80002234:	fffff097          	auipc	ra,0xfffff
    80002238:	1de080e7          	jalr	478(ra) # 80001412 <fork>
}
    8000223c:	60a2                	ld	ra,8(sp)
    8000223e:	6402                	ld	s0,0(sp)
    80002240:	0141                	addi	sp,sp,16
    80002242:	8082                	ret

0000000080002244 <sys_wait>:

uint64
sys_wait(void)
{
    80002244:	1101                	addi	sp,sp,-32
    80002246:	ec06                	sd	ra,24(sp)
    80002248:	e822                	sd	s0,16(sp)
    8000224a:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    8000224c:	fe840593          	addi	a1,s0,-24
    80002250:	4501                	li	a0,0
    80002252:	00000097          	auipc	ra,0x0
    80002256:	ece080e7          	jalr	-306(ra) # 80002120 <argaddr>
    8000225a:	87aa                	mv	a5,a0
    return -1;
    8000225c:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    8000225e:	0007c863          	bltz	a5,8000226e <sys_wait+0x2a>
  return wait(p);
    80002262:	fe843503          	ld	a0,-24(s0)
    80002266:	fffff097          	auipc	ra,0xfffff
    8000226a:	504080e7          	jalr	1284(ra) # 8000176a <wait>
}
    8000226e:	60e2                	ld	ra,24(sp)
    80002270:	6442                	ld	s0,16(sp)
    80002272:	6105                	addi	sp,sp,32
    80002274:	8082                	ret

0000000080002276 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002276:	7179                	addi	sp,sp,-48
    80002278:	f406                	sd	ra,40(sp)
    8000227a:	f022                	sd	s0,32(sp)
    8000227c:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    8000227e:	fdc40593          	addi	a1,s0,-36
    80002282:	4501                	li	a0,0
    80002284:	00000097          	auipc	ra,0x0
    80002288:	e7a080e7          	jalr	-390(ra) # 800020fe <argint>
    8000228c:	87aa                	mv	a5,a0
    return -1;
    8000228e:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002290:	0207c263          	bltz	a5,800022b4 <sys_sbrk+0x3e>
    80002294:	ec26                	sd	s1,24(sp)
  
  addr = myproc()->sz;
    80002296:	fffff097          	auipc	ra,0xfffff
    8000229a:	cf6080e7          	jalr	-778(ra) # 80000f8c <myproc>
    8000229e:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    800022a0:	fdc42503          	lw	a0,-36(s0)
    800022a4:	fffff097          	auipc	ra,0xfffff
    800022a8:	0f6080e7          	jalr	246(ra) # 8000139a <growproc>
    800022ac:	00054863          	bltz	a0,800022bc <sys_sbrk+0x46>
    return -1;
  return addr;
    800022b0:	8526                	mv	a0,s1
    800022b2:	64e2                	ld	s1,24(sp)
}
    800022b4:	70a2                	ld	ra,40(sp)
    800022b6:	7402                	ld	s0,32(sp)
    800022b8:	6145                	addi	sp,sp,48
    800022ba:	8082                	ret
    return -1;
    800022bc:	557d                	li	a0,-1
    800022be:	64e2                	ld	s1,24(sp)
    800022c0:	bfd5                	j	800022b4 <sys_sbrk+0x3e>

00000000800022c2 <sys_sleep>:

uint64
sys_sleep(void)
{
    800022c2:	7139                	addi	sp,sp,-64
    800022c4:	fc06                	sd	ra,56(sp)
    800022c6:	f822                	sd	s0,48(sp)
    800022c8:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  if(argint(0, &n) < 0)
    800022ca:	fcc40593          	addi	a1,s0,-52
    800022ce:	4501                	li	a0,0
    800022d0:	00000097          	auipc	ra,0x0
    800022d4:	e2e080e7          	jalr	-466(ra) # 800020fe <argint>
    return -1;
    800022d8:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800022da:	06054b63          	bltz	a0,80002350 <sys_sleep+0x8e>
    800022de:	f04a                	sd	s2,32(sp)
  acquire(&tickslock);
    800022e0:	0000d517          	auipc	a0,0xd
    800022e4:	da050513          	addi	a0,a0,-608 # 8000f080 <tickslock>
    800022e8:	00004097          	auipc	ra,0x4
    800022ec:	18a080e7          	jalr	394(ra) # 80006472 <acquire>
  ticks0 = ticks;
    800022f0:	00007917          	auipc	s2,0x7
    800022f4:	d2892903          	lw	s2,-728(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    800022f8:	fcc42783          	lw	a5,-52(s0)
    800022fc:	c3a1                	beqz	a5,8000233c <sys_sleep+0x7a>
    800022fe:	f426                	sd	s1,40(sp)
    80002300:	ec4e                	sd	s3,24(sp)
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002302:	0000d997          	auipc	s3,0xd
    80002306:	d7e98993          	addi	s3,s3,-642 # 8000f080 <tickslock>
    8000230a:	00007497          	auipc	s1,0x7
    8000230e:	d0e48493          	addi	s1,s1,-754 # 80009018 <ticks>
    if(myproc()->killed){
    80002312:	fffff097          	auipc	ra,0xfffff
    80002316:	c7a080e7          	jalr	-902(ra) # 80000f8c <myproc>
    8000231a:	551c                	lw	a5,40(a0)
    8000231c:	ef9d                	bnez	a5,8000235a <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    8000231e:	85ce                	mv	a1,s3
    80002320:	8526                	mv	a0,s1
    80002322:	fffff097          	auipc	ra,0xfffff
    80002326:	3e4080e7          	jalr	996(ra) # 80001706 <sleep>
  while(ticks - ticks0 < n){
    8000232a:	409c                	lw	a5,0(s1)
    8000232c:	412787bb          	subw	a5,a5,s2
    80002330:	fcc42703          	lw	a4,-52(s0)
    80002334:	fce7efe3          	bltu	a5,a4,80002312 <sys_sleep+0x50>
    80002338:	74a2                	ld	s1,40(sp)
    8000233a:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    8000233c:	0000d517          	auipc	a0,0xd
    80002340:	d4450513          	addi	a0,a0,-700 # 8000f080 <tickslock>
    80002344:	00004097          	auipc	ra,0x4
    80002348:	1de080e7          	jalr	478(ra) # 80006522 <release>
  return 0;
    8000234c:	4781                	li	a5,0
    8000234e:	7902                	ld	s2,32(sp)
}
    80002350:	853e                	mv	a0,a5
    80002352:	70e2                	ld	ra,56(sp)
    80002354:	7442                	ld	s0,48(sp)
    80002356:	6121                	addi	sp,sp,64
    80002358:	8082                	ret
      release(&tickslock);
    8000235a:	0000d517          	auipc	a0,0xd
    8000235e:	d2650513          	addi	a0,a0,-730 # 8000f080 <tickslock>
    80002362:	00004097          	auipc	ra,0x4
    80002366:	1c0080e7          	jalr	448(ra) # 80006522 <release>
      return -1;
    8000236a:	57fd                	li	a5,-1
    8000236c:	74a2                	ld	s1,40(sp)
    8000236e:	7902                	ld	s2,32(sp)
    80002370:	69e2                	ld	s3,24(sp)
    80002372:	bff9                	j	80002350 <sys_sleep+0x8e>

0000000080002374 <sys_pgaccess>:


#ifdef LAB_PGTBL
int
sys_pgaccess(void)
{
    80002374:	711d                	addi	sp,sp,-96
    80002376:	ec86                	sd	ra,88(sp)
    80002378:	e8a2                	sd	s0,80(sp)
    8000237a:	e0ca                	sd	s2,64(sp)
    8000237c:	fc4e                	sd	s3,56(sp)
    8000237e:	1080                	addi	s0,sp,96
  pagetable_t pg = myproc()->pagetable;
    80002380:	fffff097          	auipc	ra,0xfffff
    80002384:	c0c080e7          	jalr	-1012(ra) # 80000f8c <myproc>
    80002388:	05053983          	ld	s3,80(a0)
  uint64 addr;
  argaddr(0, &addr);
    8000238c:	fb840593          	addi	a1,s0,-72
    80002390:	4501                	li	a0,0
    80002392:	00000097          	auipc	ra,0x0
    80002396:	d8e080e7          	jalr	-626(ra) # 80002120 <argaddr>
  int num;
  argint(1, &num);
    8000239a:	fb440593          	addi	a1,s0,-76
    8000239e:	4505                	li	a0,1
    800023a0:	00000097          	auipc	ra,0x0
    800023a4:	d5e080e7          	jalr	-674(ra) # 800020fe <argint>
  uint64 dst;
  argaddr(2, &dst);
    800023a8:	fa840593          	addi	a1,s0,-88
    800023ac:	4509                	li	a0,2
    800023ae:	00000097          	auipc	ra,0x0
    800023b2:	d72080e7          	jalr	-654(ra) # 80002120 <argaddr>
  uint64 va = addr;
    800023b6:	fb843903          	ld	s2,-72(s0)
  uint64 abits = 0;
    800023ba:	fa043023          	sd	zero,-96(s0)
  pte_t *pte;
  for (int i = 0; i < num; i++, va += PGSIZE)
    800023be:	fb442783          	lw	a5,-76(s0)
    800023c2:	04f05a63          	blez	a5,80002416 <sys_pgaccess+0xa2>
    800023c6:	e4a6                	sd	s1,72(sp)
    800023c8:	f852                	sd	s4,48(sp)
    800023ca:	f456                	sd	s5,40(sp)
    800023cc:	4481                	li	s1,0
  {
    if (((pte = walk(pg, va, 0)) != 0) && (*pte & PTE_A))
    {
      abits |= (1 << i);
    800023ce:	4a85                	li	s5,1
  for (int i = 0; i < num; i++, va += PGSIZE)
    800023d0:	6a05                	lui	s4,0x1
    800023d2:	a819                	j	800023e8 <sys_pgaccess+0x74>
    }
    *pte = *pte & (~PTE_A);
    800023d4:	611c                	ld	a5,0(a0)
    800023d6:	fbf7f793          	andi	a5,a5,-65
    800023da:	e11c                	sd	a5,0(a0)
  for (int i = 0; i < num; i++, va += PGSIZE)
    800023dc:	2485                	addiw	s1,s1,1
    800023de:	9952                	add	s2,s2,s4
    800023e0:	fb442783          	lw	a5,-76(s0)
    800023e4:	02f4d663          	bge	s1,a5,80002410 <sys_pgaccess+0x9c>
    if (((pte = walk(pg, va, 0)) != 0) && (*pte & PTE_A))
    800023e8:	4601                	li	a2,0
    800023ea:	85ca                	mv	a1,s2
    800023ec:	854e                	mv	a0,s3
    800023ee:	ffffe097          	auipc	ra,0xffffe
    800023f2:	084080e7          	jalr	132(ra) # 80000472 <walk>
    800023f6:	dd79                	beqz	a0,800023d4 <sys_pgaccess+0x60>
    800023f8:	611c                	ld	a5,0(a0)
    800023fa:	0407f793          	andi	a5,a5,64
    800023fe:	dbf9                	beqz	a5,800023d4 <sys_pgaccess+0x60>
      abits |= (1 << i);
    80002400:	009a973b          	sllw	a4,s5,s1
    80002404:	fa043783          	ld	a5,-96(s0)
    80002408:	8fd9                	or	a5,a5,a4
    8000240a:	faf43023          	sd	a5,-96(s0)
    8000240e:	b7d9                	j	800023d4 <sys_pgaccess+0x60>
    80002410:	64a6                	ld	s1,72(sp)
    80002412:	7a42                	ld	s4,48(sp)
    80002414:	7aa2                	ld	s5,40(sp)
  }
  copyout(pg, dst, (char*)&abits, sizeof(abits));
    80002416:	46a1                	li	a3,8
    80002418:	fa040613          	addi	a2,s0,-96
    8000241c:	fa843583          	ld	a1,-88(s0)
    80002420:	854e                	mv	a0,s3
    80002422:	ffffe097          	auipc	ra,0xffffe
    80002426:	72c080e7          	jalr	1836(ra) # 80000b4e <copyout>
  return 0;
}
    8000242a:	4501                	li	a0,0
    8000242c:	60e6                	ld	ra,88(sp)
    8000242e:	6446                	ld	s0,80(sp)
    80002430:	6906                	ld	s2,64(sp)
    80002432:	79e2                	ld	s3,56(sp)
    80002434:	6125                	addi	sp,sp,96
    80002436:	8082                	ret

0000000080002438 <sys_kill>:
#endif

uint64
sys_kill(void)
{
    80002438:	1101                	addi	sp,sp,-32
    8000243a:	ec06                	sd	ra,24(sp)
    8000243c:	e822                	sd	s0,16(sp)
    8000243e:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002440:	fec40593          	addi	a1,s0,-20
    80002444:	4501                	li	a0,0
    80002446:	00000097          	auipc	ra,0x0
    8000244a:	cb8080e7          	jalr	-840(ra) # 800020fe <argint>
    8000244e:	87aa                	mv	a5,a0
    return -1;
    80002450:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002452:	0007c863          	bltz	a5,80002462 <sys_kill+0x2a>
  return kill(pid);
    80002456:	fec42503          	lw	a0,-20(s0)
    8000245a:	fffff097          	auipc	ra,0xfffff
    8000245e:	5d8080e7          	jalr	1496(ra) # 80001a32 <kill>
}
    80002462:	60e2                	ld	ra,24(sp)
    80002464:	6442                	ld	s0,16(sp)
    80002466:	6105                	addi	sp,sp,32
    80002468:	8082                	ret

000000008000246a <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000246a:	1101                	addi	sp,sp,-32
    8000246c:	ec06                	sd	ra,24(sp)
    8000246e:	e822                	sd	s0,16(sp)
    80002470:	e426                	sd	s1,8(sp)
    80002472:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002474:	0000d517          	auipc	a0,0xd
    80002478:	c0c50513          	addi	a0,a0,-1012 # 8000f080 <tickslock>
    8000247c:	00004097          	auipc	ra,0x4
    80002480:	ff6080e7          	jalr	-10(ra) # 80006472 <acquire>
  xticks = ticks;
    80002484:	00007497          	auipc	s1,0x7
    80002488:	b944a483          	lw	s1,-1132(s1) # 80009018 <ticks>
  release(&tickslock);
    8000248c:	0000d517          	auipc	a0,0xd
    80002490:	bf450513          	addi	a0,a0,-1036 # 8000f080 <tickslock>
    80002494:	00004097          	auipc	ra,0x4
    80002498:	08e080e7          	jalr	142(ra) # 80006522 <release>
  return xticks;
}
    8000249c:	02049513          	slli	a0,s1,0x20
    800024a0:	9101                	srli	a0,a0,0x20
    800024a2:	60e2                	ld	ra,24(sp)
    800024a4:	6442                	ld	s0,16(sp)
    800024a6:	64a2                	ld	s1,8(sp)
    800024a8:	6105                	addi	sp,sp,32
    800024aa:	8082                	ret

00000000800024ac <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800024ac:	7179                	addi	sp,sp,-48
    800024ae:	f406                	sd	ra,40(sp)
    800024b0:	f022                	sd	s0,32(sp)
    800024b2:	ec26                	sd	s1,24(sp)
    800024b4:	e84a                	sd	s2,16(sp)
    800024b6:	e44e                	sd	s3,8(sp)
    800024b8:	e052                	sd	s4,0(sp)
    800024ba:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800024bc:	00006597          	auipc	a1,0x6
    800024c0:	f0c58593          	addi	a1,a1,-244 # 800083c8 <etext+0x3c8>
    800024c4:	0000d517          	auipc	a0,0xd
    800024c8:	bd450513          	addi	a0,a0,-1068 # 8000f098 <bcache>
    800024cc:	00004097          	auipc	ra,0x4
    800024d0:	f12080e7          	jalr	-238(ra) # 800063de <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800024d4:	00015797          	auipc	a5,0x15
    800024d8:	bc478793          	addi	a5,a5,-1084 # 80017098 <bcache+0x8000>
    800024dc:	00015717          	auipc	a4,0x15
    800024e0:	e2470713          	addi	a4,a4,-476 # 80017300 <bcache+0x8268>
    800024e4:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    800024e8:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800024ec:	0000d497          	auipc	s1,0xd
    800024f0:	bc448493          	addi	s1,s1,-1084 # 8000f0b0 <bcache+0x18>
    b->next = bcache.head.next;
    800024f4:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800024f6:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800024f8:	00006a17          	auipc	s4,0x6
    800024fc:	ed8a0a13          	addi	s4,s4,-296 # 800083d0 <etext+0x3d0>
    b->next = bcache.head.next;
    80002500:	2b893783          	ld	a5,696(s2)
    80002504:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002506:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000250a:	85d2                	mv	a1,s4
    8000250c:	01048513          	addi	a0,s1,16
    80002510:	00001097          	auipc	ra,0x1
    80002514:	4ba080e7          	jalr	1210(ra) # 800039ca <initsleeplock>
    bcache.head.next->prev = b;
    80002518:	2b893783          	ld	a5,696(s2)
    8000251c:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    8000251e:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002522:	45848493          	addi	s1,s1,1112
    80002526:	fd349de3          	bne	s1,s3,80002500 <binit+0x54>
  }
}
    8000252a:	70a2                	ld	ra,40(sp)
    8000252c:	7402                	ld	s0,32(sp)
    8000252e:	64e2                	ld	s1,24(sp)
    80002530:	6942                	ld	s2,16(sp)
    80002532:	69a2                	ld	s3,8(sp)
    80002534:	6a02                	ld	s4,0(sp)
    80002536:	6145                	addi	sp,sp,48
    80002538:	8082                	ret

000000008000253a <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000253a:	7179                	addi	sp,sp,-48
    8000253c:	f406                	sd	ra,40(sp)
    8000253e:	f022                	sd	s0,32(sp)
    80002540:	ec26                	sd	s1,24(sp)
    80002542:	e84a                	sd	s2,16(sp)
    80002544:	e44e                	sd	s3,8(sp)
    80002546:	1800                	addi	s0,sp,48
    80002548:	892a                	mv	s2,a0
    8000254a:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    8000254c:	0000d517          	auipc	a0,0xd
    80002550:	b4c50513          	addi	a0,a0,-1204 # 8000f098 <bcache>
    80002554:	00004097          	auipc	ra,0x4
    80002558:	f1e080e7          	jalr	-226(ra) # 80006472 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000255c:	00015497          	auipc	s1,0x15
    80002560:	df44b483          	ld	s1,-524(s1) # 80017350 <bcache+0x82b8>
    80002564:	00015797          	auipc	a5,0x15
    80002568:	d9c78793          	addi	a5,a5,-612 # 80017300 <bcache+0x8268>
    8000256c:	02f48f63          	beq	s1,a5,800025aa <bread+0x70>
    80002570:	873e                	mv	a4,a5
    80002572:	a021                	j	8000257a <bread+0x40>
    80002574:	68a4                	ld	s1,80(s1)
    80002576:	02e48a63          	beq	s1,a4,800025aa <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    8000257a:	449c                	lw	a5,8(s1)
    8000257c:	ff279ce3          	bne	a5,s2,80002574 <bread+0x3a>
    80002580:	44dc                	lw	a5,12(s1)
    80002582:	ff3799e3          	bne	a5,s3,80002574 <bread+0x3a>
      b->refcnt++;
    80002586:	40bc                	lw	a5,64(s1)
    80002588:	2785                	addiw	a5,a5,1
    8000258a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000258c:	0000d517          	auipc	a0,0xd
    80002590:	b0c50513          	addi	a0,a0,-1268 # 8000f098 <bcache>
    80002594:	00004097          	auipc	ra,0x4
    80002598:	f8e080e7          	jalr	-114(ra) # 80006522 <release>
      acquiresleep(&b->lock);
    8000259c:	01048513          	addi	a0,s1,16
    800025a0:	00001097          	auipc	ra,0x1
    800025a4:	464080e7          	jalr	1124(ra) # 80003a04 <acquiresleep>
      return b;
    800025a8:	a8b9                	j	80002606 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800025aa:	00015497          	auipc	s1,0x15
    800025ae:	d9e4b483          	ld	s1,-610(s1) # 80017348 <bcache+0x82b0>
    800025b2:	00015797          	auipc	a5,0x15
    800025b6:	d4e78793          	addi	a5,a5,-690 # 80017300 <bcache+0x8268>
    800025ba:	00f48863          	beq	s1,a5,800025ca <bread+0x90>
    800025be:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800025c0:	40bc                	lw	a5,64(s1)
    800025c2:	cf81                	beqz	a5,800025da <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800025c4:	64a4                	ld	s1,72(s1)
    800025c6:	fee49de3          	bne	s1,a4,800025c0 <bread+0x86>
  panic("bget: no buffers");
    800025ca:	00006517          	auipc	a0,0x6
    800025ce:	e0e50513          	addi	a0,a0,-498 # 800083d8 <etext+0x3d8>
    800025d2:	00004097          	auipc	ra,0x4
    800025d6:	920080e7          	jalr	-1760(ra) # 80005ef2 <panic>
      b->dev = dev;
    800025da:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800025de:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800025e2:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800025e6:	4785                	li	a5,1
    800025e8:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800025ea:	0000d517          	auipc	a0,0xd
    800025ee:	aae50513          	addi	a0,a0,-1362 # 8000f098 <bcache>
    800025f2:	00004097          	auipc	ra,0x4
    800025f6:	f30080e7          	jalr	-208(ra) # 80006522 <release>
      acquiresleep(&b->lock);
    800025fa:	01048513          	addi	a0,s1,16
    800025fe:	00001097          	auipc	ra,0x1
    80002602:	406080e7          	jalr	1030(ra) # 80003a04 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002606:	409c                	lw	a5,0(s1)
    80002608:	cb89                	beqz	a5,8000261a <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000260a:	8526                	mv	a0,s1
    8000260c:	70a2                	ld	ra,40(sp)
    8000260e:	7402                	ld	s0,32(sp)
    80002610:	64e2                	ld	s1,24(sp)
    80002612:	6942                	ld	s2,16(sp)
    80002614:	69a2                	ld	s3,8(sp)
    80002616:	6145                	addi	sp,sp,48
    80002618:	8082                	ret
    virtio_disk_rw(b, 0);
    8000261a:	4581                	li	a1,0
    8000261c:	8526                	mv	a0,s1
    8000261e:	00003097          	auipc	ra,0x3
    80002622:	040080e7          	jalr	64(ra) # 8000565e <virtio_disk_rw>
    b->valid = 1;
    80002626:	4785                	li	a5,1
    80002628:	c09c                	sw	a5,0(s1)
  return b;
    8000262a:	b7c5                	j	8000260a <bread+0xd0>

000000008000262c <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000262c:	1101                	addi	sp,sp,-32
    8000262e:	ec06                	sd	ra,24(sp)
    80002630:	e822                	sd	s0,16(sp)
    80002632:	e426                	sd	s1,8(sp)
    80002634:	1000                	addi	s0,sp,32
    80002636:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002638:	0541                	addi	a0,a0,16
    8000263a:	00001097          	auipc	ra,0x1
    8000263e:	464080e7          	jalr	1124(ra) # 80003a9e <holdingsleep>
    80002642:	cd01                	beqz	a0,8000265a <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002644:	4585                	li	a1,1
    80002646:	8526                	mv	a0,s1
    80002648:	00003097          	auipc	ra,0x3
    8000264c:	016080e7          	jalr	22(ra) # 8000565e <virtio_disk_rw>
}
    80002650:	60e2                	ld	ra,24(sp)
    80002652:	6442                	ld	s0,16(sp)
    80002654:	64a2                	ld	s1,8(sp)
    80002656:	6105                	addi	sp,sp,32
    80002658:	8082                	ret
    panic("bwrite");
    8000265a:	00006517          	auipc	a0,0x6
    8000265e:	d9650513          	addi	a0,a0,-618 # 800083f0 <etext+0x3f0>
    80002662:	00004097          	auipc	ra,0x4
    80002666:	890080e7          	jalr	-1904(ra) # 80005ef2 <panic>

000000008000266a <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000266a:	1101                	addi	sp,sp,-32
    8000266c:	ec06                	sd	ra,24(sp)
    8000266e:	e822                	sd	s0,16(sp)
    80002670:	e426                	sd	s1,8(sp)
    80002672:	e04a                	sd	s2,0(sp)
    80002674:	1000                	addi	s0,sp,32
    80002676:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002678:	01050913          	addi	s2,a0,16
    8000267c:	854a                	mv	a0,s2
    8000267e:	00001097          	auipc	ra,0x1
    80002682:	420080e7          	jalr	1056(ra) # 80003a9e <holdingsleep>
    80002686:	c535                	beqz	a0,800026f2 <brelse+0x88>
    panic("brelse");

  releasesleep(&b->lock);
    80002688:	854a                	mv	a0,s2
    8000268a:	00001097          	auipc	ra,0x1
    8000268e:	3d0080e7          	jalr	976(ra) # 80003a5a <releasesleep>

  acquire(&bcache.lock);
    80002692:	0000d517          	auipc	a0,0xd
    80002696:	a0650513          	addi	a0,a0,-1530 # 8000f098 <bcache>
    8000269a:	00004097          	auipc	ra,0x4
    8000269e:	dd8080e7          	jalr	-552(ra) # 80006472 <acquire>
  b->refcnt--;
    800026a2:	40bc                	lw	a5,64(s1)
    800026a4:	37fd                	addiw	a5,a5,-1
    800026a6:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800026a8:	e79d                	bnez	a5,800026d6 <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800026aa:	68b8                	ld	a4,80(s1)
    800026ac:	64bc                	ld	a5,72(s1)
    800026ae:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    800026b0:	68b8                	ld	a4,80(s1)
    800026b2:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800026b4:	00015797          	auipc	a5,0x15
    800026b8:	9e478793          	addi	a5,a5,-1564 # 80017098 <bcache+0x8000>
    800026bc:	2b87b703          	ld	a4,696(a5)
    800026c0:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800026c2:	00015717          	auipc	a4,0x15
    800026c6:	c3e70713          	addi	a4,a4,-962 # 80017300 <bcache+0x8268>
    800026ca:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800026cc:	2b87b703          	ld	a4,696(a5)
    800026d0:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800026d2:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800026d6:	0000d517          	auipc	a0,0xd
    800026da:	9c250513          	addi	a0,a0,-1598 # 8000f098 <bcache>
    800026de:	00004097          	auipc	ra,0x4
    800026e2:	e44080e7          	jalr	-444(ra) # 80006522 <release>
}
    800026e6:	60e2                	ld	ra,24(sp)
    800026e8:	6442                	ld	s0,16(sp)
    800026ea:	64a2                	ld	s1,8(sp)
    800026ec:	6902                	ld	s2,0(sp)
    800026ee:	6105                	addi	sp,sp,32
    800026f0:	8082                	ret
    panic("brelse");
    800026f2:	00006517          	auipc	a0,0x6
    800026f6:	d0650513          	addi	a0,a0,-762 # 800083f8 <etext+0x3f8>
    800026fa:	00003097          	auipc	ra,0x3
    800026fe:	7f8080e7          	jalr	2040(ra) # 80005ef2 <panic>

0000000080002702 <bpin>:

void
bpin(struct buf *b) {
    80002702:	1101                	addi	sp,sp,-32
    80002704:	ec06                	sd	ra,24(sp)
    80002706:	e822                	sd	s0,16(sp)
    80002708:	e426                	sd	s1,8(sp)
    8000270a:	1000                	addi	s0,sp,32
    8000270c:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000270e:	0000d517          	auipc	a0,0xd
    80002712:	98a50513          	addi	a0,a0,-1654 # 8000f098 <bcache>
    80002716:	00004097          	auipc	ra,0x4
    8000271a:	d5c080e7          	jalr	-676(ra) # 80006472 <acquire>
  b->refcnt++;
    8000271e:	40bc                	lw	a5,64(s1)
    80002720:	2785                	addiw	a5,a5,1
    80002722:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002724:	0000d517          	auipc	a0,0xd
    80002728:	97450513          	addi	a0,a0,-1676 # 8000f098 <bcache>
    8000272c:	00004097          	auipc	ra,0x4
    80002730:	df6080e7          	jalr	-522(ra) # 80006522 <release>
}
    80002734:	60e2                	ld	ra,24(sp)
    80002736:	6442                	ld	s0,16(sp)
    80002738:	64a2                	ld	s1,8(sp)
    8000273a:	6105                	addi	sp,sp,32
    8000273c:	8082                	ret

000000008000273e <bunpin>:

void
bunpin(struct buf *b) {
    8000273e:	1101                	addi	sp,sp,-32
    80002740:	ec06                	sd	ra,24(sp)
    80002742:	e822                	sd	s0,16(sp)
    80002744:	e426                	sd	s1,8(sp)
    80002746:	1000                	addi	s0,sp,32
    80002748:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000274a:	0000d517          	auipc	a0,0xd
    8000274e:	94e50513          	addi	a0,a0,-1714 # 8000f098 <bcache>
    80002752:	00004097          	auipc	ra,0x4
    80002756:	d20080e7          	jalr	-736(ra) # 80006472 <acquire>
  b->refcnt--;
    8000275a:	40bc                	lw	a5,64(s1)
    8000275c:	37fd                	addiw	a5,a5,-1
    8000275e:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002760:	0000d517          	auipc	a0,0xd
    80002764:	93850513          	addi	a0,a0,-1736 # 8000f098 <bcache>
    80002768:	00004097          	auipc	ra,0x4
    8000276c:	dba080e7          	jalr	-582(ra) # 80006522 <release>
}
    80002770:	60e2                	ld	ra,24(sp)
    80002772:	6442                	ld	s0,16(sp)
    80002774:	64a2                	ld	s1,8(sp)
    80002776:	6105                	addi	sp,sp,32
    80002778:	8082                	ret

000000008000277a <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    8000277a:	1101                	addi	sp,sp,-32
    8000277c:	ec06                	sd	ra,24(sp)
    8000277e:	e822                	sd	s0,16(sp)
    80002780:	e426                	sd	s1,8(sp)
    80002782:	e04a                	sd	s2,0(sp)
    80002784:	1000                	addi	s0,sp,32
    80002786:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002788:	00d5d79b          	srliw	a5,a1,0xd
    8000278c:	00015597          	auipc	a1,0x15
    80002790:	fe85a583          	lw	a1,-24(a1) # 80017774 <sb+0x1c>
    80002794:	9dbd                	addw	a1,a1,a5
    80002796:	00000097          	auipc	ra,0x0
    8000279a:	da4080e7          	jalr	-604(ra) # 8000253a <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    8000279e:	0074f713          	andi	a4,s1,7
    800027a2:	4785                	li	a5,1
    800027a4:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    800027a8:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    800027aa:	90d9                	srli	s1,s1,0x36
    800027ac:	00950733          	add	a4,a0,s1
    800027b0:	05874703          	lbu	a4,88(a4)
    800027b4:	00e7f6b3          	and	a3,a5,a4
    800027b8:	c69d                	beqz	a3,800027e6 <bfree+0x6c>
    800027ba:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800027bc:	94aa                	add	s1,s1,a0
    800027be:	fff7c793          	not	a5,a5
    800027c2:	8f7d                	and	a4,a4,a5
    800027c4:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800027c8:	00001097          	auipc	ra,0x1
    800027cc:	11e080e7          	jalr	286(ra) # 800038e6 <log_write>
  brelse(bp);
    800027d0:	854a                	mv	a0,s2
    800027d2:	00000097          	auipc	ra,0x0
    800027d6:	e98080e7          	jalr	-360(ra) # 8000266a <brelse>
}
    800027da:	60e2                	ld	ra,24(sp)
    800027dc:	6442                	ld	s0,16(sp)
    800027de:	64a2                	ld	s1,8(sp)
    800027e0:	6902                	ld	s2,0(sp)
    800027e2:	6105                	addi	sp,sp,32
    800027e4:	8082                	ret
    panic("freeing free block");
    800027e6:	00006517          	auipc	a0,0x6
    800027ea:	c1a50513          	addi	a0,a0,-998 # 80008400 <etext+0x400>
    800027ee:	00003097          	auipc	ra,0x3
    800027f2:	704080e7          	jalr	1796(ra) # 80005ef2 <panic>

00000000800027f6 <balloc>:
{
    800027f6:	715d                	addi	sp,sp,-80
    800027f8:	e486                	sd	ra,72(sp)
    800027fa:	e0a2                	sd	s0,64(sp)
    800027fc:	fc26                	sd	s1,56(sp)
    800027fe:	f84a                	sd	s2,48(sp)
    80002800:	f44e                	sd	s3,40(sp)
    80002802:	f052                	sd	s4,32(sp)
    80002804:	ec56                	sd	s5,24(sp)
    80002806:	e85a                	sd	s6,16(sp)
    80002808:	e45e                	sd	s7,8(sp)
    8000280a:	e062                	sd	s8,0(sp)
    8000280c:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    8000280e:	00015797          	auipc	a5,0x15
    80002812:	f4e7a783          	lw	a5,-178(a5) # 8001775c <sb+0x4>
    80002816:	c7c1                	beqz	a5,8000289e <balloc+0xa8>
    80002818:	8baa                	mv	s7,a0
    8000281a:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    8000281c:	00015b17          	auipc	s6,0x15
    80002820:	f3cb0b13          	addi	s6,s6,-196 # 80017758 <sb>
      m = 1 << (bi % 8);
    80002824:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002826:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002828:	6c09                	lui	s8,0x2
    8000282a:	a821                	j	80002842 <balloc+0x4c>
    brelse(bp);
    8000282c:	854a                	mv	a0,s2
    8000282e:	00000097          	auipc	ra,0x0
    80002832:	e3c080e7          	jalr	-452(ra) # 8000266a <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002836:	015c0abb          	addw	s5,s8,s5
    8000283a:	004b2783          	lw	a5,4(s6)
    8000283e:	06faf063          	bgeu	s5,a5,8000289e <balloc+0xa8>
    bp = bread(dev, BBLOCK(b, sb));
    80002842:	41fad79b          	sraiw	a5,s5,0x1f
    80002846:	0137d79b          	srliw	a5,a5,0x13
    8000284a:	015787bb          	addw	a5,a5,s5
    8000284e:	40d7d79b          	sraiw	a5,a5,0xd
    80002852:	01cb2583          	lw	a1,28(s6)
    80002856:	9dbd                	addw	a1,a1,a5
    80002858:	855e                	mv	a0,s7
    8000285a:	00000097          	auipc	ra,0x0
    8000285e:	ce0080e7          	jalr	-800(ra) # 8000253a <bread>
    80002862:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002864:	004b2503          	lw	a0,4(s6)
    80002868:	84d6                	mv	s1,s5
    8000286a:	4701                	li	a4,0
    8000286c:	fca4f0e3          	bgeu	s1,a0,8000282c <balloc+0x36>
      m = 1 << (bi % 8);
    80002870:	00777693          	andi	a3,a4,7
    80002874:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002878:	41f7579b          	sraiw	a5,a4,0x1f
    8000287c:	01d7d79b          	srliw	a5,a5,0x1d
    80002880:	9fb9                	addw	a5,a5,a4
    80002882:	4037d79b          	sraiw	a5,a5,0x3
    80002886:	00f90633          	add	a2,s2,a5
    8000288a:	05864603          	lbu	a2,88(a2)
    8000288e:	00c6f5b3          	and	a1,a3,a2
    80002892:	cd91                	beqz	a1,800028ae <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002894:	2705                	addiw	a4,a4,1
    80002896:	2485                	addiw	s1,s1,1
    80002898:	fd471ae3          	bne	a4,s4,8000286c <balloc+0x76>
    8000289c:	bf41                	j	8000282c <balloc+0x36>
  panic("balloc: out of blocks");
    8000289e:	00006517          	auipc	a0,0x6
    800028a2:	b7a50513          	addi	a0,a0,-1158 # 80008418 <etext+0x418>
    800028a6:	00003097          	auipc	ra,0x3
    800028aa:	64c080e7          	jalr	1612(ra) # 80005ef2 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800028ae:	97ca                	add	a5,a5,s2
    800028b0:	8e55                	or	a2,a2,a3
    800028b2:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    800028b6:	854a                	mv	a0,s2
    800028b8:	00001097          	auipc	ra,0x1
    800028bc:	02e080e7          	jalr	46(ra) # 800038e6 <log_write>
        brelse(bp);
    800028c0:	854a                	mv	a0,s2
    800028c2:	00000097          	auipc	ra,0x0
    800028c6:	da8080e7          	jalr	-600(ra) # 8000266a <brelse>
  bp = bread(dev, bno);
    800028ca:	85a6                	mv	a1,s1
    800028cc:	855e                	mv	a0,s7
    800028ce:	00000097          	auipc	ra,0x0
    800028d2:	c6c080e7          	jalr	-916(ra) # 8000253a <bread>
    800028d6:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800028d8:	40000613          	li	a2,1024
    800028dc:	4581                	li	a1,0
    800028de:	05850513          	addi	a0,a0,88
    800028e2:	ffffe097          	auipc	ra,0xffffe
    800028e6:	898080e7          	jalr	-1896(ra) # 8000017a <memset>
  log_write(bp);
    800028ea:	854a                	mv	a0,s2
    800028ec:	00001097          	auipc	ra,0x1
    800028f0:	ffa080e7          	jalr	-6(ra) # 800038e6 <log_write>
  brelse(bp);
    800028f4:	854a                	mv	a0,s2
    800028f6:	00000097          	auipc	ra,0x0
    800028fa:	d74080e7          	jalr	-652(ra) # 8000266a <brelse>
}
    800028fe:	8526                	mv	a0,s1
    80002900:	60a6                	ld	ra,72(sp)
    80002902:	6406                	ld	s0,64(sp)
    80002904:	74e2                	ld	s1,56(sp)
    80002906:	7942                	ld	s2,48(sp)
    80002908:	79a2                	ld	s3,40(sp)
    8000290a:	7a02                	ld	s4,32(sp)
    8000290c:	6ae2                	ld	s5,24(sp)
    8000290e:	6b42                	ld	s6,16(sp)
    80002910:	6ba2                	ld	s7,8(sp)
    80002912:	6c02                	ld	s8,0(sp)
    80002914:	6161                	addi	sp,sp,80
    80002916:	8082                	ret

0000000080002918 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    80002918:	7179                	addi	sp,sp,-48
    8000291a:	f406                	sd	ra,40(sp)
    8000291c:	f022                	sd	s0,32(sp)
    8000291e:	ec26                	sd	s1,24(sp)
    80002920:	e84a                	sd	s2,16(sp)
    80002922:	e44e                	sd	s3,8(sp)
    80002924:	1800                	addi	s0,sp,48
    80002926:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    80002928:	47ad                	li	a5,11
    8000292a:	04b7fd63          	bgeu	a5,a1,80002984 <bmap+0x6c>
    8000292e:	e052                	sd	s4,0(sp)
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002930:	ff45849b          	addiw	s1,a1,-12

  if(bn < NINDIRECT){
    80002934:	0ff00793          	li	a5,255
    80002938:	0897ef63          	bltu	a5,s1,800029d6 <bmap+0xbe>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    8000293c:	08052583          	lw	a1,128(a0)
    80002940:	c5a5                	beqz	a1,800029a8 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80002942:	00092503          	lw	a0,0(s2)
    80002946:	00000097          	auipc	ra,0x0
    8000294a:	bf4080e7          	jalr	-1036(ra) # 8000253a <bread>
    8000294e:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002950:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002954:	02049713          	slli	a4,s1,0x20
    80002958:	01e75593          	srli	a1,a4,0x1e
    8000295c:	00b784b3          	add	s1,a5,a1
    80002960:	0004a983          	lw	s3,0(s1)
    80002964:	04098b63          	beqz	s3,800029ba <bmap+0xa2>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80002968:	8552                	mv	a0,s4
    8000296a:	00000097          	auipc	ra,0x0
    8000296e:	d00080e7          	jalr	-768(ra) # 8000266a <brelse>
    return addr;
    80002972:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    80002974:	854e                	mv	a0,s3
    80002976:	70a2                	ld	ra,40(sp)
    80002978:	7402                	ld	s0,32(sp)
    8000297a:	64e2                	ld	s1,24(sp)
    8000297c:	6942                	ld	s2,16(sp)
    8000297e:	69a2                	ld	s3,8(sp)
    80002980:	6145                	addi	sp,sp,48
    80002982:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80002984:	02059793          	slli	a5,a1,0x20
    80002988:	01e7d593          	srli	a1,a5,0x1e
    8000298c:	00b504b3          	add	s1,a0,a1
    80002990:	0504a983          	lw	s3,80(s1)
    80002994:	fe0990e3          	bnez	s3,80002974 <bmap+0x5c>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80002998:	4108                	lw	a0,0(a0)
    8000299a:	00000097          	auipc	ra,0x0
    8000299e:	e5c080e7          	jalr	-420(ra) # 800027f6 <balloc>
    800029a2:	89aa                	mv	s3,a0
    800029a4:	c8a8                	sw	a0,80(s1)
    800029a6:	b7f9                	j	80002974 <bmap+0x5c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800029a8:	4108                	lw	a0,0(a0)
    800029aa:	00000097          	auipc	ra,0x0
    800029ae:	e4c080e7          	jalr	-436(ra) # 800027f6 <balloc>
    800029b2:	85aa                	mv	a1,a0
    800029b4:	08a92023          	sw	a0,128(s2)
    800029b8:	b769                	j	80002942 <bmap+0x2a>
      a[bn] = addr = balloc(ip->dev);
    800029ba:	00092503          	lw	a0,0(s2)
    800029be:	00000097          	auipc	ra,0x0
    800029c2:	e38080e7          	jalr	-456(ra) # 800027f6 <balloc>
    800029c6:	89aa                	mv	s3,a0
    800029c8:	c088                	sw	a0,0(s1)
      log_write(bp);
    800029ca:	8552                	mv	a0,s4
    800029cc:	00001097          	auipc	ra,0x1
    800029d0:	f1a080e7          	jalr	-230(ra) # 800038e6 <log_write>
    800029d4:	bf51                	j	80002968 <bmap+0x50>
  panic("bmap: out of range");
    800029d6:	00006517          	auipc	a0,0x6
    800029da:	a5a50513          	addi	a0,a0,-1446 # 80008430 <etext+0x430>
    800029de:	00003097          	auipc	ra,0x3
    800029e2:	514080e7          	jalr	1300(ra) # 80005ef2 <panic>

00000000800029e6 <iget>:
{
    800029e6:	7179                	addi	sp,sp,-48
    800029e8:	f406                	sd	ra,40(sp)
    800029ea:	f022                	sd	s0,32(sp)
    800029ec:	ec26                	sd	s1,24(sp)
    800029ee:	e84a                	sd	s2,16(sp)
    800029f0:	e44e                	sd	s3,8(sp)
    800029f2:	e052                	sd	s4,0(sp)
    800029f4:	1800                	addi	s0,sp,48
    800029f6:	89aa                	mv	s3,a0
    800029f8:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800029fa:	00015517          	auipc	a0,0x15
    800029fe:	d7e50513          	addi	a0,a0,-642 # 80017778 <itable>
    80002a02:	00004097          	auipc	ra,0x4
    80002a06:	a70080e7          	jalr	-1424(ra) # 80006472 <acquire>
  empty = 0;
    80002a0a:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002a0c:	00015497          	auipc	s1,0x15
    80002a10:	d8448493          	addi	s1,s1,-636 # 80017790 <itable+0x18>
    80002a14:	00017697          	auipc	a3,0x17
    80002a18:	80c68693          	addi	a3,a3,-2036 # 80019220 <log>
    80002a1c:	a039                	j	80002a2a <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002a1e:	02090b63          	beqz	s2,80002a54 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002a22:	08848493          	addi	s1,s1,136
    80002a26:	02d48a63          	beq	s1,a3,80002a5a <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    80002a2a:	449c                	lw	a5,8(s1)
    80002a2c:	fef059e3          	blez	a5,80002a1e <iget+0x38>
    80002a30:	4098                	lw	a4,0(s1)
    80002a32:	ff3716e3          	bne	a4,s3,80002a1e <iget+0x38>
    80002a36:	40d8                	lw	a4,4(s1)
    80002a38:	ff4713e3          	bne	a4,s4,80002a1e <iget+0x38>
      ip->ref++;
    80002a3c:	2785                	addiw	a5,a5,1
    80002a3e:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002a40:	00015517          	auipc	a0,0x15
    80002a44:	d3850513          	addi	a0,a0,-712 # 80017778 <itable>
    80002a48:	00004097          	auipc	ra,0x4
    80002a4c:	ada080e7          	jalr	-1318(ra) # 80006522 <release>
      return ip;
    80002a50:	8926                	mv	s2,s1
    80002a52:	a03d                	j	80002a80 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002a54:	f7f9                	bnez	a5,80002a22 <iget+0x3c>
      empty = ip;
    80002a56:	8926                	mv	s2,s1
    80002a58:	b7e9                	j	80002a22 <iget+0x3c>
  if(empty == 0)
    80002a5a:	02090c63          	beqz	s2,80002a92 <iget+0xac>
  ip->dev = dev;
    80002a5e:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002a62:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002a66:	4785                	li	a5,1
    80002a68:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002a6c:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002a70:	00015517          	auipc	a0,0x15
    80002a74:	d0850513          	addi	a0,a0,-760 # 80017778 <itable>
    80002a78:	00004097          	auipc	ra,0x4
    80002a7c:	aaa080e7          	jalr	-1366(ra) # 80006522 <release>
}
    80002a80:	854a                	mv	a0,s2
    80002a82:	70a2                	ld	ra,40(sp)
    80002a84:	7402                	ld	s0,32(sp)
    80002a86:	64e2                	ld	s1,24(sp)
    80002a88:	6942                	ld	s2,16(sp)
    80002a8a:	69a2                	ld	s3,8(sp)
    80002a8c:	6a02                	ld	s4,0(sp)
    80002a8e:	6145                	addi	sp,sp,48
    80002a90:	8082                	ret
    panic("iget: no inodes");
    80002a92:	00006517          	auipc	a0,0x6
    80002a96:	9b650513          	addi	a0,a0,-1610 # 80008448 <etext+0x448>
    80002a9a:	00003097          	auipc	ra,0x3
    80002a9e:	458080e7          	jalr	1112(ra) # 80005ef2 <panic>

0000000080002aa2 <fsinit>:
fsinit(int dev) {
    80002aa2:	7179                	addi	sp,sp,-48
    80002aa4:	f406                	sd	ra,40(sp)
    80002aa6:	f022                	sd	s0,32(sp)
    80002aa8:	ec26                	sd	s1,24(sp)
    80002aaa:	e84a                	sd	s2,16(sp)
    80002aac:	e44e                	sd	s3,8(sp)
    80002aae:	1800                	addi	s0,sp,48
    80002ab0:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002ab2:	4585                	li	a1,1
    80002ab4:	00000097          	auipc	ra,0x0
    80002ab8:	a86080e7          	jalr	-1402(ra) # 8000253a <bread>
    80002abc:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002abe:	00015997          	auipc	s3,0x15
    80002ac2:	c9a98993          	addi	s3,s3,-870 # 80017758 <sb>
    80002ac6:	02000613          	li	a2,32
    80002aca:	05850593          	addi	a1,a0,88
    80002ace:	854e                	mv	a0,s3
    80002ad0:	ffffd097          	auipc	ra,0xffffd
    80002ad4:	70e080e7          	jalr	1806(ra) # 800001de <memmove>
  brelse(bp);
    80002ad8:	8526                	mv	a0,s1
    80002ada:	00000097          	auipc	ra,0x0
    80002ade:	b90080e7          	jalr	-1136(ra) # 8000266a <brelse>
  if(sb.magic != FSMAGIC)
    80002ae2:	0009a703          	lw	a4,0(s3)
    80002ae6:	102037b7          	lui	a5,0x10203
    80002aea:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002aee:	02f71263          	bne	a4,a5,80002b12 <fsinit+0x70>
  initlog(dev, &sb);
    80002af2:	00015597          	auipc	a1,0x15
    80002af6:	c6658593          	addi	a1,a1,-922 # 80017758 <sb>
    80002afa:	854a                	mv	a0,s2
    80002afc:	00001097          	auipc	ra,0x1
    80002b00:	b74080e7          	jalr	-1164(ra) # 80003670 <initlog>
}
    80002b04:	70a2                	ld	ra,40(sp)
    80002b06:	7402                	ld	s0,32(sp)
    80002b08:	64e2                	ld	s1,24(sp)
    80002b0a:	6942                	ld	s2,16(sp)
    80002b0c:	69a2                	ld	s3,8(sp)
    80002b0e:	6145                	addi	sp,sp,48
    80002b10:	8082                	ret
    panic("invalid file system");
    80002b12:	00006517          	auipc	a0,0x6
    80002b16:	94650513          	addi	a0,a0,-1722 # 80008458 <etext+0x458>
    80002b1a:	00003097          	auipc	ra,0x3
    80002b1e:	3d8080e7          	jalr	984(ra) # 80005ef2 <panic>

0000000080002b22 <iinit>:
{
    80002b22:	7179                	addi	sp,sp,-48
    80002b24:	f406                	sd	ra,40(sp)
    80002b26:	f022                	sd	s0,32(sp)
    80002b28:	ec26                	sd	s1,24(sp)
    80002b2a:	e84a                	sd	s2,16(sp)
    80002b2c:	e44e                	sd	s3,8(sp)
    80002b2e:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002b30:	00006597          	auipc	a1,0x6
    80002b34:	94058593          	addi	a1,a1,-1728 # 80008470 <etext+0x470>
    80002b38:	00015517          	auipc	a0,0x15
    80002b3c:	c4050513          	addi	a0,a0,-960 # 80017778 <itable>
    80002b40:	00004097          	auipc	ra,0x4
    80002b44:	89e080e7          	jalr	-1890(ra) # 800063de <initlock>
  for(i = 0; i < NINODE; i++) {
    80002b48:	00015497          	auipc	s1,0x15
    80002b4c:	c5848493          	addi	s1,s1,-936 # 800177a0 <itable+0x28>
    80002b50:	00016997          	auipc	s3,0x16
    80002b54:	6e098993          	addi	s3,s3,1760 # 80019230 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002b58:	00006917          	auipc	s2,0x6
    80002b5c:	92090913          	addi	s2,s2,-1760 # 80008478 <etext+0x478>
    80002b60:	85ca                	mv	a1,s2
    80002b62:	8526                	mv	a0,s1
    80002b64:	00001097          	auipc	ra,0x1
    80002b68:	e66080e7          	jalr	-410(ra) # 800039ca <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002b6c:	08848493          	addi	s1,s1,136
    80002b70:	ff3498e3          	bne	s1,s3,80002b60 <iinit+0x3e>
}
    80002b74:	70a2                	ld	ra,40(sp)
    80002b76:	7402                	ld	s0,32(sp)
    80002b78:	64e2                	ld	s1,24(sp)
    80002b7a:	6942                	ld	s2,16(sp)
    80002b7c:	69a2                	ld	s3,8(sp)
    80002b7e:	6145                	addi	sp,sp,48
    80002b80:	8082                	ret

0000000080002b82 <ialloc>:
{
    80002b82:	7139                	addi	sp,sp,-64
    80002b84:	fc06                	sd	ra,56(sp)
    80002b86:	f822                	sd	s0,48(sp)
    80002b88:	f426                	sd	s1,40(sp)
    80002b8a:	f04a                	sd	s2,32(sp)
    80002b8c:	ec4e                	sd	s3,24(sp)
    80002b8e:	e852                	sd	s4,16(sp)
    80002b90:	e456                	sd	s5,8(sp)
    80002b92:	e05a                	sd	s6,0(sp)
    80002b94:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002b96:	00015717          	auipc	a4,0x15
    80002b9a:	bce72703          	lw	a4,-1074(a4) # 80017764 <sb+0xc>
    80002b9e:	4785                	li	a5,1
    80002ba0:	04e7f863          	bgeu	a5,a4,80002bf0 <ialloc+0x6e>
    80002ba4:	8aaa                	mv	s5,a0
    80002ba6:	8b2e                	mv	s6,a1
    80002ba8:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    80002baa:	00015a17          	auipc	s4,0x15
    80002bae:	baea0a13          	addi	s4,s4,-1106 # 80017758 <sb>
    80002bb2:	00495593          	srli	a1,s2,0x4
    80002bb6:	018a2783          	lw	a5,24(s4)
    80002bba:	9dbd                	addw	a1,a1,a5
    80002bbc:	8556                	mv	a0,s5
    80002bbe:	00000097          	auipc	ra,0x0
    80002bc2:	97c080e7          	jalr	-1668(ra) # 8000253a <bread>
    80002bc6:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002bc8:	05850993          	addi	s3,a0,88
    80002bcc:	00f97793          	andi	a5,s2,15
    80002bd0:	079a                	slli	a5,a5,0x6
    80002bd2:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002bd4:	00099783          	lh	a5,0(s3)
    80002bd8:	c785                	beqz	a5,80002c00 <ialloc+0x7e>
    brelse(bp);
    80002bda:	00000097          	auipc	ra,0x0
    80002bde:	a90080e7          	jalr	-1392(ra) # 8000266a <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002be2:	0905                	addi	s2,s2,1
    80002be4:	00ca2703          	lw	a4,12(s4)
    80002be8:	0009079b          	sext.w	a5,s2
    80002bec:	fce7e3e3          	bltu	a5,a4,80002bb2 <ialloc+0x30>
  panic("ialloc: no inodes");
    80002bf0:	00006517          	auipc	a0,0x6
    80002bf4:	89050513          	addi	a0,a0,-1904 # 80008480 <etext+0x480>
    80002bf8:	00003097          	auipc	ra,0x3
    80002bfc:	2fa080e7          	jalr	762(ra) # 80005ef2 <panic>
      memset(dip, 0, sizeof(*dip));
    80002c00:	04000613          	li	a2,64
    80002c04:	4581                	li	a1,0
    80002c06:	854e                	mv	a0,s3
    80002c08:	ffffd097          	auipc	ra,0xffffd
    80002c0c:	572080e7          	jalr	1394(ra) # 8000017a <memset>
      dip->type = type;
    80002c10:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    80002c14:	8526                	mv	a0,s1
    80002c16:	00001097          	auipc	ra,0x1
    80002c1a:	cd0080e7          	jalr	-816(ra) # 800038e6 <log_write>
      brelse(bp);
    80002c1e:	8526                	mv	a0,s1
    80002c20:	00000097          	auipc	ra,0x0
    80002c24:	a4a080e7          	jalr	-1462(ra) # 8000266a <brelse>
      return iget(dev, inum);
    80002c28:	0009059b          	sext.w	a1,s2
    80002c2c:	8556                	mv	a0,s5
    80002c2e:	00000097          	auipc	ra,0x0
    80002c32:	db8080e7          	jalr	-584(ra) # 800029e6 <iget>
}
    80002c36:	70e2                	ld	ra,56(sp)
    80002c38:	7442                	ld	s0,48(sp)
    80002c3a:	74a2                	ld	s1,40(sp)
    80002c3c:	7902                	ld	s2,32(sp)
    80002c3e:	69e2                	ld	s3,24(sp)
    80002c40:	6a42                	ld	s4,16(sp)
    80002c42:	6aa2                	ld	s5,8(sp)
    80002c44:	6b02                	ld	s6,0(sp)
    80002c46:	6121                	addi	sp,sp,64
    80002c48:	8082                	ret

0000000080002c4a <iupdate>:
{
    80002c4a:	1101                	addi	sp,sp,-32
    80002c4c:	ec06                	sd	ra,24(sp)
    80002c4e:	e822                	sd	s0,16(sp)
    80002c50:	e426                	sd	s1,8(sp)
    80002c52:	e04a                	sd	s2,0(sp)
    80002c54:	1000                	addi	s0,sp,32
    80002c56:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002c58:	415c                	lw	a5,4(a0)
    80002c5a:	0047d79b          	srliw	a5,a5,0x4
    80002c5e:	00015597          	auipc	a1,0x15
    80002c62:	b125a583          	lw	a1,-1262(a1) # 80017770 <sb+0x18>
    80002c66:	9dbd                	addw	a1,a1,a5
    80002c68:	4108                	lw	a0,0(a0)
    80002c6a:	00000097          	auipc	ra,0x0
    80002c6e:	8d0080e7          	jalr	-1840(ra) # 8000253a <bread>
    80002c72:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002c74:	05850793          	addi	a5,a0,88
    80002c78:	40d8                	lw	a4,4(s1)
    80002c7a:	8b3d                	andi	a4,a4,15
    80002c7c:	071a                	slli	a4,a4,0x6
    80002c7e:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002c80:	04449703          	lh	a4,68(s1)
    80002c84:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002c88:	04649703          	lh	a4,70(s1)
    80002c8c:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002c90:	04849703          	lh	a4,72(s1)
    80002c94:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002c98:	04a49703          	lh	a4,74(s1)
    80002c9c:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002ca0:	44f8                	lw	a4,76(s1)
    80002ca2:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002ca4:	03400613          	li	a2,52
    80002ca8:	05048593          	addi	a1,s1,80
    80002cac:	00c78513          	addi	a0,a5,12
    80002cb0:	ffffd097          	auipc	ra,0xffffd
    80002cb4:	52e080e7          	jalr	1326(ra) # 800001de <memmove>
  log_write(bp);
    80002cb8:	854a                	mv	a0,s2
    80002cba:	00001097          	auipc	ra,0x1
    80002cbe:	c2c080e7          	jalr	-980(ra) # 800038e6 <log_write>
  brelse(bp);
    80002cc2:	854a                	mv	a0,s2
    80002cc4:	00000097          	auipc	ra,0x0
    80002cc8:	9a6080e7          	jalr	-1626(ra) # 8000266a <brelse>
}
    80002ccc:	60e2                	ld	ra,24(sp)
    80002cce:	6442                	ld	s0,16(sp)
    80002cd0:	64a2                	ld	s1,8(sp)
    80002cd2:	6902                	ld	s2,0(sp)
    80002cd4:	6105                	addi	sp,sp,32
    80002cd6:	8082                	ret

0000000080002cd8 <idup>:
{
    80002cd8:	1101                	addi	sp,sp,-32
    80002cda:	ec06                	sd	ra,24(sp)
    80002cdc:	e822                	sd	s0,16(sp)
    80002cde:	e426                	sd	s1,8(sp)
    80002ce0:	1000                	addi	s0,sp,32
    80002ce2:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002ce4:	00015517          	auipc	a0,0x15
    80002ce8:	a9450513          	addi	a0,a0,-1388 # 80017778 <itable>
    80002cec:	00003097          	auipc	ra,0x3
    80002cf0:	786080e7          	jalr	1926(ra) # 80006472 <acquire>
  ip->ref++;
    80002cf4:	449c                	lw	a5,8(s1)
    80002cf6:	2785                	addiw	a5,a5,1
    80002cf8:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002cfa:	00015517          	auipc	a0,0x15
    80002cfe:	a7e50513          	addi	a0,a0,-1410 # 80017778 <itable>
    80002d02:	00004097          	auipc	ra,0x4
    80002d06:	820080e7          	jalr	-2016(ra) # 80006522 <release>
}
    80002d0a:	8526                	mv	a0,s1
    80002d0c:	60e2                	ld	ra,24(sp)
    80002d0e:	6442                	ld	s0,16(sp)
    80002d10:	64a2                	ld	s1,8(sp)
    80002d12:	6105                	addi	sp,sp,32
    80002d14:	8082                	ret

0000000080002d16 <ilock>:
{
    80002d16:	1101                	addi	sp,sp,-32
    80002d18:	ec06                	sd	ra,24(sp)
    80002d1a:	e822                	sd	s0,16(sp)
    80002d1c:	e426                	sd	s1,8(sp)
    80002d1e:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002d20:	c10d                	beqz	a0,80002d42 <ilock+0x2c>
    80002d22:	84aa                	mv	s1,a0
    80002d24:	451c                	lw	a5,8(a0)
    80002d26:	00f05e63          	blez	a5,80002d42 <ilock+0x2c>
  acquiresleep(&ip->lock);
    80002d2a:	0541                	addi	a0,a0,16
    80002d2c:	00001097          	auipc	ra,0x1
    80002d30:	cd8080e7          	jalr	-808(ra) # 80003a04 <acquiresleep>
  if(ip->valid == 0){
    80002d34:	40bc                	lw	a5,64(s1)
    80002d36:	cf99                	beqz	a5,80002d54 <ilock+0x3e>
}
    80002d38:	60e2                	ld	ra,24(sp)
    80002d3a:	6442                	ld	s0,16(sp)
    80002d3c:	64a2                	ld	s1,8(sp)
    80002d3e:	6105                	addi	sp,sp,32
    80002d40:	8082                	ret
    80002d42:	e04a                	sd	s2,0(sp)
    panic("ilock");
    80002d44:	00005517          	auipc	a0,0x5
    80002d48:	75450513          	addi	a0,a0,1876 # 80008498 <etext+0x498>
    80002d4c:	00003097          	auipc	ra,0x3
    80002d50:	1a6080e7          	jalr	422(ra) # 80005ef2 <panic>
    80002d54:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002d56:	40dc                	lw	a5,4(s1)
    80002d58:	0047d79b          	srliw	a5,a5,0x4
    80002d5c:	00015597          	auipc	a1,0x15
    80002d60:	a145a583          	lw	a1,-1516(a1) # 80017770 <sb+0x18>
    80002d64:	9dbd                	addw	a1,a1,a5
    80002d66:	4088                	lw	a0,0(s1)
    80002d68:	fffff097          	auipc	ra,0xfffff
    80002d6c:	7d2080e7          	jalr	2002(ra) # 8000253a <bread>
    80002d70:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002d72:	05850593          	addi	a1,a0,88
    80002d76:	40dc                	lw	a5,4(s1)
    80002d78:	8bbd                	andi	a5,a5,15
    80002d7a:	079a                	slli	a5,a5,0x6
    80002d7c:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002d7e:	00059783          	lh	a5,0(a1)
    80002d82:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002d86:	00259783          	lh	a5,2(a1)
    80002d8a:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002d8e:	00459783          	lh	a5,4(a1)
    80002d92:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002d96:	00659783          	lh	a5,6(a1)
    80002d9a:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002d9e:	459c                	lw	a5,8(a1)
    80002da0:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002da2:	03400613          	li	a2,52
    80002da6:	05b1                	addi	a1,a1,12
    80002da8:	05048513          	addi	a0,s1,80
    80002dac:	ffffd097          	auipc	ra,0xffffd
    80002db0:	432080e7          	jalr	1074(ra) # 800001de <memmove>
    brelse(bp);
    80002db4:	854a                	mv	a0,s2
    80002db6:	00000097          	auipc	ra,0x0
    80002dba:	8b4080e7          	jalr	-1868(ra) # 8000266a <brelse>
    ip->valid = 1;
    80002dbe:	4785                	li	a5,1
    80002dc0:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002dc2:	04449783          	lh	a5,68(s1)
    80002dc6:	c399                	beqz	a5,80002dcc <ilock+0xb6>
    80002dc8:	6902                	ld	s2,0(sp)
    80002dca:	b7bd                	j	80002d38 <ilock+0x22>
      panic("ilock: no type");
    80002dcc:	00005517          	auipc	a0,0x5
    80002dd0:	6d450513          	addi	a0,a0,1748 # 800084a0 <etext+0x4a0>
    80002dd4:	00003097          	auipc	ra,0x3
    80002dd8:	11e080e7          	jalr	286(ra) # 80005ef2 <panic>

0000000080002ddc <iunlock>:
{
    80002ddc:	1101                	addi	sp,sp,-32
    80002dde:	ec06                	sd	ra,24(sp)
    80002de0:	e822                	sd	s0,16(sp)
    80002de2:	e426                	sd	s1,8(sp)
    80002de4:	e04a                	sd	s2,0(sp)
    80002de6:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002de8:	c905                	beqz	a0,80002e18 <iunlock+0x3c>
    80002dea:	84aa                	mv	s1,a0
    80002dec:	01050913          	addi	s2,a0,16
    80002df0:	854a                	mv	a0,s2
    80002df2:	00001097          	auipc	ra,0x1
    80002df6:	cac080e7          	jalr	-852(ra) # 80003a9e <holdingsleep>
    80002dfa:	cd19                	beqz	a0,80002e18 <iunlock+0x3c>
    80002dfc:	449c                	lw	a5,8(s1)
    80002dfe:	00f05d63          	blez	a5,80002e18 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002e02:	854a                	mv	a0,s2
    80002e04:	00001097          	auipc	ra,0x1
    80002e08:	c56080e7          	jalr	-938(ra) # 80003a5a <releasesleep>
}
    80002e0c:	60e2                	ld	ra,24(sp)
    80002e0e:	6442                	ld	s0,16(sp)
    80002e10:	64a2                	ld	s1,8(sp)
    80002e12:	6902                	ld	s2,0(sp)
    80002e14:	6105                	addi	sp,sp,32
    80002e16:	8082                	ret
    panic("iunlock");
    80002e18:	00005517          	auipc	a0,0x5
    80002e1c:	69850513          	addi	a0,a0,1688 # 800084b0 <etext+0x4b0>
    80002e20:	00003097          	auipc	ra,0x3
    80002e24:	0d2080e7          	jalr	210(ra) # 80005ef2 <panic>

0000000080002e28 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002e28:	7179                	addi	sp,sp,-48
    80002e2a:	f406                	sd	ra,40(sp)
    80002e2c:	f022                	sd	s0,32(sp)
    80002e2e:	ec26                	sd	s1,24(sp)
    80002e30:	e84a                	sd	s2,16(sp)
    80002e32:	e44e                	sd	s3,8(sp)
    80002e34:	1800                	addi	s0,sp,48
    80002e36:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002e38:	05050493          	addi	s1,a0,80
    80002e3c:	08050913          	addi	s2,a0,128
    80002e40:	a021                	j	80002e48 <itrunc+0x20>
    80002e42:	0491                	addi	s1,s1,4
    80002e44:	01248d63          	beq	s1,s2,80002e5e <itrunc+0x36>
    if(ip->addrs[i]){
    80002e48:	408c                	lw	a1,0(s1)
    80002e4a:	dde5                	beqz	a1,80002e42 <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    80002e4c:	0009a503          	lw	a0,0(s3)
    80002e50:	00000097          	auipc	ra,0x0
    80002e54:	92a080e7          	jalr	-1750(ra) # 8000277a <bfree>
      ip->addrs[i] = 0;
    80002e58:	0004a023          	sw	zero,0(s1)
    80002e5c:	b7dd                	j	80002e42 <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002e5e:	0809a583          	lw	a1,128(s3)
    80002e62:	ed99                	bnez	a1,80002e80 <itrunc+0x58>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002e64:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002e68:	854e                	mv	a0,s3
    80002e6a:	00000097          	auipc	ra,0x0
    80002e6e:	de0080e7          	jalr	-544(ra) # 80002c4a <iupdate>
}
    80002e72:	70a2                	ld	ra,40(sp)
    80002e74:	7402                	ld	s0,32(sp)
    80002e76:	64e2                	ld	s1,24(sp)
    80002e78:	6942                	ld	s2,16(sp)
    80002e7a:	69a2                	ld	s3,8(sp)
    80002e7c:	6145                	addi	sp,sp,48
    80002e7e:	8082                	ret
    80002e80:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002e82:	0009a503          	lw	a0,0(s3)
    80002e86:	fffff097          	auipc	ra,0xfffff
    80002e8a:	6b4080e7          	jalr	1716(ra) # 8000253a <bread>
    80002e8e:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002e90:	05850493          	addi	s1,a0,88
    80002e94:	45850913          	addi	s2,a0,1112
    80002e98:	a021                	j	80002ea0 <itrunc+0x78>
    80002e9a:	0491                	addi	s1,s1,4
    80002e9c:	01248b63          	beq	s1,s2,80002eb2 <itrunc+0x8a>
      if(a[j])
    80002ea0:	408c                	lw	a1,0(s1)
    80002ea2:	dde5                	beqz	a1,80002e9a <itrunc+0x72>
        bfree(ip->dev, a[j]);
    80002ea4:	0009a503          	lw	a0,0(s3)
    80002ea8:	00000097          	auipc	ra,0x0
    80002eac:	8d2080e7          	jalr	-1838(ra) # 8000277a <bfree>
    80002eb0:	b7ed                	j	80002e9a <itrunc+0x72>
    brelse(bp);
    80002eb2:	8552                	mv	a0,s4
    80002eb4:	fffff097          	auipc	ra,0xfffff
    80002eb8:	7b6080e7          	jalr	1974(ra) # 8000266a <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002ebc:	0809a583          	lw	a1,128(s3)
    80002ec0:	0009a503          	lw	a0,0(s3)
    80002ec4:	00000097          	auipc	ra,0x0
    80002ec8:	8b6080e7          	jalr	-1866(ra) # 8000277a <bfree>
    ip->addrs[NDIRECT] = 0;
    80002ecc:	0809a023          	sw	zero,128(s3)
    80002ed0:	6a02                	ld	s4,0(sp)
    80002ed2:	bf49                	j	80002e64 <itrunc+0x3c>

0000000080002ed4 <iput>:
{
    80002ed4:	1101                	addi	sp,sp,-32
    80002ed6:	ec06                	sd	ra,24(sp)
    80002ed8:	e822                	sd	s0,16(sp)
    80002eda:	e426                	sd	s1,8(sp)
    80002edc:	1000                	addi	s0,sp,32
    80002ede:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002ee0:	00015517          	auipc	a0,0x15
    80002ee4:	89850513          	addi	a0,a0,-1896 # 80017778 <itable>
    80002ee8:	00003097          	auipc	ra,0x3
    80002eec:	58a080e7          	jalr	1418(ra) # 80006472 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002ef0:	4498                	lw	a4,8(s1)
    80002ef2:	4785                	li	a5,1
    80002ef4:	02f70263          	beq	a4,a5,80002f18 <iput+0x44>
  ip->ref--;
    80002ef8:	449c                	lw	a5,8(s1)
    80002efa:	37fd                	addiw	a5,a5,-1
    80002efc:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002efe:	00015517          	auipc	a0,0x15
    80002f02:	87a50513          	addi	a0,a0,-1926 # 80017778 <itable>
    80002f06:	00003097          	auipc	ra,0x3
    80002f0a:	61c080e7          	jalr	1564(ra) # 80006522 <release>
}
    80002f0e:	60e2                	ld	ra,24(sp)
    80002f10:	6442                	ld	s0,16(sp)
    80002f12:	64a2                	ld	s1,8(sp)
    80002f14:	6105                	addi	sp,sp,32
    80002f16:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002f18:	40bc                	lw	a5,64(s1)
    80002f1a:	dff9                	beqz	a5,80002ef8 <iput+0x24>
    80002f1c:	04a49783          	lh	a5,74(s1)
    80002f20:	ffe1                	bnez	a5,80002ef8 <iput+0x24>
    80002f22:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    80002f24:	01048913          	addi	s2,s1,16
    80002f28:	854a                	mv	a0,s2
    80002f2a:	00001097          	auipc	ra,0x1
    80002f2e:	ada080e7          	jalr	-1318(ra) # 80003a04 <acquiresleep>
    release(&itable.lock);
    80002f32:	00015517          	auipc	a0,0x15
    80002f36:	84650513          	addi	a0,a0,-1978 # 80017778 <itable>
    80002f3a:	00003097          	auipc	ra,0x3
    80002f3e:	5e8080e7          	jalr	1512(ra) # 80006522 <release>
    itrunc(ip);
    80002f42:	8526                	mv	a0,s1
    80002f44:	00000097          	auipc	ra,0x0
    80002f48:	ee4080e7          	jalr	-284(ra) # 80002e28 <itrunc>
    ip->type = 0;
    80002f4c:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002f50:	8526                	mv	a0,s1
    80002f52:	00000097          	auipc	ra,0x0
    80002f56:	cf8080e7          	jalr	-776(ra) # 80002c4a <iupdate>
    ip->valid = 0;
    80002f5a:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002f5e:	854a                	mv	a0,s2
    80002f60:	00001097          	auipc	ra,0x1
    80002f64:	afa080e7          	jalr	-1286(ra) # 80003a5a <releasesleep>
    acquire(&itable.lock);
    80002f68:	00015517          	auipc	a0,0x15
    80002f6c:	81050513          	addi	a0,a0,-2032 # 80017778 <itable>
    80002f70:	00003097          	auipc	ra,0x3
    80002f74:	502080e7          	jalr	1282(ra) # 80006472 <acquire>
    80002f78:	6902                	ld	s2,0(sp)
    80002f7a:	bfbd                	j	80002ef8 <iput+0x24>

0000000080002f7c <iunlockput>:
{
    80002f7c:	1101                	addi	sp,sp,-32
    80002f7e:	ec06                	sd	ra,24(sp)
    80002f80:	e822                	sd	s0,16(sp)
    80002f82:	e426                	sd	s1,8(sp)
    80002f84:	1000                	addi	s0,sp,32
    80002f86:	84aa                	mv	s1,a0
  iunlock(ip);
    80002f88:	00000097          	auipc	ra,0x0
    80002f8c:	e54080e7          	jalr	-428(ra) # 80002ddc <iunlock>
  iput(ip);
    80002f90:	8526                	mv	a0,s1
    80002f92:	00000097          	auipc	ra,0x0
    80002f96:	f42080e7          	jalr	-190(ra) # 80002ed4 <iput>
}
    80002f9a:	60e2                	ld	ra,24(sp)
    80002f9c:	6442                	ld	s0,16(sp)
    80002f9e:	64a2                	ld	s1,8(sp)
    80002fa0:	6105                	addi	sp,sp,32
    80002fa2:	8082                	ret

0000000080002fa4 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002fa4:	1141                	addi	sp,sp,-16
    80002fa6:	e406                	sd	ra,8(sp)
    80002fa8:	e022                	sd	s0,0(sp)
    80002faa:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002fac:	411c                	lw	a5,0(a0)
    80002fae:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002fb0:	415c                	lw	a5,4(a0)
    80002fb2:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002fb4:	04451783          	lh	a5,68(a0)
    80002fb8:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002fbc:	04a51783          	lh	a5,74(a0)
    80002fc0:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002fc4:	04c56783          	lwu	a5,76(a0)
    80002fc8:	e99c                	sd	a5,16(a1)
}
    80002fca:	60a2                	ld	ra,8(sp)
    80002fcc:	6402                	ld	s0,0(sp)
    80002fce:	0141                	addi	sp,sp,16
    80002fd0:	8082                	ret

0000000080002fd2 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002fd2:	457c                	lw	a5,76(a0)
    80002fd4:	0ed7ea63          	bltu	a5,a3,800030c8 <readi+0xf6>
{
    80002fd8:	7159                	addi	sp,sp,-112
    80002fda:	f486                	sd	ra,104(sp)
    80002fdc:	f0a2                	sd	s0,96(sp)
    80002fde:	eca6                	sd	s1,88(sp)
    80002fe0:	fc56                	sd	s5,56(sp)
    80002fe2:	f85a                	sd	s6,48(sp)
    80002fe4:	f45e                	sd	s7,40(sp)
    80002fe6:	ec66                	sd	s9,24(sp)
    80002fe8:	1880                	addi	s0,sp,112
    80002fea:	8baa                	mv	s7,a0
    80002fec:	8cae                	mv	s9,a1
    80002fee:	8ab2                	mv	s5,a2
    80002ff0:	84b6                	mv	s1,a3
    80002ff2:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002ff4:	9f35                	addw	a4,a4,a3
    return 0;
    80002ff6:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002ff8:	0ad76763          	bltu	a4,a3,800030a6 <readi+0xd4>
    80002ffc:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    80002ffe:	00e7f463          	bgeu	a5,a4,80003006 <readi+0x34>
    n = ip->size - off;
    80003002:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003006:	0a0b0f63          	beqz	s6,800030c4 <readi+0xf2>
    8000300a:	e8ca                	sd	s2,80(sp)
    8000300c:	e0d2                	sd	s4,64(sp)
    8000300e:	f062                	sd	s8,32(sp)
    80003010:	e86a                	sd	s10,16(sp)
    80003012:	e46e                	sd	s11,8(sp)
    80003014:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003016:	40000d93          	li	s11,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    8000301a:	5d7d                	li	s10,-1
    8000301c:	a82d                	j	80003056 <readi+0x84>
    8000301e:	020a1c13          	slli	s8,s4,0x20
    80003022:	020c5c13          	srli	s8,s8,0x20
    80003026:	05890613          	addi	a2,s2,88
    8000302a:	86e2                	mv	a3,s8
    8000302c:	963e                	add	a2,a2,a5
    8000302e:	85d6                	mv	a1,s5
    80003030:	8566                	mv	a0,s9
    80003032:	fffff097          	auipc	ra,0xfffff
    80003036:	a72080e7          	jalr	-1422(ra) # 80001aa4 <either_copyout>
    8000303a:	05a50963          	beq	a0,s10,8000308c <readi+0xba>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    8000303e:	854a                	mv	a0,s2
    80003040:	fffff097          	auipc	ra,0xfffff
    80003044:	62a080e7          	jalr	1578(ra) # 8000266a <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003048:	013a09bb          	addw	s3,s4,s3
    8000304c:	009a04bb          	addw	s1,s4,s1
    80003050:	9ae2                	add	s5,s5,s8
    80003052:	0769f363          	bgeu	s3,s6,800030b8 <readi+0xe6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003056:	000ba903          	lw	s2,0(s7)
    8000305a:	00a4d59b          	srliw	a1,s1,0xa
    8000305e:	855e                	mv	a0,s7
    80003060:	00000097          	auipc	ra,0x0
    80003064:	8b8080e7          	jalr	-1864(ra) # 80002918 <bmap>
    80003068:	85aa                	mv	a1,a0
    8000306a:	854a                	mv	a0,s2
    8000306c:	fffff097          	auipc	ra,0xfffff
    80003070:	4ce080e7          	jalr	1230(ra) # 8000253a <bread>
    80003074:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003076:	3ff4f793          	andi	a5,s1,1023
    8000307a:	40fd873b          	subw	a4,s11,a5
    8000307e:	413b06bb          	subw	a3,s6,s3
    80003082:	8a3a                	mv	s4,a4
    80003084:	f8e6fde3          	bgeu	a3,a4,8000301e <readi+0x4c>
    80003088:	8a36                	mv	s4,a3
    8000308a:	bf51                	j	8000301e <readi+0x4c>
      brelse(bp);
    8000308c:	854a                	mv	a0,s2
    8000308e:	fffff097          	auipc	ra,0xfffff
    80003092:	5dc080e7          	jalr	1500(ra) # 8000266a <brelse>
      tot = -1;
    80003096:	59fd                	li	s3,-1
      break;
    80003098:	6946                	ld	s2,80(sp)
    8000309a:	6a06                	ld	s4,64(sp)
    8000309c:	7c02                	ld	s8,32(sp)
    8000309e:	6d42                	ld	s10,16(sp)
    800030a0:	6da2                	ld	s11,8(sp)
  }
  return tot;
    800030a2:	854e                	mv	a0,s3
    800030a4:	69a6                	ld	s3,72(sp)
}
    800030a6:	70a6                	ld	ra,104(sp)
    800030a8:	7406                	ld	s0,96(sp)
    800030aa:	64e6                	ld	s1,88(sp)
    800030ac:	7ae2                	ld	s5,56(sp)
    800030ae:	7b42                	ld	s6,48(sp)
    800030b0:	7ba2                	ld	s7,40(sp)
    800030b2:	6ce2                	ld	s9,24(sp)
    800030b4:	6165                	addi	sp,sp,112
    800030b6:	8082                	ret
    800030b8:	6946                	ld	s2,80(sp)
    800030ba:	6a06                	ld	s4,64(sp)
    800030bc:	7c02                	ld	s8,32(sp)
    800030be:	6d42                	ld	s10,16(sp)
    800030c0:	6da2                	ld	s11,8(sp)
    800030c2:	b7c5                	j	800030a2 <readi+0xd0>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800030c4:	89da                	mv	s3,s6
    800030c6:	bff1                	j	800030a2 <readi+0xd0>
    return 0;
    800030c8:	4501                	li	a0,0
}
    800030ca:	8082                	ret

00000000800030cc <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800030cc:	457c                	lw	a5,76(a0)
    800030ce:	10d7e963          	bltu	a5,a3,800031e0 <writei+0x114>
{
    800030d2:	7159                	addi	sp,sp,-112
    800030d4:	f486                	sd	ra,104(sp)
    800030d6:	f0a2                	sd	s0,96(sp)
    800030d8:	e8ca                	sd	s2,80(sp)
    800030da:	fc56                	sd	s5,56(sp)
    800030dc:	f45e                	sd	s7,40(sp)
    800030de:	f062                	sd	s8,32(sp)
    800030e0:	ec66                	sd	s9,24(sp)
    800030e2:	1880                	addi	s0,sp,112
    800030e4:	8baa                	mv	s7,a0
    800030e6:	8cae                	mv	s9,a1
    800030e8:	8ab2                	mv	s5,a2
    800030ea:	8936                	mv	s2,a3
    800030ec:	8c3a                	mv	s8,a4
  if(off > ip->size || off + n < off)
    800030ee:	00e687bb          	addw	a5,a3,a4
    800030f2:	0ed7e963          	bltu	a5,a3,800031e4 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    800030f6:	00043737          	lui	a4,0x43
    800030fa:	0ef76763          	bltu	a4,a5,800031e8 <writei+0x11c>
    800030fe:	e0d2                	sd	s4,64(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003100:	0c0c0863          	beqz	s8,800031d0 <writei+0x104>
    80003104:	eca6                	sd	s1,88(sp)
    80003106:	e4ce                	sd	s3,72(sp)
    80003108:	f85a                	sd	s6,48(sp)
    8000310a:	e86a                	sd	s10,16(sp)
    8000310c:	e46e                	sd	s11,8(sp)
    8000310e:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003110:	40000d93          	li	s11,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003114:	5d7d                	li	s10,-1
    80003116:	a091                	j	8000315a <writei+0x8e>
    80003118:	02099b13          	slli	s6,s3,0x20
    8000311c:	020b5b13          	srli	s6,s6,0x20
    80003120:	05848513          	addi	a0,s1,88
    80003124:	86da                	mv	a3,s6
    80003126:	8656                	mv	a2,s5
    80003128:	85e6                	mv	a1,s9
    8000312a:	953e                	add	a0,a0,a5
    8000312c:	fffff097          	auipc	ra,0xfffff
    80003130:	9ce080e7          	jalr	-1586(ra) # 80001afa <either_copyin>
    80003134:	05a50e63          	beq	a0,s10,80003190 <writei+0xc4>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003138:	8526                	mv	a0,s1
    8000313a:	00000097          	auipc	ra,0x0
    8000313e:	7ac080e7          	jalr	1964(ra) # 800038e6 <log_write>
    brelse(bp);
    80003142:	8526                	mv	a0,s1
    80003144:	fffff097          	auipc	ra,0xfffff
    80003148:	526080e7          	jalr	1318(ra) # 8000266a <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000314c:	01498a3b          	addw	s4,s3,s4
    80003150:	0129893b          	addw	s2,s3,s2
    80003154:	9ada                	add	s5,s5,s6
    80003156:	058a7263          	bgeu	s4,s8,8000319a <writei+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000315a:	000ba483          	lw	s1,0(s7)
    8000315e:	00a9559b          	srliw	a1,s2,0xa
    80003162:	855e                	mv	a0,s7
    80003164:	fffff097          	auipc	ra,0xfffff
    80003168:	7b4080e7          	jalr	1972(ra) # 80002918 <bmap>
    8000316c:	85aa                	mv	a1,a0
    8000316e:	8526                	mv	a0,s1
    80003170:	fffff097          	auipc	ra,0xfffff
    80003174:	3ca080e7          	jalr	970(ra) # 8000253a <bread>
    80003178:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000317a:	3ff97793          	andi	a5,s2,1023
    8000317e:	40fd873b          	subw	a4,s11,a5
    80003182:	414c06bb          	subw	a3,s8,s4
    80003186:	89ba                	mv	s3,a4
    80003188:	f8e6f8e3          	bgeu	a3,a4,80003118 <writei+0x4c>
    8000318c:	89b6                	mv	s3,a3
    8000318e:	b769                	j	80003118 <writei+0x4c>
      brelse(bp);
    80003190:	8526                	mv	a0,s1
    80003192:	fffff097          	auipc	ra,0xfffff
    80003196:	4d8080e7          	jalr	1240(ra) # 8000266a <brelse>
  }

  if(off > ip->size)
    8000319a:	04cba783          	lw	a5,76(s7)
    8000319e:	0327fb63          	bgeu	a5,s2,800031d4 <writei+0x108>
    ip->size = off;
    800031a2:	052ba623          	sw	s2,76(s7)
    800031a6:	64e6                	ld	s1,88(sp)
    800031a8:	69a6                	ld	s3,72(sp)
    800031aa:	7b42                	ld	s6,48(sp)
    800031ac:	6d42                	ld	s10,16(sp)
    800031ae:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    800031b0:	855e                	mv	a0,s7
    800031b2:	00000097          	auipc	ra,0x0
    800031b6:	a98080e7          	jalr	-1384(ra) # 80002c4a <iupdate>

  return tot;
    800031ba:	8552                	mv	a0,s4
    800031bc:	6a06                	ld	s4,64(sp)
}
    800031be:	70a6                	ld	ra,104(sp)
    800031c0:	7406                	ld	s0,96(sp)
    800031c2:	6946                	ld	s2,80(sp)
    800031c4:	7ae2                	ld	s5,56(sp)
    800031c6:	7ba2                	ld	s7,40(sp)
    800031c8:	7c02                	ld	s8,32(sp)
    800031ca:	6ce2                	ld	s9,24(sp)
    800031cc:	6165                	addi	sp,sp,112
    800031ce:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800031d0:	8a62                	mv	s4,s8
    800031d2:	bff9                	j	800031b0 <writei+0xe4>
    800031d4:	64e6                	ld	s1,88(sp)
    800031d6:	69a6                	ld	s3,72(sp)
    800031d8:	7b42                	ld	s6,48(sp)
    800031da:	6d42                	ld	s10,16(sp)
    800031dc:	6da2                	ld	s11,8(sp)
    800031de:	bfc9                	j	800031b0 <writei+0xe4>
    return -1;
    800031e0:	557d                	li	a0,-1
}
    800031e2:	8082                	ret
    return -1;
    800031e4:	557d                	li	a0,-1
    800031e6:	bfe1                	j	800031be <writei+0xf2>
    return -1;
    800031e8:	557d                	li	a0,-1
    800031ea:	bfd1                	j	800031be <writei+0xf2>

00000000800031ec <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800031ec:	1141                	addi	sp,sp,-16
    800031ee:	e406                	sd	ra,8(sp)
    800031f0:	e022                	sd	s0,0(sp)
    800031f2:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800031f4:	4639                	li	a2,14
    800031f6:	ffffd097          	auipc	ra,0xffffd
    800031fa:	060080e7          	jalr	96(ra) # 80000256 <strncmp>
}
    800031fe:	60a2                	ld	ra,8(sp)
    80003200:	6402                	ld	s0,0(sp)
    80003202:	0141                	addi	sp,sp,16
    80003204:	8082                	ret

0000000080003206 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003206:	711d                	addi	sp,sp,-96
    80003208:	ec86                	sd	ra,88(sp)
    8000320a:	e8a2                	sd	s0,80(sp)
    8000320c:	e4a6                	sd	s1,72(sp)
    8000320e:	e0ca                	sd	s2,64(sp)
    80003210:	fc4e                	sd	s3,56(sp)
    80003212:	f852                	sd	s4,48(sp)
    80003214:	f456                	sd	s5,40(sp)
    80003216:	f05a                	sd	s6,32(sp)
    80003218:	ec5e                	sd	s7,24(sp)
    8000321a:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    8000321c:	04451703          	lh	a4,68(a0)
    80003220:	4785                	li	a5,1
    80003222:	00f71f63          	bne	a4,a5,80003240 <dirlookup+0x3a>
    80003226:	892a                	mv	s2,a0
    80003228:	8aae                	mv	s5,a1
    8000322a:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    8000322c:	457c                	lw	a5,76(a0)
    8000322e:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003230:	fa040a13          	addi	s4,s0,-96
    80003234:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80003236:	fa240b13          	addi	s6,s0,-94
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    8000323a:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000323c:	e79d                	bnez	a5,8000326a <dirlookup+0x64>
    8000323e:	a88d                	j	800032b0 <dirlookup+0xaa>
    panic("dirlookup not DIR");
    80003240:	00005517          	auipc	a0,0x5
    80003244:	27850513          	addi	a0,a0,632 # 800084b8 <etext+0x4b8>
    80003248:	00003097          	auipc	ra,0x3
    8000324c:	caa080e7          	jalr	-854(ra) # 80005ef2 <panic>
      panic("dirlookup read");
    80003250:	00005517          	auipc	a0,0x5
    80003254:	28050513          	addi	a0,a0,640 # 800084d0 <etext+0x4d0>
    80003258:	00003097          	auipc	ra,0x3
    8000325c:	c9a080e7          	jalr	-870(ra) # 80005ef2 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003260:	24c1                	addiw	s1,s1,16
    80003262:	04c92783          	lw	a5,76(s2)
    80003266:	04f4f463          	bgeu	s1,a5,800032ae <dirlookup+0xa8>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000326a:	874e                	mv	a4,s3
    8000326c:	86a6                	mv	a3,s1
    8000326e:	8652                	mv	a2,s4
    80003270:	4581                	li	a1,0
    80003272:	854a                	mv	a0,s2
    80003274:	00000097          	auipc	ra,0x0
    80003278:	d5e080e7          	jalr	-674(ra) # 80002fd2 <readi>
    8000327c:	fd351ae3          	bne	a0,s3,80003250 <dirlookup+0x4a>
    if(de.inum == 0)
    80003280:	fa045783          	lhu	a5,-96(s0)
    80003284:	dff1                	beqz	a5,80003260 <dirlookup+0x5a>
    if(namecmp(name, de.name) == 0){
    80003286:	85da                	mv	a1,s6
    80003288:	8556                	mv	a0,s5
    8000328a:	00000097          	auipc	ra,0x0
    8000328e:	f62080e7          	jalr	-158(ra) # 800031ec <namecmp>
    80003292:	f579                	bnez	a0,80003260 <dirlookup+0x5a>
      if(poff)
    80003294:	000b8463          	beqz	s7,8000329c <dirlookup+0x96>
        *poff = off;
    80003298:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    8000329c:	fa045583          	lhu	a1,-96(s0)
    800032a0:	00092503          	lw	a0,0(s2)
    800032a4:	fffff097          	auipc	ra,0xfffff
    800032a8:	742080e7          	jalr	1858(ra) # 800029e6 <iget>
    800032ac:	a011                	j	800032b0 <dirlookup+0xaa>
  return 0;
    800032ae:	4501                	li	a0,0
}
    800032b0:	60e6                	ld	ra,88(sp)
    800032b2:	6446                	ld	s0,80(sp)
    800032b4:	64a6                	ld	s1,72(sp)
    800032b6:	6906                	ld	s2,64(sp)
    800032b8:	79e2                	ld	s3,56(sp)
    800032ba:	7a42                	ld	s4,48(sp)
    800032bc:	7aa2                	ld	s5,40(sp)
    800032be:	7b02                	ld	s6,32(sp)
    800032c0:	6be2                	ld	s7,24(sp)
    800032c2:	6125                	addi	sp,sp,96
    800032c4:	8082                	ret

00000000800032c6 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    800032c6:	711d                	addi	sp,sp,-96
    800032c8:	ec86                	sd	ra,88(sp)
    800032ca:	e8a2                	sd	s0,80(sp)
    800032cc:	e4a6                	sd	s1,72(sp)
    800032ce:	e0ca                	sd	s2,64(sp)
    800032d0:	fc4e                	sd	s3,56(sp)
    800032d2:	f852                	sd	s4,48(sp)
    800032d4:	f456                	sd	s5,40(sp)
    800032d6:	f05a                	sd	s6,32(sp)
    800032d8:	ec5e                	sd	s7,24(sp)
    800032da:	e862                	sd	s8,16(sp)
    800032dc:	e466                	sd	s9,8(sp)
    800032de:	e06a                	sd	s10,0(sp)
    800032e0:	1080                	addi	s0,sp,96
    800032e2:	84aa                	mv	s1,a0
    800032e4:	8b2e                	mv	s6,a1
    800032e6:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800032e8:	00054703          	lbu	a4,0(a0)
    800032ec:	02f00793          	li	a5,47
    800032f0:	02f70363          	beq	a4,a5,80003316 <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    800032f4:	ffffe097          	auipc	ra,0xffffe
    800032f8:	c98080e7          	jalr	-872(ra) # 80000f8c <myproc>
    800032fc:	15053503          	ld	a0,336(a0)
    80003300:	00000097          	auipc	ra,0x0
    80003304:	9d8080e7          	jalr	-1576(ra) # 80002cd8 <idup>
    80003308:	8a2a                	mv	s4,a0
  while(*path == '/')
    8000330a:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    8000330e:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80003310:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003312:	4b85                	li	s7,1
    80003314:	a87d                	j	800033d2 <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    80003316:	4585                	li	a1,1
    80003318:	852e                	mv	a0,a1
    8000331a:	fffff097          	auipc	ra,0xfffff
    8000331e:	6cc080e7          	jalr	1740(ra) # 800029e6 <iget>
    80003322:	8a2a                	mv	s4,a0
    80003324:	b7dd                	j	8000330a <namex+0x44>
      iunlockput(ip);
    80003326:	8552                	mv	a0,s4
    80003328:	00000097          	auipc	ra,0x0
    8000332c:	c54080e7          	jalr	-940(ra) # 80002f7c <iunlockput>
      return 0;
    80003330:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003332:	8552                	mv	a0,s4
    80003334:	60e6                	ld	ra,88(sp)
    80003336:	6446                	ld	s0,80(sp)
    80003338:	64a6                	ld	s1,72(sp)
    8000333a:	6906                	ld	s2,64(sp)
    8000333c:	79e2                	ld	s3,56(sp)
    8000333e:	7a42                	ld	s4,48(sp)
    80003340:	7aa2                	ld	s5,40(sp)
    80003342:	7b02                	ld	s6,32(sp)
    80003344:	6be2                	ld	s7,24(sp)
    80003346:	6c42                	ld	s8,16(sp)
    80003348:	6ca2                	ld	s9,8(sp)
    8000334a:	6d02                	ld	s10,0(sp)
    8000334c:	6125                	addi	sp,sp,96
    8000334e:	8082                	ret
      iunlock(ip);
    80003350:	8552                	mv	a0,s4
    80003352:	00000097          	auipc	ra,0x0
    80003356:	a8a080e7          	jalr	-1398(ra) # 80002ddc <iunlock>
      return ip;
    8000335a:	bfe1                	j	80003332 <namex+0x6c>
      iunlockput(ip);
    8000335c:	8552                	mv	a0,s4
    8000335e:	00000097          	auipc	ra,0x0
    80003362:	c1e080e7          	jalr	-994(ra) # 80002f7c <iunlockput>
      return 0;
    80003366:	8a4e                	mv	s4,s3
    80003368:	b7e9                	j	80003332 <namex+0x6c>
  len = path - s;
    8000336a:	40998633          	sub	a2,s3,s1
    8000336e:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80003372:	09ac5863          	bge	s8,s10,80003402 <namex+0x13c>
    memmove(name, s, DIRSIZ);
    80003376:	8666                	mv	a2,s9
    80003378:	85a6                	mv	a1,s1
    8000337a:	8556                	mv	a0,s5
    8000337c:	ffffd097          	auipc	ra,0xffffd
    80003380:	e62080e7          	jalr	-414(ra) # 800001de <memmove>
    80003384:	84ce                	mv	s1,s3
  while(*path == '/')
    80003386:	0004c783          	lbu	a5,0(s1)
    8000338a:	01279763          	bne	a5,s2,80003398 <namex+0xd2>
    path++;
    8000338e:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003390:	0004c783          	lbu	a5,0(s1)
    80003394:	ff278de3          	beq	a5,s2,8000338e <namex+0xc8>
    ilock(ip);
    80003398:	8552                	mv	a0,s4
    8000339a:	00000097          	auipc	ra,0x0
    8000339e:	97c080e7          	jalr	-1668(ra) # 80002d16 <ilock>
    if(ip->type != T_DIR){
    800033a2:	044a1783          	lh	a5,68(s4)
    800033a6:	f97790e3          	bne	a5,s7,80003326 <namex+0x60>
    if(nameiparent && *path == '\0'){
    800033aa:	000b0563          	beqz	s6,800033b4 <namex+0xee>
    800033ae:	0004c783          	lbu	a5,0(s1)
    800033b2:	dfd9                	beqz	a5,80003350 <namex+0x8a>
    if((next = dirlookup(ip, name, 0)) == 0){
    800033b4:	4601                	li	a2,0
    800033b6:	85d6                	mv	a1,s5
    800033b8:	8552                	mv	a0,s4
    800033ba:	00000097          	auipc	ra,0x0
    800033be:	e4c080e7          	jalr	-436(ra) # 80003206 <dirlookup>
    800033c2:	89aa                	mv	s3,a0
    800033c4:	dd41                	beqz	a0,8000335c <namex+0x96>
    iunlockput(ip);
    800033c6:	8552                	mv	a0,s4
    800033c8:	00000097          	auipc	ra,0x0
    800033cc:	bb4080e7          	jalr	-1100(ra) # 80002f7c <iunlockput>
    ip = next;
    800033d0:	8a4e                	mv	s4,s3
  while(*path == '/')
    800033d2:	0004c783          	lbu	a5,0(s1)
    800033d6:	01279763          	bne	a5,s2,800033e4 <namex+0x11e>
    path++;
    800033da:	0485                	addi	s1,s1,1
  while(*path == '/')
    800033dc:	0004c783          	lbu	a5,0(s1)
    800033e0:	ff278de3          	beq	a5,s2,800033da <namex+0x114>
  if(*path == 0)
    800033e4:	cb9d                	beqz	a5,8000341a <namex+0x154>
  while(*path != '/' && *path != 0)
    800033e6:	0004c783          	lbu	a5,0(s1)
    800033ea:	89a6                	mv	s3,s1
  len = path - s;
    800033ec:	4d01                	li	s10,0
    800033ee:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    800033f0:	01278963          	beq	a5,s2,80003402 <namex+0x13c>
    800033f4:	dbbd                	beqz	a5,8000336a <namex+0xa4>
    path++;
    800033f6:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    800033f8:	0009c783          	lbu	a5,0(s3)
    800033fc:	ff279ce3          	bne	a5,s2,800033f4 <namex+0x12e>
    80003400:	b7ad                	j	8000336a <namex+0xa4>
    memmove(name, s, len);
    80003402:	2601                	sext.w	a2,a2
    80003404:	85a6                	mv	a1,s1
    80003406:	8556                	mv	a0,s5
    80003408:	ffffd097          	auipc	ra,0xffffd
    8000340c:	dd6080e7          	jalr	-554(ra) # 800001de <memmove>
    name[len] = 0;
    80003410:	9d56                	add	s10,s10,s5
    80003412:	000d0023          	sb	zero,0(s10)
    80003416:	84ce                	mv	s1,s3
    80003418:	b7bd                	j	80003386 <namex+0xc0>
  if(nameiparent){
    8000341a:	f00b0ce3          	beqz	s6,80003332 <namex+0x6c>
    iput(ip);
    8000341e:	8552                	mv	a0,s4
    80003420:	00000097          	auipc	ra,0x0
    80003424:	ab4080e7          	jalr	-1356(ra) # 80002ed4 <iput>
    return 0;
    80003428:	4a01                	li	s4,0
    8000342a:	b721                	j	80003332 <namex+0x6c>

000000008000342c <dirlink>:
{
    8000342c:	715d                	addi	sp,sp,-80
    8000342e:	e486                	sd	ra,72(sp)
    80003430:	e0a2                	sd	s0,64(sp)
    80003432:	f84a                	sd	s2,48(sp)
    80003434:	ec56                	sd	s5,24(sp)
    80003436:	e85a                	sd	s6,16(sp)
    80003438:	0880                	addi	s0,sp,80
    8000343a:	892a                	mv	s2,a0
    8000343c:	8aae                	mv	s5,a1
    8000343e:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003440:	4601                	li	a2,0
    80003442:	00000097          	auipc	ra,0x0
    80003446:	dc4080e7          	jalr	-572(ra) # 80003206 <dirlookup>
    8000344a:	e129                	bnez	a0,8000348c <dirlink+0x60>
    8000344c:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000344e:	04c92483          	lw	s1,76(s2)
    80003452:	cca9                	beqz	s1,800034ac <dirlink+0x80>
    80003454:	f44e                	sd	s3,40(sp)
    80003456:	f052                	sd	s4,32(sp)
    80003458:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000345a:	fb040a13          	addi	s4,s0,-80
    8000345e:	49c1                	li	s3,16
    80003460:	874e                	mv	a4,s3
    80003462:	86a6                	mv	a3,s1
    80003464:	8652                	mv	a2,s4
    80003466:	4581                	li	a1,0
    80003468:	854a                	mv	a0,s2
    8000346a:	00000097          	auipc	ra,0x0
    8000346e:	b68080e7          	jalr	-1176(ra) # 80002fd2 <readi>
    80003472:	03351363          	bne	a0,s3,80003498 <dirlink+0x6c>
    if(de.inum == 0)
    80003476:	fb045783          	lhu	a5,-80(s0)
    8000347a:	c79d                	beqz	a5,800034a8 <dirlink+0x7c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000347c:	24c1                	addiw	s1,s1,16
    8000347e:	04c92783          	lw	a5,76(s2)
    80003482:	fcf4efe3          	bltu	s1,a5,80003460 <dirlink+0x34>
    80003486:	79a2                	ld	s3,40(sp)
    80003488:	7a02                	ld	s4,32(sp)
    8000348a:	a00d                	j	800034ac <dirlink+0x80>
    iput(ip);
    8000348c:	00000097          	auipc	ra,0x0
    80003490:	a48080e7          	jalr	-1464(ra) # 80002ed4 <iput>
    return -1;
    80003494:	557d                	li	a0,-1
    80003496:	a0a9                	j	800034e0 <dirlink+0xb4>
      panic("dirlink read");
    80003498:	00005517          	auipc	a0,0x5
    8000349c:	04850513          	addi	a0,a0,72 # 800084e0 <etext+0x4e0>
    800034a0:	00003097          	auipc	ra,0x3
    800034a4:	a52080e7          	jalr	-1454(ra) # 80005ef2 <panic>
    800034a8:	79a2                	ld	s3,40(sp)
    800034aa:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    800034ac:	4639                	li	a2,14
    800034ae:	85d6                	mv	a1,s5
    800034b0:	fb240513          	addi	a0,s0,-78
    800034b4:	ffffd097          	auipc	ra,0xffffd
    800034b8:	ddc080e7          	jalr	-548(ra) # 80000290 <strncpy>
  de.inum = inum;
    800034bc:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034c0:	4741                	li	a4,16
    800034c2:	86a6                	mv	a3,s1
    800034c4:	fb040613          	addi	a2,s0,-80
    800034c8:	4581                	li	a1,0
    800034ca:	854a                	mv	a0,s2
    800034cc:	00000097          	auipc	ra,0x0
    800034d0:	c00080e7          	jalr	-1024(ra) # 800030cc <writei>
    800034d4:	872a                	mv	a4,a0
    800034d6:	47c1                	li	a5,16
  return 0;
    800034d8:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800034da:	00f71a63          	bne	a4,a5,800034ee <dirlink+0xc2>
    800034de:	74e2                	ld	s1,56(sp)
}
    800034e0:	60a6                	ld	ra,72(sp)
    800034e2:	6406                	ld	s0,64(sp)
    800034e4:	7942                	ld	s2,48(sp)
    800034e6:	6ae2                	ld	s5,24(sp)
    800034e8:	6b42                	ld	s6,16(sp)
    800034ea:	6161                	addi	sp,sp,80
    800034ec:	8082                	ret
    800034ee:	f44e                	sd	s3,40(sp)
    800034f0:	f052                	sd	s4,32(sp)
    panic("dirlink");
    800034f2:	00005517          	auipc	a0,0x5
    800034f6:	0fe50513          	addi	a0,a0,254 # 800085f0 <etext+0x5f0>
    800034fa:	00003097          	auipc	ra,0x3
    800034fe:	9f8080e7          	jalr	-1544(ra) # 80005ef2 <panic>

0000000080003502 <namei>:

struct inode*
namei(char *path)
{
    80003502:	1101                	addi	sp,sp,-32
    80003504:	ec06                	sd	ra,24(sp)
    80003506:	e822                	sd	s0,16(sp)
    80003508:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    8000350a:	fe040613          	addi	a2,s0,-32
    8000350e:	4581                	li	a1,0
    80003510:	00000097          	auipc	ra,0x0
    80003514:	db6080e7          	jalr	-586(ra) # 800032c6 <namex>
}
    80003518:	60e2                	ld	ra,24(sp)
    8000351a:	6442                	ld	s0,16(sp)
    8000351c:	6105                	addi	sp,sp,32
    8000351e:	8082                	ret

0000000080003520 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003520:	1141                	addi	sp,sp,-16
    80003522:	e406                	sd	ra,8(sp)
    80003524:	e022                	sd	s0,0(sp)
    80003526:	0800                	addi	s0,sp,16
    80003528:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000352a:	4585                	li	a1,1
    8000352c:	00000097          	auipc	ra,0x0
    80003530:	d9a080e7          	jalr	-614(ra) # 800032c6 <namex>
}
    80003534:	60a2                	ld	ra,8(sp)
    80003536:	6402                	ld	s0,0(sp)
    80003538:	0141                	addi	sp,sp,16
    8000353a:	8082                	ret

000000008000353c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    8000353c:	1101                	addi	sp,sp,-32
    8000353e:	ec06                	sd	ra,24(sp)
    80003540:	e822                	sd	s0,16(sp)
    80003542:	e426                	sd	s1,8(sp)
    80003544:	e04a                	sd	s2,0(sp)
    80003546:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003548:	00016917          	auipc	s2,0x16
    8000354c:	cd890913          	addi	s2,s2,-808 # 80019220 <log>
    80003550:	01892583          	lw	a1,24(s2)
    80003554:	02892503          	lw	a0,40(s2)
    80003558:	fffff097          	auipc	ra,0xfffff
    8000355c:	fe2080e7          	jalr	-30(ra) # 8000253a <bread>
    80003560:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003562:	02c92603          	lw	a2,44(s2)
    80003566:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003568:	00c05f63          	blez	a2,80003586 <write_head+0x4a>
    8000356c:	00016717          	auipc	a4,0x16
    80003570:	ce470713          	addi	a4,a4,-796 # 80019250 <log+0x30>
    80003574:	87aa                	mv	a5,a0
    80003576:	060a                	slli	a2,a2,0x2
    80003578:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    8000357a:	4314                	lw	a3,0(a4)
    8000357c:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    8000357e:	0711                	addi	a4,a4,4
    80003580:	0791                	addi	a5,a5,4
    80003582:	fec79ce3          	bne	a5,a2,8000357a <write_head+0x3e>
  }
  bwrite(buf);
    80003586:	8526                	mv	a0,s1
    80003588:	fffff097          	auipc	ra,0xfffff
    8000358c:	0a4080e7          	jalr	164(ra) # 8000262c <bwrite>
  brelse(buf);
    80003590:	8526                	mv	a0,s1
    80003592:	fffff097          	auipc	ra,0xfffff
    80003596:	0d8080e7          	jalr	216(ra) # 8000266a <brelse>
}
    8000359a:	60e2                	ld	ra,24(sp)
    8000359c:	6442                	ld	s0,16(sp)
    8000359e:	64a2                	ld	s1,8(sp)
    800035a0:	6902                	ld	s2,0(sp)
    800035a2:	6105                	addi	sp,sp,32
    800035a4:	8082                	ret

00000000800035a6 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800035a6:	00016797          	auipc	a5,0x16
    800035aa:	ca67a783          	lw	a5,-858(a5) # 8001924c <log+0x2c>
    800035ae:	0cf05063          	blez	a5,8000366e <install_trans+0xc8>
{
    800035b2:	715d                	addi	sp,sp,-80
    800035b4:	e486                	sd	ra,72(sp)
    800035b6:	e0a2                	sd	s0,64(sp)
    800035b8:	fc26                	sd	s1,56(sp)
    800035ba:	f84a                	sd	s2,48(sp)
    800035bc:	f44e                	sd	s3,40(sp)
    800035be:	f052                	sd	s4,32(sp)
    800035c0:	ec56                	sd	s5,24(sp)
    800035c2:	e85a                	sd	s6,16(sp)
    800035c4:	e45e                	sd	s7,8(sp)
    800035c6:	0880                	addi	s0,sp,80
    800035c8:	8b2a                	mv	s6,a0
    800035ca:	00016a97          	auipc	s5,0x16
    800035ce:	c86a8a93          	addi	s5,s5,-890 # 80019250 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035d2:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800035d4:	00016997          	auipc	s3,0x16
    800035d8:	c4c98993          	addi	s3,s3,-948 # 80019220 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800035dc:	40000b93          	li	s7,1024
    800035e0:	a00d                	j	80003602 <install_trans+0x5c>
    brelse(lbuf);
    800035e2:	854a                	mv	a0,s2
    800035e4:	fffff097          	auipc	ra,0xfffff
    800035e8:	086080e7          	jalr	134(ra) # 8000266a <brelse>
    brelse(dbuf);
    800035ec:	8526                	mv	a0,s1
    800035ee:	fffff097          	auipc	ra,0xfffff
    800035f2:	07c080e7          	jalr	124(ra) # 8000266a <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035f6:	2a05                	addiw	s4,s4,1
    800035f8:	0a91                	addi	s5,s5,4
    800035fa:	02c9a783          	lw	a5,44(s3)
    800035fe:	04fa5d63          	bge	s4,a5,80003658 <install_trans+0xb2>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003602:	0189a583          	lw	a1,24(s3)
    80003606:	014585bb          	addw	a1,a1,s4
    8000360a:	2585                	addiw	a1,a1,1
    8000360c:	0289a503          	lw	a0,40(s3)
    80003610:	fffff097          	auipc	ra,0xfffff
    80003614:	f2a080e7          	jalr	-214(ra) # 8000253a <bread>
    80003618:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000361a:	000aa583          	lw	a1,0(s5)
    8000361e:	0289a503          	lw	a0,40(s3)
    80003622:	fffff097          	auipc	ra,0xfffff
    80003626:	f18080e7          	jalr	-232(ra) # 8000253a <bread>
    8000362a:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000362c:	865e                	mv	a2,s7
    8000362e:	05890593          	addi	a1,s2,88
    80003632:	05850513          	addi	a0,a0,88
    80003636:	ffffd097          	auipc	ra,0xffffd
    8000363a:	ba8080e7          	jalr	-1112(ra) # 800001de <memmove>
    bwrite(dbuf);  // write dst to disk
    8000363e:	8526                	mv	a0,s1
    80003640:	fffff097          	auipc	ra,0xfffff
    80003644:	fec080e7          	jalr	-20(ra) # 8000262c <bwrite>
    if(recovering == 0)
    80003648:	f80b1de3          	bnez	s6,800035e2 <install_trans+0x3c>
      bunpin(dbuf);
    8000364c:	8526                	mv	a0,s1
    8000364e:	fffff097          	auipc	ra,0xfffff
    80003652:	0f0080e7          	jalr	240(ra) # 8000273e <bunpin>
    80003656:	b771                	j	800035e2 <install_trans+0x3c>
}
    80003658:	60a6                	ld	ra,72(sp)
    8000365a:	6406                	ld	s0,64(sp)
    8000365c:	74e2                	ld	s1,56(sp)
    8000365e:	7942                	ld	s2,48(sp)
    80003660:	79a2                	ld	s3,40(sp)
    80003662:	7a02                	ld	s4,32(sp)
    80003664:	6ae2                	ld	s5,24(sp)
    80003666:	6b42                	ld	s6,16(sp)
    80003668:	6ba2                	ld	s7,8(sp)
    8000366a:	6161                	addi	sp,sp,80
    8000366c:	8082                	ret
    8000366e:	8082                	ret

0000000080003670 <initlog>:
{
    80003670:	7179                	addi	sp,sp,-48
    80003672:	f406                	sd	ra,40(sp)
    80003674:	f022                	sd	s0,32(sp)
    80003676:	ec26                	sd	s1,24(sp)
    80003678:	e84a                	sd	s2,16(sp)
    8000367a:	e44e                	sd	s3,8(sp)
    8000367c:	1800                	addi	s0,sp,48
    8000367e:	892a                	mv	s2,a0
    80003680:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003682:	00016497          	auipc	s1,0x16
    80003686:	b9e48493          	addi	s1,s1,-1122 # 80019220 <log>
    8000368a:	00005597          	auipc	a1,0x5
    8000368e:	e6658593          	addi	a1,a1,-410 # 800084f0 <etext+0x4f0>
    80003692:	8526                	mv	a0,s1
    80003694:	00003097          	auipc	ra,0x3
    80003698:	d4a080e7          	jalr	-694(ra) # 800063de <initlock>
  log.start = sb->logstart;
    8000369c:	0149a583          	lw	a1,20(s3)
    800036a0:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800036a2:	0109a783          	lw	a5,16(s3)
    800036a6:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800036a8:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800036ac:	854a                	mv	a0,s2
    800036ae:	fffff097          	auipc	ra,0xfffff
    800036b2:	e8c080e7          	jalr	-372(ra) # 8000253a <bread>
  log.lh.n = lh->n;
    800036b6:	4d30                	lw	a2,88(a0)
    800036b8:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    800036ba:	00c05f63          	blez	a2,800036d8 <initlog+0x68>
    800036be:	87aa                	mv	a5,a0
    800036c0:	00016717          	auipc	a4,0x16
    800036c4:	b9070713          	addi	a4,a4,-1136 # 80019250 <log+0x30>
    800036c8:	060a                	slli	a2,a2,0x2
    800036ca:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    800036cc:	4ff4                	lw	a3,92(a5)
    800036ce:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800036d0:	0791                	addi	a5,a5,4
    800036d2:	0711                	addi	a4,a4,4
    800036d4:	fec79ce3          	bne	a5,a2,800036cc <initlog+0x5c>
  brelse(buf);
    800036d8:	fffff097          	auipc	ra,0xfffff
    800036dc:	f92080e7          	jalr	-110(ra) # 8000266a <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800036e0:	4505                	li	a0,1
    800036e2:	00000097          	auipc	ra,0x0
    800036e6:	ec4080e7          	jalr	-316(ra) # 800035a6 <install_trans>
  log.lh.n = 0;
    800036ea:	00016797          	auipc	a5,0x16
    800036ee:	b607a123          	sw	zero,-1182(a5) # 8001924c <log+0x2c>
  write_head(); // clear the log
    800036f2:	00000097          	auipc	ra,0x0
    800036f6:	e4a080e7          	jalr	-438(ra) # 8000353c <write_head>
}
    800036fa:	70a2                	ld	ra,40(sp)
    800036fc:	7402                	ld	s0,32(sp)
    800036fe:	64e2                	ld	s1,24(sp)
    80003700:	6942                	ld	s2,16(sp)
    80003702:	69a2                	ld	s3,8(sp)
    80003704:	6145                	addi	sp,sp,48
    80003706:	8082                	ret

0000000080003708 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003708:	1101                	addi	sp,sp,-32
    8000370a:	ec06                	sd	ra,24(sp)
    8000370c:	e822                	sd	s0,16(sp)
    8000370e:	e426                	sd	s1,8(sp)
    80003710:	e04a                	sd	s2,0(sp)
    80003712:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003714:	00016517          	auipc	a0,0x16
    80003718:	b0c50513          	addi	a0,a0,-1268 # 80019220 <log>
    8000371c:	00003097          	auipc	ra,0x3
    80003720:	d56080e7          	jalr	-682(ra) # 80006472 <acquire>
  while(1){
    if(log.committing){
    80003724:	00016497          	auipc	s1,0x16
    80003728:	afc48493          	addi	s1,s1,-1284 # 80019220 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000372c:	4979                	li	s2,30
    8000372e:	a039                	j	8000373c <begin_op+0x34>
      sleep(&log, &log.lock);
    80003730:	85a6                	mv	a1,s1
    80003732:	8526                	mv	a0,s1
    80003734:	ffffe097          	auipc	ra,0xffffe
    80003738:	fd2080e7          	jalr	-46(ra) # 80001706 <sleep>
    if(log.committing){
    8000373c:	50dc                	lw	a5,36(s1)
    8000373e:	fbed                	bnez	a5,80003730 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003740:	5098                	lw	a4,32(s1)
    80003742:	2705                	addiw	a4,a4,1
    80003744:	0027179b          	slliw	a5,a4,0x2
    80003748:	9fb9                	addw	a5,a5,a4
    8000374a:	0017979b          	slliw	a5,a5,0x1
    8000374e:	54d4                	lw	a3,44(s1)
    80003750:	9fb5                	addw	a5,a5,a3
    80003752:	00f95963          	bge	s2,a5,80003764 <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003756:	85a6                	mv	a1,s1
    80003758:	8526                	mv	a0,s1
    8000375a:	ffffe097          	auipc	ra,0xffffe
    8000375e:	fac080e7          	jalr	-84(ra) # 80001706 <sleep>
    80003762:	bfe9                	j	8000373c <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003764:	00016517          	auipc	a0,0x16
    80003768:	abc50513          	addi	a0,a0,-1348 # 80019220 <log>
    8000376c:	d118                	sw	a4,32(a0)
      release(&log.lock);
    8000376e:	00003097          	auipc	ra,0x3
    80003772:	db4080e7          	jalr	-588(ra) # 80006522 <release>
      break;
    }
  }
}
    80003776:	60e2                	ld	ra,24(sp)
    80003778:	6442                	ld	s0,16(sp)
    8000377a:	64a2                	ld	s1,8(sp)
    8000377c:	6902                	ld	s2,0(sp)
    8000377e:	6105                	addi	sp,sp,32
    80003780:	8082                	ret

0000000080003782 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003782:	7139                	addi	sp,sp,-64
    80003784:	fc06                	sd	ra,56(sp)
    80003786:	f822                	sd	s0,48(sp)
    80003788:	f426                	sd	s1,40(sp)
    8000378a:	f04a                	sd	s2,32(sp)
    8000378c:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    8000378e:	00016497          	auipc	s1,0x16
    80003792:	a9248493          	addi	s1,s1,-1390 # 80019220 <log>
    80003796:	8526                	mv	a0,s1
    80003798:	00003097          	auipc	ra,0x3
    8000379c:	cda080e7          	jalr	-806(ra) # 80006472 <acquire>
  log.outstanding -= 1;
    800037a0:	509c                	lw	a5,32(s1)
    800037a2:	37fd                	addiw	a5,a5,-1
    800037a4:	893e                	mv	s2,a5
    800037a6:	d09c                	sw	a5,32(s1)
  if(log.committing)
    800037a8:	50dc                	lw	a5,36(s1)
    800037aa:	e7b9                	bnez	a5,800037f8 <end_op+0x76>
    panic("log.committing");
  if(log.outstanding == 0){
    800037ac:	06091263          	bnez	s2,80003810 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    800037b0:	00016497          	auipc	s1,0x16
    800037b4:	a7048493          	addi	s1,s1,-1424 # 80019220 <log>
    800037b8:	4785                	li	a5,1
    800037ba:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800037bc:	8526                	mv	a0,s1
    800037be:	00003097          	auipc	ra,0x3
    800037c2:	d64080e7          	jalr	-668(ra) # 80006522 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800037c6:	54dc                	lw	a5,44(s1)
    800037c8:	06f04863          	bgtz	a5,80003838 <end_op+0xb6>
    acquire(&log.lock);
    800037cc:	00016497          	auipc	s1,0x16
    800037d0:	a5448493          	addi	s1,s1,-1452 # 80019220 <log>
    800037d4:	8526                	mv	a0,s1
    800037d6:	00003097          	auipc	ra,0x3
    800037da:	c9c080e7          	jalr	-868(ra) # 80006472 <acquire>
    log.committing = 0;
    800037de:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    800037e2:	8526                	mv	a0,s1
    800037e4:	ffffe097          	auipc	ra,0xffffe
    800037e8:	0a8080e7          	jalr	168(ra) # 8000188c <wakeup>
    release(&log.lock);
    800037ec:	8526                	mv	a0,s1
    800037ee:	00003097          	auipc	ra,0x3
    800037f2:	d34080e7          	jalr	-716(ra) # 80006522 <release>
}
    800037f6:	a81d                	j	8000382c <end_op+0xaa>
    800037f8:	ec4e                	sd	s3,24(sp)
    800037fa:	e852                	sd	s4,16(sp)
    800037fc:	e456                	sd	s5,8(sp)
    800037fe:	e05a                	sd	s6,0(sp)
    panic("log.committing");
    80003800:	00005517          	auipc	a0,0x5
    80003804:	cf850513          	addi	a0,a0,-776 # 800084f8 <etext+0x4f8>
    80003808:	00002097          	auipc	ra,0x2
    8000380c:	6ea080e7          	jalr	1770(ra) # 80005ef2 <panic>
    wakeup(&log);
    80003810:	00016497          	auipc	s1,0x16
    80003814:	a1048493          	addi	s1,s1,-1520 # 80019220 <log>
    80003818:	8526                	mv	a0,s1
    8000381a:	ffffe097          	auipc	ra,0xffffe
    8000381e:	072080e7          	jalr	114(ra) # 8000188c <wakeup>
  release(&log.lock);
    80003822:	8526                	mv	a0,s1
    80003824:	00003097          	auipc	ra,0x3
    80003828:	cfe080e7          	jalr	-770(ra) # 80006522 <release>
}
    8000382c:	70e2                	ld	ra,56(sp)
    8000382e:	7442                	ld	s0,48(sp)
    80003830:	74a2                	ld	s1,40(sp)
    80003832:	7902                	ld	s2,32(sp)
    80003834:	6121                	addi	sp,sp,64
    80003836:	8082                	ret
    80003838:	ec4e                	sd	s3,24(sp)
    8000383a:	e852                	sd	s4,16(sp)
    8000383c:	e456                	sd	s5,8(sp)
    8000383e:	e05a                	sd	s6,0(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    80003840:	00016a97          	auipc	s5,0x16
    80003844:	a10a8a93          	addi	s5,s5,-1520 # 80019250 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003848:	00016a17          	auipc	s4,0x16
    8000384c:	9d8a0a13          	addi	s4,s4,-1576 # 80019220 <log>
    memmove(to->data, from->data, BSIZE);
    80003850:	40000b13          	li	s6,1024
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003854:	018a2583          	lw	a1,24(s4)
    80003858:	012585bb          	addw	a1,a1,s2
    8000385c:	2585                	addiw	a1,a1,1
    8000385e:	028a2503          	lw	a0,40(s4)
    80003862:	fffff097          	auipc	ra,0xfffff
    80003866:	cd8080e7          	jalr	-808(ra) # 8000253a <bread>
    8000386a:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000386c:	000aa583          	lw	a1,0(s5)
    80003870:	028a2503          	lw	a0,40(s4)
    80003874:	fffff097          	auipc	ra,0xfffff
    80003878:	cc6080e7          	jalr	-826(ra) # 8000253a <bread>
    8000387c:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000387e:	865a                	mv	a2,s6
    80003880:	05850593          	addi	a1,a0,88
    80003884:	05848513          	addi	a0,s1,88
    80003888:	ffffd097          	auipc	ra,0xffffd
    8000388c:	956080e7          	jalr	-1706(ra) # 800001de <memmove>
    bwrite(to);  // write the log
    80003890:	8526                	mv	a0,s1
    80003892:	fffff097          	auipc	ra,0xfffff
    80003896:	d9a080e7          	jalr	-614(ra) # 8000262c <bwrite>
    brelse(from);
    8000389a:	854e                	mv	a0,s3
    8000389c:	fffff097          	auipc	ra,0xfffff
    800038a0:	dce080e7          	jalr	-562(ra) # 8000266a <brelse>
    brelse(to);
    800038a4:	8526                	mv	a0,s1
    800038a6:	fffff097          	auipc	ra,0xfffff
    800038aa:	dc4080e7          	jalr	-572(ra) # 8000266a <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800038ae:	2905                	addiw	s2,s2,1
    800038b0:	0a91                	addi	s5,s5,4
    800038b2:	02ca2783          	lw	a5,44(s4)
    800038b6:	f8f94fe3          	blt	s2,a5,80003854 <end_op+0xd2>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800038ba:	00000097          	auipc	ra,0x0
    800038be:	c82080e7          	jalr	-894(ra) # 8000353c <write_head>
    install_trans(0); // Now install writes to home locations
    800038c2:	4501                	li	a0,0
    800038c4:	00000097          	auipc	ra,0x0
    800038c8:	ce2080e7          	jalr	-798(ra) # 800035a6 <install_trans>
    log.lh.n = 0;
    800038cc:	00016797          	auipc	a5,0x16
    800038d0:	9807a023          	sw	zero,-1664(a5) # 8001924c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800038d4:	00000097          	auipc	ra,0x0
    800038d8:	c68080e7          	jalr	-920(ra) # 8000353c <write_head>
    800038dc:	69e2                	ld	s3,24(sp)
    800038de:	6a42                	ld	s4,16(sp)
    800038e0:	6aa2                	ld	s5,8(sp)
    800038e2:	6b02                	ld	s6,0(sp)
    800038e4:	b5e5                	j	800037cc <end_op+0x4a>

00000000800038e6 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800038e6:	1101                	addi	sp,sp,-32
    800038e8:	ec06                	sd	ra,24(sp)
    800038ea:	e822                	sd	s0,16(sp)
    800038ec:	e426                	sd	s1,8(sp)
    800038ee:	e04a                	sd	s2,0(sp)
    800038f0:	1000                	addi	s0,sp,32
    800038f2:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800038f4:	00016917          	auipc	s2,0x16
    800038f8:	92c90913          	addi	s2,s2,-1748 # 80019220 <log>
    800038fc:	854a                	mv	a0,s2
    800038fe:	00003097          	auipc	ra,0x3
    80003902:	b74080e7          	jalr	-1164(ra) # 80006472 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80003906:	02c92603          	lw	a2,44(s2)
    8000390a:	47f5                	li	a5,29
    8000390c:	06c7c563          	blt	a5,a2,80003976 <log_write+0x90>
    80003910:	00016797          	auipc	a5,0x16
    80003914:	92c7a783          	lw	a5,-1748(a5) # 8001923c <log+0x1c>
    80003918:	37fd                	addiw	a5,a5,-1
    8000391a:	04f65e63          	bge	a2,a5,80003976 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    8000391e:	00016797          	auipc	a5,0x16
    80003922:	9227a783          	lw	a5,-1758(a5) # 80019240 <log+0x20>
    80003926:	06f05063          	blez	a5,80003986 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000392a:	4781                	li	a5,0
    8000392c:	06c05563          	blez	a2,80003996 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003930:	44cc                	lw	a1,12(s1)
    80003932:	00016717          	auipc	a4,0x16
    80003936:	91e70713          	addi	a4,a4,-1762 # 80019250 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000393a:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000393c:	4314                	lw	a3,0(a4)
    8000393e:	04b68c63          	beq	a3,a1,80003996 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80003942:	2785                	addiw	a5,a5,1
    80003944:	0711                	addi	a4,a4,4
    80003946:	fef61be3          	bne	a2,a5,8000393c <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000394a:	0621                	addi	a2,a2,8
    8000394c:	060a                	slli	a2,a2,0x2
    8000394e:	00016797          	auipc	a5,0x16
    80003952:	8d278793          	addi	a5,a5,-1838 # 80019220 <log>
    80003956:	97b2                	add	a5,a5,a2
    80003958:	44d8                	lw	a4,12(s1)
    8000395a:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    8000395c:	8526                	mv	a0,s1
    8000395e:	fffff097          	auipc	ra,0xfffff
    80003962:	da4080e7          	jalr	-604(ra) # 80002702 <bpin>
    log.lh.n++;
    80003966:	00016717          	auipc	a4,0x16
    8000396a:	8ba70713          	addi	a4,a4,-1862 # 80019220 <log>
    8000396e:	575c                	lw	a5,44(a4)
    80003970:	2785                	addiw	a5,a5,1
    80003972:	d75c                	sw	a5,44(a4)
    80003974:	a82d                	j	800039ae <log_write+0xc8>
    panic("too big a transaction");
    80003976:	00005517          	auipc	a0,0x5
    8000397a:	b9250513          	addi	a0,a0,-1134 # 80008508 <etext+0x508>
    8000397e:	00002097          	auipc	ra,0x2
    80003982:	574080e7          	jalr	1396(ra) # 80005ef2 <panic>
    panic("log_write outside of trans");
    80003986:	00005517          	auipc	a0,0x5
    8000398a:	b9a50513          	addi	a0,a0,-1126 # 80008520 <etext+0x520>
    8000398e:	00002097          	auipc	ra,0x2
    80003992:	564080e7          	jalr	1380(ra) # 80005ef2 <panic>
  log.lh.block[i] = b->blockno;
    80003996:	00878693          	addi	a3,a5,8
    8000399a:	068a                	slli	a3,a3,0x2
    8000399c:	00016717          	auipc	a4,0x16
    800039a0:	88470713          	addi	a4,a4,-1916 # 80019220 <log>
    800039a4:	9736                	add	a4,a4,a3
    800039a6:	44d4                	lw	a3,12(s1)
    800039a8:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800039aa:	faf609e3          	beq	a2,a5,8000395c <log_write+0x76>
  }
  release(&log.lock);
    800039ae:	00016517          	auipc	a0,0x16
    800039b2:	87250513          	addi	a0,a0,-1934 # 80019220 <log>
    800039b6:	00003097          	auipc	ra,0x3
    800039ba:	b6c080e7          	jalr	-1172(ra) # 80006522 <release>
}
    800039be:	60e2                	ld	ra,24(sp)
    800039c0:	6442                	ld	s0,16(sp)
    800039c2:	64a2                	ld	s1,8(sp)
    800039c4:	6902                	ld	s2,0(sp)
    800039c6:	6105                	addi	sp,sp,32
    800039c8:	8082                	ret

00000000800039ca <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    800039ca:	1101                	addi	sp,sp,-32
    800039cc:	ec06                	sd	ra,24(sp)
    800039ce:	e822                	sd	s0,16(sp)
    800039d0:	e426                	sd	s1,8(sp)
    800039d2:	e04a                	sd	s2,0(sp)
    800039d4:	1000                	addi	s0,sp,32
    800039d6:	84aa                	mv	s1,a0
    800039d8:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800039da:	00005597          	auipc	a1,0x5
    800039de:	b6658593          	addi	a1,a1,-1178 # 80008540 <etext+0x540>
    800039e2:	0521                	addi	a0,a0,8
    800039e4:	00003097          	auipc	ra,0x3
    800039e8:	9fa080e7          	jalr	-1542(ra) # 800063de <initlock>
  lk->name = name;
    800039ec:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800039f0:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800039f4:	0204a423          	sw	zero,40(s1)
}
    800039f8:	60e2                	ld	ra,24(sp)
    800039fa:	6442                	ld	s0,16(sp)
    800039fc:	64a2                	ld	s1,8(sp)
    800039fe:	6902                	ld	s2,0(sp)
    80003a00:	6105                	addi	sp,sp,32
    80003a02:	8082                	ret

0000000080003a04 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003a04:	1101                	addi	sp,sp,-32
    80003a06:	ec06                	sd	ra,24(sp)
    80003a08:	e822                	sd	s0,16(sp)
    80003a0a:	e426                	sd	s1,8(sp)
    80003a0c:	e04a                	sd	s2,0(sp)
    80003a0e:	1000                	addi	s0,sp,32
    80003a10:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a12:	00850913          	addi	s2,a0,8
    80003a16:	854a                	mv	a0,s2
    80003a18:	00003097          	auipc	ra,0x3
    80003a1c:	a5a080e7          	jalr	-1446(ra) # 80006472 <acquire>
  while (lk->locked) {
    80003a20:	409c                	lw	a5,0(s1)
    80003a22:	cb89                	beqz	a5,80003a34 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003a24:	85ca                	mv	a1,s2
    80003a26:	8526                	mv	a0,s1
    80003a28:	ffffe097          	auipc	ra,0xffffe
    80003a2c:	cde080e7          	jalr	-802(ra) # 80001706 <sleep>
  while (lk->locked) {
    80003a30:	409c                	lw	a5,0(s1)
    80003a32:	fbed                	bnez	a5,80003a24 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003a34:	4785                	li	a5,1
    80003a36:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003a38:	ffffd097          	auipc	ra,0xffffd
    80003a3c:	554080e7          	jalr	1364(ra) # 80000f8c <myproc>
    80003a40:	591c                	lw	a5,48(a0)
    80003a42:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003a44:	854a                	mv	a0,s2
    80003a46:	00003097          	auipc	ra,0x3
    80003a4a:	adc080e7          	jalr	-1316(ra) # 80006522 <release>
}
    80003a4e:	60e2                	ld	ra,24(sp)
    80003a50:	6442                	ld	s0,16(sp)
    80003a52:	64a2                	ld	s1,8(sp)
    80003a54:	6902                	ld	s2,0(sp)
    80003a56:	6105                	addi	sp,sp,32
    80003a58:	8082                	ret

0000000080003a5a <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003a5a:	1101                	addi	sp,sp,-32
    80003a5c:	ec06                	sd	ra,24(sp)
    80003a5e:	e822                	sd	s0,16(sp)
    80003a60:	e426                	sd	s1,8(sp)
    80003a62:	e04a                	sd	s2,0(sp)
    80003a64:	1000                	addi	s0,sp,32
    80003a66:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a68:	00850913          	addi	s2,a0,8
    80003a6c:	854a                	mv	a0,s2
    80003a6e:	00003097          	auipc	ra,0x3
    80003a72:	a04080e7          	jalr	-1532(ra) # 80006472 <acquire>
  lk->locked = 0;
    80003a76:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a7a:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003a7e:	8526                	mv	a0,s1
    80003a80:	ffffe097          	auipc	ra,0xffffe
    80003a84:	e0c080e7          	jalr	-500(ra) # 8000188c <wakeup>
  release(&lk->lk);
    80003a88:	854a                	mv	a0,s2
    80003a8a:	00003097          	auipc	ra,0x3
    80003a8e:	a98080e7          	jalr	-1384(ra) # 80006522 <release>
}
    80003a92:	60e2                	ld	ra,24(sp)
    80003a94:	6442                	ld	s0,16(sp)
    80003a96:	64a2                	ld	s1,8(sp)
    80003a98:	6902                	ld	s2,0(sp)
    80003a9a:	6105                	addi	sp,sp,32
    80003a9c:	8082                	ret

0000000080003a9e <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003a9e:	7179                	addi	sp,sp,-48
    80003aa0:	f406                	sd	ra,40(sp)
    80003aa2:	f022                	sd	s0,32(sp)
    80003aa4:	ec26                	sd	s1,24(sp)
    80003aa6:	e84a                	sd	s2,16(sp)
    80003aa8:	1800                	addi	s0,sp,48
    80003aaa:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003aac:	00850913          	addi	s2,a0,8
    80003ab0:	854a                	mv	a0,s2
    80003ab2:	00003097          	auipc	ra,0x3
    80003ab6:	9c0080e7          	jalr	-1600(ra) # 80006472 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003aba:	409c                	lw	a5,0(s1)
    80003abc:	ef91                	bnez	a5,80003ad8 <holdingsleep+0x3a>
    80003abe:	4481                	li	s1,0
  release(&lk->lk);
    80003ac0:	854a                	mv	a0,s2
    80003ac2:	00003097          	auipc	ra,0x3
    80003ac6:	a60080e7          	jalr	-1440(ra) # 80006522 <release>
  return r;
}
    80003aca:	8526                	mv	a0,s1
    80003acc:	70a2                	ld	ra,40(sp)
    80003ace:	7402                	ld	s0,32(sp)
    80003ad0:	64e2                	ld	s1,24(sp)
    80003ad2:	6942                	ld	s2,16(sp)
    80003ad4:	6145                	addi	sp,sp,48
    80003ad6:	8082                	ret
    80003ad8:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    80003ada:	0284a983          	lw	s3,40(s1)
    80003ade:	ffffd097          	auipc	ra,0xffffd
    80003ae2:	4ae080e7          	jalr	1198(ra) # 80000f8c <myproc>
    80003ae6:	5904                	lw	s1,48(a0)
    80003ae8:	413484b3          	sub	s1,s1,s3
    80003aec:	0014b493          	seqz	s1,s1
    80003af0:	69a2                	ld	s3,8(sp)
    80003af2:	b7f9                	j	80003ac0 <holdingsleep+0x22>

0000000080003af4 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003af4:	1141                	addi	sp,sp,-16
    80003af6:	e406                	sd	ra,8(sp)
    80003af8:	e022                	sd	s0,0(sp)
    80003afa:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003afc:	00005597          	auipc	a1,0x5
    80003b00:	a5458593          	addi	a1,a1,-1452 # 80008550 <etext+0x550>
    80003b04:	00016517          	auipc	a0,0x16
    80003b08:	86450513          	addi	a0,a0,-1948 # 80019368 <ftable>
    80003b0c:	00003097          	auipc	ra,0x3
    80003b10:	8d2080e7          	jalr	-1838(ra) # 800063de <initlock>
}
    80003b14:	60a2                	ld	ra,8(sp)
    80003b16:	6402                	ld	s0,0(sp)
    80003b18:	0141                	addi	sp,sp,16
    80003b1a:	8082                	ret

0000000080003b1c <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003b1c:	1101                	addi	sp,sp,-32
    80003b1e:	ec06                	sd	ra,24(sp)
    80003b20:	e822                	sd	s0,16(sp)
    80003b22:	e426                	sd	s1,8(sp)
    80003b24:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003b26:	00016517          	auipc	a0,0x16
    80003b2a:	84250513          	addi	a0,a0,-1982 # 80019368 <ftable>
    80003b2e:	00003097          	auipc	ra,0x3
    80003b32:	944080e7          	jalr	-1724(ra) # 80006472 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b36:	00016497          	auipc	s1,0x16
    80003b3a:	84a48493          	addi	s1,s1,-1974 # 80019380 <ftable+0x18>
    80003b3e:	00016717          	auipc	a4,0x16
    80003b42:	7e270713          	addi	a4,a4,2018 # 8001a320 <ftable+0xfb8>
    if(f->ref == 0){
    80003b46:	40dc                	lw	a5,4(s1)
    80003b48:	cf99                	beqz	a5,80003b66 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b4a:	02848493          	addi	s1,s1,40
    80003b4e:	fee49ce3          	bne	s1,a4,80003b46 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003b52:	00016517          	auipc	a0,0x16
    80003b56:	81650513          	addi	a0,a0,-2026 # 80019368 <ftable>
    80003b5a:	00003097          	auipc	ra,0x3
    80003b5e:	9c8080e7          	jalr	-1592(ra) # 80006522 <release>
  return 0;
    80003b62:	4481                	li	s1,0
    80003b64:	a819                	j	80003b7a <filealloc+0x5e>
      f->ref = 1;
    80003b66:	4785                	li	a5,1
    80003b68:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003b6a:	00015517          	auipc	a0,0x15
    80003b6e:	7fe50513          	addi	a0,a0,2046 # 80019368 <ftable>
    80003b72:	00003097          	auipc	ra,0x3
    80003b76:	9b0080e7          	jalr	-1616(ra) # 80006522 <release>
}
    80003b7a:	8526                	mv	a0,s1
    80003b7c:	60e2                	ld	ra,24(sp)
    80003b7e:	6442                	ld	s0,16(sp)
    80003b80:	64a2                	ld	s1,8(sp)
    80003b82:	6105                	addi	sp,sp,32
    80003b84:	8082                	ret

0000000080003b86 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003b86:	1101                	addi	sp,sp,-32
    80003b88:	ec06                	sd	ra,24(sp)
    80003b8a:	e822                	sd	s0,16(sp)
    80003b8c:	e426                	sd	s1,8(sp)
    80003b8e:	1000                	addi	s0,sp,32
    80003b90:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003b92:	00015517          	auipc	a0,0x15
    80003b96:	7d650513          	addi	a0,a0,2006 # 80019368 <ftable>
    80003b9a:	00003097          	auipc	ra,0x3
    80003b9e:	8d8080e7          	jalr	-1832(ra) # 80006472 <acquire>
  if(f->ref < 1)
    80003ba2:	40dc                	lw	a5,4(s1)
    80003ba4:	02f05263          	blez	a5,80003bc8 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003ba8:	2785                	addiw	a5,a5,1
    80003baa:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003bac:	00015517          	auipc	a0,0x15
    80003bb0:	7bc50513          	addi	a0,a0,1980 # 80019368 <ftable>
    80003bb4:	00003097          	auipc	ra,0x3
    80003bb8:	96e080e7          	jalr	-1682(ra) # 80006522 <release>
  return f;
}
    80003bbc:	8526                	mv	a0,s1
    80003bbe:	60e2                	ld	ra,24(sp)
    80003bc0:	6442                	ld	s0,16(sp)
    80003bc2:	64a2                	ld	s1,8(sp)
    80003bc4:	6105                	addi	sp,sp,32
    80003bc6:	8082                	ret
    panic("filedup");
    80003bc8:	00005517          	auipc	a0,0x5
    80003bcc:	99050513          	addi	a0,a0,-1648 # 80008558 <etext+0x558>
    80003bd0:	00002097          	auipc	ra,0x2
    80003bd4:	322080e7          	jalr	802(ra) # 80005ef2 <panic>

0000000080003bd8 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003bd8:	7139                	addi	sp,sp,-64
    80003bda:	fc06                	sd	ra,56(sp)
    80003bdc:	f822                	sd	s0,48(sp)
    80003bde:	f426                	sd	s1,40(sp)
    80003be0:	0080                	addi	s0,sp,64
    80003be2:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003be4:	00015517          	auipc	a0,0x15
    80003be8:	78450513          	addi	a0,a0,1924 # 80019368 <ftable>
    80003bec:	00003097          	auipc	ra,0x3
    80003bf0:	886080e7          	jalr	-1914(ra) # 80006472 <acquire>
  if(f->ref < 1)
    80003bf4:	40dc                	lw	a5,4(s1)
    80003bf6:	04f05a63          	blez	a5,80003c4a <fileclose+0x72>
    panic("fileclose");
  if(--f->ref > 0){
    80003bfa:	37fd                	addiw	a5,a5,-1
    80003bfc:	c0dc                	sw	a5,4(s1)
    80003bfe:	06f04263          	bgtz	a5,80003c62 <fileclose+0x8a>
    80003c02:	f04a                	sd	s2,32(sp)
    80003c04:	ec4e                	sd	s3,24(sp)
    80003c06:	e852                	sd	s4,16(sp)
    80003c08:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003c0a:	0004a903          	lw	s2,0(s1)
    80003c0e:	0094ca83          	lbu	s5,9(s1)
    80003c12:	0104ba03          	ld	s4,16(s1)
    80003c16:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003c1a:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003c1e:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003c22:	00015517          	auipc	a0,0x15
    80003c26:	74650513          	addi	a0,a0,1862 # 80019368 <ftable>
    80003c2a:	00003097          	auipc	ra,0x3
    80003c2e:	8f8080e7          	jalr	-1800(ra) # 80006522 <release>

  if(ff.type == FD_PIPE){
    80003c32:	4785                	li	a5,1
    80003c34:	04f90463          	beq	s2,a5,80003c7c <fileclose+0xa4>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003c38:	3979                	addiw	s2,s2,-2
    80003c3a:	4785                	li	a5,1
    80003c3c:	0527fb63          	bgeu	a5,s2,80003c92 <fileclose+0xba>
    80003c40:	7902                	ld	s2,32(sp)
    80003c42:	69e2                	ld	s3,24(sp)
    80003c44:	6a42                	ld	s4,16(sp)
    80003c46:	6aa2                	ld	s5,8(sp)
    80003c48:	a02d                	j	80003c72 <fileclose+0x9a>
    80003c4a:	f04a                	sd	s2,32(sp)
    80003c4c:	ec4e                	sd	s3,24(sp)
    80003c4e:	e852                	sd	s4,16(sp)
    80003c50:	e456                	sd	s5,8(sp)
    panic("fileclose");
    80003c52:	00005517          	auipc	a0,0x5
    80003c56:	90e50513          	addi	a0,a0,-1778 # 80008560 <etext+0x560>
    80003c5a:	00002097          	auipc	ra,0x2
    80003c5e:	298080e7          	jalr	664(ra) # 80005ef2 <panic>
    release(&ftable.lock);
    80003c62:	00015517          	auipc	a0,0x15
    80003c66:	70650513          	addi	a0,a0,1798 # 80019368 <ftable>
    80003c6a:	00003097          	auipc	ra,0x3
    80003c6e:	8b8080e7          	jalr	-1864(ra) # 80006522 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    80003c72:	70e2                	ld	ra,56(sp)
    80003c74:	7442                	ld	s0,48(sp)
    80003c76:	74a2                	ld	s1,40(sp)
    80003c78:	6121                	addi	sp,sp,64
    80003c7a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003c7c:	85d6                	mv	a1,s5
    80003c7e:	8552                	mv	a0,s4
    80003c80:	00000097          	auipc	ra,0x0
    80003c84:	3ac080e7          	jalr	940(ra) # 8000402c <pipeclose>
    80003c88:	7902                	ld	s2,32(sp)
    80003c8a:	69e2                	ld	s3,24(sp)
    80003c8c:	6a42                	ld	s4,16(sp)
    80003c8e:	6aa2                	ld	s5,8(sp)
    80003c90:	b7cd                	j	80003c72 <fileclose+0x9a>
    begin_op();
    80003c92:	00000097          	auipc	ra,0x0
    80003c96:	a76080e7          	jalr	-1418(ra) # 80003708 <begin_op>
    iput(ff.ip);
    80003c9a:	854e                	mv	a0,s3
    80003c9c:	fffff097          	auipc	ra,0xfffff
    80003ca0:	238080e7          	jalr	568(ra) # 80002ed4 <iput>
    end_op();
    80003ca4:	00000097          	auipc	ra,0x0
    80003ca8:	ade080e7          	jalr	-1314(ra) # 80003782 <end_op>
    80003cac:	7902                	ld	s2,32(sp)
    80003cae:	69e2                	ld	s3,24(sp)
    80003cb0:	6a42                	ld	s4,16(sp)
    80003cb2:	6aa2                	ld	s5,8(sp)
    80003cb4:	bf7d                	j	80003c72 <fileclose+0x9a>

0000000080003cb6 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003cb6:	715d                	addi	sp,sp,-80
    80003cb8:	e486                	sd	ra,72(sp)
    80003cba:	e0a2                	sd	s0,64(sp)
    80003cbc:	fc26                	sd	s1,56(sp)
    80003cbe:	f44e                	sd	s3,40(sp)
    80003cc0:	0880                	addi	s0,sp,80
    80003cc2:	84aa                	mv	s1,a0
    80003cc4:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003cc6:	ffffd097          	auipc	ra,0xffffd
    80003cca:	2c6080e7          	jalr	710(ra) # 80000f8c <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003cce:	409c                	lw	a5,0(s1)
    80003cd0:	37f9                	addiw	a5,a5,-2
    80003cd2:	4705                	li	a4,1
    80003cd4:	04f76a63          	bltu	a4,a5,80003d28 <filestat+0x72>
    80003cd8:	f84a                	sd	s2,48(sp)
    80003cda:	f052                	sd	s4,32(sp)
    80003cdc:	892a                	mv	s2,a0
    ilock(f->ip);
    80003cde:	6c88                	ld	a0,24(s1)
    80003ce0:	fffff097          	auipc	ra,0xfffff
    80003ce4:	036080e7          	jalr	54(ra) # 80002d16 <ilock>
    stati(f->ip, &st);
    80003ce8:	fb840a13          	addi	s4,s0,-72
    80003cec:	85d2                	mv	a1,s4
    80003cee:	6c88                	ld	a0,24(s1)
    80003cf0:	fffff097          	auipc	ra,0xfffff
    80003cf4:	2b4080e7          	jalr	692(ra) # 80002fa4 <stati>
    iunlock(f->ip);
    80003cf8:	6c88                	ld	a0,24(s1)
    80003cfa:	fffff097          	auipc	ra,0xfffff
    80003cfe:	0e2080e7          	jalr	226(ra) # 80002ddc <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003d02:	46e1                	li	a3,24
    80003d04:	8652                	mv	a2,s4
    80003d06:	85ce                	mv	a1,s3
    80003d08:	05093503          	ld	a0,80(s2)
    80003d0c:	ffffd097          	auipc	ra,0xffffd
    80003d10:	e42080e7          	jalr	-446(ra) # 80000b4e <copyout>
    80003d14:	41f5551b          	sraiw	a0,a0,0x1f
    80003d18:	7942                	ld	s2,48(sp)
    80003d1a:	7a02                	ld	s4,32(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003d1c:	60a6                	ld	ra,72(sp)
    80003d1e:	6406                	ld	s0,64(sp)
    80003d20:	74e2                	ld	s1,56(sp)
    80003d22:	79a2                	ld	s3,40(sp)
    80003d24:	6161                	addi	sp,sp,80
    80003d26:	8082                	ret
  return -1;
    80003d28:	557d                	li	a0,-1
    80003d2a:	bfcd                	j	80003d1c <filestat+0x66>

0000000080003d2c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003d2c:	7179                	addi	sp,sp,-48
    80003d2e:	f406                	sd	ra,40(sp)
    80003d30:	f022                	sd	s0,32(sp)
    80003d32:	e84a                	sd	s2,16(sp)
    80003d34:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003d36:	00854783          	lbu	a5,8(a0)
    80003d3a:	cbc5                	beqz	a5,80003dea <fileread+0xbe>
    80003d3c:	ec26                	sd	s1,24(sp)
    80003d3e:	e44e                	sd	s3,8(sp)
    80003d40:	84aa                	mv	s1,a0
    80003d42:	89ae                	mv	s3,a1
    80003d44:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d46:	411c                	lw	a5,0(a0)
    80003d48:	4705                	li	a4,1
    80003d4a:	04e78963          	beq	a5,a4,80003d9c <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d4e:	470d                	li	a4,3
    80003d50:	04e78f63          	beq	a5,a4,80003dae <fileread+0x82>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d54:	4709                	li	a4,2
    80003d56:	08e79263          	bne	a5,a4,80003dda <fileread+0xae>
    ilock(f->ip);
    80003d5a:	6d08                	ld	a0,24(a0)
    80003d5c:	fffff097          	auipc	ra,0xfffff
    80003d60:	fba080e7          	jalr	-70(ra) # 80002d16 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003d64:	874a                	mv	a4,s2
    80003d66:	5094                	lw	a3,32(s1)
    80003d68:	864e                	mv	a2,s3
    80003d6a:	4585                	li	a1,1
    80003d6c:	6c88                	ld	a0,24(s1)
    80003d6e:	fffff097          	auipc	ra,0xfffff
    80003d72:	264080e7          	jalr	612(ra) # 80002fd2 <readi>
    80003d76:	892a                	mv	s2,a0
    80003d78:	00a05563          	blez	a0,80003d82 <fileread+0x56>
      f->off += r;
    80003d7c:	509c                	lw	a5,32(s1)
    80003d7e:	9fa9                	addw	a5,a5,a0
    80003d80:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003d82:	6c88                	ld	a0,24(s1)
    80003d84:	fffff097          	auipc	ra,0xfffff
    80003d88:	058080e7          	jalr	88(ra) # 80002ddc <iunlock>
    80003d8c:	64e2                	ld	s1,24(sp)
    80003d8e:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    80003d90:	854a                	mv	a0,s2
    80003d92:	70a2                	ld	ra,40(sp)
    80003d94:	7402                	ld	s0,32(sp)
    80003d96:	6942                	ld	s2,16(sp)
    80003d98:	6145                	addi	sp,sp,48
    80003d9a:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003d9c:	6908                	ld	a0,16(a0)
    80003d9e:	00000097          	auipc	ra,0x0
    80003da2:	414080e7          	jalr	1044(ra) # 800041b2 <piperead>
    80003da6:	892a                	mv	s2,a0
    80003da8:	64e2                	ld	s1,24(sp)
    80003daa:	69a2                	ld	s3,8(sp)
    80003dac:	b7d5                	j	80003d90 <fileread+0x64>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003dae:	02451783          	lh	a5,36(a0)
    80003db2:	03079693          	slli	a3,a5,0x30
    80003db6:	92c1                	srli	a3,a3,0x30
    80003db8:	4725                	li	a4,9
    80003dba:	02d76a63          	bltu	a4,a3,80003dee <fileread+0xc2>
    80003dbe:	0792                	slli	a5,a5,0x4
    80003dc0:	00015717          	auipc	a4,0x15
    80003dc4:	50870713          	addi	a4,a4,1288 # 800192c8 <devsw>
    80003dc8:	97ba                	add	a5,a5,a4
    80003dca:	639c                	ld	a5,0(a5)
    80003dcc:	c78d                	beqz	a5,80003df6 <fileread+0xca>
    r = devsw[f->major].read(1, addr, n);
    80003dce:	4505                	li	a0,1
    80003dd0:	9782                	jalr	a5
    80003dd2:	892a                	mv	s2,a0
    80003dd4:	64e2                	ld	s1,24(sp)
    80003dd6:	69a2                	ld	s3,8(sp)
    80003dd8:	bf65                	j	80003d90 <fileread+0x64>
    panic("fileread");
    80003dda:	00004517          	auipc	a0,0x4
    80003dde:	79650513          	addi	a0,a0,1942 # 80008570 <etext+0x570>
    80003de2:	00002097          	auipc	ra,0x2
    80003de6:	110080e7          	jalr	272(ra) # 80005ef2 <panic>
    return -1;
    80003dea:	597d                	li	s2,-1
    80003dec:	b755                	j	80003d90 <fileread+0x64>
      return -1;
    80003dee:	597d                	li	s2,-1
    80003df0:	64e2                	ld	s1,24(sp)
    80003df2:	69a2                	ld	s3,8(sp)
    80003df4:	bf71                	j	80003d90 <fileread+0x64>
    80003df6:	597d                	li	s2,-1
    80003df8:	64e2                	ld	s1,24(sp)
    80003dfa:	69a2                	ld	s3,8(sp)
    80003dfc:	bf51                	j	80003d90 <fileread+0x64>

0000000080003dfe <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003dfe:	00954783          	lbu	a5,9(a0)
    80003e02:	12078c63          	beqz	a5,80003f3a <filewrite+0x13c>
{
    80003e06:	711d                	addi	sp,sp,-96
    80003e08:	ec86                	sd	ra,88(sp)
    80003e0a:	e8a2                	sd	s0,80(sp)
    80003e0c:	e0ca                	sd	s2,64(sp)
    80003e0e:	f456                	sd	s5,40(sp)
    80003e10:	f05a                	sd	s6,32(sp)
    80003e12:	1080                	addi	s0,sp,96
    80003e14:	892a                	mv	s2,a0
    80003e16:	8b2e                	mv	s6,a1
    80003e18:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    80003e1a:	411c                	lw	a5,0(a0)
    80003e1c:	4705                	li	a4,1
    80003e1e:	02e78963          	beq	a5,a4,80003e50 <filewrite+0x52>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003e22:	470d                	li	a4,3
    80003e24:	02e78c63          	beq	a5,a4,80003e5c <filewrite+0x5e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003e28:	4709                	li	a4,2
    80003e2a:	0ee79a63          	bne	a5,a4,80003f1e <filewrite+0x120>
    80003e2e:	f852                	sd	s4,48(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003e30:	0cc05563          	blez	a2,80003efa <filewrite+0xfc>
    80003e34:	e4a6                	sd	s1,72(sp)
    80003e36:	fc4e                	sd	s3,56(sp)
    80003e38:	ec5e                	sd	s7,24(sp)
    80003e3a:	e862                	sd	s8,16(sp)
    80003e3c:	e466                	sd	s9,8(sp)
    int i = 0;
    80003e3e:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    80003e40:	6b85                	lui	s7,0x1
    80003e42:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003e46:	6c85                	lui	s9,0x1
    80003e48:	c00c8c9b          	addiw	s9,s9,-1024 # c00 <_entry-0x7ffff400>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003e4c:	4c05                	li	s8,1
    80003e4e:	a849                	j	80003ee0 <filewrite+0xe2>
    ret = pipewrite(f->pipe, addr, n);
    80003e50:	6908                	ld	a0,16(a0)
    80003e52:	00000097          	auipc	ra,0x0
    80003e56:	24a080e7          	jalr	586(ra) # 8000409c <pipewrite>
    80003e5a:	a85d                	j	80003f10 <filewrite+0x112>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003e5c:	02451783          	lh	a5,36(a0)
    80003e60:	03079693          	slli	a3,a5,0x30
    80003e64:	92c1                	srli	a3,a3,0x30
    80003e66:	4725                	li	a4,9
    80003e68:	0cd76b63          	bltu	a4,a3,80003f3e <filewrite+0x140>
    80003e6c:	0792                	slli	a5,a5,0x4
    80003e6e:	00015717          	auipc	a4,0x15
    80003e72:	45a70713          	addi	a4,a4,1114 # 800192c8 <devsw>
    80003e76:	97ba                	add	a5,a5,a4
    80003e78:	679c                	ld	a5,8(a5)
    80003e7a:	c7e1                	beqz	a5,80003f42 <filewrite+0x144>
    ret = devsw[f->major].write(1, addr, n);
    80003e7c:	4505                	li	a0,1
    80003e7e:	9782                	jalr	a5
    80003e80:	a841                	j	80003f10 <filewrite+0x112>
      if(n1 > max)
    80003e82:	2981                	sext.w	s3,s3
      begin_op();
    80003e84:	00000097          	auipc	ra,0x0
    80003e88:	884080e7          	jalr	-1916(ra) # 80003708 <begin_op>
      ilock(f->ip);
    80003e8c:	01893503          	ld	a0,24(s2)
    80003e90:	fffff097          	auipc	ra,0xfffff
    80003e94:	e86080e7          	jalr	-378(ra) # 80002d16 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003e98:	874e                	mv	a4,s3
    80003e9a:	02092683          	lw	a3,32(s2)
    80003e9e:	016a0633          	add	a2,s4,s6
    80003ea2:	85e2                	mv	a1,s8
    80003ea4:	01893503          	ld	a0,24(s2)
    80003ea8:	fffff097          	auipc	ra,0xfffff
    80003eac:	224080e7          	jalr	548(ra) # 800030cc <writei>
    80003eb0:	84aa                	mv	s1,a0
    80003eb2:	00a05763          	blez	a0,80003ec0 <filewrite+0xc2>
        f->off += r;
    80003eb6:	02092783          	lw	a5,32(s2)
    80003eba:	9fa9                	addw	a5,a5,a0
    80003ebc:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003ec0:	01893503          	ld	a0,24(s2)
    80003ec4:	fffff097          	auipc	ra,0xfffff
    80003ec8:	f18080e7          	jalr	-232(ra) # 80002ddc <iunlock>
      end_op();
    80003ecc:	00000097          	auipc	ra,0x0
    80003ed0:	8b6080e7          	jalr	-1866(ra) # 80003782 <end_op>

      if(r != n1){
    80003ed4:	02999563          	bne	s3,s1,80003efe <filewrite+0x100>
        // error from writei
        break;
      }
      i += r;
    80003ed8:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    80003edc:	015a5963          	bge	s4,s5,80003eee <filewrite+0xf0>
      int n1 = n - i;
    80003ee0:	414a87bb          	subw	a5,s5,s4
    80003ee4:	89be                	mv	s3,a5
      if(n1 > max)
    80003ee6:	f8fbdee3          	bge	s7,a5,80003e82 <filewrite+0x84>
    80003eea:	89e6                	mv	s3,s9
    80003eec:	bf59                	j	80003e82 <filewrite+0x84>
    80003eee:	64a6                	ld	s1,72(sp)
    80003ef0:	79e2                	ld	s3,56(sp)
    80003ef2:	6be2                	ld	s7,24(sp)
    80003ef4:	6c42                	ld	s8,16(sp)
    80003ef6:	6ca2                	ld	s9,8(sp)
    80003ef8:	a801                	j	80003f08 <filewrite+0x10a>
    int i = 0;
    80003efa:	4a01                	li	s4,0
    80003efc:	a031                	j	80003f08 <filewrite+0x10a>
    80003efe:	64a6                	ld	s1,72(sp)
    80003f00:	79e2                	ld	s3,56(sp)
    80003f02:	6be2                	ld	s7,24(sp)
    80003f04:	6c42                	ld	s8,16(sp)
    80003f06:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    80003f08:	034a9f63          	bne	s5,s4,80003f46 <filewrite+0x148>
    80003f0c:	8556                	mv	a0,s5
    80003f0e:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003f10:	60e6                	ld	ra,88(sp)
    80003f12:	6446                	ld	s0,80(sp)
    80003f14:	6906                	ld	s2,64(sp)
    80003f16:	7aa2                	ld	s5,40(sp)
    80003f18:	7b02                	ld	s6,32(sp)
    80003f1a:	6125                	addi	sp,sp,96
    80003f1c:	8082                	ret
    80003f1e:	e4a6                	sd	s1,72(sp)
    80003f20:	fc4e                	sd	s3,56(sp)
    80003f22:	f852                	sd	s4,48(sp)
    80003f24:	ec5e                	sd	s7,24(sp)
    80003f26:	e862                	sd	s8,16(sp)
    80003f28:	e466                	sd	s9,8(sp)
    panic("filewrite");
    80003f2a:	00004517          	auipc	a0,0x4
    80003f2e:	65650513          	addi	a0,a0,1622 # 80008580 <etext+0x580>
    80003f32:	00002097          	auipc	ra,0x2
    80003f36:	fc0080e7          	jalr	-64(ra) # 80005ef2 <panic>
    return -1;
    80003f3a:	557d                	li	a0,-1
}
    80003f3c:	8082                	ret
      return -1;
    80003f3e:	557d                	li	a0,-1
    80003f40:	bfc1                	j	80003f10 <filewrite+0x112>
    80003f42:	557d                	li	a0,-1
    80003f44:	b7f1                	j	80003f10 <filewrite+0x112>
    ret = (i == n ? n : -1);
    80003f46:	557d                	li	a0,-1
    80003f48:	7a42                	ld	s4,48(sp)
    80003f4a:	b7d9                	j	80003f10 <filewrite+0x112>

0000000080003f4c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003f4c:	7179                	addi	sp,sp,-48
    80003f4e:	f406                	sd	ra,40(sp)
    80003f50:	f022                	sd	s0,32(sp)
    80003f52:	ec26                	sd	s1,24(sp)
    80003f54:	e052                	sd	s4,0(sp)
    80003f56:	1800                	addi	s0,sp,48
    80003f58:	84aa                	mv	s1,a0
    80003f5a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003f5c:	0005b023          	sd	zero,0(a1)
    80003f60:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003f64:	00000097          	auipc	ra,0x0
    80003f68:	bb8080e7          	jalr	-1096(ra) # 80003b1c <filealloc>
    80003f6c:	e088                	sd	a0,0(s1)
    80003f6e:	cd49                	beqz	a0,80004008 <pipealloc+0xbc>
    80003f70:	00000097          	auipc	ra,0x0
    80003f74:	bac080e7          	jalr	-1108(ra) # 80003b1c <filealloc>
    80003f78:	00aa3023          	sd	a0,0(s4)
    80003f7c:	c141                	beqz	a0,80003ffc <pipealloc+0xb0>
    80003f7e:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003f80:	ffffc097          	auipc	ra,0xffffc
    80003f84:	19a080e7          	jalr	410(ra) # 8000011a <kalloc>
    80003f88:	892a                	mv	s2,a0
    80003f8a:	c13d                	beqz	a0,80003ff0 <pipealloc+0xa4>
    80003f8c:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003f8e:	4985                	li	s3,1
    80003f90:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003f94:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003f98:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003f9c:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003fa0:	00004597          	auipc	a1,0x4
    80003fa4:	5f058593          	addi	a1,a1,1520 # 80008590 <etext+0x590>
    80003fa8:	00002097          	auipc	ra,0x2
    80003fac:	436080e7          	jalr	1078(ra) # 800063de <initlock>
  (*f0)->type = FD_PIPE;
    80003fb0:	609c                	ld	a5,0(s1)
    80003fb2:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003fb6:	609c                	ld	a5,0(s1)
    80003fb8:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003fbc:	609c                	ld	a5,0(s1)
    80003fbe:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003fc2:	609c                	ld	a5,0(s1)
    80003fc4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003fc8:	000a3783          	ld	a5,0(s4)
    80003fcc:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003fd0:	000a3783          	ld	a5,0(s4)
    80003fd4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003fd8:	000a3783          	ld	a5,0(s4)
    80003fdc:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003fe0:	000a3783          	ld	a5,0(s4)
    80003fe4:	0127b823          	sd	s2,16(a5)
  return 0;
    80003fe8:	4501                	li	a0,0
    80003fea:	6942                	ld	s2,16(sp)
    80003fec:	69a2                	ld	s3,8(sp)
    80003fee:	a03d                	j	8000401c <pipealloc+0xd0>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003ff0:	6088                	ld	a0,0(s1)
    80003ff2:	c119                	beqz	a0,80003ff8 <pipealloc+0xac>
    80003ff4:	6942                	ld	s2,16(sp)
    80003ff6:	a029                	j	80004000 <pipealloc+0xb4>
    80003ff8:	6942                	ld	s2,16(sp)
    80003ffa:	a039                	j	80004008 <pipealloc+0xbc>
    80003ffc:	6088                	ld	a0,0(s1)
    80003ffe:	c50d                	beqz	a0,80004028 <pipealloc+0xdc>
    fileclose(*f0);
    80004000:	00000097          	auipc	ra,0x0
    80004004:	bd8080e7          	jalr	-1064(ra) # 80003bd8 <fileclose>
  if(*f1)
    80004008:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    8000400c:	557d                	li	a0,-1
  if(*f1)
    8000400e:	c799                	beqz	a5,8000401c <pipealloc+0xd0>
    fileclose(*f1);
    80004010:	853e                	mv	a0,a5
    80004012:	00000097          	auipc	ra,0x0
    80004016:	bc6080e7          	jalr	-1082(ra) # 80003bd8 <fileclose>
  return -1;
    8000401a:	557d                	li	a0,-1
}
    8000401c:	70a2                	ld	ra,40(sp)
    8000401e:	7402                	ld	s0,32(sp)
    80004020:	64e2                	ld	s1,24(sp)
    80004022:	6a02                	ld	s4,0(sp)
    80004024:	6145                	addi	sp,sp,48
    80004026:	8082                	ret
  return -1;
    80004028:	557d                	li	a0,-1
    8000402a:	bfcd                	j	8000401c <pipealloc+0xd0>

000000008000402c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000402c:	1101                	addi	sp,sp,-32
    8000402e:	ec06                	sd	ra,24(sp)
    80004030:	e822                	sd	s0,16(sp)
    80004032:	e426                	sd	s1,8(sp)
    80004034:	e04a                	sd	s2,0(sp)
    80004036:	1000                	addi	s0,sp,32
    80004038:	84aa                	mv	s1,a0
    8000403a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000403c:	00002097          	auipc	ra,0x2
    80004040:	436080e7          	jalr	1078(ra) # 80006472 <acquire>
  if(writable){
    80004044:	02090d63          	beqz	s2,8000407e <pipeclose+0x52>
    pi->writeopen = 0;
    80004048:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    8000404c:	21848513          	addi	a0,s1,536
    80004050:	ffffe097          	auipc	ra,0xffffe
    80004054:	83c080e7          	jalr	-1988(ra) # 8000188c <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004058:	2204b783          	ld	a5,544(s1)
    8000405c:	eb95                	bnez	a5,80004090 <pipeclose+0x64>
    release(&pi->lock);
    8000405e:	8526                	mv	a0,s1
    80004060:	00002097          	auipc	ra,0x2
    80004064:	4c2080e7          	jalr	1218(ra) # 80006522 <release>
    kfree((char*)pi);
    80004068:	8526                	mv	a0,s1
    8000406a:	ffffc097          	auipc	ra,0xffffc
    8000406e:	fb2080e7          	jalr	-78(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80004072:	60e2                	ld	ra,24(sp)
    80004074:	6442                	ld	s0,16(sp)
    80004076:	64a2                	ld	s1,8(sp)
    80004078:	6902                	ld	s2,0(sp)
    8000407a:	6105                	addi	sp,sp,32
    8000407c:	8082                	ret
    pi->readopen = 0;
    8000407e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004082:	21c48513          	addi	a0,s1,540
    80004086:	ffffe097          	auipc	ra,0xffffe
    8000408a:	806080e7          	jalr	-2042(ra) # 8000188c <wakeup>
    8000408e:	b7e9                	j	80004058 <pipeclose+0x2c>
    release(&pi->lock);
    80004090:	8526                	mv	a0,s1
    80004092:	00002097          	auipc	ra,0x2
    80004096:	490080e7          	jalr	1168(ra) # 80006522 <release>
}
    8000409a:	bfe1                	j	80004072 <pipeclose+0x46>

000000008000409c <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    8000409c:	7159                	addi	sp,sp,-112
    8000409e:	f486                	sd	ra,104(sp)
    800040a0:	f0a2                	sd	s0,96(sp)
    800040a2:	eca6                	sd	s1,88(sp)
    800040a4:	e8ca                	sd	s2,80(sp)
    800040a6:	e4ce                	sd	s3,72(sp)
    800040a8:	e0d2                	sd	s4,64(sp)
    800040aa:	fc56                	sd	s5,56(sp)
    800040ac:	1880                	addi	s0,sp,112
    800040ae:	84aa                	mv	s1,a0
    800040b0:	8aae                	mv	s5,a1
    800040b2:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800040b4:	ffffd097          	auipc	ra,0xffffd
    800040b8:	ed8080e7          	jalr	-296(ra) # 80000f8c <myproc>
    800040bc:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800040be:	8526                	mv	a0,s1
    800040c0:	00002097          	auipc	ra,0x2
    800040c4:	3b2080e7          	jalr	946(ra) # 80006472 <acquire>
  while(i < n){
    800040c8:	0d405d63          	blez	s4,800041a2 <pipewrite+0x106>
    800040cc:	f85a                	sd	s6,48(sp)
    800040ce:	f45e                	sd	s7,40(sp)
    800040d0:	f062                	sd	s8,32(sp)
    800040d2:	ec66                	sd	s9,24(sp)
    800040d4:	e86a                	sd	s10,16(sp)
  int i = 0;
    800040d6:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800040d8:	f9f40c13          	addi	s8,s0,-97
    800040dc:	4b85                	li	s7,1
    800040de:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800040e0:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    800040e4:	21c48c93          	addi	s9,s1,540
    800040e8:	a099                	j	8000412e <pipewrite+0x92>
      release(&pi->lock);
    800040ea:	8526                	mv	a0,s1
    800040ec:	00002097          	auipc	ra,0x2
    800040f0:	436080e7          	jalr	1078(ra) # 80006522 <release>
      return -1;
    800040f4:	597d                	li	s2,-1
    800040f6:	7b42                	ld	s6,48(sp)
    800040f8:	7ba2                	ld	s7,40(sp)
    800040fa:	7c02                	ld	s8,32(sp)
    800040fc:	6ce2                	ld	s9,24(sp)
    800040fe:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004100:	854a                	mv	a0,s2
    80004102:	70a6                	ld	ra,104(sp)
    80004104:	7406                	ld	s0,96(sp)
    80004106:	64e6                	ld	s1,88(sp)
    80004108:	6946                	ld	s2,80(sp)
    8000410a:	69a6                	ld	s3,72(sp)
    8000410c:	6a06                	ld	s4,64(sp)
    8000410e:	7ae2                	ld	s5,56(sp)
    80004110:	6165                	addi	sp,sp,112
    80004112:	8082                	ret
      wakeup(&pi->nread);
    80004114:	856a                	mv	a0,s10
    80004116:	ffffd097          	auipc	ra,0xffffd
    8000411a:	776080e7          	jalr	1910(ra) # 8000188c <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    8000411e:	85a6                	mv	a1,s1
    80004120:	8566                	mv	a0,s9
    80004122:	ffffd097          	auipc	ra,0xffffd
    80004126:	5e4080e7          	jalr	1508(ra) # 80001706 <sleep>
  while(i < n){
    8000412a:	05495b63          	bge	s2,s4,80004180 <pipewrite+0xe4>
    if(pi->readopen == 0 || pr->killed){
    8000412e:	2204a783          	lw	a5,544(s1)
    80004132:	dfc5                	beqz	a5,800040ea <pipewrite+0x4e>
    80004134:	0289a783          	lw	a5,40(s3)
    80004138:	fbcd                	bnez	a5,800040ea <pipewrite+0x4e>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    8000413a:	2184a783          	lw	a5,536(s1)
    8000413e:	21c4a703          	lw	a4,540(s1)
    80004142:	2007879b          	addiw	a5,a5,512
    80004146:	fcf707e3          	beq	a4,a5,80004114 <pipewrite+0x78>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    8000414a:	86de                	mv	a3,s7
    8000414c:	01590633          	add	a2,s2,s5
    80004150:	85e2                	mv	a1,s8
    80004152:	0509b503          	ld	a0,80(s3)
    80004156:	ffffd097          	auipc	ra,0xffffd
    8000415a:	a84080e7          	jalr	-1404(ra) # 80000bda <copyin>
    8000415e:	05650463          	beq	a0,s6,800041a6 <pipewrite+0x10a>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004162:	21c4a783          	lw	a5,540(s1)
    80004166:	0017871b          	addiw	a4,a5,1
    8000416a:	20e4ae23          	sw	a4,540(s1)
    8000416e:	1ff7f793          	andi	a5,a5,511
    80004172:	97a6                	add	a5,a5,s1
    80004174:	f9f44703          	lbu	a4,-97(s0)
    80004178:	00e78c23          	sb	a4,24(a5)
      i++;
    8000417c:	2905                	addiw	s2,s2,1
    8000417e:	b775                	j	8000412a <pipewrite+0x8e>
    80004180:	7b42                	ld	s6,48(sp)
    80004182:	7ba2                	ld	s7,40(sp)
    80004184:	7c02                	ld	s8,32(sp)
    80004186:	6ce2                	ld	s9,24(sp)
    80004188:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    8000418a:	21848513          	addi	a0,s1,536
    8000418e:	ffffd097          	auipc	ra,0xffffd
    80004192:	6fe080e7          	jalr	1790(ra) # 8000188c <wakeup>
  release(&pi->lock);
    80004196:	8526                	mv	a0,s1
    80004198:	00002097          	auipc	ra,0x2
    8000419c:	38a080e7          	jalr	906(ra) # 80006522 <release>
  return i;
    800041a0:	b785                	j	80004100 <pipewrite+0x64>
  int i = 0;
    800041a2:	4901                	li	s2,0
    800041a4:	b7dd                	j	8000418a <pipewrite+0xee>
    800041a6:	7b42                	ld	s6,48(sp)
    800041a8:	7ba2                	ld	s7,40(sp)
    800041aa:	7c02                	ld	s8,32(sp)
    800041ac:	6ce2                	ld	s9,24(sp)
    800041ae:	6d42                	ld	s10,16(sp)
    800041b0:	bfe9                	j	8000418a <pipewrite+0xee>

00000000800041b2 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800041b2:	711d                	addi	sp,sp,-96
    800041b4:	ec86                	sd	ra,88(sp)
    800041b6:	e8a2                	sd	s0,80(sp)
    800041b8:	e4a6                	sd	s1,72(sp)
    800041ba:	e0ca                	sd	s2,64(sp)
    800041bc:	fc4e                	sd	s3,56(sp)
    800041be:	f852                	sd	s4,48(sp)
    800041c0:	f456                	sd	s5,40(sp)
    800041c2:	1080                	addi	s0,sp,96
    800041c4:	84aa                	mv	s1,a0
    800041c6:	892e                	mv	s2,a1
    800041c8:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800041ca:	ffffd097          	auipc	ra,0xffffd
    800041ce:	dc2080e7          	jalr	-574(ra) # 80000f8c <myproc>
    800041d2:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800041d4:	8526                	mv	a0,s1
    800041d6:	00002097          	auipc	ra,0x2
    800041da:	29c080e7          	jalr	668(ra) # 80006472 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041de:	2184a703          	lw	a4,536(s1)
    800041e2:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041e6:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041ea:	02f71863          	bne	a4,a5,8000421a <piperead+0x68>
    800041ee:	2244a783          	lw	a5,548(s1)
    800041f2:	cf9d                	beqz	a5,80004230 <piperead+0x7e>
    if(pr->killed){
    800041f4:	028a2783          	lw	a5,40(s4)
    800041f8:	e78d                	bnez	a5,80004222 <piperead+0x70>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041fa:	85a6                	mv	a1,s1
    800041fc:	854e                	mv	a0,s3
    800041fe:	ffffd097          	auipc	ra,0xffffd
    80004202:	508080e7          	jalr	1288(ra) # 80001706 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004206:	2184a703          	lw	a4,536(s1)
    8000420a:	21c4a783          	lw	a5,540(s1)
    8000420e:	fef700e3          	beq	a4,a5,800041ee <piperead+0x3c>
    80004212:	f05a                	sd	s6,32(sp)
    80004214:	ec5e                	sd	s7,24(sp)
    80004216:	e862                	sd	s8,16(sp)
    80004218:	a839                	j	80004236 <piperead+0x84>
    8000421a:	f05a                	sd	s6,32(sp)
    8000421c:	ec5e                	sd	s7,24(sp)
    8000421e:	e862                	sd	s8,16(sp)
    80004220:	a819                	j	80004236 <piperead+0x84>
      release(&pi->lock);
    80004222:	8526                	mv	a0,s1
    80004224:	00002097          	auipc	ra,0x2
    80004228:	2fe080e7          	jalr	766(ra) # 80006522 <release>
      return -1;
    8000422c:	59fd                	li	s3,-1
    8000422e:	a895                	j	800042a2 <piperead+0xf0>
    80004230:	f05a                	sd	s6,32(sp)
    80004232:	ec5e                	sd	s7,24(sp)
    80004234:	e862                	sd	s8,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004236:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004238:	faf40c13          	addi	s8,s0,-81
    8000423c:	4b85                	li	s7,1
    8000423e:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004240:	05505363          	blez	s5,80004286 <piperead+0xd4>
    if(pi->nread == pi->nwrite)
    80004244:	2184a783          	lw	a5,536(s1)
    80004248:	21c4a703          	lw	a4,540(s1)
    8000424c:	02f70d63          	beq	a4,a5,80004286 <piperead+0xd4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004250:	0017871b          	addiw	a4,a5,1
    80004254:	20e4ac23          	sw	a4,536(s1)
    80004258:	1ff7f793          	andi	a5,a5,511
    8000425c:	97a6                	add	a5,a5,s1
    8000425e:	0187c783          	lbu	a5,24(a5)
    80004262:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004266:	86de                	mv	a3,s7
    80004268:	8662                	mv	a2,s8
    8000426a:	85ca                	mv	a1,s2
    8000426c:	050a3503          	ld	a0,80(s4)
    80004270:	ffffd097          	auipc	ra,0xffffd
    80004274:	8de080e7          	jalr	-1826(ra) # 80000b4e <copyout>
    80004278:	01650763          	beq	a0,s6,80004286 <piperead+0xd4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000427c:	2985                	addiw	s3,s3,1
    8000427e:	0905                	addi	s2,s2,1
    80004280:	fd3a92e3          	bne	s5,s3,80004244 <piperead+0x92>
    80004284:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004286:	21c48513          	addi	a0,s1,540
    8000428a:	ffffd097          	auipc	ra,0xffffd
    8000428e:	602080e7          	jalr	1538(ra) # 8000188c <wakeup>
  release(&pi->lock);
    80004292:	8526                	mv	a0,s1
    80004294:	00002097          	auipc	ra,0x2
    80004298:	28e080e7          	jalr	654(ra) # 80006522 <release>
    8000429c:	7b02                	ld	s6,32(sp)
    8000429e:	6be2                	ld	s7,24(sp)
    800042a0:	6c42                	ld	s8,16(sp)
  return i;
}
    800042a2:	854e                	mv	a0,s3
    800042a4:	60e6                	ld	ra,88(sp)
    800042a6:	6446                	ld	s0,80(sp)
    800042a8:	64a6                	ld	s1,72(sp)
    800042aa:	6906                	ld	s2,64(sp)
    800042ac:	79e2                	ld	s3,56(sp)
    800042ae:	7a42                	ld	s4,48(sp)
    800042b0:	7aa2                	ld	s5,40(sp)
    800042b2:	6125                	addi	sp,sp,96
    800042b4:	8082                	ret

00000000800042b6 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800042b6:	de010113          	addi	sp,sp,-544
    800042ba:	20113c23          	sd	ra,536(sp)
    800042be:	20813823          	sd	s0,528(sp)
    800042c2:	20913423          	sd	s1,520(sp)
    800042c6:	21213023          	sd	s2,512(sp)
    800042ca:	1400                	addi	s0,sp,544
    800042cc:	892a                	mv	s2,a0
    800042ce:	dea43823          	sd	a0,-528(s0)
    800042d2:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800042d6:	ffffd097          	auipc	ra,0xffffd
    800042da:	cb6080e7          	jalr	-842(ra) # 80000f8c <myproc>
    800042de:	84aa                	mv	s1,a0

  begin_op();
    800042e0:	fffff097          	auipc	ra,0xfffff
    800042e4:	428080e7          	jalr	1064(ra) # 80003708 <begin_op>

  if((ip = namei(path)) == 0){
    800042e8:	854a                	mv	a0,s2
    800042ea:	fffff097          	auipc	ra,0xfffff
    800042ee:	218080e7          	jalr	536(ra) # 80003502 <namei>
    800042f2:	c525                	beqz	a0,8000435a <exec+0xa4>
    800042f4:	fbd2                	sd	s4,496(sp)
    800042f6:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800042f8:	fffff097          	auipc	ra,0xfffff
    800042fc:	a1e080e7          	jalr	-1506(ra) # 80002d16 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004300:	04000713          	li	a4,64
    80004304:	4681                	li	a3,0
    80004306:	e5040613          	addi	a2,s0,-432
    8000430a:	4581                	li	a1,0
    8000430c:	8552                	mv	a0,s4
    8000430e:	fffff097          	auipc	ra,0xfffff
    80004312:	cc4080e7          	jalr	-828(ra) # 80002fd2 <readi>
    80004316:	04000793          	li	a5,64
    8000431a:	00f51a63          	bne	a0,a5,8000432e <exec+0x78>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    8000431e:	e5042703          	lw	a4,-432(s0)
    80004322:	464c47b7          	lui	a5,0x464c4
    80004326:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000432a:	02f70e63          	beq	a4,a5,80004366 <exec+0xb0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000432e:	8552                	mv	a0,s4
    80004330:	fffff097          	auipc	ra,0xfffff
    80004334:	c4c080e7          	jalr	-948(ra) # 80002f7c <iunlockput>
    end_op();
    80004338:	fffff097          	auipc	ra,0xfffff
    8000433c:	44a080e7          	jalr	1098(ra) # 80003782 <end_op>
  }
  return -1;
    80004340:	557d                	li	a0,-1
    80004342:	7a5e                	ld	s4,496(sp)
}
    80004344:	21813083          	ld	ra,536(sp)
    80004348:	21013403          	ld	s0,528(sp)
    8000434c:	20813483          	ld	s1,520(sp)
    80004350:	20013903          	ld	s2,512(sp)
    80004354:	22010113          	addi	sp,sp,544
    80004358:	8082                	ret
    end_op();
    8000435a:	fffff097          	auipc	ra,0xfffff
    8000435e:	428080e7          	jalr	1064(ra) # 80003782 <end_op>
    return -1;
    80004362:	557d                	li	a0,-1
    80004364:	b7c5                	j	80004344 <exec+0x8e>
    80004366:	f3da                	sd	s6,480(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80004368:	8526                	mv	a0,s1
    8000436a:	ffffd097          	auipc	ra,0xffffd
    8000436e:	ce6080e7          	jalr	-794(ra) # 80001050 <proc_pagetable>
    80004372:	8b2a                	mv	s6,a0
    80004374:	2c050463          	beqz	a0,8000463c <exec+0x386>
    80004378:	ffce                	sd	s3,504(sp)
    8000437a:	f7d6                	sd	s5,488(sp)
    8000437c:	efde                	sd	s7,472(sp)
    8000437e:	ebe2                	sd	s8,464(sp)
    80004380:	e7e6                	sd	s9,456(sp)
    80004382:	e3ea                	sd	s10,448(sp)
    80004384:	ff6e                	sd	s11,440(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004386:	e7042683          	lw	a3,-400(s0)
    8000438a:	e8845783          	lhu	a5,-376(s0)
    8000438e:	cbfd                	beqz	a5,80004484 <exec+0x1ce>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004390:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004392:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004394:	03800d93          	li	s11,56
    if((ph.vaddr % PGSIZE) != 0)
    80004398:	6c85                	lui	s9,0x1
    8000439a:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    8000439e:	def43423          	sd	a5,-536(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    800043a2:	6a85                	lui	s5,0x1
    800043a4:	a0b5                	j	80004410 <exec+0x15a>
      panic("loadseg: address should exist");
    800043a6:	00004517          	auipc	a0,0x4
    800043aa:	1f250513          	addi	a0,a0,498 # 80008598 <etext+0x598>
    800043ae:	00002097          	auipc	ra,0x2
    800043b2:	b44080e7          	jalr	-1212(ra) # 80005ef2 <panic>
    if(sz - i < PGSIZE)
    800043b6:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800043b8:	874a                	mv	a4,s2
    800043ba:	009c06bb          	addw	a3,s8,s1
    800043be:	4581                	li	a1,0
    800043c0:	8552                	mv	a0,s4
    800043c2:	fffff097          	auipc	ra,0xfffff
    800043c6:	c10080e7          	jalr	-1008(ra) # 80002fd2 <readi>
    800043ca:	26a91d63          	bne	s2,a0,80004644 <exec+0x38e>
  for(i = 0; i < sz; i += PGSIZE){
    800043ce:	009a84bb          	addw	s1,s5,s1
    800043d2:	0334f463          	bgeu	s1,s3,800043fa <exec+0x144>
    pa = walkaddr(pagetable, va + i);
    800043d6:	02049593          	slli	a1,s1,0x20
    800043da:	9181                	srli	a1,a1,0x20
    800043dc:	95de                	add	a1,a1,s7
    800043de:	855a                	mv	a0,s6
    800043e0:	ffffc097          	auipc	ra,0xffffc
    800043e4:	138080e7          	jalr	312(ra) # 80000518 <walkaddr>
    800043e8:	862a                	mv	a2,a0
    if(pa == 0)
    800043ea:	dd55                	beqz	a0,800043a6 <exec+0xf0>
    if(sz - i < PGSIZE)
    800043ec:	409987bb          	subw	a5,s3,s1
    800043f0:	893e                	mv	s2,a5
    800043f2:	fcfcf2e3          	bgeu	s9,a5,800043b6 <exec+0x100>
    800043f6:	8956                	mv	s2,s5
    800043f8:	bf7d                	j	800043b6 <exec+0x100>
    sz = sz1;
    800043fa:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800043fe:	2d05                	addiw	s10,s10,1
    80004400:	e0843783          	ld	a5,-504(s0)
    80004404:	0387869b          	addiw	a3,a5,56
    80004408:	e8845783          	lhu	a5,-376(s0)
    8000440c:	06fd5d63          	bge	s10,a5,80004486 <exec+0x1d0>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004410:	e0d43423          	sd	a3,-504(s0)
    80004414:	876e                	mv	a4,s11
    80004416:	e1840613          	addi	a2,s0,-488
    8000441a:	4581                	li	a1,0
    8000441c:	8552                	mv	a0,s4
    8000441e:	fffff097          	auipc	ra,0xfffff
    80004422:	bb4080e7          	jalr	-1100(ra) # 80002fd2 <readi>
    80004426:	21b51d63          	bne	a0,s11,80004640 <exec+0x38a>
    if(ph.type != ELF_PROG_LOAD)
    8000442a:	e1842783          	lw	a5,-488(s0)
    8000442e:	4705                	li	a4,1
    80004430:	fce797e3          	bne	a5,a4,800043fe <exec+0x148>
    if(ph.memsz < ph.filesz)
    80004434:	e4043603          	ld	a2,-448(s0)
    80004438:	e3843783          	ld	a5,-456(s0)
    8000443c:	22f66463          	bltu	a2,a5,80004664 <exec+0x3ae>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004440:	e2843783          	ld	a5,-472(s0)
    80004444:	963e                	add	a2,a2,a5
    80004446:	22f66263          	bltu	a2,a5,8000466a <exec+0x3b4>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000444a:	85a6                	mv	a1,s1
    8000444c:	855a                	mv	a0,s6
    8000444e:	ffffc097          	auipc	ra,0xffffc
    80004452:	48e080e7          	jalr	1166(ra) # 800008dc <uvmalloc>
    80004456:	dea43c23          	sd	a0,-520(s0)
    8000445a:	20050b63          	beqz	a0,80004670 <exec+0x3ba>
    if((ph.vaddr % PGSIZE) != 0)
    8000445e:	e2843b83          	ld	s7,-472(s0)
    80004462:	de843783          	ld	a5,-536(s0)
    80004466:	00fbf7b3          	and	a5,s7,a5
    8000446a:	1c079d63          	bnez	a5,80004644 <exec+0x38e>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000446e:	e2042c03          	lw	s8,-480(s0)
    80004472:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004476:	00098463          	beqz	s3,8000447e <exec+0x1c8>
    8000447a:	4481                	li	s1,0
    8000447c:	bfa9                	j	800043d6 <exec+0x120>
    sz = sz1;
    8000447e:	df843483          	ld	s1,-520(s0)
    80004482:	bfb5                	j	800043fe <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004484:	4481                	li	s1,0
  iunlockput(ip);
    80004486:	8552                	mv	a0,s4
    80004488:	fffff097          	auipc	ra,0xfffff
    8000448c:	af4080e7          	jalr	-1292(ra) # 80002f7c <iunlockput>
  end_op();
    80004490:	fffff097          	auipc	ra,0xfffff
    80004494:	2f2080e7          	jalr	754(ra) # 80003782 <end_op>
  p = myproc();
    80004498:	ffffd097          	auipc	ra,0xffffd
    8000449c:	af4080e7          	jalr	-1292(ra) # 80000f8c <myproc>
    800044a0:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800044a2:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800044a6:	6985                	lui	s3,0x1
    800044a8:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    800044aa:	99a6                	add	s3,s3,s1
    800044ac:	77fd                	lui	a5,0xfffff
    800044ae:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    800044b2:	6609                	lui	a2,0x2
    800044b4:	964e                	add	a2,a2,s3
    800044b6:	85ce                	mv	a1,s3
    800044b8:	855a                	mv	a0,s6
    800044ba:	ffffc097          	auipc	ra,0xffffc
    800044be:	422080e7          	jalr	1058(ra) # 800008dc <uvmalloc>
    800044c2:	8a2a                	mv	s4,a0
    800044c4:	e115                	bnez	a0,800044e8 <exec+0x232>
    proc_freepagetable(pagetable, sz);
    800044c6:	85ce                	mv	a1,s3
    800044c8:	855a                	mv	a0,s6
    800044ca:	ffffd097          	auipc	ra,0xffffd
    800044ce:	c86080e7          	jalr	-890(ra) # 80001150 <proc_freepagetable>
  return -1;
    800044d2:	557d                	li	a0,-1
    800044d4:	79fe                	ld	s3,504(sp)
    800044d6:	7a5e                	ld	s4,496(sp)
    800044d8:	7abe                	ld	s5,488(sp)
    800044da:	7b1e                	ld	s6,480(sp)
    800044dc:	6bfe                	ld	s7,472(sp)
    800044de:	6c5e                	ld	s8,464(sp)
    800044e0:	6cbe                	ld	s9,456(sp)
    800044e2:	6d1e                	ld	s10,448(sp)
    800044e4:	7dfa                	ld	s11,440(sp)
    800044e6:	bdb9                	j	80004344 <exec+0x8e>
  uvmclear(pagetable, sz-2*PGSIZE);
    800044e8:	75f9                	lui	a1,0xffffe
    800044ea:	95aa                	add	a1,a1,a0
    800044ec:	855a                	mv	a0,s6
    800044ee:	ffffc097          	auipc	ra,0xffffc
    800044f2:	62e080e7          	jalr	1582(ra) # 80000b1c <uvmclear>
  stackbase = sp - PGSIZE;
    800044f6:	7bfd                	lui	s7,0xfffff
    800044f8:	9bd2                	add	s7,s7,s4
  for(argc = 0; argv[argc]; argc++) {
    800044fa:	e0043783          	ld	a5,-512(s0)
    800044fe:	6388                	ld	a0,0(a5)
  sp = sz;
    80004500:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    80004502:	4481                	li	s1,0
    ustack[argc] = sp;
    80004504:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    80004508:	02000c13          	li	s8,32
  for(argc = 0; argv[argc]; argc++) {
    8000450c:	c135                	beqz	a0,80004570 <exec+0x2ba>
    sp -= strlen(argv[argc]) + 1;
    8000450e:	ffffc097          	auipc	ra,0xffffc
    80004512:	df8080e7          	jalr	-520(ra) # 80000306 <strlen>
    80004516:	0015079b          	addiw	a5,a0,1
    8000451a:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    8000451e:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80004522:	15796a63          	bltu	s2,s7,80004676 <exec+0x3c0>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004526:	e0043d83          	ld	s11,-512(s0)
    8000452a:	000db983          	ld	s3,0(s11)
    8000452e:	854e                	mv	a0,s3
    80004530:	ffffc097          	auipc	ra,0xffffc
    80004534:	dd6080e7          	jalr	-554(ra) # 80000306 <strlen>
    80004538:	0015069b          	addiw	a3,a0,1
    8000453c:	864e                	mv	a2,s3
    8000453e:	85ca                	mv	a1,s2
    80004540:	855a                	mv	a0,s6
    80004542:	ffffc097          	auipc	ra,0xffffc
    80004546:	60c080e7          	jalr	1548(ra) # 80000b4e <copyout>
    8000454a:	12054863          	bltz	a0,8000467a <exec+0x3c4>
    ustack[argc] = sp;
    8000454e:	00349793          	slli	a5,s1,0x3
    80004552:	97e6                	add	a5,a5,s9
    80004554:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffd8dc0>
  for(argc = 0; argv[argc]; argc++) {
    80004558:	0485                	addi	s1,s1,1
    8000455a:	008d8793          	addi	a5,s11,8
    8000455e:	e0f43023          	sd	a5,-512(s0)
    80004562:	008db503          	ld	a0,8(s11)
    80004566:	c509                	beqz	a0,80004570 <exec+0x2ba>
    if(argc >= MAXARG)
    80004568:	fb8493e3          	bne	s1,s8,8000450e <exec+0x258>
  sz = sz1;
    8000456c:	89d2                	mv	s3,s4
    8000456e:	bfa1                	j	800044c6 <exec+0x210>
  ustack[argc] = 0;
    80004570:	00349793          	slli	a5,s1,0x3
    80004574:	f9078793          	addi	a5,a5,-112
    80004578:	97a2                	add	a5,a5,s0
    8000457a:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    8000457e:	00148693          	addi	a3,s1,1
    80004582:	068e                	slli	a3,a3,0x3
    80004584:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004588:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    8000458c:	89d2                	mv	s3,s4
  if(sp < stackbase)
    8000458e:	f3796ce3          	bltu	s2,s7,800044c6 <exec+0x210>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004592:	e9040613          	addi	a2,s0,-368
    80004596:	85ca                	mv	a1,s2
    80004598:	855a                	mv	a0,s6
    8000459a:	ffffc097          	auipc	ra,0xffffc
    8000459e:	5b4080e7          	jalr	1460(ra) # 80000b4e <copyout>
    800045a2:	f20542e3          	bltz	a0,800044c6 <exec+0x210>
  p->trapframe->a1 = sp;
    800045a6:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    800045aa:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800045ae:	df043783          	ld	a5,-528(s0)
    800045b2:	0007c703          	lbu	a4,0(a5)
    800045b6:	cf11                	beqz	a4,800045d2 <exec+0x31c>
    800045b8:	0785                	addi	a5,a5,1
    if(*s == '/')
    800045ba:	02f00693          	li	a3,47
    800045be:	a029                	j	800045c8 <exec+0x312>
  for(last=s=path; *s; s++)
    800045c0:	0785                	addi	a5,a5,1
    800045c2:	fff7c703          	lbu	a4,-1(a5)
    800045c6:	c711                	beqz	a4,800045d2 <exec+0x31c>
    if(*s == '/')
    800045c8:	fed71ce3          	bne	a4,a3,800045c0 <exec+0x30a>
      last = s+1;
    800045cc:	def43823          	sd	a5,-528(s0)
    800045d0:	bfc5                	j	800045c0 <exec+0x30a>
  safestrcpy(p->name, last, sizeof(p->name));
    800045d2:	4641                	li	a2,16
    800045d4:	df043583          	ld	a1,-528(s0)
    800045d8:	158a8513          	addi	a0,s5,344
    800045dc:	ffffc097          	auipc	ra,0xffffc
    800045e0:	cf4080e7          	jalr	-780(ra) # 800002d0 <safestrcpy>
  oldpagetable = p->pagetable;
    800045e4:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800045e8:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    800045ec:	054ab423          	sd	s4,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800045f0:	058ab783          	ld	a5,88(s5)
    800045f4:	e6843703          	ld	a4,-408(s0)
    800045f8:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800045fa:	058ab783          	ld	a5,88(s5)
    800045fe:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004602:	85ea                	mv	a1,s10
    80004604:	ffffd097          	auipc	ra,0xffffd
    80004608:	b4c080e7          	jalr	-1204(ra) # 80001150 <proc_freepagetable>
  if(p->pid == 1)
    8000460c:	030aa703          	lw	a4,48(s5)
    80004610:	4785                	li	a5,1
    80004612:	00f70e63          	beq	a4,a5,8000462e <exec+0x378>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004616:	0004851b          	sext.w	a0,s1
    8000461a:	79fe                	ld	s3,504(sp)
    8000461c:	7a5e                	ld	s4,496(sp)
    8000461e:	7abe                	ld	s5,488(sp)
    80004620:	7b1e                	ld	s6,480(sp)
    80004622:	6bfe                	ld	s7,472(sp)
    80004624:	6c5e                	ld	s8,464(sp)
    80004626:	6cbe                	ld	s9,456(sp)
    80004628:	6d1e                	ld	s10,448(sp)
    8000462a:	7dfa                	ld	s11,440(sp)
    8000462c:	bb21                	j	80004344 <exec+0x8e>
    vmprint(p->pagetable);
    8000462e:	050ab503          	ld	a0,80(s5)
    80004632:	ffffc097          	auipc	ra,0xffffc
    80004636:	794080e7          	jalr	1940(ra) # 80000dc6 <vmprint>
    8000463a:	bff1                	j	80004616 <exec+0x360>
    8000463c:	7b1e                	ld	s6,480(sp)
    8000463e:	b9c5                	j	8000432e <exec+0x78>
    80004640:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004644:	df843583          	ld	a1,-520(s0)
    80004648:	855a                	mv	a0,s6
    8000464a:	ffffd097          	auipc	ra,0xffffd
    8000464e:	b06080e7          	jalr	-1274(ra) # 80001150 <proc_freepagetable>
  if(ip){
    80004652:	79fe                	ld	s3,504(sp)
    80004654:	7abe                	ld	s5,488(sp)
    80004656:	7b1e                	ld	s6,480(sp)
    80004658:	6bfe                	ld	s7,472(sp)
    8000465a:	6c5e                	ld	s8,464(sp)
    8000465c:	6cbe                	ld	s9,456(sp)
    8000465e:	6d1e                	ld	s10,448(sp)
    80004660:	7dfa                	ld	s11,440(sp)
    80004662:	b1f1                	j	8000432e <exec+0x78>
    80004664:	de943c23          	sd	s1,-520(s0)
    80004668:	bff1                	j	80004644 <exec+0x38e>
    8000466a:	de943c23          	sd	s1,-520(s0)
    8000466e:	bfd9                	j	80004644 <exec+0x38e>
    80004670:	de943c23          	sd	s1,-520(s0)
    80004674:	bfc1                	j	80004644 <exec+0x38e>
  sz = sz1;
    80004676:	89d2                	mv	s3,s4
    80004678:	b5b9                	j	800044c6 <exec+0x210>
    8000467a:	89d2                	mv	s3,s4
    8000467c:	b5a9                	j	800044c6 <exec+0x210>

000000008000467e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000467e:	7179                	addi	sp,sp,-48
    80004680:	f406                	sd	ra,40(sp)
    80004682:	f022                	sd	s0,32(sp)
    80004684:	ec26                	sd	s1,24(sp)
    80004686:	e84a                	sd	s2,16(sp)
    80004688:	1800                	addi	s0,sp,48
    8000468a:	892e                	mv	s2,a1
    8000468c:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    8000468e:	fdc40593          	addi	a1,s0,-36
    80004692:	ffffe097          	auipc	ra,0xffffe
    80004696:	a6c080e7          	jalr	-1428(ra) # 800020fe <argint>
    8000469a:	04054063          	bltz	a0,800046da <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000469e:	fdc42703          	lw	a4,-36(s0)
    800046a2:	47bd                	li	a5,15
    800046a4:	02e7ed63          	bltu	a5,a4,800046de <argfd+0x60>
    800046a8:	ffffd097          	auipc	ra,0xffffd
    800046ac:	8e4080e7          	jalr	-1820(ra) # 80000f8c <myproc>
    800046b0:	fdc42703          	lw	a4,-36(s0)
    800046b4:	01a70793          	addi	a5,a4,26
    800046b8:	078e                	slli	a5,a5,0x3
    800046ba:	953e                	add	a0,a0,a5
    800046bc:	611c                	ld	a5,0(a0)
    800046be:	c395                	beqz	a5,800046e2 <argfd+0x64>
    return -1;
  if(pfd)
    800046c0:	00090463          	beqz	s2,800046c8 <argfd+0x4a>
    *pfd = fd;
    800046c4:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800046c8:	4501                	li	a0,0
  if(pf)
    800046ca:	c091                	beqz	s1,800046ce <argfd+0x50>
    *pf = f;
    800046cc:	e09c                	sd	a5,0(s1)
}
    800046ce:	70a2                	ld	ra,40(sp)
    800046d0:	7402                	ld	s0,32(sp)
    800046d2:	64e2                	ld	s1,24(sp)
    800046d4:	6942                	ld	s2,16(sp)
    800046d6:	6145                	addi	sp,sp,48
    800046d8:	8082                	ret
    return -1;
    800046da:	557d                	li	a0,-1
    800046dc:	bfcd                	j	800046ce <argfd+0x50>
    return -1;
    800046de:	557d                	li	a0,-1
    800046e0:	b7fd                	j	800046ce <argfd+0x50>
    800046e2:	557d                	li	a0,-1
    800046e4:	b7ed                	j	800046ce <argfd+0x50>

00000000800046e6 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800046e6:	1101                	addi	sp,sp,-32
    800046e8:	ec06                	sd	ra,24(sp)
    800046ea:	e822                	sd	s0,16(sp)
    800046ec:	e426                	sd	s1,8(sp)
    800046ee:	1000                	addi	s0,sp,32
    800046f0:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800046f2:	ffffd097          	auipc	ra,0xffffd
    800046f6:	89a080e7          	jalr	-1894(ra) # 80000f8c <myproc>
    800046fa:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800046fc:	0d050793          	addi	a5,a0,208
    80004700:	4501                	li	a0,0
    80004702:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004704:	6398                	ld	a4,0(a5)
    80004706:	cb19                	beqz	a4,8000471c <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004708:	2505                	addiw	a0,a0,1
    8000470a:	07a1                	addi	a5,a5,8
    8000470c:	fed51ce3          	bne	a0,a3,80004704 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004710:	557d                	li	a0,-1
}
    80004712:	60e2                	ld	ra,24(sp)
    80004714:	6442                	ld	s0,16(sp)
    80004716:	64a2                	ld	s1,8(sp)
    80004718:	6105                	addi	sp,sp,32
    8000471a:	8082                	ret
      p->ofile[fd] = f;
    8000471c:	01a50793          	addi	a5,a0,26
    80004720:	078e                	slli	a5,a5,0x3
    80004722:	963e                	add	a2,a2,a5
    80004724:	e204                	sd	s1,0(a2)
      return fd;
    80004726:	b7f5                	j	80004712 <fdalloc+0x2c>

0000000080004728 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004728:	715d                	addi	sp,sp,-80
    8000472a:	e486                	sd	ra,72(sp)
    8000472c:	e0a2                	sd	s0,64(sp)
    8000472e:	fc26                	sd	s1,56(sp)
    80004730:	f84a                	sd	s2,48(sp)
    80004732:	f44e                	sd	s3,40(sp)
    80004734:	f052                	sd	s4,32(sp)
    80004736:	ec56                	sd	s5,24(sp)
    80004738:	0880                	addi	s0,sp,80
    8000473a:	8aae                	mv	s5,a1
    8000473c:	8a32                	mv	s4,a2
    8000473e:	89b6                	mv	s3,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004740:	fb040593          	addi	a1,s0,-80
    80004744:	fffff097          	auipc	ra,0xfffff
    80004748:	ddc080e7          	jalr	-548(ra) # 80003520 <nameiparent>
    8000474c:	892a                	mv	s2,a0
    8000474e:	12050c63          	beqz	a0,80004886 <create+0x15e>
    return 0;

  ilock(dp);
    80004752:	ffffe097          	auipc	ra,0xffffe
    80004756:	5c4080e7          	jalr	1476(ra) # 80002d16 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000475a:	4601                	li	a2,0
    8000475c:	fb040593          	addi	a1,s0,-80
    80004760:	854a                	mv	a0,s2
    80004762:	fffff097          	auipc	ra,0xfffff
    80004766:	aa4080e7          	jalr	-1372(ra) # 80003206 <dirlookup>
    8000476a:	84aa                	mv	s1,a0
    8000476c:	c539                	beqz	a0,800047ba <create+0x92>
    iunlockput(dp);
    8000476e:	854a                	mv	a0,s2
    80004770:	fffff097          	auipc	ra,0xfffff
    80004774:	80c080e7          	jalr	-2036(ra) # 80002f7c <iunlockput>
    ilock(ip);
    80004778:	8526                	mv	a0,s1
    8000477a:	ffffe097          	auipc	ra,0xffffe
    8000477e:	59c080e7          	jalr	1436(ra) # 80002d16 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004782:	4789                	li	a5,2
    80004784:	02fa9463          	bne	s5,a5,800047ac <create+0x84>
    80004788:	0444d783          	lhu	a5,68(s1)
    8000478c:	37f9                	addiw	a5,a5,-2
    8000478e:	17c2                	slli	a5,a5,0x30
    80004790:	93c1                	srli	a5,a5,0x30
    80004792:	4705                	li	a4,1
    80004794:	00f76c63          	bltu	a4,a5,800047ac <create+0x84>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004798:	8526                	mv	a0,s1
    8000479a:	60a6                	ld	ra,72(sp)
    8000479c:	6406                	ld	s0,64(sp)
    8000479e:	74e2                	ld	s1,56(sp)
    800047a0:	7942                	ld	s2,48(sp)
    800047a2:	79a2                	ld	s3,40(sp)
    800047a4:	7a02                	ld	s4,32(sp)
    800047a6:	6ae2                	ld	s5,24(sp)
    800047a8:	6161                	addi	sp,sp,80
    800047aa:	8082                	ret
    iunlockput(ip);
    800047ac:	8526                	mv	a0,s1
    800047ae:	ffffe097          	auipc	ra,0xffffe
    800047b2:	7ce080e7          	jalr	1998(ra) # 80002f7c <iunlockput>
    return 0;
    800047b6:	4481                	li	s1,0
    800047b8:	b7c5                	j	80004798 <create+0x70>
  if((ip = ialloc(dp->dev, type)) == 0)
    800047ba:	85d6                	mv	a1,s5
    800047bc:	00092503          	lw	a0,0(s2)
    800047c0:	ffffe097          	auipc	ra,0xffffe
    800047c4:	3c2080e7          	jalr	962(ra) # 80002b82 <ialloc>
    800047c8:	84aa                	mv	s1,a0
    800047ca:	c139                	beqz	a0,80004810 <create+0xe8>
  ilock(ip);
    800047cc:	ffffe097          	auipc	ra,0xffffe
    800047d0:	54a080e7          	jalr	1354(ra) # 80002d16 <ilock>
  ip->major = major;
    800047d4:	05449323          	sh	s4,70(s1)
  ip->minor = minor;
    800047d8:	05349423          	sh	s3,72(s1)
  ip->nlink = 1;
    800047dc:	4985                	li	s3,1
    800047de:	05349523          	sh	s3,74(s1)
  iupdate(ip);
    800047e2:	8526                	mv	a0,s1
    800047e4:	ffffe097          	auipc	ra,0xffffe
    800047e8:	466080e7          	jalr	1126(ra) # 80002c4a <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800047ec:	033a8a63          	beq	s5,s3,80004820 <create+0xf8>
  if(dirlink(dp, name, ip->inum) < 0)
    800047f0:	40d0                	lw	a2,4(s1)
    800047f2:	fb040593          	addi	a1,s0,-80
    800047f6:	854a                	mv	a0,s2
    800047f8:	fffff097          	auipc	ra,0xfffff
    800047fc:	c34080e7          	jalr	-972(ra) # 8000342c <dirlink>
    80004800:	06054b63          	bltz	a0,80004876 <create+0x14e>
  iunlockput(dp);
    80004804:	854a                	mv	a0,s2
    80004806:	ffffe097          	auipc	ra,0xffffe
    8000480a:	776080e7          	jalr	1910(ra) # 80002f7c <iunlockput>
  return ip;
    8000480e:	b769                	j	80004798 <create+0x70>
    panic("create: ialloc");
    80004810:	00004517          	auipc	a0,0x4
    80004814:	da850513          	addi	a0,a0,-600 # 800085b8 <etext+0x5b8>
    80004818:	00001097          	auipc	ra,0x1
    8000481c:	6da080e7          	jalr	1754(ra) # 80005ef2 <panic>
    dp->nlink++;  // for ".."
    80004820:	04a95783          	lhu	a5,74(s2)
    80004824:	2785                	addiw	a5,a5,1
    80004826:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    8000482a:	854a                	mv	a0,s2
    8000482c:	ffffe097          	auipc	ra,0xffffe
    80004830:	41e080e7          	jalr	1054(ra) # 80002c4a <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004834:	40d0                	lw	a2,4(s1)
    80004836:	00004597          	auipc	a1,0x4
    8000483a:	d9258593          	addi	a1,a1,-622 # 800085c8 <etext+0x5c8>
    8000483e:	8526                	mv	a0,s1
    80004840:	fffff097          	auipc	ra,0xfffff
    80004844:	bec080e7          	jalr	-1044(ra) # 8000342c <dirlink>
    80004848:	00054f63          	bltz	a0,80004866 <create+0x13e>
    8000484c:	00492603          	lw	a2,4(s2)
    80004850:	00004597          	auipc	a1,0x4
    80004854:	d8058593          	addi	a1,a1,-640 # 800085d0 <etext+0x5d0>
    80004858:	8526                	mv	a0,s1
    8000485a:	fffff097          	auipc	ra,0xfffff
    8000485e:	bd2080e7          	jalr	-1070(ra) # 8000342c <dirlink>
    80004862:	f80557e3          	bgez	a0,800047f0 <create+0xc8>
      panic("create dots");
    80004866:	00004517          	auipc	a0,0x4
    8000486a:	d7250513          	addi	a0,a0,-654 # 800085d8 <etext+0x5d8>
    8000486e:	00001097          	auipc	ra,0x1
    80004872:	684080e7          	jalr	1668(ra) # 80005ef2 <panic>
    panic("create: dirlink");
    80004876:	00004517          	auipc	a0,0x4
    8000487a:	d7250513          	addi	a0,a0,-654 # 800085e8 <etext+0x5e8>
    8000487e:	00001097          	auipc	ra,0x1
    80004882:	674080e7          	jalr	1652(ra) # 80005ef2 <panic>
    return 0;
    80004886:	84aa                	mv	s1,a0
    80004888:	bf01                	j	80004798 <create+0x70>

000000008000488a <sys_dup>:
{
    8000488a:	7179                	addi	sp,sp,-48
    8000488c:	f406                	sd	ra,40(sp)
    8000488e:	f022                	sd	s0,32(sp)
    80004890:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004892:	fd840613          	addi	a2,s0,-40
    80004896:	4581                	li	a1,0
    80004898:	4501                	li	a0,0
    8000489a:	00000097          	auipc	ra,0x0
    8000489e:	de4080e7          	jalr	-540(ra) # 8000467e <argfd>
    return -1;
    800048a2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800048a4:	02054763          	bltz	a0,800048d2 <sys_dup+0x48>
    800048a8:	ec26                	sd	s1,24(sp)
    800048aa:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    800048ac:	fd843903          	ld	s2,-40(s0)
    800048b0:	854a                	mv	a0,s2
    800048b2:	00000097          	auipc	ra,0x0
    800048b6:	e34080e7          	jalr	-460(ra) # 800046e6 <fdalloc>
    800048ba:	84aa                	mv	s1,a0
    return -1;
    800048bc:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800048be:	00054f63          	bltz	a0,800048dc <sys_dup+0x52>
  filedup(f);
    800048c2:	854a                	mv	a0,s2
    800048c4:	fffff097          	auipc	ra,0xfffff
    800048c8:	2c2080e7          	jalr	706(ra) # 80003b86 <filedup>
  return fd;
    800048cc:	87a6                	mv	a5,s1
    800048ce:	64e2                	ld	s1,24(sp)
    800048d0:	6942                	ld	s2,16(sp)
}
    800048d2:	853e                	mv	a0,a5
    800048d4:	70a2                	ld	ra,40(sp)
    800048d6:	7402                	ld	s0,32(sp)
    800048d8:	6145                	addi	sp,sp,48
    800048da:	8082                	ret
    800048dc:	64e2                	ld	s1,24(sp)
    800048de:	6942                	ld	s2,16(sp)
    800048e0:	bfcd                	j	800048d2 <sys_dup+0x48>

00000000800048e2 <sys_read>:
{
    800048e2:	7179                	addi	sp,sp,-48
    800048e4:	f406                	sd	ra,40(sp)
    800048e6:	f022                	sd	s0,32(sp)
    800048e8:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048ea:	fe840613          	addi	a2,s0,-24
    800048ee:	4581                	li	a1,0
    800048f0:	4501                	li	a0,0
    800048f2:	00000097          	auipc	ra,0x0
    800048f6:	d8c080e7          	jalr	-628(ra) # 8000467e <argfd>
    return -1;
    800048fa:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048fc:	04054163          	bltz	a0,8000493e <sys_read+0x5c>
    80004900:	fe440593          	addi	a1,s0,-28
    80004904:	4509                	li	a0,2
    80004906:	ffffd097          	auipc	ra,0xffffd
    8000490a:	7f8080e7          	jalr	2040(ra) # 800020fe <argint>
    return -1;
    8000490e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004910:	02054763          	bltz	a0,8000493e <sys_read+0x5c>
    80004914:	fd840593          	addi	a1,s0,-40
    80004918:	4505                	li	a0,1
    8000491a:	ffffe097          	auipc	ra,0xffffe
    8000491e:	806080e7          	jalr	-2042(ra) # 80002120 <argaddr>
    return -1;
    80004922:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004924:	00054d63          	bltz	a0,8000493e <sys_read+0x5c>
  return fileread(f, p, n);
    80004928:	fe442603          	lw	a2,-28(s0)
    8000492c:	fd843583          	ld	a1,-40(s0)
    80004930:	fe843503          	ld	a0,-24(s0)
    80004934:	fffff097          	auipc	ra,0xfffff
    80004938:	3f8080e7          	jalr	1016(ra) # 80003d2c <fileread>
    8000493c:	87aa                	mv	a5,a0
}
    8000493e:	853e                	mv	a0,a5
    80004940:	70a2                	ld	ra,40(sp)
    80004942:	7402                	ld	s0,32(sp)
    80004944:	6145                	addi	sp,sp,48
    80004946:	8082                	ret

0000000080004948 <sys_write>:
{
    80004948:	7179                	addi	sp,sp,-48
    8000494a:	f406                	sd	ra,40(sp)
    8000494c:	f022                	sd	s0,32(sp)
    8000494e:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004950:	fe840613          	addi	a2,s0,-24
    80004954:	4581                	li	a1,0
    80004956:	4501                	li	a0,0
    80004958:	00000097          	auipc	ra,0x0
    8000495c:	d26080e7          	jalr	-730(ra) # 8000467e <argfd>
    return -1;
    80004960:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004962:	04054163          	bltz	a0,800049a4 <sys_write+0x5c>
    80004966:	fe440593          	addi	a1,s0,-28
    8000496a:	4509                	li	a0,2
    8000496c:	ffffd097          	auipc	ra,0xffffd
    80004970:	792080e7          	jalr	1938(ra) # 800020fe <argint>
    return -1;
    80004974:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004976:	02054763          	bltz	a0,800049a4 <sys_write+0x5c>
    8000497a:	fd840593          	addi	a1,s0,-40
    8000497e:	4505                	li	a0,1
    80004980:	ffffd097          	auipc	ra,0xffffd
    80004984:	7a0080e7          	jalr	1952(ra) # 80002120 <argaddr>
    return -1;
    80004988:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000498a:	00054d63          	bltz	a0,800049a4 <sys_write+0x5c>
  return filewrite(f, p, n);
    8000498e:	fe442603          	lw	a2,-28(s0)
    80004992:	fd843583          	ld	a1,-40(s0)
    80004996:	fe843503          	ld	a0,-24(s0)
    8000499a:	fffff097          	auipc	ra,0xfffff
    8000499e:	464080e7          	jalr	1124(ra) # 80003dfe <filewrite>
    800049a2:	87aa                	mv	a5,a0
}
    800049a4:	853e                	mv	a0,a5
    800049a6:	70a2                	ld	ra,40(sp)
    800049a8:	7402                	ld	s0,32(sp)
    800049aa:	6145                	addi	sp,sp,48
    800049ac:	8082                	ret

00000000800049ae <sys_close>:
{
    800049ae:	1101                	addi	sp,sp,-32
    800049b0:	ec06                	sd	ra,24(sp)
    800049b2:	e822                	sd	s0,16(sp)
    800049b4:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800049b6:	fe040613          	addi	a2,s0,-32
    800049ba:	fec40593          	addi	a1,s0,-20
    800049be:	4501                	li	a0,0
    800049c0:	00000097          	auipc	ra,0x0
    800049c4:	cbe080e7          	jalr	-834(ra) # 8000467e <argfd>
    return -1;
    800049c8:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800049ca:	02054463          	bltz	a0,800049f2 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800049ce:	ffffc097          	auipc	ra,0xffffc
    800049d2:	5be080e7          	jalr	1470(ra) # 80000f8c <myproc>
    800049d6:	fec42783          	lw	a5,-20(s0)
    800049da:	07e9                	addi	a5,a5,26
    800049dc:	078e                	slli	a5,a5,0x3
    800049de:	953e                	add	a0,a0,a5
    800049e0:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800049e4:	fe043503          	ld	a0,-32(s0)
    800049e8:	fffff097          	auipc	ra,0xfffff
    800049ec:	1f0080e7          	jalr	496(ra) # 80003bd8 <fileclose>
  return 0;
    800049f0:	4781                	li	a5,0
}
    800049f2:	853e                	mv	a0,a5
    800049f4:	60e2                	ld	ra,24(sp)
    800049f6:	6442                	ld	s0,16(sp)
    800049f8:	6105                	addi	sp,sp,32
    800049fa:	8082                	ret

00000000800049fc <sys_fstat>:
{
    800049fc:	1101                	addi	sp,sp,-32
    800049fe:	ec06                	sd	ra,24(sp)
    80004a00:	e822                	sd	s0,16(sp)
    80004a02:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004a04:	fe840613          	addi	a2,s0,-24
    80004a08:	4581                	li	a1,0
    80004a0a:	4501                	li	a0,0
    80004a0c:	00000097          	auipc	ra,0x0
    80004a10:	c72080e7          	jalr	-910(ra) # 8000467e <argfd>
    return -1;
    80004a14:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004a16:	02054563          	bltz	a0,80004a40 <sys_fstat+0x44>
    80004a1a:	fe040593          	addi	a1,s0,-32
    80004a1e:	4505                	li	a0,1
    80004a20:	ffffd097          	auipc	ra,0xffffd
    80004a24:	700080e7          	jalr	1792(ra) # 80002120 <argaddr>
    return -1;
    80004a28:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004a2a:	00054b63          	bltz	a0,80004a40 <sys_fstat+0x44>
  return filestat(f, st);
    80004a2e:	fe043583          	ld	a1,-32(s0)
    80004a32:	fe843503          	ld	a0,-24(s0)
    80004a36:	fffff097          	auipc	ra,0xfffff
    80004a3a:	280080e7          	jalr	640(ra) # 80003cb6 <filestat>
    80004a3e:	87aa                	mv	a5,a0
}
    80004a40:	853e                	mv	a0,a5
    80004a42:	60e2                	ld	ra,24(sp)
    80004a44:	6442                	ld	s0,16(sp)
    80004a46:	6105                	addi	sp,sp,32
    80004a48:	8082                	ret

0000000080004a4a <sys_link>:
{
    80004a4a:	7169                	addi	sp,sp,-304
    80004a4c:	f606                	sd	ra,296(sp)
    80004a4e:	f222                	sd	s0,288(sp)
    80004a50:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a52:	08000613          	li	a2,128
    80004a56:	ed040593          	addi	a1,s0,-304
    80004a5a:	4501                	li	a0,0
    80004a5c:	ffffd097          	auipc	ra,0xffffd
    80004a60:	6e6080e7          	jalr	1766(ra) # 80002142 <argstr>
    return -1;
    80004a64:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a66:	12054663          	bltz	a0,80004b92 <sys_link+0x148>
    80004a6a:	08000613          	li	a2,128
    80004a6e:	f5040593          	addi	a1,s0,-176
    80004a72:	4505                	li	a0,1
    80004a74:	ffffd097          	auipc	ra,0xffffd
    80004a78:	6ce080e7          	jalr	1742(ra) # 80002142 <argstr>
    return -1;
    80004a7c:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a7e:	10054a63          	bltz	a0,80004b92 <sys_link+0x148>
    80004a82:	ee26                	sd	s1,280(sp)
  begin_op();
    80004a84:	fffff097          	auipc	ra,0xfffff
    80004a88:	c84080e7          	jalr	-892(ra) # 80003708 <begin_op>
  if((ip = namei(old)) == 0){
    80004a8c:	ed040513          	addi	a0,s0,-304
    80004a90:	fffff097          	auipc	ra,0xfffff
    80004a94:	a72080e7          	jalr	-1422(ra) # 80003502 <namei>
    80004a98:	84aa                	mv	s1,a0
    80004a9a:	c949                	beqz	a0,80004b2c <sys_link+0xe2>
  ilock(ip);
    80004a9c:	ffffe097          	auipc	ra,0xffffe
    80004aa0:	27a080e7          	jalr	634(ra) # 80002d16 <ilock>
  if(ip->type == T_DIR){
    80004aa4:	04449703          	lh	a4,68(s1)
    80004aa8:	4785                	li	a5,1
    80004aaa:	08f70863          	beq	a4,a5,80004b3a <sys_link+0xf0>
    80004aae:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    80004ab0:	04a4d783          	lhu	a5,74(s1)
    80004ab4:	2785                	addiw	a5,a5,1
    80004ab6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004aba:	8526                	mv	a0,s1
    80004abc:	ffffe097          	auipc	ra,0xffffe
    80004ac0:	18e080e7          	jalr	398(ra) # 80002c4a <iupdate>
  iunlock(ip);
    80004ac4:	8526                	mv	a0,s1
    80004ac6:	ffffe097          	auipc	ra,0xffffe
    80004aca:	316080e7          	jalr	790(ra) # 80002ddc <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004ace:	fd040593          	addi	a1,s0,-48
    80004ad2:	f5040513          	addi	a0,s0,-176
    80004ad6:	fffff097          	auipc	ra,0xfffff
    80004ada:	a4a080e7          	jalr	-1462(ra) # 80003520 <nameiparent>
    80004ade:	892a                	mv	s2,a0
    80004ae0:	cd35                	beqz	a0,80004b5c <sys_link+0x112>
  ilock(dp);
    80004ae2:	ffffe097          	auipc	ra,0xffffe
    80004ae6:	234080e7          	jalr	564(ra) # 80002d16 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004aea:	00092703          	lw	a4,0(s2)
    80004aee:	409c                	lw	a5,0(s1)
    80004af0:	06f71163          	bne	a4,a5,80004b52 <sys_link+0x108>
    80004af4:	40d0                	lw	a2,4(s1)
    80004af6:	fd040593          	addi	a1,s0,-48
    80004afa:	854a                	mv	a0,s2
    80004afc:	fffff097          	auipc	ra,0xfffff
    80004b00:	930080e7          	jalr	-1744(ra) # 8000342c <dirlink>
    80004b04:	04054763          	bltz	a0,80004b52 <sys_link+0x108>
  iunlockput(dp);
    80004b08:	854a                	mv	a0,s2
    80004b0a:	ffffe097          	auipc	ra,0xffffe
    80004b0e:	472080e7          	jalr	1138(ra) # 80002f7c <iunlockput>
  iput(ip);
    80004b12:	8526                	mv	a0,s1
    80004b14:	ffffe097          	auipc	ra,0xffffe
    80004b18:	3c0080e7          	jalr	960(ra) # 80002ed4 <iput>
  end_op();
    80004b1c:	fffff097          	auipc	ra,0xfffff
    80004b20:	c66080e7          	jalr	-922(ra) # 80003782 <end_op>
  return 0;
    80004b24:	4781                	li	a5,0
    80004b26:	64f2                	ld	s1,280(sp)
    80004b28:	6952                	ld	s2,272(sp)
    80004b2a:	a0a5                	j	80004b92 <sys_link+0x148>
    end_op();
    80004b2c:	fffff097          	auipc	ra,0xfffff
    80004b30:	c56080e7          	jalr	-938(ra) # 80003782 <end_op>
    return -1;
    80004b34:	57fd                	li	a5,-1
    80004b36:	64f2                	ld	s1,280(sp)
    80004b38:	a8a9                	j	80004b92 <sys_link+0x148>
    iunlockput(ip);
    80004b3a:	8526                	mv	a0,s1
    80004b3c:	ffffe097          	auipc	ra,0xffffe
    80004b40:	440080e7          	jalr	1088(ra) # 80002f7c <iunlockput>
    end_op();
    80004b44:	fffff097          	auipc	ra,0xfffff
    80004b48:	c3e080e7          	jalr	-962(ra) # 80003782 <end_op>
    return -1;
    80004b4c:	57fd                	li	a5,-1
    80004b4e:	64f2                	ld	s1,280(sp)
    80004b50:	a089                	j	80004b92 <sys_link+0x148>
    iunlockput(dp);
    80004b52:	854a                	mv	a0,s2
    80004b54:	ffffe097          	auipc	ra,0xffffe
    80004b58:	428080e7          	jalr	1064(ra) # 80002f7c <iunlockput>
  ilock(ip);
    80004b5c:	8526                	mv	a0,s1
    80004b5e:	ffffe097          	auipc	ra,0xffffe
    80004b62:	1b8080e7          	jalr	440(ra) # 80002d16 <ilock>
  ip->nlink--;
    80004b66:	04a4d783          	lhu	a5,74(s1)
    80004b6a:	37fd                	addiw	a5,a5,-1
    80004b6c:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004b70:	8526                	mv	a0,s1
    80004b72:	ffffe097          	auipc	ra,0xffffe
    80004b76:	0d8080e7          	jalr	216(ra) # 80002c4a <iupdate>
  iunlockput(ip);
    80004b7a:	8526                	mv	a0,s1
    80004b7c:	ffffe097          	auipc	ra,0xffffe
    80004b80:	400080e7          	jalr	1024(ra) # 80002f7c <iunlockput>
  end_op();
    80004b84:	fffff097          	auipc	ra,0xfffff
    80004b88:	bfe080e7          	jalr	-1026(ra) # 80003782 <end_op>
  return -1;
    80004b8c:	57fd                	li	a5,-1
    80004b8e:	64f2                	ld	s1,280(sp)
    80004b90:	6952                	ld	s2,272(sp)
}
    80004b92:	853e                	mv	a0,a5
    80004b94:	70b2                	ld	ra,296(sp)
    80004b96:	7412                	ld	s0,288(sp)
    80004b98:	6155                	addi	sp,sp,304
    80004b9a:	8082                	ret

0000000080004b9c <sys_unlink>:
{
    80004b9c:	7111                	addi	sp,sp,-256
    80004b9e:	fd86                	sd	ra,248(sp)
    80004ba0:	f9a2                	sd	s0,240(sp)
    80004ba2:	0200                	addi	s0,sp,256
  if(argstr(0, path, MAXPATH) < 0)
    80004ba4:	08000613          	li	a2,128
    80004ba8:	f2040593          	addi	a1,s0,-224
    80004bac:	4501                	li	a0,0
    80004bae:	ffffd097          	auipc	ra,0xffffd
    80004bb2:	594080e7          	jalr	1428(ra) # 80002142 <argstr>
    80004bb6:	1c054063          	bltz	a0,80004d76 <sys_unlink+0x1da>
    80004bba:	f5a6                	sd	s1,232(sp)
  begin_op();
    80004bbc:	fffff097          	auipc	ra,0xfffff
    80004bc0:	b4c080e7          	jalr	-1204(ra) # 80003708 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004bc4:	fa040593          	addi	a1,s0,-96
    80004bc8:	f2040513          	addi	a0,s0,-224
    80004bcc:	fffff097          	auipc	ra,0xfffff
    80004bd0:	954080e7          	jalr	-1708(ra) # 80003520 <nameiparent>
    80004bd4:	84aa                	mv	s1,a0
    80004bd6:	c165                	beqz	a0,80004cb6 <sys_unlink+0x11a>
  ilock(dp);
    80004bd8:	ffffe097          	auipc	ra,0xffffe
    80004bdc:	13e080e7          	jalr	318(ra) # 80002d16 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004be0:	00004597          	auipc	a1,0x4
    80004be4:	9e858593          	addi	a1,a1,-1560 # 800085c8 <etext+0x5c8>
    80004be8:	fa040513          	addi	a0,s0,-96
    80004bec:	ffffe097          	auipc	ra,0xffffe
    80004bf0:	600080e7          	jalr	1536(ra) # 800031ec <namecmp>
    80004bf4:	16050263          	beqz	a0,80004d58 <sys_unlink+0x1bc>
    80004bf8:	00004597          	auipc	a1,0x4
    80004bfc:	9d858593          	addi	a1,a1,-1576 # 800085d0 <etext+0x5d0>
    80004c00:	fa040513          	addi	a0,s0,-96
    80004c04:	ffffe097          	auipc	ra,0xffffe
    80004c08:	5e8080e7          	jalr	1512(ra) # 800031ec <namecmp>
    80004c0c:	14050663          	beqz	a0,80004d58 <sys_unlink+0x1bc>
    80004c10:	f1ca                	sd	s2,224(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004c12:	f1c40613          	addi	a2,s0,-228
    80004c16:	fa040593          	addi	a1,s0,-96
    80004c1a:	8526                	mv	a0,s1
    80004c1c:	ffffe097          	auipc	ra,0xffffe
    80004c20:	5ea080e7          	jalr	1514(ra) # 80003206 <dirlookup>
    80004c24:	892a                	mv	s2,a0
    80004c26:	12050863          	beqz	a0,80004d56 <sys_unlink+0x1ba>
    80004c2a:	edce                	sd	s3,216(sp)
  ilock(ip);
    80004c2c:	ffffe097          	auipc	ra,0xffffe
    80004c30:	0ea080e7          	jalr	234(ra) # 80002d16 <ilock>
  if(ip->nlink < 1)
    80004c34:	04a91783          	lh	a5,74(s2)
    80004c38:	08f05663          	blez	a5,80004cc4 <sys_unlink+0x128>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004c3c:	04491703          	lh	a4,68(s2)
    80004c40:	4785                	li	a5,1
    80004c42:	08f70b63          	beq	a4,a5,80004cd8 <sys_unlink+0x13c>
  memset(&de, 0, sizeof(de));
    80004c46:	fb040993          	addi	s3,s0,-80
    80004c4a:	4641                	li	a2,16
    80004c4c:	4581                	li	a1,0
    80004c4e:	854e                	mv	a0,s3
    80004c50:	ffffb097          	auipc	ra,0xffffb
    80004c54:	52a080e7          	jalr	1322(ra) # 8000017a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c58:	4741                	li	a4,16
    80004c5a:	f1c42683          	lw	a3,-228(s0)
    80004c5e:	864e                	mv	a2,s3
    80004c60:	4581                	li	a1,0
    80004c62:	8526                	mv	a0,s1
    80004c64:	ffffe097          	auipc	ra,0xffffe
    80004c68:	468080e7          	jalr	1128(ra) # 800030cc <writei>
    80004c6c:	47c1                	li	a5,16
    80004c6e:	0af51f63          	bne	a0,a5,80004d2c <sys_unlink+0x190>
  if(ip->type == T_DIR){
    80004c72:	04491703          	lh	a4,68(s2)
    80004c76:	4785                	li	a5,1
    80004c78:	0cf70463          	beq	a4,a5,80004d40 <sys_unlink+0x1a4>
  iunlockput(dp);
    80004c7c:	8526                	mv	a0,s1
    80004c7e:	ffffe097          	auipc	ra,0xffffe
    80004c82:	2fe080e7          	jalr	766(ra) # 80002f7c <iunlockput>
  ip->nlink--;
    80004c86:	04a95783          	lhu	a5,74(s2)
    80004c8a:	37fd                	addiw	a5,a5,-1
    80004c8c:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004c90:	854a                	mv	a0,s2
    80004c92:	ffffe097          	auipc	ra,0xffffe
    80004c96:	fb8080e7          	jalr	-72(ra) # 80002c4a <iupdate>
  iunlockput(ip);
    80004c9a:	854a                	mv	a0,s2
    80004c9c:	ffffe097          	auipc	ra,0xffffe
    80004ca0:	2e0080e7          	jalr	736(ra) # 80002f7c <iunlockput>
  end_op();
    80004ca4:	fffff097          	auipc	ra,0xfffff
    80004ca8:	ade080e7          	jalr	-1314(ra) # 80003782 <end_op>
  return 0;
    80004cac:	4501                	li	a0,0
    80004cae:	74ae                	ld	s1,232(sp)
    80004cb0:	790e                	ld	s2,224(sp)
    80004cb2:	69ee                	ld	s3,216(sp)
    80004cb4:	a86d                	j	80004d6e <sys_unlink+0x1d2>
    end_op();
    80004cb6:	fffff097          	auipc	ra,0xfffff
    80004cba:	acc080e7          	jalr	-1332(ra) # 80003782 <end_op>
    return -1;
    80004cbe:	557d                	li	a0,-1
    80004cc0:	74ae                	ld	s1,232(sp)
    80004cc2:	a075                	j	80004d6e <sys_unlink+0x1d2>
    80004cc4:	e9d2                	sd	s4,208(sp)
    80004cc6:	e5d6                	sd	s5,200(sp)
    panic("unlink: nlink < 1");
    80004cc8:	00004517          	auipc	a0,0x4
    80004ccc:	93050513          	addi	a0,a0,-1744 # 800085f8 <etext+0x5f8>
    80004cd0:	00001097          	auipc	ra,0x1
    80004cd4:	222080e7          	jalr	546(ra) # 80005ef2 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004cd8:	04c92703          	lw	a4,76(s2)
    80004cdc:	02000793          	li	a5,32
    80004ce0:	f6e7f3e3          	bgeu	a5,a4,80004c46 <sys_unlink+0xaa>
    80004ce4:	e9d2                	sd	s4,208(sp)
    80004ce6:	e5d6                	sd	s5,200(sp)
    80004ce8:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004cea:	f0840a93          	addi	s5,s0,-248
    80004cee:	4a41                	li	s4,16
    80004cf0:	8752                	mv	a4,s4
    80004cf2:	86ce                	mv	a3,s3
    80004cf4:	8656                	mv	a2,s5
    80004cf6:	4581                	li	a1,0
    80004cf8:	854a                	mv	a0,s2
    80004cfa:	ffffe097          	auipc	ra,0xffffe
    80004cfe:	2d8080e7          	jalr	728(ra) # 80002fd2 <readi>
    80004d02:	01451d63          	bne	a0,s4,80004d1c <sys_unlink+0x180>
    if(de.inum != 0)
    80004d06:	f0845783          	lhu	a5,-248(s0)
    80004d0a:	eba5                	bnez	a5,80004d7a <sys_unlink+0x1de>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004d0c:	29c1                	addiw	s3,s3,16
    80004d0e:	04c92783          	lw	a5,76(s2)
    80004d12:	fcf9efe3          	bltu	s3,a5,80004cf0 <sys_unlink+0x154>
    80004d16:	6a4e                	ld	s4,208(sp)
    80004d18:	6aae                	ld	s5,200(sp)
    80004d1a:	b735                	j	80004c46 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004d1c:	00004517          	auipc	a0,0x4
    80004d20:	8f450513          	addi	a0,a0,-1804 # 80008610 <etext+0x610>
    80004d24:	00001097          	auipc	ra,0x1
    80004d28:	1ce080e7          	jalr	462(ra) # 80005ef2 <panic>
    80004d2c:	e9d2                	sd	s4,208(sp)
    80004d2e:	e5d6                	sd	s5,200(sp)
    panic("unlink: writei");
    80004d30:	00004517          	auipc	a0,0x4
    80004d34:	8f850513          	addi	a0,a0,-1800 # 80008628 <etext+0x628>
    80004d38:	00001097          	auipc	ra,0x1
    80004d3c:	1ba080e7          	jalr	442(ra) # 80005ef2 <panic>
    dp->nlink--;
    80004d40:	04a4d783          	lhu	a5,74(s1)
    80004d44:	37fd                	addiw	a5,a5,-1
    80004d46:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004d4a:	8526                	mv	a0,s1
    80004d4c:	ffffe097          	auipc	ra,0xffffe
    80004d50:	efe080e7          	jalr	-258(ra) # 80002c4a <iupdate>
    80004d54:	b725                	j	80004c7c <sys_unlink+0xe0>
    80004d56:	790e                	ld	s2,224(sp)
  iunlockput(dp);
    80004d58:	8526                	mv	a0,s1
    80004d5a:	ffffe097          	auipc	ra,0xffffe
    80004d5e:	222080e7          	jalr	546(ra) # 80002f7c <iunlockput>
  end_op();
    80004d62:	fffff097          	auipc	ra,0xfffff
    80004d66:	a20080e7          	jalr	-1504(ra) # 80003782 <end_op>
  return -1;
    80004d6a:	557d                	li	a0,-1
    80004d6c:	74ae                	ld	s1,232(sp)
}
    80004d6e:	70ee                	ld	ra,248(sp)
    80004d70:	744e                	ld	s0,240(sp)
    80004d72:	6111                	addi	sp,sp,256
    80004d74:	8082                	ret
    return -1;
    80004d76:	557d                	li	a0,-1
    80004d78:	bfdd                	j	80004d6e <sys_unlink+0x1d2>
    iunlockput(ip);
    80004d7a:	854a                	mv	a0,s2
    80004d7c:	ffffe097          	auipc	ra,0xffffe
    80004d80:	200080e7          	jalr	512(ra) # 80002f7c <iunlockput>
    goto bad;
    80004d84:	790e                	ld	s2,224(sp)
    80004d86:	69ee                	ld	s3,216(sp)
    80004d88:	6a4e                	ld	s4,208(sp)
    80004d8a:	6aae                	ld	s5,200(sp)
    80004d8c:	b7f1                	j	80004d58 <sys_unlink+0x1bc>

0000000080004d8e <sys_open>:

uint64
sys_open(void)
{
    80004d8e:	7131                	addi	sp,sp,-192
    80004d90:	fd06                	sd	ra,184(sp)
    80004d92:	f922                	sd	s0,176(sp)
    80004d94:	f526                	sd	s1,168(sp)
    80004d96:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004d98:	08000613          	li	a2,128
    80004d9c:	f5040593          	addi	a1,s0,-176
    80004da0:	4501                	li	a0,0
    80004da2:	ffffd097          	auipc	ra,0xffffd
    80004da6:	3a0080e7          	jalr	928(ra) # 80002142 <argstr>
    return -1;
    80004daa:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004dac:	0c054563          	bltz	a0,80004e76 <sys_open+0xe8>
    80004db0:	f4c40593          	addi	a1,s0,-180
    80004db4:	4505                	li	a0,1
    80004db6:	ffffd097          	auipc	ra,0xffffd
    80004dba:	348080e7          	jalr	840(ra) # 800020fe <argint>
    80004dbe:	0a054c63          	bltz	a0,80004e76 <sys_open+0xe8>
    80004dc2:	f14a                	sd	s2,160(sp)

  begin_op();
    80004dc4:	fffff097          	auipc	ra,0xfffff
    80004dc8:	944080e7          	jalr	-1724(ra) # 80003708 <begin_op>

  if(omode & O_CREATE){
    80004dcc:	f4c42783          	lw	a5,-180(s0)
    80004dd0:	2007f793          	andi	a5,a5,512
    80004dd4:	cfcd                	beqz	a5,80004e8e <sys_open+0x100>
    ip = create(path, T_FILE, 0, 0);
    80004dd6:	4681                	li	a3,0
    80004dd8:	4601                	li	a2,0
    80004dda:	4589                	li	a1,2
    80004ddc:	f5040513          	addi	a0,s0,-176
    80004de0:	00000097          	auipc	ra,0x0
    80004de4:	948080e7          	jalr	-1720(ra) # 80004728 <create>
    80004de8:	892a                	mv	s2,a0
    if(ip == 0){
    80004dea:	cd41                	beqz	a0,80004e82 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004dec:	04491703          	lh	a4,68(s2)
    80004df0:	478d                	li	a5,3
    80004df2:	00f71763          	bne	a4,a5,80004e00 <sys_open+0x72>
    80004df6:	04695703          	lhu	a4,70(s2)
    80004dfa:	47a5                	li	a5,9
    80004dfc:	0ee7e063          	bltu	a5,a4,80004edc <sys_open+0x14e>
    80004e00:	ed4e                	sd	s3,152(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004e02:	fffff097          	auipc	ra,0xfffff
    80004e06:	d1a080e7          	jalr	-742(ra) # 80003b1c <filealloc>
    80004e0a:	89aa                	mv	s3,a0
    80004e0c:	c96d                	beqz	a0,80004efe <sys_open+0x170>
    80004e0e:	00000097          	auipc	ra,0x0
    80004e12:	8d8080e7          	jalr	-1832(ra) # 800046e6 <fdalloc>
    80004e16:	84aa                	mv	s1,a0
    80004e18:	0c054e63          	bltz	a0,80004ef4 <sys_open+0x166>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004e1c:	04491703          	lh	a4,68(s2)
    80004e20:	478d                	li	a5,3
    80004e22:	0ef70b63          	beq	a4,a5,80004f18 <sys_open+0x18a>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004e26:	4789                	li	a5,2
    80004e28:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004e2c:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004e30:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004e34:	f4c42783          	lw	a5,-180(s0)
    80004e38:	0017f713          	andi	a4,a5,1
    80004e3c:	00174713          	xori	a4,a4,1
    80004e40:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004e44:	0037f713          	andi	a4,a5,3
    80004e48:	00e03733          	snez	a4,a4
    80004e4c:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004e50:	4007f793          	andi	a5,a5,1024
    80004e54:	c791                	beqz	a5,80004e60 <sys_open+0xd2>
    80004e56:	04491703          	lh	a4,68(s2)
    80004e5a:	4789                	li	a5,2
    80004e5c:	0cf70563          	beq	a4,a5,80004f26 <sys_open+0x198>
    itrunc(ip);
  }

  iunlock(ip);
    80004e60:	854a                	mv	a0,s2
    80004e62:	ffffe097          	auipc	ra,0xffffe
    80004e66:	f7a080e7          	jalr	-134(ra) # 80002ddc <iunlock>
  end_op();
    80004e6a:	fffff097          	auipc	ra,0xfffff
    80004e6e:	918080e7          	jalr	-1768(ra) # 80003782 <end_op>
    80004e72:	790a                	ld	s2,160(sp)
    80004e74:	69ea                	ld	s3,152(sp)

  return fd;
}
    80004e76:	8526                	mv	a0,s1
    80004e78:	70ea                	ld	ra,184(sp)
    80004e7a:	744a                	ld	s0,176(sp)
    80004e7c:	74aa                	ld	s1,168(sp)
    80004e7e:	6129                	addi	sp,sp,192
    80004e80:	8082                	ret
      end_op();
    80004e82:	fffff097          	auipc	ra,0xfffff
    80004e86:	900080e7          	jalr	-1792(ra) # 80003782 <end_op>
      return -1;
    80004e8a:	790a                	ld	s2,160(sp)
    80004e8c:	b7ed                	j	80004e76 <sys_open+0xe8>
    if((ip = namei(path)) == 0){
    80004e8e:	f5040513          	addi	a0,s0,-176
    80004e92:	ffffe097          	auipc	ra,0xffffe
    80004e96:	670080e7          	jalr	1648(ra) # 80003502 <namei>
    80004e9a:	892a                	mv	s2,a0
    80004e9c:	c90d                	beqz	a0,80004ece <sys_open+0x140>
    ilock(ip);
    80004e9e:	ffffe097          	auipc	ra,0xffffe
    80004ea2:	e78080e7          	jalr	-392(ra) # 80002d16 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004ea6:	04491703          	lh	a4,68(s2)
    80004eaa:	4785                	li	a5,1
    80004eac:	f4f710e3          	bne	a4,a5,80004dec <sys_open+0x5e>
    80004eb0:	f4c42783          	lw	a5,-180(s0)
    80004eb4:	d7b1                	beqz	a5,80004e00 <sys_open+0x72>
      iunlockput(ip);
    80004eb6:	854a                	mv	a0,s2
    80004eb8:	ffffe097          	auipc	ra,0xffffe
    80004ebc:	0c4080e7          	jalr	196(ra) # 80002f7c <iunlockput>
      end_op();
    80004ec0:	fffff097          	auipc	ra,0xfffff
    80004ec4:	8c2080e7          	jalr	-1854(ra) # 80003782 <end_op>
      return -1;
    80004ec8:	54fd                	li	s1,-1
    80004eca:	790a                	ld	s2,160(sp)
    80004ecc:	b76d                	j	80004e76 <sys_open+0xe8>
      end_op();
    80004ece:	fffff097          	auipc	ra,0xfffff
    80004ed2:	8b4080e7          	jalr	-1868(ra) # 80003782 <end_op>
      return -1;
    80004ed6:	54fd                	li	s1,-1
    80004ed8:	790a                	ld	s2,160(sp)
    80004eda:	bf71                	j	80004e76 <sys_open+0xe8>
    iunlockput(ip);
    80004edc:	854a                	mv	a0,s2
    80004ede:	ffffe097          	auipc	ra,0xffffe
    80004ee2:	09e080e7          	jalr	158(ra) # 80002f7c <iunlockput>
    end_op();
    80004ee6:	fffff097          	auipc	ra,0xfffff
    80004eea:	89c080e7          	jalr	-1892(ra) # 80003782 <end_op>
    return -1;
    80004eee:	54fd                	li	s1,-1
    80004ef0:	790a                	ld	s2,160(sp)
    80004ef2:	b751                	j	80004e76 <sys_open+0xe8>
      fileclose(f);
    80004ef4:	854e                	mv	a0,s3
    80004ef6:	fffff097          	auipc	ra,0xfffff
    80004efa:	ce2080e7          	jalr	-798(ra) # 80003bd8 <fileclose>
    iunlockput(ip);
    80004efe:	854a                	mv	a0,s2
    80004f00:	ffffe097          	auipc	ra,0xffffe
    80004f04:	07c080e7          	jalr	124(ra) # 80002f7c <iunlockput>
    end_op();
    80004f08:	fffff097          	auipc	ra,0xfffff
    80004f0c:	87a080e7          	jalr	-1926(ra) # 80003782 <end_op>
    return -1;
    80004f10:	54fd                	li	s1,-1
    80004f12:	790a                	ld	s2,160(sp)
    80004f14:	69ea                	ld	s3,152(sp)
    80004f16:	b785                	j	80004e76 <sys_open+0xe8>
    f->type = FD_DEVICE;
    80004f18:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004f1c:	04691783          	lh	a5,70(s2)
    80004f20:	02f99223          	sh	a5,36(s3)
    80004f24:	b731                	j	80004e30 <sys_open+0xa2>
    itrunc(ip);
    80004f26:	854a                	mv	a0,s2
    80004f28:	ffffe097          	auipc	ra,0xffffe
    80004f2c:	f00080e7          	jalr	-256(ra) # 80002e28 <itrunc>
    80004f30:	bf05                	j	80004e60 <sys_open+0xd2>

0000000080004f32 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004f32:	7175                	addi	sp,sp,-144
    80004f34:	e506                	sd	ra,136(sp)
    80004f36:	e122                	sd	s0,128(sp)
    80004f38:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004f3a:	ffffe097          	auipc	ra,0xffffe
    80004f3e:	7ce080e7          	jalr	1998(ra) # 80003708 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004f42:	08000613          	li	a2,128
    80004f46:	f7040593          	addi	a1,s0,-144
    80004f4a:	4501                	li	a0,0
    80004f4c:	ffffd097          	auipc	ra,0xffffd
    80004f50:	1f6080e7          	jalr	502(ra) # 80002142 <argstr>
    80004f54:	02054963          	bltz	a0,80004f86 <sys_mkdir+0x54>
    80004f58:	4681                	li	a3,0
    80004f5a:	4601                	li	a2,0
    80004f5c:	4585                	li	a1,1
    80004f5e:	f7040513          	addi	a0,s0,-144
    80004f62:	fffff097          	auipc	ra,0xfffff
    80004f66:	7c6080e7          	jalr	1990(ra) # 80004728 <create>
    80004f6a:	cd11                	beqz	a0,80004f86 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f6c:	ffffe097          	auipc	ra,0xffffe
    80004f70:	010080e7          	jalr	16(ra) # 80002f7c <iunlockput>
  end_op();
    80004f74:	fffff097          	auipc	ra,0xfffff
    80004f78:	80e080e7          	jalr	-2034(ra) # 80003782 <end_op>
  return 0;
    80004f7c:	4501                	li	a0,0
}
    80004f7e:	60aa                	ld	ra,136(sp)
    80004f80:	640a                	ld	s0,128(sp)
    80004f82:	6149                	addi	sp,sp,144
    80004f84:	8082                	ret
    end_op();
    80004f86:	ffffe097          	auipc	ra,0xffffe
    80004f8a:	7fc080e7          	jalr	2044(ra) # 80003782 <end_op>
    return -1;
    80004f8e:	557d                	li	a0,-1
    80004f90:	b7fd                	j	80004f7e <sys_mkdir+0x4c>

0000000080004f92 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004f92:	7135                	addi	sp,sp,-160
    80004f94:	ed06                	sd	ra,152(sp)
    80004f96:	e922                	sd	s0,144(sp)
    80004f98:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004f9a:	ffffe097          	auipc	ra,0xffffe
    80004f9e:	76e080e7          	jalr	1902(ra) # 80003708 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004fa2:	08000613          	li	a2,128
    80004fa6:	f7040593          	addi	a1,s0,-144
    80004faa:	4501                	li	a0,0
    80004fac:	ffffd097          	auipc	ra,0xffffd
    80004fb0:	196080e7          	jalr	406(ra) # 80002142 <argstr>
    80004fb4:	04054a63          	bltz	a0,80005008 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004fb8:	f6c40593          	addi	a1,s0,-148
    80004fbc:	4505                	li	a0,1
    80004fbe:	ffffd097          	auipc	ra,0xffffd
    80004fc2:	140080e7          	jalr	320(ra) # 800020fe <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004fc6:	04054163          	bltz	a0,80005008 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004fca:	f6840593          	addi	a1,s0,-152
    80004fce:	4509                	li	a0,2
    80004fd0:	ffffd097          	auipc	ra,0xffffd
    80004fd4:	12e080e7          	jalr	302(ra) # 800020fe <argint>
     argint(1, &major) < 0 ||
    80004fd8:	02054863          	bltz	a0,80005008 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004fdc:	f6841683          	lh	a3,-152(s0)
    80004fe0:	f6c41603          	lh	a2,-148(s0)
    80004fe4:	458d                	li	a1,3
    80004fe6:	f7040513          	addi	a0,s0,-144
    80004fea:	fffff097          	auipc	ra,0xfffff
    80004fee:	73e080e7          	jalr	1854(ra) # 80004728 <create>
     argint(2, &minor) < 0 ||
    80004ff2:	c919                	beqz	a0,80005008 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004ff4:	ffffe097          	auipc	ra,0xffffe
    80004ff8:	f88080e7          	jalr	-120(ra) # 80002f7c <iunlockput>
  end_op();
    80004ffc:	ffffe097          	auipc	ra,0xffffe
    80005000:	786080e7          	jalr	1926(ra) # 80003782 <end_op>
  return 0;
    80005004:	4501                	li	a0,0
    80005006:	a031                	j	80005012 <sys_mknod+0x80>
    end_op();
    80005008:	ffffe097          	auipc	ra,0xffffe
    8000500c:	77a080e7          	jalr	1914(ra) # 80003782 <end_op>
    return -1;
    80005010:	557d                	li	a0,-1
}
    80005012:	60ea                	ld	ra,152(sp)
    80005014:	644a                	ld	s0,144(sp)
    80005016:	610d                	addi	sp,sp,160
    80005018:	8082                	ret

000000008000501a <sys_chdir>:

uint64
sys_chdir(void)
{
    8000501a:	7135                	addi	sp,sp,-160
    8000501c:	ed06                	sd	ra,152(sp)
    8000501e:	e922                	sd	s0,144(sp)
    80005020:	e14a                	sd	s2,128(sp)
    80005022:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005024:	ffffc097          	auipc	ra,0xffffc
    80005028:	f68080e7          	jalr	-152(ra) # 80000f8c <myproc>
    8000502c:	892a                	mv	s2,a0
  
  begin_op();
    8000502e:	ffffe097          	auipc	ra,0xffffe
    80005032:	6da080e7          	jalr	1754(ra) # 80003708 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005036:	08000613          	li	a2,128
    8000503a:	f6040593          	addi	a1,s0,-160
    8000503e:	4501                	li	a0,0
    80005040:	ffffd097          	auipc	ra,0xffffd
    80005044:	102080e7          	jalr	258(ra) # 80002142 <argstr>
    80005048:	04054d63          	bltz	a0,800050a2 <sys_chdir+0x88>
    8000504c:	e526                	sd	s1,136(sp)
    8000504e:	f6040513          	addi	a0,s0,-160
    80005052:	ffffe097          	auipc	ra,0xffffe
    80005056:	4b0080e7          	jalr	1200(ra) # 80003502 <namei>
    8000505a:	84aa                	mv	s1,a0
    8000505c:	c131                	beqz	a0,800050a0 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    8000505e:	ffffe097          	auipc	ra,0xffffe
    80005062:	cb8080e7          	jalr	-840(ra) # 80002d16 <ilock>
  if(ip->type != T_DIR){
    80005066:	04449703          	lh	a4,68(s1)
    8000506a:	4785                	li	a5,1
    8000506c:	04f71163          	bne	a4,a5,800050ae <sys_chdir+0x94>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005070:	8526                	mv	a0,s1
    80005072:	ffffe097          	auipc	ra,0xffffe
    80005076:	d6a080e7          	jalr	-662(ra) # 80002ddc <iunlock>
  iput(p->cwd);
    8000507a:	15093503          	ld	a0,336(s2)
    8000507e:	ffffe097          	auipc	ra,0xffffe
    80005082:	e56080e7          	jalr	-426(ra) # 80002ed4 <iput>
  end_op();
    80005086:	ffffe097          	auipc	ra,0xffffe
    8000508a:	6fc080e7          	jalr	1788(ra) # 80003782 <end_op>
  p->cwd = ip;
    8000508e:	14993823          	sd	s1,336(s2)
  return 0;
    80005092:	4501                	li	a0,0
    80005094:	64aa                	ld	s1,136(sp)
}
    80005096:	60ea                	ld	ra,152(sp)
    80005098:	644a                	ld	s0,144(sp)
    8000509a:	690a                	ld	s2,128(sp)
    8000509c:	610d                	addi	sp,sp,160
    8000509e:	8082                	ret
    800050a0:	64aa                	ld	s1,136(sp)
    end_op();
    800050a2:	ffffe097          	auipc	ra,0xffffe
    800050a6:	6e0080e7          	jalr	1760(ra) # 80003782 <end_op>
    return -1;
    800050aa:	557d                	li	a0,-1
    800050ac:	b7ed                	j	80005096 <sys_chdir+0x7c>
    iunlockput(ip);
    800050ae:	8526                	mv	a0,s1
    800050b0:	ffffe097          	auipc	ra,0xffffe
    800050b4:	ecc080e7          	jalr	-308(ra) # 80002f7c <iunlockput>
    end_op();
    800050b8:	ffffe097          	auipc	ra,0xffffe
    800050bc:	6ca080e7          	jalr	1738(ra) # 80003782 <end_op>
    return -1;
    800050c0:	557d                	li	a0,-1
    800050c2:	64aa                	ld	s1,136(sp)
    800050c4:	bfc9                	j	80005096 <sys_chdir+0x7c>

00000000800050c6 <sys_exec>:

uint64
sys_exec(void)
{
    800050c6:	7105                	addi	sp,sp,-480
    800050c8:	ef86                	sd	ra,472(sp)
    800050ca:	eba2                	sd	s0,464(sp)
    800050cc:	e3ca                	sd	s2,448(sp)
    800050ce:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800050d0:	08000613          	li	a2,128
    800050d4:	f3040593          	addi	a1,s0,-208
    800050d8:	4501                	li	a0,0
    800050da:	ffffd097          	auipc	ra,0xffffd
    800050de:	068080e7          	jalr	104(ra) # 80002142 <argstr>
    return -1;
    800050e2:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    800050e4:	10054963          	bltz	a0,800051f6 <sys_exec+0x130>
    800050e8:	e2840593          	addi	a1,s0,-472
    800050ec:	4505                	li	a0,1
    800050ee:	ffffd097          	auipc	ra,0xffffd
    800050f2:	032080e7          	jalr	50(ra) # 80002120 <argaddr>
    800050f6:	10054063          	bltz	a0,800051f6 <sys_exec+0x130>
    800050fa:	e7a6                	sd	s1,456(sp)
    800050fc:	ff4e                	sd	s3,440(sp)
    800050fe:	fb52                	sd	s4,432(sp)
    80005100:	f756                	sd	s5,424(sp)
    80005102:	f35a                	sd	s6,416(sp)
    80005104:	ef5e                	sd	s7,408(sp)
  }
  memset(argv, 0, sizeof(argv));
    80005106:	e3040a13          	addi	s4,s0,-464
    8000510a:	10000613          	li	a2,256
    8000510e:	4581                	li	a1,0
    80005110:	8552                	mv	a0,s4
    80005112:	ffffb097          	auipc	ra,0xffffb
    80005116:	068080e7          	jalr	104(ra) # 8000017a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    8000511a:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    8000511c:	89d2                	mv	s3,s4
    8000511e:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005120:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005124:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    80005126:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    8000512a:	00391513          	slli	a0,s2,0x3
    8000512e:	85d6                	mv	a1,s5
    80005130:	e2843783          	ld	a5,-472(s0)
    80005134:	953e                	add	a0,a0,a5
    80005136:	ffffd097          	auipc	ra,0xffffd
    8000513a:	f2e080e7          	jalr	-210(ra) # 80002064 <fetchaddr>
    8000513e:	02054a63          	bltz	a0,80005172 <sys_exec+0xac>
    if(uarg == 0){
    80005142:	e2043783          	ld	a5,-480(s0)
    80005146:	cba9                	beqz	a5,80005198 <sys_exec+0xd2>
    argv[i] = kalloc();
    80005148:	ffffb097          	auipc	ra,0xffffb
    8000514c:	fd2080e7          	jalr	-46(ra) # 8000011a <kalloc>
    80005150:	85aa                	mv	a1,a0
    80005152:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005156:	cd11                	beqz	a0,80005172 <sys_exec+0xac>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005158:	865a                	mv	a2,s6
    8000515a:	e2043503          	ld	a0,-480(s0)
    8000515e:	ffffd097          	auipc	ra,0xffffd
    80005162:	f58080e7          	jalr	-168(ra) # 800020b6 <fetchstr>
    80005166:	00054663          	bltz	a0,80005172 <sys_exec+0xac>
    if(i >= NELEM(argv)){
    8000516a:	0905                	addi	s2,s2,1
    8000516c:	09a1                	addi	s3,s3,8
    8000516e:	fb791ee3          	bne	s2,s7,8000512a <sys_exec+0x64>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005172:	100a0a13          	addi	s4,s4,256
    80005176:	6088                	ld	a0,0(s1)
    80005178:	c925                	beqz	a0,800051e8 <sys_exec+0x122>
    kfree(argv[i]);
    8000517a:	ffffb097          	auipc	ra,0xffffb
    8000517e:	ea2080e7          	jalr	-350(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005182:	04a1                	addi	s1,s1,8
    80005184:	ff4499e3          	bne	s1,s4,80005176 <sys_exec+0xb0>
  return -1;
    80005188:	597d                	li	s2,-1
    8000518a:	64be                	ld	s1,456(sp)
    8000518c:	79fa                	ld	s3,440(sp)
    8000518e:	7a5a                	ld	s4,432(sp)
    80005190:	7aba                	ld	s5,424(sp)
    80005192:	7b1a                	ld	s6,416(sp)
    80005194:	6bfa                	ld	s7,408(sp)
    80005196:	a085                	j	800051f6 <sys_exec+0x130>
      argv[i] = 0;
    80005198:	0009079b          	sext.w	a5,s2
    8000519c:	e3040593          	addi	a1,s0,-464
    800051a0:	078e                	slli	a5,a5,0x3
    800051a2:	97ae                	add	a5,a5,a1
    800051a4:	0007b023          	sd	zero,0(a5)
  int ret = exec(path, argv);
    800051a8:	f3040513          	addi	a0,s0,-208
    800051ac:	fffff097          	auipc	ra,0xfffff
    800051b0:	10a080e7          	jalr	266(ra) # 800042b6 <exec>
    800051b4:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800051b6:	100a0a13          	addi	s4,s4,256
    800051ba:	6088                	ld	a0,0(s1)
    800051bc:	cd19                	beqz	a0,800051da <sys_exec+0x114>
    kfree(argv[i]);
    800051be:	ffffb097          	auipc	ra,0xffffb
    800051c2:	e5e080e7          	jalr	-418(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800051c6:	04a1                	addi	s1,s1,8
    800051c8:	ff4499e3          	bne	s1,s4,800051ba <sys_exec+0xf4>
    800051cc:	64be                	ld	s1,456(sp)
    800051ce:	79fa                	ld	s3,440(sp)
    800051d0:	7a5a                	ld	s4,432(sp)
    800051d2:	7aba                	ld	s5,424(sp)
    800051d4:	7b1a                	ld	s6,416(sp)
    800051d6:	6bfa                	ld	s7,408(sp)
    800051d8:	a839                	j	800051f6 <sys_exec+0x130>
  return ret;
    800051da:	64be                	ld	s1,456(sp)
    800051dc:	79fa                	ld	s3,440(sp)
    800051de:	7a5a                	ld	s4,432(sp)
    800051e0:	7aba                	ld	s5,424(sp)
    800051e2:	7b1a                	ld	s6,416(sp)
    800051e4:	6bfa                	ld	s7,408(sp)
    800051e6:	a801                	j	800051f6 <sys_exec+0x130>
  return -1;
    800051e8:	597d                	li	s2,-1
    800051ea:	64be                	ld	s1,456(sp)
    800051ec:	79fa                	ld	s3,440(sp)
    800051ee:	7a5a                	ld	s4,432(sp)
    800051f0:	7aba                	ld	s5,424(sp)
    800051f2:	7b1a                	ld	s6,416(sp)
    800051f4:	6bfa                	ld	s7,408(sp)
}
    800051f6:	854a                	mv	a0,s2
    800051f8:	60fe                	ld	ra,472(sp)
    800051fa:	645e                	ld	s0,464(sp)
    800051fc:	691e                	ld	s2,448(sp)
    800051fe:	613d                	addi	sp,sp,480
    80005200:	8082                	ret

0000000080005202 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005202:	7139                	addi	sp,sp,-64
    80005204:	fc06                	sd	ra,56(sp)
    80005206:	f822                	sd	s0,48(sp)
    80005208:	f426                	sd	s1,40(sp)
    8000520a:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    8000520c:	ffffc097          	auipc	ra,0xffffc
    80005210:	d80080e7          	jalr	-640(ra) # 80000f8c <myproc>
    80005214:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005216:	fd840593          	addi	a1,s0,-40
    8000521a:	4501                	li	a0,0
    8000521c:	ffffd097          	auipc	ra,0xffffd
    80005220:	f04080e7          	jalr	-252(ra) # 80002120 <argaddr>
    return -1;
    80005224:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005226:	0e054063          	bltz	a0,80005306 <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    8000522a:	fc840593          	addi	a1,s0,-56
    8000522e:	fd040513          	addi	a0,s0,-48
    80005232:	fffff097          	auipc	ra,0xfffff
    80005236:	d1a080e7          	jalr	-742(ra) # 80003f4c <pipealloc>
    return -1;
    8000523a:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    8000523c:	0c054563          	bltz	a0,80005306 <sys_pipe+0x104>
  fd0 = -1;
    80005240:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005244:	fd043503          	ld	a0,-48(s0)
    80005248:	fffff097          	auipc	ra,0xfffff
    8000524c:	49e080e7          	jalr	1182(ra) # 800046e6 <fdalloc>
    80005250:	fca42223          	sw	a0,-60(s0)
    80005254:	08054c63          	bltz	a0,800052ec <sys_pipe+0xea>
    80005258:	fc843503          	ld	a0,-56(s0)
    8000525c:	fffff097          	auipc	ra,0xfffff
    80005260:	48a080e7          	jalr	1162(ra) # 800046e6 <fdalloc>
    80005264:	fca42023          	sw	a0,-64(s0)
    80005268:	06054963          	bltz	a0,800052da <sys_pipe+0xd8>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000526c:	4691                	li	a3,4
    8000526e:	fc440613          	addi	a2,s0,-60
    80005272:	fd843583          	ld	a1,-40(s0)
    80005276:	68a8                	ld	a0,80(s1)
    80005278:	ffffc097          	auipc	ra,0xffffc
    8000527c:	8d6080e7          	jalr	-1834(ra) # 80000b4e <copyout>
    80005280:	02054063          	bltz	a0,800052a0 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005284:	4691                	li	a3,4
    80005286:	fc040613          	addi	a2,s0,-64
    8000528a:	fd843583          	ld	a1,-40(s0)
    8000528e:	95b6                	add	a1,a1,a3
    80005290:	68a8                	ld	a0,80(s1)
    80005292:	ffffc097          	auipc	ra,0xffffc
    80005296:	8bc080e7          	jalr	-1860(ra) # 80000b4e <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8000529a:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000529c:	06055563          	bgez	a0,80005306 <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    800052a0:	fc442783          	lw	a5,-60(s0)
    800052a4:	07e9                	addi	a5,a5,26
    800052a6:	078e                	slli	a5,a5,0x3
    800052a8:	97a6                	add	a5,a5,s1
    800052aa:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800052ae:	fc042783          	lw	a5,-64(s0)
    800052b2:	07e9                	addi	a5,a5,26
    800052b4:	078e                	slli	a5,a5,0x3
    800052b6:	00f48533          	add	a0,s1,a5
    800052ba:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    800052be:	fd043503          	ld	a0,-48(s0)
    800052c2:	fffff097          	auipc	ra,0xfffff
    800052c6:	916080e7          	jalr	-1770(ra) # 80003bd8 <fileclose>
    fileclose(wf);
    800052ca:	fc843503          	ld	a0,-56(s0)
    800052ce:	fffff097          	auipc	ra,0xfffff
    800052d2:	90a080e7          	jalr	-1782(ra) # 80003bd8 <fileclose>
    return -1;
    800052d6:	57fd                	li	a5,-1
    800052d8:	a03d                	j	80005306 <sys_pipe+0x104>
    if(fd0 >= 0)
    800052da:	fc442783          	lw	a5,-60(s0)
    800052de:	0007c763          	bltz	a5,800052ec <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    800052e2:	07e9                	addi	a5,a5,26
    800052e4:	078e                	slli	a5,a5,0x3
    800052e6:	97a6                	add	a5,a5,s1
    800052e8:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800052ec:	fd043503          	ld	a0,-48(s0)
    800052f0:	fffff097          	auipc	ra,0xfffff
    800052f4:	8e8080e7          	jalr	-1816(ra) # 80003bd8 <fileclose>
    fileclose(wf);
    800052f8:	fc843503          	ld	a0,-56(s0)
    800052fc:	fffff097          	auipc	ra,0xfffff
    80005300:	8dc080e7          	jalr	-1828(ra) # 80003bd8 <fileclose>
    return -1;
    80005304:	57fd                	li	a5,-1
}
    80005306:	853e                	mv	a0,a5
    80005308:	70e2                	ld	ra,56(sp)
    8000530a:	7442                	ld	s0,48(sp)
    8000530c:	74a2                	ld	s1,40(sp)
    8000530e:	6121                	addi	sp,sp,64
    80005310:	8082                	ret
	...

0000000080005320 <kernelvec>:
    80005320:	7111                	addi	sp,sp,-256
    80005322:	e006                	sd	ra,0(sp)
    80005324:	e40a                	sd	sp,8(sp)
    80005326:	e80e                	sd	gp,16(sp)
    80005328:	ec12                	sd	tp,24(sp)
    8000532a:	f016                	sd	t0,32(sp)
    8000532c:	f41a                	sd	t1,40(sp)
    8000532e:	f81e                	sd	t2,48(sp)
    80005330:	fc22                	sd	s0,56(sp)
    80005332:	e0a6                	sd	s1,64(sp)
    80005334:	e4aa                	sd	a0,72(sp)
    80005336:	e8ae                	sd	a1,80(sp)
    80005338:	ecb2                	sd	a2,88(sp)
    8000533a:	f0b6                	sd	a3,96(sp)
    8000533c:	f4ba                	sd	a4,104(sp)
    8000533e:	f8be                	sd	a5,112(sp)
    80005340:	fcc2                	sd	a6,120(sp)
    80005342:	e146                	sd	a7,128(sp)
    80005344:	e54a                	sd	s2,136(sp)
    80005346:	e94e                	sd	s3,144(sp)
    80005348:	ed52                	sd	s4,152(sp)
    8000534a:	f156                	sd	s5,160(sp)
    8000534c:	f55a                	sd	s6,168(sp)
    8000534e:	f95e                	sd	s7,176(sp)
    80005350:	fd62                	sd	s8,184(sp)
    80005352:	e1e6                	sd	s9,192(sp)
    80005354:	e5ea                	sd	s10,200(sp)
    80005356:	e9ee                	sd	s11,208(sp)
    80005358:	edf2                	sd	t3,216(sp)
    8000535a:	f1f6                	sd	t4,224(sp)
    8000535c:	f5fa                	sd	t5,232(sp)
    8000535e:	f9fe                	sd	t6,240(sp)
    80005360:	bd1fc0ef          	jal	80001f30 <kerneltrap>
    80005364:	6082                	ld	ra,0(sp)
    80005366:	6122                	ld	sp,8(sp)
    80005368:	61c2                	ld	gp,16(sp)
    8000536a:	7282                	ld	t0,32(sp)
    8000536c:	7322                	ld	t1,40(sp)
    8000536e:	73c2                	ld	t2,48(sp)
    80005370:	7462                	ld	s0,56(sp)
    80005372:	6486                	ld	s1,64(sp)
    80005374:	6526                	ld	a0,72(sp)
    80005376:	65c6                	ld	a1,80(sp)
    80005378:	6666                	ld	a2,88(sp)
    8000537a:	7686                	ld	a3,96(sp)
    8000537c:	7726                	ld	a4,104(sp)
    8000537e:	77c6                	ld	a5,112(sp)
    80005380:	7866                	ld	a6,120(sp)
    80005382:	688a                	ld	a7,128(sp)
    80005384:	692a                	ld	s2,136(sp)
    80005386:	69ca                	ld	s3,144(sp)
    80005388:	6a6a                	ld	s4,152(sp)
    8000538a:	7a8a                	ld	s5,160(sp)
    8000538c:	7b2a                	ld	s6,168(sp)
    8000538e:	7bca                	ld	s7,176(sp)
    80005390:	7c6a                	ld	s8,184(sp)
    80005392:	6c8e                	ld	s9,192(sp)
    80005394:	6d2e                	ld	s10,200(sp)
    80005396:	6dce                	ld	s11,208(sp)
    80005398:	6e6e                	ld	t3,216(sp)
    8000539a:	7e8e                	ld	t4,224(sp)
    8000539c:	7f2e                	ld	t5,232(sp)
    8000539e:	7fce                	ld	t6,240(sp)
    800053a0:	6111                	addi	sp,sp,256
    800053a2:	10200073          	sret
    800053a6:	00000013          	nop
    800053aa:	00000013          	nop
    800053ae:	0001                	nop

00000000800053b0 <timervec>:
    800053b0:	34051573          	csrrw	a0,mscratch,a0
    800053b4:	e10c                	sd	a1,0(a0)
    800053b6:	e510                	sd	a2,8(a0)
    800053b8:	e914                	sd	a3,16(a0)
    800053ba:	6d0c                	ld	a1,24(a0)
    800053bc:	7110                	ld	a2,32(a0)
    800053be:	6194                	ld	a3,0(a1)
    800053c0:	96b2                	add	a3,a3,a2
    800053c2:	e194                	sd	a3,0(a1)
    800053c4:	4589                	li	a1,2
    800053c6:	14459073          	csrw	sip,a1
    800053ca:	6914                	ld	a3,16(a0)
    800053cc:	6510                	ld	a2,8(a0)
    800053ce:	610c                	ld	a1,0(a0)
    800053d0:	34051573          	csrrw	a0,mscratch,a0
    800053d4:	30200073          	mret
	...

00000000800053da <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    800053da:	1141                	addi	sp,sp,-16
    800053dc:	e406                	sd	ra,8(sp)
    800053de:	e022                	sd	s0,0(sp)
    800053e0:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800053e2:	0c000737          	lui	a4,0xc000
    800053e6:	4785                	li	a5,1
    800053e8:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800053ea:	c35c                	sw	a5,4(a4)
}
    800053ec:	60a2                	ld	ra,8(sp)
    800053ee:	6402                	ld	s0,0(sp)
    800053f0:	0141                	addi	sp,sp,16
    800053f2:	8082                	ret

00000000800053f4 <plicinithart>:

void
plicinithart(void)
{
    800053f4:	1141                	addi	sp,sp,-16
    800053f6:	e406                	sd	ra,8(sp)
    800053f8:	e022                	sd	s0,0(sp)
    800053fa:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800053fc:	ffffc097          	auipc	ra,0xffffc
    80005400:	b5c080e7          	jalr	-1188(ra) # 80000f58 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005404:	0085171b          	slliw	a4,a0,0x8
    80005408:	0c0027b7          	lui	a5,0xc002
    8000540c:	97ba                	add	a5,a5,a4
    8000540e:	40200713          	li	a4,1026
    80005412:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005416:	00d5151b          	slliw	a0,a0,0xd
    8000541a:	0c2017b7          	lui	a5,0xc201
    8000541e:	97aa                	add	a5,a5,a0
    80005420:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    80005424:	60a2                	ld	ra,8(sp)
    80005426:	6402                	ld	s0,0(sp)
    80005428:	0141                	addi	sp,sp,16
    8000542a:	8082                	ret

000000008000542c <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    8000542c:	1141                	addi	sp,sp,-16
    8000542e:	e406                	sd	ra,8(sp)
    80005430:	e022                	sd	s0,0(sp)
    80005432:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005434:	ffffc097          	auipc	ra,0xffffc
    80005438:	b24080e7          	jalr	-1244(ra) # 80000f58 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    8000543c:	00d5151b          	slliw	a0,a0,0xd
    80005440:	0c2017b7          	lui	a5,0xc201
    80005444:	97aa                	add	a5,a5,a0
  return irq;
}
    80005446:	43c8                	lw	a0,4(a5)
    80005448:	60a2                	ld	ra,8(sp)
    8000544a:	6402                	ld	s0,0(sp)
    8000544c:	0141                	addi	sp,sp,16
    8000544e:	8082                	ret

0000000080005450 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005450:	1101                	addi	sp,sp,-32
    80005452:	ec06                	sd	ra,24(sp)
    80005454:	e822                	sd	s0,16(sp)
    80005456:	e426                	sd	s1,8(sp)
    80005458:	1000                	addi	s0,sp,32
    8000545a:	84aa                	mv	s1,a0
  int hart = cpuid();
    8000545c:	ffffc097          	auipc	ra,0xffffc
    80005460:	afc080e7          	jalr	-1284(ra) # 80000f58 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005464:	00d5179b          	slliw	a5,a0,0xd
    80005468:	0c201737          	lui	a4,0xc201
    8000546c:	97ba                	add	a5,a5,a4
    8000546e:	c3c4                	sw	s1,4(a5)
}
    80005470:	60e2                	ld	ra,24(sp)
    80005472:	6442                	ld	s0,16(sp)
    80005474:	64a2                	ld	s1,8(sp)
    80005476:	6105                	addi	sp,sp,32
    80005478:	8082                	ret

000000008000547a <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    8000547a:	1141                	addi	sp,sp,-16
    8000547c:	e406                	sd	ra,8(sp)
    8000547e:	e022                	sd	s0,0(sp)
    80005480:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005482:	479d                	li	a5,7
    80005484:	06a7c863          	blt	a5,a0,800054f4 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    80005488:	00016717          	auipc	a4,0x16
    8000548c:	b7870713          	addi	a4,a4,-1160 # 8001b000 <disk>
    80005490:	972a                	add	a4,a4,a0
    80005492:	6789                	lui	a5,0x2
    80005494:	97ba                	add	a5,a5,a4
    80005496:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    8000549a:	e7ad                	bnez	a5,80005504 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    8000549c:	00451793          	slli	a5,a0,0x4
    800054a0:	00018717          	auipc	a4,0x18
    800054a4:	b6070713          	addi	a4,a4,-1184 # 8001d000 <disk+0x2000>
    800054a8:	6314                	ld	a3,0(a4)
    800054aa:	96be                	add	a3,a3,a5
    800054ac:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800054b0:	6314                	ld	a3,0(a4)
    800054b2:	96be                	add	a3,a3,a5
    800054b4:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    800054b8:	6314                	ld	a3,0(a4)
    800054ba:	96be                	add	a3,a3,a5
    800054bc:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    800054c0:	6318                	ld	a4,0(a4)
    800054c2:	97ba                	add	a5,a5,a4
    800054c4:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    800054c8:	00016717          	auipc	a4,0x16
    800054cc:	b3870713          	addi	a4,a4,-1224 # 8001b000 <disk>
    800054d0:	972a                	add	a4,a4,a0
    800054d2:	6789                	lui	a5,0x2
    800054d4:	97ba                	add	a5,a5,a4
    800054d6:	4705                	li	a4,1
    800054d8:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    800054dc:	00018517          	auipc	a0,0x18
    800054e0:	b3c50513          	addi	a0,a0,-1220 # 8001d018 <disk+0x2018>
    800054e4:	ffffc097          	auipc	ra,0xffffc
    800054e8:	3a8080e7          	jalr	936(ra) # 8000188c <wakeup>
}
    800054ec:	60a2                	ld	ra,8(sp)
    800054ee:	6402                	ld	s0,0(sp)
    800054f0:	0141                	addi	sp,sp,16
    800054f2:	8082                	ret
    panic("free_desc 1");
    800054f4:	00003517          	auipc	a0,0x3
    800054f8:	14450513          	addi	a0,a0,324 # 80008638 <etext+0x638>
    800054fc:	00001097          	auipc	ra,0x1
    80005500:	9f6080e7          	jalr	-1546(ra) # 80005ef2 <panic>
    panic("free_desc 2");
    80005504:	00003517          	auipc	a0,0x3
    80005508:	14450513          	addi	a0,a0,324 # 80008648 <etext+0x648>
    8000550c:	00001097          	auipc	ra,0x1
    80005510:	9e6080e7          	jalr	-1562(ra) # 80005ef2 <panic>

0000000080005514 <virtio_disk_init>:
{
    80005514:	1141                	addi	sp,sp,-16
    80005516:	e406                	sd	ra,8(sp)
    80005518:	e022                	sd	s0,0(sp)
    8000551a:	0800                	addi	s0,sp,16
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000551c:	00003597          	auipc	a1,0x3
    80005520:	13c58593          	addi	a1,a1,316 # 80008658 <etext+0x658>
    80005524:	00018517          	auipc	a0,0x18
    80005528:	c0450513          	addi	a0,a0,-1020 # 8001d128 <disk+0x2128>
    8000552c:	00001097          	auipc	ra,0x1
    80005530:	eb2080e7          	jalr	-334(ra) # 800063de <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005534:	100017b7          	lui	a5,0x10001
    80005538:	4398                	lw	a4,0(a5)
    8000553a:	2701                	sext.w	a4,a4
    8000553c:	747277b7          	lui	a5,0x74727
    80005540:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005544:	0ef71563          	bne	a4,a5,8000562e <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005548:	100017b7          	lui	a5,0x10001
    8000554c:	43dc                	lw	a5,4(a5)
    8000554e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005550:	4705                	li	a4,1
    80005552:	0ce79e63          	bne	a5,a4,8000562e <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005556:	100017b7          	lui	a5,0x10001
    8000555a:	479c                	lw	a5,8(a5)
    8000555c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000555e:	4709                	li	a4,2
    80005560:	0ce79763          	bne	a5,a4,8000562e <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005564:	100017b7          	lui	a5,0x10001
    80005568:	47d8                	lw	a4,12(a5)
    8000556a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000556c:	554d47b7          	lui	a5,0x554d4
    80005570:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005574:	0af71d63          	bne	a4,a5,8000562e <virtio_disk_init+0x11a>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005578:	100017b7          	lui	a5,0x10001
    8000557c:	4705                	li	a4,1
    8000557e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005580:	470d                	li	a4,3
    80005582:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005584:	10001737          	lui	a4,0x10001
    80005588:	4b18                	lw	a4,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    8000558a:	c7ffe6b7          	lui	a3,0xc7ffe
    8000558e:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fd851f>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005592:	8f75                	and	a4,a4,a3
    80005594:	100016b7          	lui	a3,0x10001
    80005598:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000559a:	472d                	li	a4,11
    8000559c:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000559e:	473d                	li	a4,15
    800055a0:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800055a2:	6705                	lui	a4,0x1
    800055a4:	d698                	sw	a4,40(a3)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800055a6:	0206a823          	sw	zero,48(a3) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800055aa:	5adc                	lw	a5,52(a3)
    800055ac:	2781                	sext.w	a5,a5
  if(max == 0)
    800055ae:	cbc1                	beqz	a5,8000563e <virtio_disk_init+0x12a>
  if(max < NUM)
    800055b0:	471d                	li	a4,7
    800055b2:	08f77e63          	bgeu	a4,a5,8000564e <virtio_disk_init+0x13a>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800055b6:	100017b7          	lui	a5,0x10001
    800055ba:	4721                	li	a4,8
    800055bc:	df98                	sw	a4,56(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    800055be:	6609                	lui	a2,0x2
    800055c0:	4581                	li	a1,0
    800055c2:	00016517          	auipc	a0,0x16
    800055c6:	a3e50513          	addi	a0,a0,-1474 # 8001b000 <disk>
    800055ca:	ffffb097          	auipc	ra,0xffffb
    800055ce:	bb0080e7          	jalr	-1104(ra) # 8000017a <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800055d2:	00016717          	auipc	a4,0x16
    800055d6:	a2e70713          	addi	a4,a4,-1490 # 8001b000 <disk>
    800055da:	00c75793          	srli	a5,a4,0xc
    800055de:	2781                	sext.w	a5,a5
    800055e0:	100016b7          	lui	a3,0x10001
    800055e4:	c2bc                	sw	a5,64(a3)
  disk.desc = (struct virtq_desc *) disk.pages;
    800055e6:	00018797          	auipc	a5,0x18
    800055ea:	a1a78793          	addi	a5,a5,-1510 # 8001d000 <disk+0x2000>
    800055ee:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800055f0:	00016717          	auipc	a4,0x16
    800055f4:	a9070713          	addi	a4,a4,-1392 # 8001b080 <disk+0x80>
    800055f8:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800055fa:	00017717          	auipc	a4,0x17
    800055fe:	a0670713          	addi	a4,a4,-1530 # 8001c000 <disk+0x1000>
    80005602:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005604:	4705                	li	a4,1
    80005606:	00e78c23          	sb	a4,24(a5)
    8000560a:	00e78ca3          	sb	a4,25(a5)
    8000560e:	00e78d23          	sb	a4,26(a5)
    80005612:	00e78da3          	sb	a4,27(a5)
    80005616:	00e78e23          	sb	a4,28(a5)
    8000561a:	00e78ea3          	sb	a4,29(a5)
    8000561e:	00e78f23          	sb	a4,30(a5)
    80005622:	00e78fa3          	sb	a4,31(a5)
}
    80005626:	60a2                	ld	ra,8(sp)
    80005628:	6402                	ld	s0,0(sp)
    8000562a:	0141                	addi	sp,sp,16
    8000562c:	8082                	ret
    panic("could not find virtio disk");
    8000562e:	00003517          	auipc	a0,0x3
    80005632:	03a50513          	addi	a0,a0,58 # 80008668 <etext+0x668>
    80005636:	00001097          	auipc	ra,0x1
    8000563a:	8bc080e7          	jalr	-1860(ra) # 80005ef2 <panic>
    panic("virtio disk has no queue 0");
    8000563e:	00003517          	auipc	a0,0x3
    80005642:	04a50513          	addi	a0,a0,74 # 80008688 <etext+0x688>
    80005646:	00001097          	auipc	ra,0x1
    8000564a:	8ac080e7          	jalr	-1876(ra) # 80005ef2 <panic>
    panic("virtio disk max queue too short");
    8000564e:	00003517          	auipc	a0,0x3
    80005652:	05a50513          	addi	a0,a0,90 # 800086a8 <etext+0x6a8>
    80005656:	00001097          	auipc	ra,0x1
    8000565a:	89c080e7          	jalr	-1892(ra) # 80005ef2 <panic>

000000008000565e <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    8000565e:	711d                	addi	sp,sp,-96
    80005660:	ec86                	sd	ra,88(sp)
    80005662:	e8a2                	sd	s0,80(sp)
    80005664:	e4a6                	sd	s1,72(sp)
    80005666:	e0ca                	sd	s2,64(sp)
    80005668:	fc4e                	sd	s3,56(sp)
    8000566a:	f852                	sd	s4,48(sp)
    8000566c:	f456                	sd	s5,40(sp)
    8000566e:	f05a                	sd	s6,32(sp)
    80005670:	ec5e                	sd	s7,24(sp)
    80005672:	e862                	sd	s8,16(sp)
    80005674:	1080                	addi	s0,sp,96
    80005676:	89aa                	mv	s3,a0
    80005678:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    8000567a:	00c52b83          	lw	s7,12(a0)
    8000567e:	001b9b9b          	slliw	s7,s7,0x1
    80005682:	1b82                	slli	s7,s7,0x20
    80005684:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80005688:	00018517          	auipc	a0,0x18
    8000568c:	aa050513          	addi	a0,a0,-1376 # 8001d128 <disk+0x2128>
    80005690:	00001097          	auipc	ra,0x1
    80005694:	de2080e7          	jalr	-542(ra) # 80006472 <acquire>
  for(int i = 0; i < NUM; i++){
    80005698:	44a1                	li	s1,8
      disk.free[i] = 0;
    8000569a:	00016b17          	auipc	s6,0x16
    8000569e:	966b0b13          	addi	s6,s6,-1690 # 8001b000 <disk>
    800056a2:	6a89                	lui	s5,0x2
  for(int i = 0; i < 3; i++){
    800056a4:	4a0d                	li	s4,3
    800056a6:	a88d                	j	80005718 <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    800056a8:	00fb0733          	add	a4,s6,a5
    800056ac:	9756                	add	a4,a4,s5
    800056ae:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    800056b2:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    800056b4:	0207c563          	bltz	a5,800056de <virtio_disk_rw+0x80>
  for(int i = 0; i < 3; i++){
    800056b8:	2905                	addiw	s2,s2,1
    800056ba:	0611                	addi	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    800056bc:	1b490063          	beq	s2,s4,8000585c <virtio_disk_rw+0x1fe>
    idx[i] = alloc_desc();
    800056c0:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    800056c2:	00018717          	auipc	a4,0x18
    800056c6:	95670713          	addi	a4,a4,-1706 # 8001d018 <disk+0x2018>
    800056ca:	4781                	li	a5,0
    if(disk.free[i]){
    800056cc:	00074683          	lbu	a3,0(a4)
    800056d0:	fee1                	bnez	a3,800056a8 <virtio_disk_rw+0x4a>
  for(int i = 0; i < NUM; i++){
    800056d2:	2785                	addiw	a5,a5,1
    800056d4:	0705                	addi	a4,a4,1
    800056d6:	fe979be3          	bne	a5,s1,800056cc <virtio_disk_rw+0x6e>
    idx[i] = alloc_desc();
    800056da:	57fd                	li	a5,-1
    800056dc:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    800056de:	03205163          	blez	s2,80005700 <virtio_disk_rw+0xa2>
        free_desc(idx[j]);
    800056e2:	fa042503          	lw	a0,-96(s0)
    800056e6:	00000097          	auipc	ra,0x0
    800056ea:	d94080e7          	jalr	-620(ra) # 8000547a <free_desc>
      for(int j = 0; j < i; j++)
    800056ee:	4785                	li	a5,1
    800056f0:	0127d863          	bge	a5,s2,80005700 <virtio_disk_rw+0xa2>
        free_desc(idx[j]);
    800056f4:	fa442503          	lw	a0,-92(s0)
    800056f8:	00000097          	auipc	ra,0x0
    800056fc:	d82080e7          	jalr	-638(ra) # 8000547a <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005700:	00018597          	auipc	a1,0x18
    80005704:	a2858593          	addi	a1,a1,-1496 # 8001d128 <disk+0x2128>
    80005708:	00018517          	auipc	a0,0x18
    8000570c:	91050513          	addi	a0,a0,-1776 # 8001d018 <disk+0x2018>
    80005710:	ffffc097          	auipc	ra,0xffffc
    80005714:	ff6080e7          	jalr	-10(ra) # 80001706 <sleep>
  for(int i = 0; i < 3; i++){
    80005718:	fa040613          	addi	a2,s0,-96
    8000571c:	4901                	li	s2,0
    8000571e:	b74d                	j	800056c0 <virtio_disk_rw+0x62>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80005720:	00018717          	auipc	a4,0x18
    80005724:	8e073703          	ld	a4,-1824(a4) # 8001d000 <disk+0x2000>
    80005728:	973e                	add	a4,a4,a5
    8000572a:	00071623          	sh	zero,12(a4)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    8000572e:	00016897          	auipc	a7,0x16
    80005732:	8d288893          	addi	a7,a7,-1838 # 8001b000 <disk>
    80005736:	00018717          	auipc	a4,0x18
    8000573a:	8ca70713          	addi	a4,a4,-1846 # 8001d000 <disk+0x2000>
    8000573e:	6314                	ld	a3,0(a4)
    80005740:	96be                	add	a3,a3,a5
    80005742:	00c6d583          	lhu	a1,12(a3) # 1000100c <_entry-0x6fffeff4>
    80005746:	0015e593          	ori	a1,a1,1
    8000574a:	00b69623          	sh	a1,12(a3)
  disk.desc[idx[1]].next = idx[2];
    8000574e:	fa842683          	lw	a3,-88(s0)
    80005752:	630c                	ld	a1,0(a4)
    80005754:	97ae                	add	a5,a5,a1
    80005756:	00d79723          	sh	a3,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    8000575a:	20050593          	addi	a1,a0,512
    8000575e:	0592                	slli	a1,a1,0x4
    80005760:	95c6                	add	a1,a1,a7
    80005762:	57fd                	li	a5,-1
    80005764:	02f58823          	sb	a5,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005768:	00469793          	slli	a5,a3,0x4
    8000576c:	00073803          	ld	a6,0(a4)
    80005770:	983e                	add	a6,a6,a5
    80005772:	6689                	lui	a3,0x2
    80005774:	03068693          	addi	a3,a3,48 # 2030 <_entry-0x7fffdfd0>
    80005778:	96b2                	add	a3,a3,a2
    8000577a:	96c6                	add	a3,a3,a7
    8000577c:	00d83023          	sd	a3,0(a6)
  disk.desc[idx[2]].len = 1;
    80005780:	6314                	ld	a3,0(a4)
    80005782:	96be                	add	a3,a3,a5
    80005784:	4605                	li	a2,1
    80005786:	c690                	sw	a2,8(a3)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005788:	6314                	ld	a3,0(a4)
    8000578a:	96be                	add	a3,a3,a5
    8000578c:	4809                	li	a6,2
    8000578e:	01069623          	sh	a6,12(a3)
  disk.desc[idx[2]].next = 0;
    80005792:	6314                	ld	a3,0(a4)
    80005794:	97b6                	add	a5,a5,a3
    80005796:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000579a:	00c9a223          	sw	a2,4(s3)
  disk.info[idx[0]].b = b;
    8000579e:	0335b423          	sd	s3,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800057a2:	6714                	ld	a3,8(a4)
    800057a4:	0026d783          	lhu	a5,2(a3)
    800057a8:	8b9d                	andi	a5,a5,7
    800057aa:	0786                	slli	a5,a5,0x1
    800057ac:	96be                	add	a3,a3,a5
    800057ae:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    800057b2:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    800057b6:	6718                	ld	a4,8(a4)
    800057b8:	00275783          	lhu	a5,2(a4)
    800057bc:	2785                	addiw	a5,a5,1
    800057be:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800057c2:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800057c6:	100017b7          	lui	a5,0x10001
    800057ca:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800057ce:	0049a783          	lw	a5,4(s3)
    800057d2:	02c79163          	bne	a5,a2,800057f4 <virtio_disk_rw+0x196>
    sleep(b, &disk.vdisk_lock);
    800057d6:	00018917          	auipc	s2,0x18
    800057da:	95290913          	addi	s2,s2,-1710 # 8001d128 <disk+0x2128>
  while(b->disk == 1) {
    800057de:	84b2                	mv	s1,a2
    sleep(b, &disk.vdisk_lock);
    800057e0:	85ca                	mv	a1,s2
    800057e2:	854e                	mv	a0,s3
    800057e4:	ffffc097          	auipc	ra,0xffffc
    800057e8:	f22080e7          	jalr	-222(ra) # 80001706 <sleep>
  while(b->disk == 1) {
    800057ec:	0049a783          	lw	a5,4(s3)
    800057f0:	fe9788e3          	beq	a5,s1,800057e0 <virtio_disk_rw+0x182>
  }

  disk.info[idx[0]].b = 0;
    800057f4:	fa042903          	lw	s2,-96(s0)
    800057f8:	20090713          	addi	a4,s2,512
    800057fc:	0712                	slli	a4,a4,0x4
    800057fe:	00016797          	auipc	a5,0x16
    80005802:	80278793          	addi	a5,a5,-2046 # 8001b000 <disk>
    80005806:	97ba                	add	a5,a5,a4
    80005808:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    8000580c:	00017997          	auipc	s3,0x17
    80005810:	7f498993          	addi	s3,s3,2036 # 8001d000 <disk+0x2000>
    80005814:	00491713          	slli	a4,s2,0x4
    80005818:	0009b783          	ld	a5,0(s3)
    8000581c:	97ba                	add	a5,a5,a4
    8000581e:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005822:	854a                	mv	a0,s2
    80005824:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005828:	00000097          	auipc	ra,0x0
    8000582c:	c52080e7          	jalr	-942(ra) # 8000547a <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80005830:	8885                	andi	s1,s1,1
    80005832:	f0ed                	bnez	s1,80005814 <virtio_disk_rw+0x1b6>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005834:	00018517          	auipc	a0,0x18
    80005838:	8f450513          	addi	a0,a0,-1804 # 8001d128 <disk+0x2128>
    8000583c:	00001097          	auipc	ra,0x1
    80005840:	ce6080e7          	jalr	-794(ra) # 80006522 <release>
}
    80005844:	60e6                	ld	ra,88(sp)
    80005846:	6446                	ld	s0,80(sp)
    80005848:	64a6                	ld	s1,72(sp)
    8000584a:	6906                	ld	s2,64(sp)
    8000584c:	79e2                	ld	s3,56(sp)
    8000584e:	7a42                	ld	s4,48(sp)
    80005850:	7aa2                	ld	s5,40(sp)
    80005852:	7b02                	ld	s6,32(sp)
    80005854:	6be2                	ld	s7,24(sp)
    80005856:	6c42                	ld	s8,16(sp)
    80005858:	6125                	addi	sp,sp,96
    8000585a:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000585c:	fa042503          	lw	a0,-96(s0)
    80005860:	00451613          	slli	a2,a0,0x4
  if(write)
    80005864:	00015597          	auipc	a1,0x15
    80005868:	79c58593          	addi	a1,a1,1948 # 8001b000 <disk>
    8000586c:	20050793          	addi	a5,a0,512
    80005870:	0792                	slli	a5,a5,0x4
    80005872:	97ae                	add	a5,a5,a1
    80005874:	01803733          	snez	a4,s8
    80005878:	0ae7a423          	sw	a4,168(a5)
  buf0->reserved = 0;
    8000587c:	0a07a623          	sw	zero,172(a5)
  buf0->sector = sector;
    80005880:	0b77b823          	sd	s7,176(a5)
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005884:	00017717          	auipc	a4,0x17
    80005888:	77c70713          	addi	a4,a4,1916 # 8001d000 <disk+0x2000>
    8000588c:	6314                	ld	a3,0(a4)
    8000588e:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005890:	6789                	lui	a5,0x2
    80005892:	0a878793          	addi	a5,a5,168 # 20a8 <_entry-0x7fffdf58>
    80005896:	97b2                	add	a5,a5,a2
    80005898:	97ae                	add	a5,a5,a1
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000589a:	e29c                	sd	a5,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000589c:	631c                	ld	a5,0(a4)
    8000589e:	97b2                	add	a5,a5,a2
    800058a0:	46c1                	li	a3,16
    800058a2:	c794                	sw	a3,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800058a4:	631c                	ld	a5,0(a4)
    800058a6:	97b2                	add	a5,a5,a2
    800058a8:	4685                	li	a3,1
    800058aa:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[0]].next = idx[1];
    800058ae:	fa442783          	lw	a5,-92(s0)
    800058b2:	6314                	ld	a3,0(a4)
    800058b4:	96b2                	add	a3,a3,a2
    800058b6:	00f69723          	sh	a5,14(a3)
  disk.desc[idx[1]].addr = (uint64) b->data;
    800058ba:	0792                	slli	a5,a5,0x4
    800058bc:	6314                	ld	a3,0(a4)
    800058be:	96be                	add	a3,a3,a5
    800058c0:	05898593          	addi	a1,s3,88
    800058c4:	e28c                	sd	a1,0(a3)
  disk.desc[idx[1]].len = BSIZE;
    800058c6:	6318                	ld	a4,0(a4)
    800058c8:	973e                	add	a4,a4,a5
    800058ca:	40000693          	li	a3,1024
    800058ce:	c714                	sw	a3,8(a4)
  if(write)
    800058d0:	e40c18e3          	bnez	s8,80005720 <virtio_disk_rw+0xc2>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800058d4:	00017717          	auipc	a4,0x17
    800058d8:	72c73703          	ld	a4,1836(a4) # 8001d000 <disk+0x2000>
    800058dc:	973e                	add	a4,a4,a5
    800058de:	4689                	li	a3,2
    800058e0:	00d71623          	sh	a3,12(a4)
    800058e4:	b5a9                	j	8000572e <virtio_disk_rw+0xd0>

00000000800058e6 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800058e6:	1101                	addi	sp,sp,-32
    800058e8:	ec06                	sd	ra,24(sp)
    800058ea:	e822                	sd	s0,16(sp)
    800058ec:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800058ee:	00018517          	auipc	a0,0x18
    800058f2:	83a50513          	addi	a0,a0,-1990 # 8001d128 <disk+0x2128>
    800058f6:	00001097          	auipc	ra,0x1
    800058fa:	b7c080e7          	jalr	-1156(ra) # 80006472 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800058fe:	100017b7          	lui	a5,0x10001
    80005902:	53bc                	lw	a5,96(a5)
    80005904:	8b8d                	andi	a5,a5,3
    80005906:	10001737          	lui	a4,0x10001
    8000590a:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    8000590c:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005910:	00017797          	auipc	a5,0x17
    80005914:	6f078793          	addi	a5,a5,1776 # 8001d000 <disk+0x2000>
    80005918:	6b94                	ld	a3,16(a5)
    8000591a:	0207d703          	lhu	a4,32(a5)
    8000591e:	0026d783          	lhu	a5,2(a3)
    80005922:	06f70563          	beq	a4,a5,8000598c <virtio_disk_intr+0xa6>
    80005926:	e426                	sd	s1,8(sp)
    80005928:	e04a                	sd	s2,0(sp)
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000592a:	00015917          	auipc	s2,0x15
    8000592e:	6d690913          	addi	s2,s2,1750 # 8001b000 <disk>
    80005932:	00017497          	auipc	s1,0x17
    80005936:	6ce48493          	addi	s1,s1,1742 # 8001d000 <disk+0x2000>
    __sync_synchronize();
    8000593a:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000593e:	6898                	ld	a4,16(s1)
    80005940:	0204d783          	lhu	a5,32(s1)
    80005944:	8b9d                	andi	a5,a5,7
    80005946:	078e                	slli	a5,a5,0x3
    80005948:	97ba                	add	a5,a5,a4
    8000594a:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000594c:	20078713          	addi	a4,a5,512
    80005950:	0712                	slli	a4,a4,0x4
    80005952:	974a                	add	a4,a4,s2
    80005954:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005958:	e731                	bnez	a4,800059a4 <virtio_disk_intr+0xbe>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000595a:	20078793          	addi	a5,a5,512
    8000595e:	0792                	slli	a5,a5,0x4
    80005960:	97ca                	add	a5,a5,s2
    80005962:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005964:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005968:	ffffc097          	auipc	ra,0xffffc
    8000596c:	f24080e7          	jalr	-220(ra) # 8000188c <wakeup>

    disk.used_idx += 1;
    80005970:	0204d783          	lhu	a5,32(s1)
    80005974:	2785                	addiw	a5,a5,1
    80005976:	17c2                	slli	a5,a5,0x30
    80005978:	93c1                	srli	a5,a5,0x30
    8000597a:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    8000597e:	6898                	ld	a4,16(s1)
    80005980:	00275703          	lhu	a4,2(a4)
    80005984:	faf71be3          	bne	a4,a5,8000593a <virtio_disk_intr+0x54>
    80005988:	64a2                	ld	s1,8(sp)
    8000598a:	6902                	ld	s2,0(sp)
  }

  release(&disk.vdisk_lock);
    8000598c:	00017517          	auipc	a0,0x17
    80005990:	79c50513          	addi	a0,a0,1948 # 8001d128 <disk+0x2128>
    80005994:	00001097          	auipc	ra,0x1
    80005998:	b8e080e7          	jalr	-1138(ra) # 80006522 <release>
}
    8000599c:	60e2                	ld	ra,24(sp)
    8000599e:	6442                	ld	s0,16(sp)
    800059a0:	6105                	addi	sp,sp,32
    800059a2:	8082                	ret
      panic("virtio_disk_intr status");
    800059a4:	00003517          	auipc	a0,0x3
    800059a8:	d2450513          	addi	a0,a0,-732 # 800086c8 <etext+0x6c8>
    800059ac:	00000097          	auipc	ra,0x0
    800059b0:	546080e7          	jalr	1350(ra) # 80005ef2 <panic>

00000000800059b4 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800059b4:	1141                	addi	sp,sp,-16
    800059b6:	e406                	sd	ra,8(sp)
    800059b8:	e022                	sd	s0,0(sp)
    800059ba:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800059bc:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800059c0:	2781                	sext.w	a5,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800059c2:	0037961b          	slliw	a2,a5,0x3
    800059c6:	02004737          	lui	a4,0x2004
    800059ca:	963a                	add	a2,a2,a4
    800059cc:	0200c737          	lui	a4,0x200c
    800059d0:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800059d4:	000f46b7          	lui	a3,0xf4
    800059d8:	24068693          	addi	a3,a3,576 # f4240 <_entry-0x7ff0bdc0>
    800059dc:	9736                	add	a4,a4,a3
    800059de:	e218                	sd	a4,0(a2)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800059e0:	00279713          	slli	a4,a5,0x2
    800059e4:	973e                	add	a4,a4,a5
    800059e6:	070e                	slli	a4,a4,0x3
    800059e8:	00018797          	auipc	a5,0x18
    800059ec:	61878793          	addi	a5,a5,1560 # 8001e000 <timer_scratch>
    800059f0:	97ba                	add	a5,a5,a4
  scratch[3] = CLINT_MTIMECMP(id);
    800059f2:	ef90                	sd	a2,24(a5)
  scratch[4] = interval;
    800059f4:	f394                	sd	a3,32(a5)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    800059f6:	34079073          	csrw	mscratch,a5
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800059fa:	00000797          	auipc	a5,0x0
    800059fe:	9b678793          	addi	a5,a5,-1610 # 800053b0 <timervec>
    80005a02:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005a06:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005a0a:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005a0e:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005a12:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005a16:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005a1a:	30479073          	csrw	mie,a5
}
    80005a1e:	60a2                	ld	ra,8(sp)
    80005a20:	6402                	ld	s0,0(sp)
    80005a22:	0141                	addi	sp,sp,16
    80005a24:	8082                	ret

0000000080005a26 <start>:
{
    80005a26:	1141                	addi	sp,sp,-16
    80005a28:	e406                	sd	ra,8(sp)
    80005a2a:	e022                	sd	s0,0(sp)
    80005a2c:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005a2e:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005a32:	7779                	lui	a4,0xffffe
    80005a34:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd85bf>
    80005a38:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005a3a:	6705                	lui	a4,0x1
    80005a3c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005a40:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005a42:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005a46:	ffffb797          	auipc	a5,0xffffb
    80005a4a:	8ee78793          	addi	a5,a5,-1810 # 80000334 <main>
    80005a4e:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005a52:	4781                	li	a5,0
    80005a54:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005a58:	67c1                	lui	a5,0x10
    80005a5a:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80005a5c:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005a60:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005a64:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005a68:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005a6c:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005a70:	57fd                	li	a5,-1
    80005a72:	83a9                	srli	a5,a5,0xa
    80005a74:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005a78:	47bd                	li	a5,15
    80005a7a:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005a7e:	00000097          	auipc	ra,0x0
    80005a82:	f36080e7          	jalr	-202(ra) # 800059b4 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005a86:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005a8a:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005a8c:	823e                	mv	tp,a5
  asm volatile("mret");
    80005a8e:	30200073          	mret
}
    80005a92:	60a2                	ld	ra,8(sp)
    80005a94:	6402                	ld	s0,0(sp)
    80005a96:	0141                	addi	sp,sp,16
    80005a98:	8082                	ret

0000000080005a9a <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005a9a:	711d                	addi	sp,sp,-96
    80005a9c:	ec86                	sd	ra,88(sp)
    80005a9e:	e8a2                	sd	s0,80(sp)
    80005aa0:	e0ca                	sd	s2,64(sp)
    80005aa2:	1080                	addi	s0,sp,96
  int i;

  for(i = 0; i < n; i++){
    80005aa4:	04c05c63          	blez	a2,80005afc <consolewrite+0x62>
    80005aa8:	e4a6                	sd	s1,72(sp)
    80005aaa:	fc4e                	sd	s3,56(sp)
    80005aac:	f852                	sd	s4,48(sp)
    80005aae:	f456                	sd	s5,40(sp)
    80005ab0:	f05a                	sd	s6,32(sp)
    80005ab2:	ec5e                	sd	s7,24(sp)
    80005ab4:	8a2a                	mv	s4,a0
    80005ab6:	84ae                	mv	s1,a1
    80005ab8:	89b2                	mv	s3,a2
    80005aba:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005abc:	faf40b93          	addi	s7,s0,-81
    80005ac0:	4b05                	li	s6,1
    80005ac2:	5afd                	li	s5,-1
    80005ac4:	86da                	mv	a3,s6
    80005ac6:	8626                	mv	a2,s1
    80005ac8:	85d2                	mv	a1,s4
    80005aca:	855e                	mv	a0,s7
    80005acc:	ffffc097          	auipc	ra,0xffffc
    80005ad0:	02e080e7          	jalr	46(ra) # 80001afa <either_copyin>
    80005ad4:	03550663          	beq	a0,s5,80005b00 <consolewrite+0x66>
      break;
    uartputc(c);
    80005ad8:	faf44503          	lbu	a0,-81(s0)
    80005adc:	00000097          	auipc	ra,0x0
    80005ae0:	7d4080e7          	jalr	2004(ra) # 800062b0 <uartputc>
  for(i = 0; i < n; i++){
    80005ae4:	2905                	addiw	s2,s2,1
    80005ae6:	0485                	addi	s1,s1,1
    80005ae8:	fd299ee3          	bne	s3,s2,80005ac4 <consolewrite+0x2a>
    80005aec:	894e                	mv	s2,s3
    80005aee:	64a6                	ld	s1,72(sp)
    80005af0:	79e2                	ld	s3,56(sp)
    80005af2:	7a42                	ld	s4,48(sp)
    80005af4:	7aa2                	ld	s5,40(sp)
    80005af6:	7b02                	ld	s6,32(sp)
    80005af8:	6be2                	ld	s7,24(sp)
    80005afa:	a809                	j	80005b0c <consolewrite+0x72>
    80005afc:	4901                	li	s2,0
    80005afe:	a039                	j	80005b0c <consolewrite+0x72>
    80005b00:	64a6                	ld	s1,72(sp)
    80005b02:	79e2                	ld	s3,56(sp)
    80005b04:	7a42                	ld	s4,48(sp)
    80005b06:	7aa2                	ld	s5,40(sp)
    80005b08:	7b02                	ld	s6,32(sp)
    80005b0a:	6be2                	ld	s7,24(sp)
  }

  return i;
}
    80005b0c:	854a                	mv	a0,s2
    80005b0e:	60e6                	ld	ra,88(sp)
    80005b10:	6446                	ld	s0,80(sp)
    80005b12:	6906                	ld	s2,64(sp)
    80005b14:	6125                	addi	sp,sp,96
    80005b16:	8082                	ret

0000000080005b18 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005b18:	711d                	addi	sp,sp,-96
    80005b1a:	ec86                	sd	ra,88(sp)
    80005b1c:	e8a2                	sd	s0,80(sp)
    80005b1e:	e4a6                	sd	s1,72(sp)
    80005b20:	e0ca                	sd	s2,64(sp)
    80005b22:	fc4e                	sd	s3,56(sp)
    80005b24:	f852                	sd	s4,48(sp)
    80005b26:	f456                	sd	s5,40(sp)
    80005b28:	f05a                	sd	s6,32(sp)
    80005b2a:	1080                	addi	s0,sp,96
    80005b2c:	8aaa                	mv	s5,a0
    80005b2e:	8a2e                	mv	s4,a1
    80005b30:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005b32:	8b32                	mv	s6,a2
  acquire(&cons.lock);
    80005b34:	00020517          	auipc	a0,0x20
    80005b38:	60c50513          	addi	a0,a0,1548 # 80026140 <cons>
    80005b3c:	00001097          	auipc	ra,0x1
    80005b40:	936080e7          	jalr	-1738(ra) # 80006472 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005b44:	00020497          	auipc	s1,0x20
    80005b48:	5fc48493          	addi	s1,s1,1532 # 80026140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005b4c:	00020917          	auipc	s2,0x20
    80005b50:	68c90913          	addi	s2,s2,1676 # 800261d8 <cons+0x98>
  while(n > 0){
    80005b54:	0d305263          	blez	s3,80005c18 <consoleread+0x100>
    while(cons.r == cons.w){
    80005b58:	0984a783          	lw	a5,152(s1)
    80005b5c:	09c4a703          	lw	a4,156(s1)
    80005b60:	0af71763          	bne	a4,a5,80005c0e <consoleread+0xf6>
      if(myproc()->killed){
    80005b64:	ffffb097          	auipc	ra,0xffffb
    80005b68:	428080e7          	jalr	1064(ra) # 80000f8c <myproc>
    80005b6c:	551c                	lw	a5,40(a0)
    80005b6e:	e7ad                	bnez	a5,80005bd8 <consoleread+0xc0>
      sleep(&cons.r, &cons.lock);
    80005b70:	85a6                	mv	a1,s1
    80005b72:	854a                	mv	a0,s2
    80005b74:	ffffc097          	auipc	ra,0xffffc
    80005b78:	b92080e7          	jalr	-1134(ra) # 80001706 <sleep>
    while(cons.r == cons.w){
    80005b7c:	0984a783          	lw	a5,152(s1)
    80005b80:	09c4a703          	lw	a4,156(s1)
    80005b84:	fef700e3          	beq	a4,a5,80005b64 <consoleread+0x4c>
    80005b88:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    80005b8a:	00020717          	auipc	a4,0x20
    80005b8e:	5b670713          	addi	a4,a4,1462 # 80026140 <cons>
    80005b92:	0017869b          	addiw	a3,a5,1
    80005b96:	08d72c23          	sw	a3,152(a4)
    80005b9a:	07f7f693          	andi	a3,a5,127
    80005b9e:	9736                	add	a4,a4,a3
    80005ba0:	01874703          	lbu	a4,24(a4)
    80005ba4:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    80005ba8:	4691                	li	a3,4
    80005baa:	04db8a63          	beq	s7,a3,80005bfe <consoleread+0xe6>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80005bae:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005bb2:	4685                	li	a3,1
    80005bb4:	faf40613          	addi	a2,s0,-81
    80005bb8:	85d2                	mv	a1,s4
    80005bba:	8556                	mv	a0,s5
    80005bbc:	ffffc097          	auipc	ra,0xffffc
    80005bc0:	ee8080e7          	jalr	-280(ra) # 80001aa4 <either_copyout>
    80005bc4:	57fd                	li	a5,-1
    80005bc6:	04f50863          	beq	a0,a5,80005c16 <consoleread+0xfe>
      break;

    dst++;
    80005bca:	0a05                	addi	s4,s4,1
    --n;
    80005bcc:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80005bce:	47a9                	li	a5,10
    80005bd0:	04fb8f63          	beq	s7,a5,80005c2e <consoleread+0x116>
    80005bd4:	6be2                	ld	s7,24(sp)
    80005bd6:	bfbd                	j	80005b54 <consoleread+0x3c>
        release(&cons.lock);
    80005bd8:	00020517          	auipc	a0,0x20
    80005bdc:	56850513          	addi	a0,a0,1384 # 80026140 <cons>
    80005be0:	00001097          	auipc	ra,0x1
    80005be4:	942080e7          	jalr	-1726(ra) # 80006522 <release>
        return -1;
    80005be8:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80005bea:	60e6                	ld	ra,88(sp)
    80005bec:	6446                	ld	s0,80(sp)
    80005bee:	64a6                	ld	s1,72(sp)
    80005bf0:	6906                	ld	s2,64(sp)
    80005bf2:	79e2                	ld	s3,56(sp)
    80005bf4:	7a42                	ld	s4,48(sp)
    80005bf6:	7aa2                	ld	s5,40(sp)
    80005bf8:	7b02                	ld	s6,32(sp)
    80005bfa:	6125                	addi	sp,sp,96
    80005bfc:	8082                	ret
      if(n < target){
    80005bfe:	0169fa63          	bgeu	s3,s6,80005c12 <consoleread+0xfa>
        cons.r--;
    80005c02:	00020717          	auipc	a4,0x20
    80005c06:	5cf72b23          	sw	a5,1494(a4) # 800261d8 <cons+0x98>
    80005c0a:	6be2                	ld	s7,24(sp)
    80005c0c:	a031                	j	80005c18 <consoleread+0x100>
    80005c0e:	ec5e                	sd	s7,24(sp)
    80005c10:	bfad                	j	80005b8a <consoleread+0x72>
    80005c12:	6be2                	ld	s7,24(sp)
    80005c14:	a011                	j	80005c18 <consoleread+0x100>
    80005c16:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    80005c18:	00020517          	auipc	a0,0x20
    80005c1c:	52850513          	addi	a0,a0,1320 # 80026140 <cons>
    80005c20:	00001097          	auipc	ra,0x1
    80005c24:	902080e7          	jalr	-1790(ra) # 80006522 <release>
  return target - n;
    80005c28:	413b053b          	subw	a0,s6,s3
    80005c2c:	bf7d                	j	80005bea <consoleread+0xd2>
    80005c2e:	6be2                	ld	s7,24(sp)
    80005c30:	b7e5                	j	80005c18 <consoleread+0x100>

0000000080005c32 <consputc>:
{
    80005c32:	1141                	addi	sp,sp,-16
    80005c34:	e406                	sd	ra,8(sp)
    80005c36:	e022                	sd	s0,0(sp)
    80005c38:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005c3a:	10000793          	li	a5,256
    80005c3e:	00f50a63          	beq	a0,a5,80005c52 <consputc+0x20>
    uartputc_sync(c);
    80005c42:	00000097          	auipc	ra,0x0
    80005c46:	590080e7          	jalr	1424(ra) # 800061d2 <uartputc_sync>
}
    80005c4a:	60a2                	ld	ra,8(sp)
    80005c4c:	6402                	ld	s0,0(sp)
    80005c4e:	0141                	addi	sp,sp,16
    80005c50:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005c52:	4521                	li	a0,8
    80005c54:	00000097          	auipc	ra,0x0
    80005c58:	57e080e7          	jalr	1406(ra) # 800061d2 <uartputc_sync>
    80005c5c:	02000513          	li	a0,32
    80005c60:	00000097          	auipc	ra,0x0
    80005c64:	572080e7          	jalr	1394(ra) # 800061d2 <uartputc_sync>
    80005c68:	4521                	li	a0,8
    80005c6a:	00000097          	auipc	ra,0x0
    80005c6e:	568080e7          	jalr	1384(ra) # 800061d2 <uartputc_sync>
    80005c72:	bfe1                	j	80005c4a <consputc+0x18>

0000000080005c74 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005c74:	7179                	addi	sp,sp,-48
    80005c76:	f406                	sd	ra,40(sp)
    80005c78:	f022                	sd	s0,32(sp)
    80005c7a:	ec26                	sd	s1,24(sp)
    80005c7c:	1800                	addi	s0,sp,48
    80005c7e:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005c80:	00020517          	auipc	a0,0x20
    80005c84:	4c050513          	addi	a0,a0,1216 # 80026140 <cons>
    80005c88:	00000097          	auipc	ra,0x0
    80005c8c:	7ea080e7          	jalr	2026(ra) # 80006472 <acquire>

  switch(c){
    80005c90:	47d5                	li	a5,21
    80005c92:	0af48463          	beq	s1,a5,80005d3a <consoleintr+0xc6>
    80005c96:	0297c963          	blt	a5,s1,80005cc8 <consoleintr+0x54>
    80005c9a:	47a1                	li	a5,8
    80005c9c:	10f48063          	beq	s1,a5,80005d9c <consoleintr+0x128>
    80005ca0:	47c1                	li	a5,16
    80005ca2:	12f49363          	bne	s1,a5,80005dc8 <consoleintr+0x154>
  case C('P'):  // Print process list.
    procdump();
    80005ca6:	ffffc097          	auipc	ra,0xffffc
    80005caa:	eaa080e7          	jalr	-342(ra) # 80001b50 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005cae:	00020517          	auipc	a0,0x20
    80005cb2:	49250513          	addi	a0,a0,1170 # 80026140 <cons>
    80005cb6:	00001097          	auipc	ra,0x1
    80005cba:	86c080e7          	jalr	-1940(ra) # 80006522 <release>
}
    80005cbe:	70a2                	ld	ra,40(sp)
    80005cc0:	7402                	ld	s0,32(sp)
    80005cc2:	64e2                	ld	s1,24(sp)
    80005cc4:	6145                	addi	sp,sp,48
    80005cc6:	8082                	ret
  switch(c){
    80005cc8:	07f00793          	li	a5,127
    80005ccc:	0cf48863          	beq	s1,a5,80005d9c <consoleintr+0x128>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005cd0:	00020717          	auipc	a4,0x20
    80005cd4:	47070713          	addi	a4,a4,1136 # 80026140 <cons>
    80005cd8:	0a072783          	lw	a5,160(a4)
    80005cdc:	09872703          	lw	a4,152(a4)
    80005ce0:	9f99                	subw	a5,a5,a4
    80005ce2:	07f00713          	li	a4,127
    80005ce6:	fcf764e3          	bltu	a4,a5,80005cae <consoleintr+0x3a>
      c = (c == '\r') ? '\n' : c;
    80005cea:	47b5                	li	a5,13
    80005cec:	0ef48163          	beq	s1,a5,80005dce <consoleintr+0x15a>
      consputc(c);
    80005cf0:	8526                	mv	a0,s1
    80005cf2:	00000097          	auipc	ra,0x0
    80005cf6:	f40080e7          	jalr	-192(ra) # 80005c32 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005cfa:	00020797          	auipc	a5,0x20
    80005cfe:	44678793          	addi	a5,a5,1094 # 80026140 <cons>
    80005d02:	0a07a703          	lw	a4,160(a5)
    80005d06:	0017069b          	addiw	a3,a4,1
    80005d0a:	8636                	mv	a2,a3
    80005d0c:	0ad7a023          	sw	a3,160(a5)
    80005d10:	07f77713          	andi	a4,a4,127
    80005d14:	97ba                	add	a5,a5,a4
    80005d16:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80005d1a:	47a9                	li	a5,10
    80005d1c:	0cf48f63          	beq	s1,a5,80005dfa <consoleintr+0x186>
    80005d20:	4791                	li	a5,4
    80005d22:	0cf48c63          	beq	s1,a5,80005dfa <consoleintr+0x186>
    80005d26:	00020797          	auipc	a5,0x20
    80005d2a:	4b27a783          	lw	a5,1202(a5) # 800261d8 <cons+0x98>
    80005d2e:	0807879b          	addiw	a5,a5,128
    80005d32:	f6f69ee3          	bne	a3,a5,80005cae <consoleintr+0x3a>
    80005d36:	863e                	mv	a2,a5
    80005d38:	a0c9                	j	80005dfa <consoleintr+0x186>
    80005d3a:	e84a                	sd	s2,16(sp)
    80005d3c:	e44e                	sd	s3,8(sp)
    while(cons.e != cons.w &&
    80005d3e:	00020717          	auipc	a4,0x20
    80005d42:	40270713          	addi	a4,a4,1026 # 80026140 <cons>
    80005d46:	0a072783          	lw	a5,160(a4)
    80005d4a:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005d4e:	00020497          	auipc	s1,0x20
    80005d52:	3f248493          	addi	s1,s1,1010 # 80026140 <cons>
    while(cons.e != cons.w &&
    80005d56:	4929                	li	s2,10
      consputc(BACKSPACE);
    80005d58:	10000993          	li	s3,256
    while(cons.e != cons.w &&
    80005d5c:	02f70a63          	beq	a4,a5,80005d90 <consoleintr+0x11c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005d60:	37fd                	addiw	a5,a5,-1
    80005d62:	07f7f713          	andi	a4,a5,127
    80005d66:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005d68:	01874703          	lbu	a4,24(a4)
    80005d6c:	03270563          	beq	a4,s2,80005d96 <consoleintr+0x122>
      cons.e--;
    80005d70:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005d74:	854e                	mv	a0,s3
    80005d76:	00000097          	auipc	ra,0x0
    80005d7a:	ebc080e7          	jalr	-324(ra) # 80005c32 <consputc>
    while(cons.e != cons.w &&
    80005d7e:	0a04a783          	lw	a5,160(s1)
    80005d82:	09c4a703          	lw	a4,156(s1)
    80005d86:	fcf71de3          	bne	a4,a5,80005d60 <consoleintr+0xec>
    80005d8a:	6942                	ld	s2,16(sp)
    80005d8c:	69a2                	ld	s3,8(sp)
    80005d8e:	b705                	j	80005cae <consoleintr+0x3a>
    80005d90:	6942                	ld	s2,16(sp)
    80005d92:	69a2                	ld	s3,8(sp)
    80005d94:	bf29                	j	80005cae <consoleintr+0x3a>
    80005d96:	6942                	ld	s2,16(sp)
    80005d98:	69a2                	ld	s3,8(sp)
    80005d9a:	bf11                	j	80005cae <consoleintr+0x3a>
    if(cons.e != cons.w){
    80005d9c:	00020717          	auipc	a4,0x20
    80005da0:	3a470713          	addi	a4,a4,932 # 80026140 <cons>
    80005da4:	0a072783          	lw	a5,160(a4)
    80005da8:	09c72703          	lw	a4,156(a4)
    80005dac:	f0f701e3          	beq	a4,a5,80005cae <consoleintr+0x3a>
      cons.e--;
    80005db0:	37fd                	addiw	a5,a5,-1
    80005db2:	00020717          	auipc	a4,0x20
    80005db6:	42f72723          	sw	a5,1070(a4) # 800261e0 <cons+0xa0>
      consputc(BACKSPACE);
    80005dba:	10000513          	li	a0,256
    80005dbe:	00000097          	auipc	ra,0x0
    80005dc2:	e74080e7          	jalr	-396(ra) # 80005c32 <consputc>
    80005dc6:	b5e5                	j	80005cae <consoleintr+0x3a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005dc8:	ee0483e3          	beqz	s1,80005cae <consoleintr+0x3a>
    80005dcc:	b711                	j	80005cd0 <consoleintr+0x5c>
      consputc(c);
    80005dce:	4529                	li	a0,10
    80005dd0:	00000097          	auipc	ra,0x0
    80005dd4:	e62080e7          	jalr	-414(ra) # 80005c32 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005dd8:	00020797          	auipc	a5,0x20
    80005ddc:	36878793          	addi	a5,a5,872 # 80026140 <cons>
    80005de0:	0a07a703          	lw	a4,160(a5)
    80005de4:	0017069b          	addiw	a3,a4,1
    80005de8:	8636                	mv	a2,a3
    80005dea:	0ad7a023          	sw	a3,160(a5)
    80005dee:	07f77713          	andi	a4,a4,127
    80005df2:	97ba                	add	a5,a5,a4
    80005df4:	4729                	li	a4,10
    80005df6:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005dfa:	00020797          	auipc	a5,0x20
    80005dfe:	3ec7a123          	sw	a2,994(a5) # 800261dc <cons+0x9c>
        wakeup(&cons.r);
    80005e02:	00020517          	auipc	a0,0x20
    80005e06:	3d650513          	addi	a0,a0,982 # 800261d8 <cons+0x98>
    80005e0a:	ffffc097          	auipc	ra,0xffffc
    80005e0e:	a82080e7          	jalr	-1406(ra) # 8000188c <wakeup>
    80005e12:	bd71                	j	80005cae <consoleintr+0x3a>

0000000080005e14 <consoleinit>:

void
consoleinit(void)
{
    80005e14:	1141                	addi	sp,sp,-16
    80005e16:	e406                	sd	ra,8(sp)
    80005e18:	e022                	sd	s0,0(sp)
    80005e1a:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005e1c:	00003597          	auipc	a1,0x3
    80005e20:	8c458593          	addi	a1,a1,-1852 # 800086e0 <etext+0x6e0>
    80005e24:	00020517          	auipc	a0,0x20
    80005e28:	31c50513          	addi	a0,a0,796 # 80026140 <cons>
    80005e2c:	00000097          	auipc	ra,0x0
    80005e30:	5b2080e7          	jalr	1458(ra) # 800063de <initlock>

  uartinit();
    80005e34:	00000097          	auipc	ra,0x0
    80005e38:	344080e7          	jalr	836(ra) # 80006178 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005e3c:	00013797          	auipc	a5,0x13
    80005e40:	48c78793          	addi	a5,a5,1164 # 800192c8 <devsw>
    80005e44:	00000717          	auipc	a4,0x0
    80005e48:	cd470713          	addi	a4,a4,-812 # 80005b18 <consoleread>
    80005e4c:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005e4e:	00000717          	auipc	a4,0x0
    80005e52:	c4c70713          	addi	a4,a4,-948 # 80005a9a <consolewrite>
    80005e56:	ef98                	sd	a4,24(a5)
}
    80005e58:	60a2                	ld	ra,8(sp)
    80005e5a:	6402                	ld	s0,0(sp)
    80005e5c:	0141                	addi	sp,sp,16
    80005e5e:	8082                	ret

0000000080005e60 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005e60:	7179                	addi	sp,sp,-48
    80005e62:	f406                	sd	ra,40(sp)
    80005e64:	f022                	sd	s0,32(sp)
    80005e66:	ec26                	sd	s1,24(sp)
    80005e68:	e84a                	sd	s2,16(sp)
    80005e6a:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005e6c:	c219                	beqz	a2,80005e72 <printint+0x12>
    80005e6e:	06054e63          	bltz	a0,80005eea <printint+0x8a>
    x = -xx;
  else
    x = xx;
    80005e72:	4e01                	li	t3,0

  i = 0;
    80005e74:	fd040313          	addi	t1,s0,-48
    x = xx;
    80005e78:	869a                	mv	a3,t1
  i = 0;
    80005e7a:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    80005e7c:	00003817          	auipc	a6,0x3
    80005e80:	a0c80813          	addi	a6,a6,-1524 # 80008888 <digits>
    80005e84:	88be                	mv	a7,a5
    80005e86:	0017861b          	addiw	a2,a5,1
    80005e8a:	87b2                	mv	a5,a2
    80005e8c:	02b5773b          	remuw	a4,a0,a1
    80005e90:	1702                	slli	a4,a4,0x20
    80005e92:	9301                	srli	a4,a4,0x20
    80005e94:	9742                	add	a4,a4,a6
    80005e96:	00074703          	lbu	a4,0(a4)
    80005e9a:	00e68023          	sb	a4,0(a3)
  } while((x /= base) != 0);
    80005e9e:	872a                	mv	a4,a0
    80005ea0:	02b5553b          	divuw	a0,a0,a1
    80005ea4:	0685                	addi	a3,a3,1
    80005ea6:	fcb77fe3          	bgeu	a4,a1,80005e84 <printint+0x24>

  if(sign)
    80005eaa:	000e0c63          	beqz	t3,80005ec2 <printint+0x62>
    buf[i++] = '-';
    80005eae:	fe060793          	addi	a5,a2,-32
    80005eb2:	00878633          	add	a2,a5,s0
    80005eb6:	02d00793          	li	a5,45
    80005eba:	fef60823          	sb	a5,-16(a2)
    80005ebe:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
    80005ec2:	fff7891b          	addiw	s2,a5,-1
    80005ec6:	006784b3          	add	s1,a5,t1
    consputc(buf[i]);
    80005eca:	fff4c503          	lbu	a0,-1(s1)
    80005ece:	00000097          	auipc	ra,0x0
    80005ed2:	d64080e7          	jalr	-668(ra) # 80005c32 <consputc>
  while(--i >= 0)
    80005ed6:	397d                	addiw	s2,s2,-1
    80005ed8:	14fd                	addi	s1,s1,-1
    80005eda:	fe0958e3          	bgez	s2,80005eca <printint+0x6a>
}
    80005ede:	70a2                	ld	ra,40(sp)
    80005ee0:	7402                	ld	s0,32(sp)
    80005ee2:	64e2                	ld	s1,24(sp)
    80005ee4:	6942                	ld	s2,16(sp)
    80005ee6:	6145                	addi	sp,sp,48
    80005ee8:	8082                	ret
    x = -xx;
    80005eea:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005eee:	4e05                	li	t3,1
    x = -xx;
    80005ef0:	b751                	j	80005e74 <printint+0x14>

0000000080005ef2 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005ef2:	1101                	addi	sp,sp,-32
    80005ef4:	ec06                	sd	ra,24(sp)
    80005ef6:	e822                	sd	s0,16(sp)
    80005ef8:	e426                	sd	s1,8(sp)
    80005efa:	1000                	addi	s0,sp,32
    80005efc:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005efe:	00020797          	auipc	a5,0x20
    80005f02:	3007a123          	sw	zero,770(a5) # 80026200 <pr+0x18>
  printf("panic: ");
    80005f06:	00002517          	auipc	a0,0x2
    80005f0a:	7e250513          	addi	a0,a0,2018 # 800086e8 <etext+0x6e8>
    80005f0e:	00000097          	auipc	ra,0x0
    80005f12:	02e080e7          	jalr	46(ra) # 80005f3c <printf>
  printf(s);
    80005f16:	8526                	mv	a0,s1
    80005f18:	00000097          	auipc	ra,0x0
    80005f1c:	024080e7          	jalr	36(ra) # 80005f3c <printf>
  printf("\n");
    80005f20:	00002517          	auipc	a0,0x2
    80005f24:	0f850513          	addi	a0,a0,248 # 80008018 <etext+0x18>
    80005f28:	00000097          	auipc	ra,0x0
    80005f2c:	014080e7          	jalr	20(ra) # 80005f3c <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005f30:	4785                	li	a5,1
    80005f32:	00003717          	auipc	a4,0x3
    80005f36:	0ef72523          	sw	a5,234(a4) # 8000901c <panicked>
  for(;;)
    80005f3a:	a001                	j	80005f3a <panic+0x48>

0000000080005f3c <printf>:
{
    80005f3c:	7131                	addi	sp,sp,-192
    80005f3e:	fc86                	sd	ra,120(sp)
    80005f40:	f8a2                	sd	s0,112(sp)
    80005f42:	e8d2                	sd	s4,80(sp)
    80005f44:	ec6e                	sd	s11,24(sp)
    80005f46:	0100                	addi	s0,sp,128
    80005f48:	8a2a                	mv	s4,a0
    80005f4a:	e40c                	sd	a1,8(s0)
    80005f4c:	e810                	sd	a2,16(s0)
    80005f4e:	ec14                	sd	a3,24(s0)
    80005f50:	f018                	sd	a4,32(s0)
    80005f52:	f41c                	sd	a5,40(s0)
    80005f54:	03043823          	sd	a6,48(s0)
    80005f58:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005f5c:	00020d97          	auipc	s11,0x20
    80005f60:	2a4dad83          	lw	s11,676(s11) # 80026200 <pr+0x18>
  if(locking)
    80005f64:	040d9463          	bnez	s11,80005fac <printf+0x70>
  if (fmt == 0)
    80005f68:	040a0b63          	beqz	s4,80005fbe <printf+0x82>
  va_start(ap, fmt);
    80005f6c:	00840793          	addi	a5,s0,8
    80005f70:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005f74:	000a4503          	lbu	a0,0(s4)
    80005f78:	18050c63          	beqz	a0,80006110 <printf+0x1d4>
    80005f7c:	f4a6                	sd	s1,104(sp)
    80005f7e:	f0ca                	sd	s2,96(sp)
    80005f80:	ecce                	sd	s3,88(sp)
    80005f82:	e4d6                	sd	s5,72(sp)
    80005f84:	e0da                	sd	s6,64(sp)
    80005f86:	fc5e                	sd	s7,56(sp)
    80005f88:	f862                	sd	s8,48(sp)
    80005f8a:	f466                	sd	s9,40(sp)
    80005f8c:	f06a                	sd	s10,32(sp)
    80005f8e:	4981                	li	s3,0
    if(c != '%'){
    80005f90:	02500b13          	li	s6,37
    switch(c){
    80005f94:	07000b93          	li	s7,112
  consputc('x');
    80005f98:	07800c93          	li	s9,120
    80005f9c:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005f9e:	00003a97          	auipc	s5,0x3
    80005fa2:	8eaa8a93          	addi	s5,s5,-1814 # 80008888 <digits>
    switch(c){
    80005fa6:	07300c13          	li	s8,115
    80005faa:	a0b9                	j	80005ff8 <printf+0xbc>
    acquire(&pr.lock);
    80005fac:	00020517          	auipc	a0,0x20
    80005fb0:	23c50513          	addi	a0,a0,572 # 800261e8 <pr>
    80005fb4:	00000097          	auipc	ra,0x0
    80005fb8:	4be080e7          	jalr	1214(ra) # 80006472 <acquire>
    80005fbc:	b775                	j	80005f68 <printf+0x2c>
    80005fbe:	f4a6                	sd	s1,104(sp)
    80005fc0:	f0ca                	sd	s2,96(sp)
    80005fc2:	ecce                	sd	s3,88(sp)
    80005fc4:	e4d6                	sd	s5,72(sp)
    80005fc6:	e0da                	sd	s6,64(sp)
    80005fc8:	fc5e                	sd	s7,56(sp)
    80005fca:	f862                	sd	s8,48(sp)
    80005fcc:	f466                	sd	s9,40(sp)
    80005fce:	f06a                	sd	s10,32(sp)
    panic("null fmt");
    80005fd0:	00002517          	auipc	a0,0x2
    80005fd4:	72850513          	addi	a0,a0,1832 # 800086f8 <etext+0x6f8>
    80005fd8:	00000097          	auipc	ra,0x0
    80005fdc:	f1a080e7          	jalr	-230(ra) # 80005ef2 <panic>
      consputc(c);
    80005fe0:	00000097          	auipc	ra,0x0
    80005fe4:	c52080e7          	jalr	-942(ra) # 80005c32 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005fe8:	0019879b          	addiw	a5,s3,1
    80005fec:	89be                	mv	s3,a5
    80005fee:	97d2                	add	a5,a5,s4
    80005ff0:	0007c503          	lbu	a0,0(a5)
    80005ff4:	10050563          	beqz	a0,800060fe <printf+0x1c2>
    if(c != '%'){
    80005ff8:	ff6514e3          	bne	a0,s6,80005fe0 <printf+0xa4>
    c = fmt[++i] & 0xff;
    80005ffc:	0019879b          	addiw	a5,s3,1
    80006000:	89be                	mv	s3,a5
    80006002:	97d2                	add	a5,a5,s4
    80006004:	0007c783          	lbu	a5,0(a5)
    80006008:	0007849b          	sext.w	s1,a5
    if(c == 0)
    8000600c:	10078a63          	beqz	a5,80006120 <printf+0x1e4>
    switch(c){
    80006010:	05778a63          	beq	a5,s7,80006064 <printf+0x128>
    80006014:	02fbf463          	bgeu	s7,a5,8000603c <printf+0x100>
    80006018:	09878763          	beq	a5,s8,800060a6 <printf+0x16a>
    8000601c:	0d979663          	bne	a5,s9,800060e8 <printf+0x1ac>
      printint(va_arg(ap, int), 16, 1);
    80006020:	f8843783          	ld	a5,-120(s0)
    80006024:	00878713          	addi	a4,a5,8
    80006028:	f8e43423          	sd	a4,-120(s0)
    8000602c:	4605                	li	a2,1
    8000602e:	85ea                	mv	a1,s10
    80006030:	4388                	lw	a0,0(a5)
    80006032:	00000097          	auipc	ra,0x0
    80006036:	e2e080e7          	jalr	-466(ra) # 80005e60 <printint>
      break;
    8000603a:	b77d                	j	80005fe8 <printf+0xac>
    switch(c){
    8000603c:	0b678063          	beq	a5,s6,800060dc <printf+0x1a0>
    80006040:	06400713          	li	a4,100
    80006044:	0ae79263          	bne	a5,a4,800060e8 <printf+0x1ac>
      printint(va_arg(ap, int), 10, 1);
    80006048:	f8843783          	ld	a5,-120(s0)
    8000604c:	00878713          	addi	a4,a5,8
    80006050:	f8e43423          	sd	a4,-120(s0)
    80006054:	4605                	li	a2,1
    80006056:	45a9                	li	a1,10
    80006058:	4388                	lw	a0,0(a5)
    8000605a:	00000097          	auipc	ra,0x0
    8000605e:	e06080e7          	jalr	-506(ra) # 80005e60 <printint>
      break;
    80006062:	b759                	j	80005fe8 <printf+0xac>
      printptr(va_arg(ap, uint64));
    80006064:	f8843783          	ld	a5,-120(s0)
    80006068:	00878713          	addi	a4,a5,8
    8000606c:	f8e43423          	sd	a4,-120(s0)
    80006070:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80006074:	03000513          	li	a0,48
    80006078:	00000097          	auipc	ra,0x0
    8000607c:	bba080e7          	jalr	-1094(ra) # 80005c32 <consputc>
  consputc('x');
    80006080:	8566                	mv	a0,s9
    80006082:	00000097          	auipc	ra,0x0
    80006086:	bb0080e7          	jalr	-1104(ra) # 80005c32 <consputc>
    8000608a:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    8000608c:	03c95793          	srli	a5,s2,0x3c
    80006090:	97d6                	add	a5,a5,s5
    80006092:	0007c503          	lbu	a0,0(a5)
    80006096:	00000097          	auipc	ra,0x0
    8000609a:	b9c080e7          	jalr	-1124(ra) # 80005c32 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    8000609e:	0912                	slli	s2,s2,0x4
    800060a0:	34fd                	addiw	s1,s1,-1
    800060a2:	f4ed                	bnez	s1,8000608c <printf+0x150>
    800060a4:	b791                	j	80005fe8 <printf+0xac>
      if((s = va_arg(ap, char*)) == 0)
    800060a6:	f8843783          	ld	a5,-120(s0)
    800060aa:	00878713          	addi	a4,a5,8
    800060ae:	f8e43423          	sd	a4,-120(s0)
    800060b2:	6384                	ld	s1,0(a5)
    800060b4:	cc89                	beqz	s1,800060ce <printf+0x192>
      for(; *s; s++)
    800060b6:	0004c503          	lbu	a0,0(s1)
    800060ba:	d51d                	beqz	a0,80005fe8 <printf+0xac>
        consputc(*s);
    800060bc:	00000097          	auipc	ra,0x0
    800060c0:	b76080e7          	jalr	-1162(ra) # 80005c32 <consputc>
      for(; *s; s++)
    800060c4:	0485                	addi	s1,s1,1
    800060c6:	0004c503          	lbu	a0,0(s1)
    800060ca:	f96d                	bnez	a0,800060bc <printf+0x180>
    800060cc:	bf31                	j	80005fe8 <printf+0xac>
        s = "(null)";
    800060ce:	00002497          	auipc	s1,0x2
    800060d2:	62248493          	addi	s1,s1,1570 # 800086f0 <etext+0x6f0>
      for(; *s; s++)
    800060d6:	02800513          	li	a0,40
    800060da:	b7cd                	j	800060bc <printf+0x180>
      consputc('%');
    800060dc:	855a                	mv	a0,s6
    800060de:	00000097          	auipc	ra,0x0
    800060e2:	b54080e7          	jalr	-1196(ra) # 80005c32 <consputc>
      break;
    800060e6:	b709                	j	80005fe8 <printf+0xac>
      consputc('%');
    800060e8:	855a                	mv	a0,s6
    800060ea:	00000097          	auipc	ra,0x0
    800060ee:	b48080e7          	jalr	-1208(ra) # 80005c32 <consputc>
      consputc(c);
    800060f2:	8526                	mv	a0,s1
    800060f4:	00000097          	auipc	ra,0x0
    800060f8:	b3e080e7          	jalr	-1218(ra) # 80005c32 <consputc>
      break;
    800060fc:	b5f5                	j	80005fe8 <printf+0xac>
    800060fe:	74a6                	ld	s1,104(sp)
    80006100:	7906                	ld	s2,96(sp)
    80006102:	69e6                	ld	s3,88(sp)
    80006104:	6aa6                	ld	s5,72(sp)
    80006106:	6b06                	ld	s6,64(sp)
    80006108:	7be2                	ld	s7,56(sp)
    8000610a:	7c42                	ld	s8,48(sp)
    8000610c:	7ca2                	ld	s9,40(sp)
    8000610e:	7d02                	ld	s10,32(sp)
  if(locking)
    80006110:	020d9263          	bnez	s11,80006134 <printf+0x1f8>
}
    80006114:	70e6                	ld	ra,120(sp)
    80006116:	7446                	ld	s0,112(sp)
    80006118:	6a46                	ld	s4,80(sp)
    8000611a:	6de2                	ld	s11,24(sp)
    8000611c:	6129                	addi	sp,sp,192
    8000611e:	8082                	ret
    80006120:	74a6                	ld	s1,104(sp)
    80006122:	7906                	ld	s2,96(sp)
    80006124:	69e6                	ld	s3,88(sp)
    80006126:	6aa6                	ld	s5,72(sp)
    80006128:	6b06                	ld	s6,64(sp)
    8000612a:	7be2                	ld	s7,56(sp)
    8000612c:	7c42                	ld	s8,48(sp)
    8000612e:	7ca2                	ld	s9,40(sp)
    80006130:	7d02                	ld	s10,32(sp)
    80006132:	bff9                	j	80006110 <printf+0x1d4>
    release(&pr.lock);
    80006134:	00020517          	auipc	a0,0x20
    80006138:	0b450513          	addi	a0,a0,180 # 800261e8 <pr>
    8000613c:	00000097          	auipc	ra,0x0
    80006140:	3e6080e7          	jalr	998(ra) # 80006522 <release>
}
    80006144:	bfc1                	j	80006114 <printf+0x1d8>

0000000080006146 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006146:	1101                	addi	sp,sp,-32
    80006148:	ec06                	sd	ra,24(sp)
    8000614a:	e822                	sd	s0,16(sp)
    8000614c:	e426                	sd	s1,8(sp)
    8000614e:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80006150:	00020497          	auipc	s1,0x20
    80006154:	09848493          	addi	s1,s1,152 # 800261e8 <pr>
    80006158:	00002597          	auipc	a1,0x2
    8000615c:	5b058593          	addi	a1,a1,1456 # 80008708 <etext+0x708>
    80006160:	8526                	mv	a0,s1
    80006162:	00000097          	auipc	ra,0x0
    80006166:	27c080e7          	jalr	636(ra) # 800063de <initlock>
  pr.locking = 1;
    8000616a:	4785                	li	a5,1
    8000616c:	cc9c                	sw	a5,24(s1)
}
    8000616e:	60e2                	ld	ra,24(sp)
    80006170:	6442                	ld	s0,16(sp)
    80006172:	64a2                	ld	s1,8(sp)
    80006174:	6105                	addi	sp,sp,32
    80006176:	8082                	ret

0000000080006178 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80006178:	1141                	addi	sp,sp,-16
    8000617a:	e406                	sd	ra,8(sp)
    8000617c:	e022                	sd	s0,0(sp)
    8000617e:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80006180:	100007b7          	lui	a5,0x10000
    80006184:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80006188:	10000737          	lui	a4,0x10000
    8000618c:	f8000693          	li	a3,-128
    80006190:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80006194:	468d                	li	a3,3
    80006196:	10000637          	lui	a2,0x10000
    8000619a:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    8000619e:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800061a2:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800061a6:	8732                	mv	a4,a2
    800061a8:	461d                	li	a2,7
    800061aa:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800061ae:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    800061b2:	00002597          	auipc	a1,0x2
    800061b6:	55e58593          	addi	a1,a1,1374 # 80008710 <etext+0x710>
    800061ba:	00020517          	auipc	a0,0x20
    800061be:	04e50513          	addi	a0,a0,78 # 80026208 <uart_tx_lock>
    800061c2:	00000097          	auipc	ra,0x0
    800061c6:	21c080e7          	jalr	540(ra) # 800063de <initlock>
}
    800061ca:	60a2                	ld	ra,8(sp)
    800061cc:	6402                	ld	s0,0(sp)
    800061ce:	0141                	addi	sp,sp,16
    800061d0:	8082                	ret

00000000800061d2 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800061d2:	1101                	addi	sp,sp,-32
    800061d4:	ec06                	sd	ra,24(sp)
    800061d6:	e822                	sd	s0,16(sp)
    800061d8:	e426                	sd	s1,8(sp)
    800061da:	1000                	addi	s0,sp,32
    800061dc:	84aa                	mv	s1,a0
  push_off();
    800061de:	00000097          	auipc	ra,0x0
    800061e2:	248080e7          	jalr	584(ra) # 80006426 <push_off>

  if(panicked){
    800061e6:	00003797          	auipc	a5,0x3
    800061ea:	e367a783          	lw	a5,-458(a5) # 8000901c <panicked>
    800061ee:	eb85                	bnez	a5,8000621e <uartputc_sync+0x4c>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    800061f0:	10000737          	lui	a4,0x10000
    800061f4:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    800061f6:	00074783          	lbu	a5,0(a4)
    800061fa:	0207f793          	andi	a5,a5,32
    800061fe:	dfe5                	beqz	a5,800061f6 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80006200:	0ff4f513          	zext.b	a0,s1
    80006204:	100007b7          	lui	a5,0x10000
    80006208:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    8000620c:	00000097          	auipc	ra,0x0
    80006210:	2ba080e7          	jalr	698(ra) # 800064c6 <pop_off>
}
    80006214:	60e2                	ld	ra,24(sp)
    80006216:	6442                	ld	s0,16(sp)
    80006218:	64a2                	ld	s1,8(sp)
    8000621a:	6105                	addi	sp,sp,32
    8000621c:	8082                	ret
    for(;;)
    8000621e:	a001                	j	8000621e <uartputc_sync+0x4c>

0000000080006220 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80006220:	00003797          	auipc	a5,0x3
    80006224:	e007b783          	ld	a5,-512(a5) # 80009020 <uart_tx_r>
    80006228:	00003717          	auipc	a4,0x3
    8000622c:	e0073703          	ld	a4,-512(a4) # 80009028 <uart_tx_w>
    80006230:	06f70f63          	beq	a4,a5,800062ae <uartstart+0x8e>
{
    80006234:	7139                	addi	sp,sp,-64
    80006236:	fc06                	sd	ra,56(sp)
    80006238:	f822                	sd	s0,48(sp)
    8000623a:	f426                	sd	s1,40(sp)
    8000623c:	f04a                	sd	s2,32(sp)
    8000623e:	ec4e                	sd	s3,24(sp)
    80006240:	e852                	sd	s4,16(sp)
    80006242:	e456                	sd	s5,8(sp)
    80006244:	e05a                	sd	s6,0(sp)
    80006246:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006248:	10000937          	lui	s2,0x10000
    8000624c:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000624e:	00020a97          	auipc	s5,0x20
    80006252:	fbaa8a93          	addi	s5,s5,-70 # 80026208 <uart_tx_lock>
    uart_tx_r += 1;
    80006256:	00003497          	auipc	s1,0x3
    8000625a:	dca48493          	addi	s1,s1,-566 # 80009020 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    8000625e:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    80006262:	00003997          	auipc	s3,0x3
    80006266:	dc698993          	addi	s3,s3,-570 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000626a:	00094703          	lbu	a4,0(s2)
    8000626e:	02077713          	andi	a4,a4,32
    80006272:	c705                	beqz	a4,8000629a <uartstart+0x7a>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006274:	01f7f713          	andi	a4,a5,31
    80006278:	9756                	add	a4,a4,s5
    8000627a:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    8000627e:	0785                	addi	a5,a5,1
    80006280:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    80006282:	8526                	mv	a0,s1
    80006284:	ffffb097          	auipc	ra,0xffffb
    80006288:	608080e7          	jalr	1544(ra) # 8000188c <wakeup>
    WriteReg(THR, c);
    8000628c:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    80006290:	609c                	ld	a5,0(s1)
    80006292:	0009b703          	ld	a4,0(s3)
    80006296:	fcf71ae3          	bne	a4,a5,8000626a <uartstart+0x4a>
  }
}
    8000629a:	70e2                	ld	ra,56(sp)
    8000629c:	7442                	ld	s0,48(sp)
    8000629e:	74a2                	ld	s1,40(sp)
    800062a0:	7902                	ld	s2,32(sp)
    800062a2:	69e2                	ld	s3,24(sp)
    800062a4:	6a42                	ld	s4,16(sp)
    800062a6:	6aa2                	ld	s5,8(sp)
    800062a8:	6b02                	ld	s6,0(sp)
    800062aa:	6121                	addi	sp,sp,64
    800062ac:	8082                	ret
    800062ae:	8082                	ret

00000000800062b0 <uartputc>:
{
    800062b0:	7179                	addi	sp,sp,-48
    800062b2:	f406                	sd	ra,40(sp)
    800062b4:	f022                	sd	s0,32(sp)
    800062b6:	e052                	sd	s4,0(sp)
    800062b8:	1800                	addi	s0,sp,48
    800062ba:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800062bc:	00020517          	auipc	a0,0x20
    800062c0:	f4c50513          	addi	a0,a0,-180 # 80026208 <uart_tx_lock>
    800062c4:	00000097          	auipc	ra,0x0
    800062c8:	1ae080e7          	jalr	430(ra) # 80006472 <acquire>
  if(panicked){
    800062cc:	00003797          	auipc	a5,0x3
    800062d0:	d507a783          	lw	a5,-688(a5) # 8000901c <panicked>
    800062d4:	c391                	beqz	a5,800062d8 <uartputc+0x28>
    for(;;)
    800062d6:	a001                	j	800062d6 <uartputc+0x26>
    800062d8:	ec26                	sd	s1,24(sp)
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800062da:	00003717          	auipc	a4,0x3
    800062de:	d4e73703          	ld	a4,-690(a4) # 80009028 <uart_tx_w>
    800062e2:	00003797          	auipc	a5,0x3
    800062e6:	d3e7b783          	ld	a5,-706(a5) # 80009020 <uart_tx_r>
    800062ea:	02078793          	addi	a5,a5,32
    800062ee:	02e79f63          	bne	a5,a4,8000632c <uartputc+0x7c>
    800062f2:	e84a                	sd	s2,16(sp)
    800062f4:	e44e                	sd	s3,8(sp)
      sleep(&uart_tx_r, &uart_tx_lock);
    800062f6:	00020997          	auipc	s3,0x20
    800062fa:	f1298993          	addi	s3,s3,-238 # 80026208 <uart_tx_lock>
    800062fe:	00003497          	auipc	s1,0x3
    80006302:	d2248493          	addi	s1,s1,-734 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006306:	00003917          	auipc	s2,0x3
    8000630a:	d2290913          	addi	s2,s2,-734 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    8000630e:	85ce                	mv	a1,s3
    80006310:	8526                	mv	a0,s1
    80006312:	ffffb097          	auipc	ra,0xffffb
    80006316:	3f4080e7          	jalr	1012(ra) # 80001706 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000631a:	00093703          	ld	a4,0(s2)
    8000631e:	609c                	ld	a5,0(s1)
    80006320:	02078793          	addi	a5,a5,32
    80006324:	fee785e3          	beq	a5,a4,8000630e <uartputc+0x5e>
    80006328:	6942                	ld	s2,16(sp)
    8000632a:	69a2                	ld	s3,8(sp)
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    8000632c:	00020497          	auipc	s1,0x20
    80006330:	edc48493          	addi	s1,s1,-292 # 80026208 <uart_tx_lock>
    80006334:	01f77793          	andi	a5,a4,31
    80006338:	97a6                	add	a5,a5,s1
    8000633a:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    8000633e:	0705                	addi	a4,a4,1
    80006340:	00003797          	auipc	a5,0x3
    80006344:	cee7b423          	sd	a4,-792(a5) # 80009028 <uart_tx_w>
      uartstart();
    80006348:	00000097          	auipc	ra,0x0
    8000634c:	ed8080e7          	jalr	-296(ra) # 80006220 <uartstart>
      release(&uart_tx_lock);
    80006350:	8526                	mv	a0,s1
    80006352:	00000097          	auipc	ra,0x0
    80006356:	1d0080e7          	jalr	464(ra) # 80006522 <release>
    8000635a:	64e2                	ld	s1,24(sp)
}
    8000635c:	70a2                	ld	ra,40(sp)
    8000635e:	7402                	ld	s0,32(sp)
    80006360:	6a02                	ld	s4,0(sp)
    80006362:	6145                	addi	sp,sp,48
    80006364:	8082                	ret

0000000080006366 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006366:	1141                	addi	sp,sp,-16
    80006368:	e406                	sd	ra,8(sp)
    8000636a:	e022                	sd	s0,0(sp)
    8000636c:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000636e:	100007b7          	lui	a5,0x10000
    80006372:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006376:	8b85                	andi	a5,a5,1
    80006378:	cb89                	beqz	a5,8000638a <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000637a:	100007b7          	lui	a5,0x10000
    8000637e:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80006382:	60a2                	ld	ra,8(sp)
    80006384:	6402                	ld	s0,0(sp)
    80006386:	0141                	addi	sp,sp,16
    80006388:	8082                	ret
    return -1;
    8000638a:	557d                	li	a0,-1
    8000638c:	bfdd                	j	80006382 <uartgetc+0x1c>

000000008000638e <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    8000638e:	1101                	addi	sp,sp,-32
    80006390:	ec06                	sd	ra,24(sp)
    80006392:	e822                	sd	s0,16(sp)
    80006394:	e426                	sd	s1,8(sp)
    80006396:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006398:	54fd                	li	s1,-1
    int c = uartgetc();
    8000639a:	00000097          	auipc	ra,0x0
    8000639e:	fcc080e7          	jalr	-52(ra) # 80006366 <uartgetc>
    if(c == -1)
    800063a2:	00950763          	beq	a0,s1,800063b0 <uartintr+0x22>
      break;
    consoleintr(c);
    800063a6:	00000097          	auipc	ra,0x0
    800063aa:	8ce080e7          	jalr	-1842(ra) # 80005c74 <consoleintr>
  while(1){
    800063ae:	b7f5                	j	8000639a <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800063b0:	00020497          	auipc	s1,0x20
    800063b4:	e5848493          	addi	s1,s1,-424 # 80026208 <uart_tx_lock>
    800063b8:	8526                	mv	a0,s1
    800063ba:	00000097          	auipc	ra,0x0
    800063be:	0b8080e7          	jalr	184(ra) # 80006472 <acquire>
  uartstart();
    800063c2:	00000097          	auipc	ra,0x0
    800063c6:	e5e080e7          	jalr	-418(ra) # 80006220 <uartstart>
  release(&uart_tx_lock);
    800063ca:	8526                	mv	a0,s1
    800063cc:	00000097          	auipc	ra,0x0
    800063d0:	156080e7          	jalr	342(ra) # 80006522 <release>
}
    800063d4:	60e2                	ld	ra,24(sp)
    800063d6:	6442                	ld	s0,16(sp)
    800063d8:	64a2                	ld	s1,8(sp)
    800063da:	6105                	addi	sp,sp,32
    800063dc:	8082                	ret

00000000800063de <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800063de:	1141                	addi	sp,sp,-16
    800063e0:	e406                	sd	ra,8(sp)
    800063e2:	e022                	sd	s0,0(sp)
    800063e4:	0800                	addi	s0,sp,16
  lk->name = name;
    800063e6:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800063e8:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800063ec:	00053823          	sd	zero,16(a0)
}
    800063f0:	60a2                	ld	ra,8(sp)
    800063f2:	6402                	ld	s0,0(sp)
    800063f4:	0141                	addi	sp,sp,16
    800063f6:	8082                	ret

00000000800063f8 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800063f8:	411c                	lw	a5,0(a0)
    800063fa:	e399                	bnez	a5,80006400 <holding+0x8>
    800063fc:	4501                	li	a0,0
  return r;
}
    800063fe:	8082                	ret
{
    80006400:	1101                	addi	sp,sp,-32
    80006402:	ec06                	sd	ra,24(sp)
    80006404:	e822                	sd	s0,16(sp)
    80006406:	e426                	sd	s1,8(sp)
    80006408:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    8000640a:	6904                	ld	s1,16(a0)
    8000640c:	ffffb097          	auipc	ra,0xffffb
    80006410:	b60080e7          	jalr	-1184(ra) # 80000f6c <mycpu>
    80006414:	40a48533          	sub	a0,s1,a0
    80006418:	00153513          	seqz	a0,a0
}
    8000641c:	60e2                	ld	ra,24(sp)
    8000641e:	6442                	ld	s0,16(sp)
    80006420:	64a2                	ld	s1,8(sp)
    80006422:	6105                	addi	sp,sp,32
    80006424:	8082                	ret

0000000080006426 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006426:	1101                	addi	sp,sp,-32
    80006428:	ec06                	sd	ra,24(sp)
    8000642a:	e822                	sd	s0,16(sp)
    8000642c:	e426                	sd	s1,8(sp)
    8000642e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006430:	100024f3          	csrr	s1,sstatus
    80006434:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006438:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000643a:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    8000643e:	ffffb097          	auipc	ra,0xffffb
    80006442:	b2e080e7          	jalr	-1234(ra) # 80000f6c <mycpu>
    80006446:	5d3c                	lw	a5,120(a0)
    80006448:	cf89                	beqz	a5,80006462 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    8000644a:	ffffb097          	auipc	ra,0xffffb
    8000644e:	b22080e7          	jalr	-1246(ra) # 80000f6c <mycpu>
    80006452:	5d3c                	lw	a5,120(a0)
    80006454:	2785                	addiw	a5,a5,1
    80006456:	dd3c                	sw	a5,120(a0)
}
    80006458:	60e2                	ld	ra,24(sp)
    8000645a:	6442                	ld	s0,16(sp)
    8000645c:	64a2                	ld	s1,8(sp)
    8000645e:	6105                	addi	sp,sp,32
    80006460:	8082                	ret
    mycpu()->intena = old;
    80006462:	ffffb097          	auipc	ra,0xffffb
    80006466:	b0a080e7          	jalr	-1270(ra) # 80000f6c <mycpu>
  return (x & SSTATUS_SIE) != 0;
    8000646a:	8085                	srli	s1,s1,0x1
    8000646c:	8885                	andi	s1,s1,1
    8000646e:	dd64                	sw	s1,124(a0)
    80006470:	bfe9                	j	8000644a <push_off+0x24>

0000000080006472 <acquire>:
{
    80006472:	1101                	addi	sp,sp,-32
    80006474:	ec06                	sd	ra,24(sp)
    80006476:	e822                	sd	s0,16(sp)
    80006478:	e426                	sd	s1,8(sp)
    8000647a:	1000                	addi	s0,sp,32
    8000647c:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000647e:	00000097          	auipc	ra,0x0
    80006482:	fa8080e7          	jalr	-88(ra) # 80006426 <push_off>
  if(holding(lk))
    80006486:	8526                	mv	a0,s1
    80006488:	00000097          	auipc	ra,0x0
    8000648c:	f70080e7          	jalr	-144(ra) # 800063f8 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006490:	4705                	li	a4,1
  if(holding(lk))
    80006492:	e115                	bnez	a0,800064b6 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006494:	87ba                	mv	a5,a4
    80006496:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    8000649a:	2781                	sext.w	a5,a5
    8000649c:	ffe5                	bnez	a5,80006494 <acquire+0x22>
  __sync_synchronize();
    8000649e:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    800064a2:	ffffb097          	auipc	ra,0xffffb
    800064a6:	aca080e7          	jalr	-1334(ra) # 80000f6c <mycpu>
    800064aa:	e888                	sd	a0,16(s1)
}
    800064ac:	60e2                	ld	ra,24(sp)
    800064ae:	6442                	ld	s0,16(sp)
    800064b0:	64a2                	ld	s1,8(sp)
    800064b2:	6105                	addi	sp,sp,32
    800064b4:	8082                	ret
    panic("acquire");
    800064b6:	00002517          	auipc	a0,0x2
    800064ba:	26250513          	addi	a0,a0,610 # 80008718 <etext+0x718>
    800064be:	00000097          	auipc	ra,0x0
    800064c2:	a34080e7          	jalr	-1484(ra) # 80005ef2 <panic>

00000000800064c6 <pop_off>:

void
pop_off(void)
{
    800064c6:	1141                	addi	sp,sp,-16
    800064c8:	e406                	sd	ra,8(sp)
    800064ca:	e022                	sd	s0,0(sp)
    800064cc:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800064ce:	ffffb097          	auipc	ra,0xffffb
    800064d2:	a9e080e7          	jalr	-1378(ra) # 80000f6c <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800064d6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800064da:	8b89                	andi	a5,a5,2
  if(intr_get())
    800064dc:	e39d                	bnez	a5,80006502 <pop_off+0x3c>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800064de:	5d3c                	lw	a5,120(a0)
    800064e0:	02f05963          	blez	a5,80006512 <pop_off+0x4c>
    panic("pop_off");
  c->noff -= 1;
    800064e4:	37fd                	addiw	a5,a5,-1
    800064e6:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800064e8:	eb89                	bnez	a5,800064fa <pop_off+0x34>
    800064ea:	5d7c                	lw	a5,124(a0)
    800064ec:	c799                	beqz	a5,800064fa <pop_off+0x34>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800064ee:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800064f2:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800064f6:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800064fa:	60a2                	ld	ra,8(sp)
    800064fc:	6402                	ld	s0,0(sp)
    800064fe:	0141                	addi	sp,sp,16
    80006500:	8082                	ret
    panic("pop_off - interruptible");
    80006502:	00002517          	auipc	a0,0x2
    80006506:	21e50513          	addi	a0,a0,542 # 80008720 <etext+0x720>
    8000650a:	00000097          	auipc	ra,0x0
    8000650e:	9e8080e7          	jalr	-1560(ra) # 80005ef2 <panic>
    panic("pop_off");
    80006512:	00002517          	auipc	a0,0x2
    80006516:	22650513          	addi	a0,a0,550 # 80008738 <etext+0x738>
    8000651a:	00000097          	auipc	ra,0x0
    8000651e:	9d8080e7          	jalr	-1576(ra) # 80005ef2 <panic>

0000000080006522 <release>:
{
    80006522:	1101                	addi	sp,sp,-32
    80006524:	ec06                	sd	ra,24(sp)
    80006526:	e822                	sd	s0,16(sp)
    80006528:	e426                	sd	s1,8(sp)
    8000652a:	1000                	addi	s0,sp,32
    8000652c:	84aa                	mv	s1,a0
  if(!holding(lk))
    8000652e:	00000097          	auipc	ra,0x0
    80006532:	eca080e7          	jalr	-310(ra) # 800063f8 <holding>
    80006536:	c115                	beqz	a0,8000655a <release+0x38>
  lk->cpu = 0;
    80006538:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8000653c:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    80006540:	0310000f          	fence	rw,w
    80006544:	0004a023          	sw	zero,0(s1)
  pop_off();
    80006548:	00000097          	auipc	ra,0x0
    8000654c:	f7e080e7          	jalr	-130(ra) # 800064c6 <pop_off>
}
    80006550:	60e2                	ld	ra,24(sp)
    80006552:	6442                	ld	s0,16(sp)
    80006554:	64a2                	ld	s1,8(sp)
    80006556:	6105                	addi	sp,sp,32
    80006558:	8082                	ret
    panic("release");
    8000655a:	00002517          	auipc	a0,0x2
    8000655e:	1e650513          	addi	a0,a0,486 # 80008740 <etext+0x740>
    80006562:	00000097          	auipc	ra,0x0
    80006566:	990080e7          	jalr	-1648(ra) # 80005ef2 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
