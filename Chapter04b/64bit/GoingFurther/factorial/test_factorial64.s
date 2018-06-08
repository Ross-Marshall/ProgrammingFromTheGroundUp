#PURPOSE - 	Given a number, this program computes the	
# 		factorial. For example, the factorial of	
# 		3 is 3 * 2 * 1, or 6. The factorial of	
# 		4 is 4 * 3 * 2 * 1, or 24, and so on.	
#	
#	This program shows how to call a function recursively.	
	
.section .data	
	
#This program has no global data	
	
.section .text
.globl _start	
	
.globl factorial 		#this is unneeded unless we want to share	
				#this function among other programs
_start:	
	push $4			#The factorial takes one argument - the
				#number we want a factorial of. So, it
				#gets pushed
	
	call factorial 		#run the factorial function	
	addq $8, %rsp		#Scrubs the parameter that was pushed on
				#the stack
	
	movq %rax, %rbx 	#factorial returns the answer in %rax, but	
				#we want it in %rbx to send it as our exit
				#status
	movq $1, %rax 		#call the kernel’s exit function
	int $0x80		
