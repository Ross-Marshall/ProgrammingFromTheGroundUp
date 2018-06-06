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

.quad 3,67,34,222,45,75,54,44,34,42,4,33,22,11,66,0

.section .text
.globl _start
_start:
 	movq $0, %rdi			# move 0 into the index register

 	pushq $data_items		# load the first byte of data

	call maximum 			# run the square function	
	add $8, %rsp			# Scrubs the parameter that was pushed on
					# the stack
 	
_exit:
	mov %rax, %rbx			# %rbx is the status code for the exit system call
					# and it already has the maximum number
	mov $1, %rax			# 1 is the exit() syscall
	int $0x80
