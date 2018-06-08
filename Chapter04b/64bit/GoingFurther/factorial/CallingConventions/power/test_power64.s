#PURPOSE:	Program to illustrate how functions work
#		This program will compute the value of
#		2^3 + 5^2 = 8 + 25 = 33
#

#
# Everything in the main program is stored in registers,
# so the data section doesn’t have anything.
#
# Modified for 64 bit compilation (eax ==> rax, ebx ==> rbx, etc...)
#

.section .data

.section .text

.globl power

.globl _start

_start:
	movq $3, %r9		#push second argument
	movq $2, %r8		#push first argument
	call power		#call the function
	#add $16, %rsp		#move the stack pointer back

	push %rax 		#save the first answer before
				#calling the next function

	movq $2, %r9		#push second argument
	movq $5, %r8		#push first argument
	call power		#call the function
	#add $16, %rsp		#move the stack pointer back

	pop %rbx 		#The second answer is already	
				#in %rax. We saved the	
				#first answer onto the stack,	
				#so now we can just pop it	
				#out into %rbx	

	add %rax, %rbx 	#add them together	
				#the result is in %rbx	
		
	mov $1, %rax		#exit (%rbx is returned)	
	int $0x80 		
