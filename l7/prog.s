.text

# .globl _start
# _start:
#     mov $-1, %rax
#     mov $10, %eax # Почему здесь перезаписывает все... Одна инструкция. Кошмар
#     mov $60, %rax
#     syscall

.globl main

main:
    # mov $f, %rdi
    # call printf
    mov $0, %rax
    ret

.data
f:
.asciz "Hello world"
