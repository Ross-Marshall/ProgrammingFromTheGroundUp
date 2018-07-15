	.file	"read_write.c"
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"/tmp/test.txt"
.LC2:
	.string	"%s"
.LC3:
	.string	"1 : %s\n"
.LC4:
	.string	"2: %s\n"
.LC5:
	.string	"3: %s\n"
.LC6:
	.string	"w+"
.LC7:
	.string	"testc.out"
	.align 8
.LC8:
	.string	"This is testing for fprintf...\n"
.LC9:
	.string	"This is testing for fputs...\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$272, %rsp
	leaq	.LC0(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -8(%rbp)
	leaq	-272(%rbp), %rdx
	movq	-8(%rbp), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_fscanf@PLT
	leaq	-272(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rdx
	leaq	-272(%rbp), %rax
	movl	$255, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	leaq	-272(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rdx
	leaq	-272(%rbp), %rax
	movl	$255, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	leaq	-272(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	leaq	.LC6(%rip), %rsi
	leaq	.LC7(%rip), %rdi
	call	fopen@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	movl	$31, %edx
	movl	$1, %esi
	leaq	.LC8(%rip), %rdi
	call	fwrite@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	movl	$29, %edx
	movl	$1, %esi
	leaq	.LC9(%rip), %rdi
	call	fwrite@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 6.3.0-18+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",@progbits
