.text
read:
    mov $0, %rax
    mov $0, %rdi
    mov $1f, %rsi
    mov $ls, %rdx
    syscall

    xor %rax, %rax
    mov $10, %rbx
    mov $1f, %rsi
    xor %rcx, %rcx
2:
    cmp %bl, (%rsi)
    je 2f
    mul %rbx
    mov (%rsi), %cl
    sub $48, %rcx
    add %rcx, %rax
    inc %rsi
    jmp 2b
2:
    ret

write:
    mov $1f+ls, %rsi # byte before \n
    mov $10, %rbx
2:
    xor %rdx, %rdx
    div %rbx
    add $48, %rdx
    mov %dl, (%rsi)
    dec %rsi
    test %rax, %rax
    jnz 2b

# write to stdout
    mov $1, %rax
    mov $1, %rdi
    inc %rsi # pointer to the first meaningful char
    mov $1f+ls+1, %rdx
    sub %rsi, %rdx
    syscall
    
    ret

fib:
    mov $0, %rbx
    mov $1, %rcx

    test %rax, %rax # if rax == 0 return 0
    jnz 2f
    ret

2:
    add %rcx, %rbx
    xchg %rcx, %rbx
    dec %rax
    jnz 2b
    mov %rbx, %rax
    ret

gcd:
    test %rax, %rax
    jnz 2f
    mov %rbx, %rax
    ret
2:
    mov %rbx, %rcx
    div %rbx
    mov %rdx, %rax
    mov %rcx, %rbx
    jmp gcd

.data
1:
    .fill 50, 1, 0
ls=.-1b
