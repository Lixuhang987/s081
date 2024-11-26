// Buffer cache.
//
// The buffer cache is a linked list of buf structures holding
// cached copies of disk block contents.  Caching disk blocks
// in memory reduces the number of disk reads and also provides
// a synchronization point for disk blocks used by multiple processes.
//
// Interface:
// * To get a buffer for a particular disk block, call bread.
// * After changing buffer data, call bwrite to write it to disk.
// * When done with the buffer, call brelse.
// * Do not use the buffer after calling brelse.
// * Only one process at a time can use a buffer,
//     so do not keep them longer than necessary.


#include "types.h"
#include "param.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "riscv.h"
#include "defs.h"
#include "fs.h"
#include "buf.h"

#define BUCKETS 17

struct spinlock global;

struct {
  int nclock[BUCKETS];
  struct spinlock lock[BUCKETS];
  struct buf buf[NBUF];
  struct spinlock block;
  struct buf *hash[BUCKETS][NBUF];

  // Linked list of all buffers, through prev/next.
  // Sorted by how recently the buffer was used.
  // head.next is most recent, head.prev is least.
} bcache;

#define HASH(id) ((id) % BUCKETS)

void
binit(void)
{
  struct buf *b;

  for (int i = 0; i < BUCKETS; i++)
    initlock(&bcache.lock[i], "bcache");
  initlock(&bcache.block, "bcache");

  // Create linked list of buffers
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    initsleeplock(&b->lock, "buffer");
    b->ticks = 0;
    b->valid = 0;
    b->refcnt = 0;
  }

  memset(bcache.nclock, 0, BUCKETS*sizeof(int));
  memset(bcache.hash, 0, BUCKETS*NBUF*sizeof(struct buf*));
}

// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;
  int bucket = HASH(blockno);
  acquire(&bcache.lock[bucket]);

  // Is the block already cached?
  for(int i = 0; i < NBUF; i++){
    b = bcache.hash[bucket][i];
    if(b && b->dev == dev && b->blockno == blockno){
      b->refcnt++;
      release(&bcache.lock[bucket]);
      acquiresleep(&b->lock);
      return b;
    }
  }
  while (bcache.nclock[bucket])
  {
    sleep(&bcache.nclock[bucket], &bcache.lock[bucket]);
    for (int i = 0; i < NBUF; i++)
    {
      b = bcache.hash[bucket][i];
      if (b && b->dev == dev && b->blockno == blockno)
      {
        b->refcnt++;
        release(&bcache.lock[bucket]);
        acquiresleep(&b->lock);
        return b;
      }
    }
  }
  bcache.nclock[bucket] = 1;
  release(&bcache.lock[bucket]);

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  acquire(&bcache.block);
  acquire(&bcache.lock[bucket]);
 re:
  int free = 0;
  struct buf *lru = 0;
  for(b = bcache.buf; b < bcache.buf + NBUF; b++){
    if(b->refcnt == 0) {
      if (!free || b->ticks < lru->ticks)
        lru = b;
      free = 1;
    }
  }
  if (free && lru)
  {
    int id = lru->blockno;
    if (HASH(id) != bucket)
      acquire(&bcache.lock[HASH(id)]);
    if (lru->refcnt > 0)
    {
      release(&bcache.lock[HASH(id)]);
      goto re;
    }
    int i = 0;
    for (i = 0; i < NBUF; i++)
      if (bcache.hash[HASH(id)][i] && bcache.hash[HASH(id)][i]->blockno == id)
        bcache.hash[HASH(id)][i] = 0;
    if (HASH(id) != bucket)
      release(&bcache.lock[HASH(id)]);
    lru->dev = dev;
    lru->blockno = blockno;
    lru->valid = 0;
    lru->refcnt = 1;
    lru->ticks = 0;
    for (i = 0; bcache.hash[bucket][i] != 0;)
      i++;
    bcache.hash[bucket][i] = lru;
    bcache.nclock[bucket] = 0;
    wakeup(&bcache.nclock[bucket]);
    release(&bcache.lock[bucket]);
    release(&bcache.block);
    acquiresleep(&lru->lock);
    return lru;
  }
  panic("bget: no buffers");
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  virtio_disk_rw(b, 1);
}

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock[HASH(b->blockno)]);
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->ticks = ticks;
  }
  release(&bcache.lock[HASH(b->blockno)]);
}

void
bpin(struct buf *b) {
  acquire(&bcache.lock[HASH(b->blockno)]);
  b->refcnt++;
  release(&bcache.lock[HASH(b->blockno)]);
}

void
bunpin(struct buf *b) {
  acquire(&bcache.lock[HASH(b->blockno)]);
  b->refcnt--;
  release(&bcache.lock[HASH(b->blockno)]);
}


