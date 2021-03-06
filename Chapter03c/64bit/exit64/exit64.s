#PURPOSE:  Simple program that exits and returns a
#          status code back to the Linux kernel
#
#INPUT:    none
#
#OUTPUT:   returns a status code.  This can be viewed
#          by typing
#
#          echo $?
#
#          after running the program
#
#VARIABLES:
#          %rax holds the system call number
#          %rbx holds the return status
#
.section .data
.section .text
.globl _start
_start:
#
# 64 bit version - Changed movl to mov  
#
mov $1, %rax      # this is the linux kernel command
# number (system call) for exiting
# a program
mov $0, %rbx      # this is the status number we will
# return to the operating system.
# Change this around and it will
# return different things to
# echo $?
int $0x80          # this wakes up the kernel to run
# the exit comman
