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

.quad 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text
.globl _start
_start:
 	mov $0, %rdi			# move 0 into the index register

 	push data_items(,%rdi,8)	# load the first byte of data

	call maximum 			# run the square function	
	add $8, %rsp			# Scrubs the parameter that was pushed on
					# the stack
 	
_exit:
	mov %rax, %rbx			# %rbx is the status code for the exit system call
					# and it already has the maximum number
	mov $1, %rax			# 1 is the exit() syscall
	int $0x80

# This is the actual function definition	
.type maximum,@function	
maximum:	

	push %rbp			# standard function stuff - we have to
					# restore %rbp to its prior state before
					# returning, so we have to push it
	
	mov %rsp, %rbp 			# This is because we don’t want to modify	
					# the stack pointer, so we use %rbp.

	mov 16(%rbp), %rax 		# This moves the first argument to %rax	
					# 8(%rbp) holds the return address, and
					# 16(%rbp) holds the first parameter

	mov %rax, %rbx			# since this is the first item, %rax is
					# the biggest

start_loop:				# start loop
	cmp $0, %rax			# check to see if we’ve hit the end
	je end_loop
	inc %rdi			# load next value
	mov data_items(,%rdi,8),%rax
	cmp %rbx, %rax			# compare values
	jle start_loop			# jump to loop beginning if the new
					# one isn’t bigger
	mov %rax, %rbx			# move the value as the largest

	jmp start_loop			# jump to loop beginning

end_loop:
	mov %rbx, %rax			# return the largest value into %rax
	mov %rbp, %rsp			# standard function return stuff - we	
	pop %rbp			# have to restore %rbp and %rsp to where
					# they were before the function started
					# Note: exit codes ($?) > 255 will be
					# displayed are not correct.

end_maximum:
	ret


