.globl _start

.text
_start:
    mov $s, %rdi
    xor %rsi, %rsi
    syscall

    mov %rax, %rdi
    mov $60, %rax
    syscall

.data
s:
    .asciz "q.s"
