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

data_items1:		#These are the data items
.quad 2,67,34,222,45,75,54,44,34,42,4,33,22,11,66,0

data_items2:		#These are the data items
.quad 88,33,44,67,234,56,32,13,48,34,199,23,34,33,0

data_items3:		#These are the data items
.quad 18,65,19,77,201,23,234,33,23,33,5,17,1,99,0

.section .text
.globl _start
_start:
 	movq $0, %rdi			# move 0 into the index register

 	pushq $data_items1		# load the first byte of data

	call maximum 			# run the square function	
	add $8, %rsp			# Scrubs the parameter that was pushed on
					# the stack

 	pushq $data_items2		# load the first byte of data

	call maximum 			# run the square function	
	add $8, %rsp			# Scrubs the parameter that was pushed on
					# the stack
 	pushq $data_items3		# load the first byte of data

	call maximum 			# run the square function	
	add $8, %rsp			# Scrubs the parameter that was pushed on
					# the stack
 	
_exit:
	mov %rax, %rbx			# %rbx is the status code for the exit system call
					# and it already has the maximum number
	mov $1, %rax			# 1 is the exit() syscall
	int $0x80
