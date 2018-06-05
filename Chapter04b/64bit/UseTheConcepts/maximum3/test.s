#PURPOSE:  This program finds the maximum number of a
#          set of data items.
#

#VARIABLES: The registers have the following uses:
#
# %rdi - Holds the index of the data item being examined
# %rbx - Largest data item found
# %rax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used
#              to terminate the data
#
.section .data
data_items:		#These are the data items

# Change .long to .quad for 64 bit
.quad 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text
.globl _start
_start:
 	mov $0, %rdi			# move 0 into the index register
 	mov data_items(,%rdi,8), %rax	# load the first byte of data
 	mov %rax, %rbx			# since this is the first item, %rax is
					# the biggest

start_loop:				# start loop
	cmp $0, %rax			# check to see if we’ve hit the end
	je loop_exit
	inc %rdi			# load next value
	mov data_items(,%rdi,8),%rax
	cmp %rbx, %rax			# compare values
	jle start_loop			# jump to loop beginning if the new
					# one isn’t bigger
	mov %rax, %rbx			# move the value as the largest

	jmp start_loop			# jump to loop beginning
loop_exit:
	# %rbx is the status code for the exit system call
	# and it already has the maximum number
	mov $1, %rax			#1 is the exit() syscall
	int $0x80
