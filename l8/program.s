.global main
.text
main:
    mov $name, %rdi
    mov $100500, %rsi
    mov $0, %rax # used xmmN == 0
    # что-то для регистров xmm, он смотрит количество элементов, не находит их, если там не 0, и падает с сегфолтом
    call printf
.data

name:
    .asciz "hello %d"
