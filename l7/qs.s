	.file	"program.c"
	.text
	.globl	x
	.type	x, @function
x:
.LFB11:
	.cfi_startproc
	leal	(%rdi,%rsi), %eax
	ret
	.cfi_endproc
.LFE11:
	.size	x, .-x
	.ident	"GCC: (GNU) 13.2.1 20230801"
	.section	.note.GNU-stack,"",@progbits
