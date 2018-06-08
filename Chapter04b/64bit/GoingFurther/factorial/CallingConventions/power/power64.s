#PURPOSE:	Program to illustrate how functions work
#		This program will compute the value of
#		2^3 + 5^2
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

# PURPOSE: This function is used to compute		
# the value of a number raised to		
# a power.		
#		
# INPUT: First argument - the base number		
# Second argument - the power to		
# raise it to		
#		
# OUTPUT: Will give the result as a return value		
#		
# NOTES: The power must be 1 or greater		
#		
# VARIABLES:		
# %rbx - holds the base number		
# %ecx - holds the power		
#		
#  -4(%ebp) - holds the current result		
#		
#  %rax is used for temporary storage		
#	
	
.type power, @function		

power:		
	push	%rbp		#save old base pointer
	mov	%rsp, %rbp	#make stack pointer the base pointer
	sub	$8, %rsp	#get room for our local storage
				
	movq %r8, %rbx 		#put first argument in %rax		
	movq %r9, %rcx 		#put second argument in %ecx 		
		
	mov %rbx, -8(%rbp) 	#store current result		
		
power_loop_start:		
	cmp $1, %rcx		#if the power is 1, we are done		
	je end_power	
	
	mov -8(%rbp), %rax 	#move the current result into %rax		
	imul %rbx, %rax	 	#multiply the current result by		
				#the base number	
	mov %rax, -8(%rbp) 	#store the current result		
		
	dec %rcx		#decrease the power	
	jmp power_loop_start 	#run for the next power	
		
end_power:		
	mov -8(%rbp), %rax	#return value goes in %rax	
	mov %rbp, %rsp		#restore the stack pointer	
	pop %rbp		#restore the base pointer	
	ret		
