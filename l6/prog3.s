.include "funcs.s"

.macro exchange r1, r2, p3
    push %rcx
    mov \p3, %rcx

1:
    add \r1, \r2
    sub \r2, \r1
    add \r1, \r2
    neg \r1
    loop 1b

    pop %rcx
.endm

.text
.globl _start
_start:
    mov $60, %rdi
    mov $10, %rax
    exchange %rax, %rdi, $2
    exchange %rax, %rdi, $3
    syscall
    


