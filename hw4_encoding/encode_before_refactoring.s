.globl _start

.text
exit_err:
    mov $1, %rdi
exit:
    mov $60, %rax
    syscall

to_int:
    push %rbx
    mov $0, %rax # a number
    mov $10, %rbx # 10 is a base
    mov $0, %rcx # current digit

to_int_loop:
    movb (%rdi), %cl # get current char
    cmp $0, %cl # 0 is ascii for \0
    je to_int_end
    mul %rbx
    sub $48, %cl # convert char digit to number (48 is ascii for 0)
    add %rcx, %rax # add digit to number
    inc %rdi # move index to next char
    jmp to_int_loop
to_int_end:
    pop %rbx
    ret

_start:
    pop %rax
    cmp $3, %rax
    jne exit_err

    pop %rax # binary name
    
    pop %rdi
    call to_int
    mov %rax, %rbx
    pop %rdi
    call to_int
    cmp $2, %rbx
    jl exit_err
    cmp $36, %rbx
    jg exit_err


    mov $str_end-2, %rsi # byte before \n
write_digits_loop:
    xor %rdx, %rdx
    div %rbx

digit_to_char:
    cmp $10, %rdx
    jge capital_letters
    add $48, %rdx
    jmp digit_to_char_end
capital_letters:
    add $55, %rdx
digit_to_char_end:

    mov %dl, (%rsi)
    dec %rsi
    test %rax, %rax
    jnz write_digits_loop

# write to stdout
    mov $1, %rax
    mov $1, %rdi
    inc %rsi # pointer to the first meaningful char
    mov $str_end, %rdx
    sub %rsi, %rdx
    syscall

    mov $0, %rdi
    mov %rbx, %rdi
    jmp exit


.data
str:
.space 64
.ascii "\n"
str_end:
str_len=.-str
