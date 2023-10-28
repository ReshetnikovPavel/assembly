.include "funcs.s"

.macro exchange r1, r2
    add \r1, \r2
    sub \r2, \r1
    add \r1, \r2
    neg \r1
.endm

.text
.globl _start
_start:
    mov $60, %rdi
    mov $10, %rax
    exchange %rax, %rdi
    syscall
    
