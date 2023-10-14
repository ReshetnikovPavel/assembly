.globl _start

_start:
    mov $s1, %rsi
    mov $s2, %rdi
    mov $6, %rcx
    rep movsb

    mov $1, %rax
    mov $1, %rdi
    mov $s2, %rsi
    mov $ls, %rdx
    syscall

    mov $60, %rax
    mov $0, %rdi
    syscall

.data
s1:
.ascii "Hello\n"
ls=.-s1
s2=.
