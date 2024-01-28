.global main
.text
#brk системный вызов
main:
    mov $12, %rdi
    xor %rdi, %rdi
    syscall

    movb $10, (%rax)

    lea 10(%rax), %rdi
    mov $12, %rax
    syscall

    movb $10, (%rax)

    lea -7(%rax), %rdi
    mov $12, %rax
    syscall

    mov $s, %rdi
    mov %rax, %rsi
    call printf
    ret

.data
s:

# /etc/ld.so.conf
# в этом конфиге написано, в каких папках могут лежать библиотеки
