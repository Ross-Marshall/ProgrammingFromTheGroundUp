# Install NASM

sudo apt-get install nasm

___________________________________________________________________

as is the GNU Assembler. It's found in binutils but if you do:

sudo apt-get install build-essential

You will get gas along with gcc (which default uses gas for assembling on the back end).

For a 'tutorial' about using gas, you probably want to read Programming From the Ground Up, which uses it.

____________________________________________________________________

/me/code/assembly/ProgrammingFromTheGroundUp/Chapter03/32bit$ as exit.s -o exit.o
/me/code/assembly/ProgrammingFromTheGroundUp/Chapter03/32bit$ ls -lart
total 32
-rw-r--r-- 1 megazor megazor  741 Feb 11  2016 e2.s
-rw-r--r-- 1 megazor megazor  696 Feb 11  2016 e2.o
-rwxr-xr-x 1 megazor megazor  664 Feb 11  2016 e2
drwxr-xr-x 4 megazor megazor 4096 Feb 11  2016 ..
-rw-r--r-- 1 megazor megazor  764 May 24 22:05 exit.s
-rw------- 1 megazor megazor    0 May 24 22:09 nohup.out
-rw-r--r-- 1 megazor megazor  212 May 24 22:19 hello.s
-rw-r--r-- 1 megazor megazor  704 May 24 22:22 exit.o
drwxr-xr-x 2 megazor megazor 4096 May 24 22:22 .

________________________________________________________________________

  549  sudo apt-get install build-essential
  550  as exit.s -o exit.o
  551  ls -lart
  552  as hello.s -o hello.o
  553  ld exit.o -o exit
  554  ld hello.o -o hello
  555  ./exit
  556  ./hello 
  557  cd ../64bit/
  558  ls
  559  ls -lart
  560  as exit64.s -o exit64.o
  561  ld exit64.o -o exit64
  562  ls -lart
  563  ./exit64 
  564  diff exit64.s ../32bit/exit.s 
  565  history
/me/code/assembly/ProgrammingFromTh
