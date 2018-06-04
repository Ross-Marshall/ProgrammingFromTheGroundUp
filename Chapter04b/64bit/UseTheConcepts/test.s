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
	
.globl _start	

_start:	
	push $15		# The square takes one argument - the
				# number we want a square of. So, it
				# gets pushed
	
	call square 		# run the square function	
	add $8, %rsp		# Scrubs the parameter that was pushed on
				# the stack
	
	mov %rax, %rbx 		# square returns the answer in %rax, but	
				# we want it in %rbx to send it as our exit
				# status
	mov $1, %rax 		# call the kernel’s exit function
	int $0x80		
