# PURPOSE - 	Given a number, this program computes the	
#  		square. For example, the square of	
#  		3 is 3 * 2 * 1, or 6. The square of	
#  		4 is 4 * 3 * 2 * 1, or 24, and so on.	
# 	
# 	This program shows how to call a function recursively.	
#	Change mull to mulq for 64 bit
	
.section .data	
	
# This program has no global data	
	
.section .text	

.globl square
	
# This is the actual function definition	
.type square,@function	
square:	
	push %rbp		# standard function stuff - we have to
				# restore %rbp to its prior state before
				# returning, so we have to push it
	
	mov %rsp, %rbp 		# This is because we don’t want to modify	
				# the stack pointer, so we use %rbp.
	mov 16(%rbp), %rax 	# This moves the first argument to %rax	
				# 8(%rbp) holds the return address, and
				# 16(%rbp) holds the first parameter
	

	imulq %rax, %rax	# multiply that by the result of the
				# last call to square (in %rax)
				# the answer is stored in %rax, which
				# is good since that’s where return
				# values go.
	
end_square:	
	mov %rbp, %rsp		# standard function return stuff - we	
	pop %rbp		# have to restore %rbp and %rsp to where
				# they were before the function started
				# Note: exit codes ($?) > 255 will be
				# displayed are not correct.
	
	ret			# return to the function (this pops the
				# return value, too)

