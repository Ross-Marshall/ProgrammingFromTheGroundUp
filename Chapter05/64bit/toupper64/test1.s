.section .data

.section .bss

.section .text

# STACK POSITIONS	
	.equ ST_SIZE_RESERVE, 16	
	.equ ST_FD_IN, -8
	.equ ST_FD_OUT, -16	
	.equ ST_ARGC, 0		# Number of arguments
	.equ ST_ARGV_0, 8	# Name of program:q
	.equ ST_ARGV_1, 16	# Input file name
	.equ ST_ARGV_2, 24	# Output file name

.globl _start

_start:

# sys_open = 2
# O_RDONLY = 0

mov $2,%rax
mov ST_ARGV_1(%rbp), %rdi
mov $0, %rsi
mov $0644, %rdx
syscall


