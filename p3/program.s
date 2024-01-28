.include "funcs.s"

.text
.globl _start
_start:
    call read
    mov %rax, %r8
    call read
    mov %r8, %rbx

    call gcd
    call write

    # mov %rax, %rdi
    mov $60, %rax
    syscall
