#PURPOSE:  This program finds the maximum number of a
#          set of data items.
#

#VARIABLES: The registers have the following uses:
#
# %edi - Holds the index of the data item being examined
# %ebx - Largest data item found
# %eax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used
#              to terminate the data
#
.section .data
data_items:		#These are the data items
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text
.globl _start
_start:
 	movl _start, %eax		# Move the value pointed to by _start into eax
 	movl $_start, %eax		# Move the value of _start into eax
loop_exit:
	# %ebx is the status code for the exit system call
	# and it already has the maximum number
	movl $128, %ebx			#1 is the exit() syscall
	movl $1, %eax			#1 is the exit() syscall
	int $0x80
