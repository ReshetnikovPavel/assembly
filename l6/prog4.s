.include "funcs.s"

.data
.ascii "Привет мир!!\n"
.align 16
ls=.-s

.text
.globl _start
_start:
    mov $60, %rdi
    mov $10, %rax
    syscall
    



