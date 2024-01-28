.globl main

.text
main:
    mov $2, %rax
    mov $s, %rdi
    mov $0, %rsi
    syscall


# r8=file descriptor
    mov %rax, %r8
    mov $9, %rax
    xor %rdi, %rdi
    mov $5000, %rsi
    mov $3, %rdx
    mov $2, %r10
    mov $0x20, %r9
    syscall

    movb $10, (%rax)

    mov %rax, %rsi
    mov $1, %rax
    mov $1, %rdi
    mov $5000, %rdx
    syscall
    ret

.data
s:
.asciz "mmap.s"
