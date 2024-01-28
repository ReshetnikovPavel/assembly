.globl _start
.text

_start:
    mov $1, %rax
    mov $1, %rdi
    mov $s, %rsi
    mov $s_l, %rdx
    syscall

    mov $60, %rax
    syscall

.data
s:
.quad 12
.quad 0
.quad 0
.quad 0
s_l=.-s
