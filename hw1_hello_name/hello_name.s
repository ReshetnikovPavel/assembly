.data
hello: .string "Hello "
name: .space 16

.text
.global _start
_start:
    mov $0, %rax
    mov $0, %rdi
    mov $name, %rsi
    mov $16, %rdx
    syscall

    mov $1, %rax
    mov $1, %rdi
    mov $hello, %rsi
    mov $22, %rdx
    syscall

    mov $60, %rax
    syscall
