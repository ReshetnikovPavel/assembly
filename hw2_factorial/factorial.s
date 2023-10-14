.global _start

.text
_start:
# read a number
    mov $0, %rax
    mov $0, %rdi
    mov $str, %rsi
    mov $str_len, %rdx
    syscall

    mov $str, %rsi
    mov $0, %rax # a number
    mov $10, %rbx # 10 is a base
    mov $0, %rcx # current digit

to_int_loop:
    mov (%rsi), %cl # get current char
    cmp $10, %cl # 10 is ascii for \n
    je to_int_end
    mul %rbx
    sub $48, %cl # convert char digit to number (48 is ascii for 0)
    add %rcx, %rax # add digit to number
    inc %rsi # move index to next char
    jmp to_int_loop
to_int_end:

#handle case: 0! == 1
    mov %rax, %rcx
    mov $1, %rax
    test %rcx, %rcx
    jz factorial_end
factorial_loop:
    mul %rcx
    dec %rcx
    jnz factorial_loop
factorial_end:

    mov $str_end-2, %rsi # byte before \n
write_digits_loop:
    xor %rdx, %rdx
    div %rbx
    add $48, %rdx
    mov %dl, (%rsi)
    dec %rsi
    test %rax, %rax
    jnz write_digits_loop

# output a factorial
    mov $1, %rax
    mov $1, %rdi
    inc %rsi # pointer to a first meaningful char
    mov $str_end, %rdx
    sub %rsi, %rdx
    syscall

# exit
    mov $60, %rax
    syscall

.data
str:
.space 20
.ascii "\n"
str_end:
str_len=.-str
