.text
hello:
    # stack pointer точно долже быть кратен 8, а нам надо 16
    push %rbp # - Это полезные данные, мы не хотим их терять
    mov %rsp, %rbp
    and $~15, %rsp # убрали остаток от деления на 16
    # mov $name, %rdi # оно не позиционно независимая, надо через lea name(%rip), но нифига не получилось
    lea name(%rip), %rdi
    mov $100500, %rsi
    mov $0, %rax
# Если делаете дин библиотеку для кого-то, то придерживайтесь всех соглашений, например сохраняйте callee небезопасные аргументы, мы тут  так не делаем ))
    call printf
    mov %rbp, %rsp
    pop %rbp
    ret

.data
name:
    .asciz "Hello World %d times\n"
