.include "funcs.s"

.data
s:

// это не работает)))
.macro f p
    .if \p
        \p*f "\p-1"
        f \p-1
    .endif
.endm
.quad f 10

.text

.macro exchange r1, r2, p3
    push %rcx
    mov \p3, %rcx

1:
    add \r1, \r2
    sub \r2, \r1
    add \r1, \r2
    neg \r1
    jmp 2f
1:

2:
1:
    pop %rcx
.endm

.text
.globl _start
_start:
    mov s+3*8, %rdi
    mov $10, %rax
    syscall
    

