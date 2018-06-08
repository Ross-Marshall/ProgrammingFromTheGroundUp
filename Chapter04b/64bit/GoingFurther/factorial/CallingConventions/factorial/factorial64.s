# PURPOSE - 	Given a number, this program computes the	
#  		factorial. For example, the factorial of	
#  		3 is 3 * 2 * 1, or 6. The factorial of	
#  		4 is 4 * 3 * 2 * 1, or 24, and so on.	
# 	
# 	This program shows how to call a function recursively.	
#	Change mull to mulq for 64 bit
	
.section .data	
	
# This program has no global data	
	
.section .text	

	
.globl factorial 		# this is unneeded unless we want to share	
				# this function among other programs
	
# This is the actual function definition	
.type factorial,@function	
factorial:	
	push %rbp		# standard function stuff - we have to
				# restore %rbp to its prior state before
				# returning, so we have to push it
	
	mov %rsp, %rbp 		# This is because we don’t want to modify	
				# the stack pointer, so we use %rbp.
	movq %r8, %rax 		# This moves the first argument to %rax	
				# 8(%rbp) holds the return address, and
				# 16(%rbp) holds the first parameter
	
	cmpq $1, %rax		# If the number is 1, that is our base
				# case, and we simply return (1 is
				# already in %rax as the return value)
	
	je end_factorial	
	decq %rax		# otherwise, decrease the value
	
	movq %rax,%r8		# push it for our call to factorial
	
	call factorial		# call factorial
	
	movq %rax, %rbx 	# %rax has the return value, so we	
				# reload our parameter into %rbx
	imulq %r8, %rax		# multiply that by the result of the
				# last call to factorial (in %rax)
				# the answer is stored in %rax, which
				# is good since that’s where return
				# values go.
	
end_factorial:	
	mov %rbp, %rsp		# standard function return stuff - we	
	pop %rbp		# have to restore %rbp and %rsp to where
				# they were before the function started
				# Note: exit codes ($?) > 255 will be
				# displayed are not correct.
	
	ret			# return to the function (this pops the
				# return value, too)

