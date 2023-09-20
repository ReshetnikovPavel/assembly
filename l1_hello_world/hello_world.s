.data
.globl greet
greet:
.string "Hello world!\n"

.text
.global _start
_start:
    mov $1, %rax
    mov $1, %rdi
    mov $greet, %rsi
    mov $13, %rdx
    syscall
    mov $60, %rax
    syscall
