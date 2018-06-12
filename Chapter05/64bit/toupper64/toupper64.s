##########################################################################
#
# PURPOSE:	This program converts an input file	
# 		to an output file with all letters	
# 		converted to uppercase.	
# 		
# PROCESSING:		
# 		1) Open the input file
# 		2) Open the output file			
# 		4) While we’re not at the end of the input file	
# 			a) read part of file into our memory buffer	
# 			b) go through each byte of memory	
# 			   if the byte is a lower-case letter,	
# 			   convert it to uppercase	
# 			c) write the memory buffer to output file
#
##########################################################################
	
.section .data	
	
##########################################################################
# 
# CONSTANTS
#
##########################################################################	
		
	.equ SYS_OPEN, 5		# system call numbers	
	.equ SYS_WRITE, 4	
	.equ SYS_READ, 3	
	.equ SYS_CLOSE, 6	
	.equ SYS_EXIT, 1

##########################################################################
# 	
# options for open (look at		
# /usr/include/asm/fcntl.h for		
# various values. You can combine them		
# by adding them or ORing them)		
# This is discussed at greater length		
# in "Counting Like a Computer"	
#
##########################################################################
	
	.equ O_RDONLY, 0	
	.equ O_CREAT_WRONLY_TRUNC, 03101	
		
# standard file descriptors		
	.equ STDIN, 0	
	.equ STDOUT, 1	
	.equ STDERR, 2	

# system call interrupt		
	.equ LINUX_SYSCALL, 0x80	# This is the return value
	.equ END_OF_FILE, 0		# of read which means we’ve
					# hit the end of the file		
		
	.equ NUMBER_ARGUMENTS, 2
	
.section .bss		
		
##########################################################################
#
# Buffer - 	this is where the data is loaded into		
# 		from the data file and written from	
# 		into the output file. This should	
# 		never exceed 16,000 for various	
# 		reasons.
#
##########################################################################	
		
.equ BUFFER_SIZE, 500	
	
.lcomm BUFFER_DATA, BUFFER_SIZE		
		
.section .text		
		
# STACK POSITIONS	
	.equ ST_SIZE_RESERVE, 8	
	.equ ST_FD_IN, -4	
	.equ ST_FD_OUT, -8	
	.equ ST_ARGC, 0		# Number of arguments
	.equ ST_ARGV_0, 4	# Name of program
	.equ ST_ARGV_1, 8	# Input file name
	.equ ST_ARGV_2, 12	# Output file name
		
.globl _start		
		
_start:		
		
##########################################################################
# 
# INITIALIZE PROGRAM 
# 
##########################################################################		
			
	movq	%rsp, %rbp	# save the stack pointer
		
##########################################################################
#
# Allocate space for our file descriptors		
# on the stack	
#
##########################################################################
	
	subq $ST_SIZE_RESERVE, %rsp		
		
open_files:		

open_fd_in:		

##########################################################################
#
# OPEN INPUT FILE
#
########################################################################## 		
		
	movq $SYS_OPEN, %rax			# open syscall
	movq ST_ARGV_1(%rbp), %rbx		# input filename into %rbx
	movq $O_RDONLY, %rcx			# read-only flag
	movq $0666, %rdx			# this doesn’t really matter for reading
	int $LINUX_SYSCALL			# call Linux
		
store_fd_in:	
	movq %rax, ST_FD_IN(%rbp)		# save the given file descriptor

open_fd_out:		

##########################################################################
# 
# OPEN OUTPUT FILE
#
########################################################################## 	
	
	movq $SYS_OPEN, %rax			# open the file
	movq ST_ARGV_2(%rbp), %rbx		# output filename into %rbx
	movq $O_CREAT_WRONLY_TRUNC, %rcx	# flags for writing to the file
	movq $0666, %rdx			# mode for new file (if it’s created)
		
	int $LINUX_SYSCALL 			# call Linux

store_fd_out:		
	movq %rax, ST_FD_OUT(%rbp)	# store the file descriptor here

##########################################################################
#		
# BEGIN MAIN LOOP
#
########################################################################## 	
	
read_loop_begin:		
	
##########################################################################	
#
# READ IN A BLOCK FROM THE INPUT FILE
# 
########################################################################## 		
	movq $SYS_READ, %rax	
	movq ST_FD_IN(%rbp), %rbx	# get the input file descriptor
	movq $BUFFER_DATA, %rcx		# the location to read into
	movq $BUFFER_SIZE, %rdx		# the size of the buffer
	int $LINUX_SYSCALL 		# Size of buffer read is returned in %rax

