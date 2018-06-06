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

.global maximum

.type maximum,@function	

maximum:	

	pushq %rbp			# standard function stuff - we have to
					# restore %rbp to its prior state before
					# returning, so we have to push it
	
	movq %rsp, %rbp 		# This is because we don’t want to modify	
					# the stack pointer, so we use %rbp.

	movq 16(%rbp), %rax 		# This moves the first argument to %rax	
					# 8(%rbp) holds the return address, and
					# 16(%rbp) holds the first parameter

	movq (%rax), %rbx		# since this is the first item, %rax is
					# the biggest

start_loop:				# start loop
	cmp $0, (%rax)			# check to see if we’ve hit the end
	je end_loop
        addq $8, %rax			# increment the address in %rax by 8
					# to get the next number

	cmp %rbx, (%rax)		# compare values
	jle start_loop			# jump to loop beginning if the new
					# one isn’t bigger
	movq (%rax), %rbx		# move the value as the largest

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


