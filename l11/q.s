	.file	"q.c"
	.text
	.section	.rodata
.LC4:
	.string	"%f\n"
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
	subq	$16, %rsp
	movsd	.LC0(%rip), %xmm0
	movsd	%xmm0, -8(%rbp)
	movsd	-8(%rbp), %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
	jmp	.L2
.L3:
	movsd	-8(%rbp), %xmm0
	divsd	-16(%rbp), %xmm0
	addsd	-16(%rbp), %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -16(%rbp)
.L2:
	movsd	-8(%rbp), %xmm0
	divsd	-16(%rbp), %xmm0
	subsd	-16(%rbp), %xmm0
	movq	.LC2(%rip), %xmm1
	andpd	%xmm1, %xmm0
	comisd	.LC3(%rip), %xmm0
	ja	.L3
	movq	-16(%rbp), %rax
	movq	%rax, %xmm0
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1076101120
	.align 8
.LC1:
	.long	0
	.long	1073741824
	.align 16
.LC2:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC3:
	.long	-400107883
	.long	1041313291
	.ident	"GCC: (GNU) 13.2.1 20230801"
	.section	.note.GNU-stack,"",@progbits
