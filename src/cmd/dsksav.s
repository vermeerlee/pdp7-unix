"** 07-13-19.pdf page 40
" dsksav

	" Copies the entire file system (except system image and
	" swap area) from side 1 of the disk onto same location
	" on side 0.
	"
	" I.e. copies the first 6400 blocks from side 1 to side 0.

   iof			" disable interrupts
   hlt			" halt the computer!
   dzm track		" start copying from block address 0
   -640			" transfer 640 chunks of 10 blocks each
   dac c1
1:
   lac track		" read chunk of blocks starting at block "track" on side 1
   jms dskrd1

   lac track		" write chunk of blocks starting at block "track" on side 0
   jms dskwr0

   lac track		" proceed to next chunk (of 10 blocks)
   tad d10
   dac track
   isz c1		" increment chunks transferred, if there chunks remaining
   jmp 1b		" ...loop and transfer the next chunk

   hlt			" ...otherwise halt the computer!
   sys exit		" call exit system call

track: 0		" block address of chunk to transfer
c1: 0			" number of chunks remaining
d10: 10
