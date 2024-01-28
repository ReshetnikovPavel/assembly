.globl _start

.text
_start:
    add $16, %rsp
    pop %rdi

#open
    mov $2, %rax
    # mov $s, %rdi
    xor %rsi, %rsi
    syscall

    mov %rax, %r8
    mov %r8, %rdi
    mov $0, %rax
    mov $s, %rsi
    mov $4096, %rdx
    syscall

    mov $s, %rdx
    mov $1, %rdi
    mov $1, %rax
    mov $ls, %rsi
    syscall


    mov %rax, %rdi
    mov $60, %rax
    syscall

.data
s:
    .byte 0x1b
    .asciz "[42;34m"
ls=.-s