##########################################################################		
# 
# EXIT IF WE’VE REACHED THE END
#
########################################################################## 		
	cmpq $END_OF_FILE, %rax		# check for end of file marker
	jle end_loop 			# if found or on error, go to the end

continue_read_loop:		
	
##########################################################################
#	
# CONVERT THE BLOCK TO UPPER CASE
# 
##########################################################################
	
	push $BUFFER_DATA		# location of buffer
	push %rax			# size of the buffer
	call convert_to_upper	
	pop %rax			# get the size back
	addq $8, %rsp			# restore %rsp

##########################################################################
#		
# WRITE THE BLOCK OUT TO THE OUTPUT FILE
# 		
##########################################################################
	movq %rax, %rdx			# size of the buffer
	movq $SYS_WRITE, %rax	
	movq ST_FD_OUT(%rbp), %rbx	# file to use
	movq $BUFFER_DATA, %rcx		# location of the buffer
	int $LINUX_SYSCALL 	
		
##########################################################################
#
# CONTINUE THE LOOP
# 		
##########################################################################

	jmp read_loop_begin 	
		
end_loop:	

##########################################################################
#	
# CLOSE THE FILES		
#
# NOTE - we don’t need to do error checking		
#        on these, because error conditions 		
#        don’t signify anything special here 
#		
##########################################################################

	movq $SYS_CLOSE, %rax	
	movq ST_FD_OUT(%rbp), %rbx	
	int $LINUX_SYSCALL 	
		
	movq $SYS_CLOSE, %rax 	
	movq ST_FD_IN(%rbp), %rbx 	
	int $LINUX_SYSCALL 	
		
##########################################################################
#
# EXIT
#
########################################################################## 
		
	movq $SYS_EXIT, %rax	
	movq $0, %rbx	
	int $LINUX_SYSCALL 	
		
##########################################################################
#
# PURPOSE:	This function actually does the	
# 		conversion to upper case for a block	
# 		
# INPUT:	The first parameter is the location	
# 		of the block of memory to convert	
# 		The second parameter is the length of	
# 		that buffer	
# 		
# OUTPUT:	This function overwrites the current	
# 		buffer with the upper-casified version.	

# 		
# VARIABLES:		
# 	%rax - beginning of buffer	
# 	%rbx - length of buffer	
# 	%rdi - current buffer offset	
# 	%cl - current byte being examined	
# 	(first part of %rcx)	
# 		
##########################################################################

##########################################################################
#
# CONSTANTS
#
########################################################################## 	
	
	.equ LOWERCASE_A, 'a'			# The lower boundary of our search
	.equ LOWERCASE_Z, 'z'			# The upper boundary of our search
	.equ UPPER_CONVERSION, 'A' - 'a'	# Conversion between upper and lower case
	
##########################################################################	
#
# STACK STUFF
# 		
##########################################################################

	.equ ST_BUFFER_LEN, 8 			# Length of buffer	
	.equ ST_BUFFER, 12			# actual buffer
		
convert_to_upper:
		
	push %rbp	
	movq %rsp, %rbp	

##########################################################################
#
# SET UP VARIABLES
#
########################################################################## 	
	
	movq ST_BUFFER(%rbp), %rax	
	movq ST_BUFFER_LEN(%rbp), %rbx	
	movq $0, %rdi	
			
	cmpq $0, %rbx				# if a buffer with zero length was given
	je end_convert_loop 			# to us, just leave
		
convert_loop:	
	
	movb (%rax,%rdi,1), %cl			# get the current byte
	cmpb $LOWERCASE_A, %cl			# go to the next byte unless it is between
	jl next_byte 				# ’a’ and ’z’
	cmpb $LOWERCASE_Z, %cl	
	jg next_byte 	
		
	addb $UPPER_CONVERSION, %cl		# otherwise convert the byte to uppercase
	movb %cl, (%rax,%rdi,1)			# and store it back
		
next_byte:	
	
	incq %rdi				# next byte
	cmpq %rdi, %rbx				# continue unless
						# we’ve reached the
						# end
	jne convert_loop 	
		
end_convert_loop:		
	movq %rbp, %rsp				# no return value, just leave
	pop %rbp	
	ret	
