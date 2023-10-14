.global _start

.text
_start:
    # read input
    mov $0, %rax
    mov $0, %rdi
    mov $input, %rsi
    mov $input_len, %rdx
    syscall

    mov $input, %rsi
    mov $0, %rax # int from input
    mov $10, %rbx # 10 is a base
    mov $0, %rcx # current digit

    # convert to number
to_int_loop:
    mov (%rsi), %cl # get current char
    cmp $10, %cl # 10 is ascii for \n
    je to_int_end
    mul %rbx # rax *= rbx
    sub $48, %cl # convert char digit to number (48 is ascii for 0)
    add %rcx, %rax # add digit to number
    inc %rsi # move index to next char
    jmp to_int_loop
to_int_end:
    mov %rax, %rcx # now rax is a value for factorial

factorial_loop:
    cmp $0, %rcx
    je factorial_end
    dec %rcx
    jz factorial_end
    mul %rcx
    jmp factorial_loop
factorial_end:

    push $0
push_digits_to_stack:
    mov $0, %rdx
    div %rbx
    add $48, %rdx
    push %rdx
    cmp $0, %rax
    je push_digits_to_stack_end
    jmp push_digits_to_stack
push_digits_to_stack_end:

    mov $output, %rsi # i
pop_digits:
    pop %rcx
    mov %cl, (%rsi)
    inc %rsi
    cmp $0, %rcx
    je pop_digits_end
    jmp pop_digits
pop_digits_end: 
    mov $10, (%rsi) # add \n to the end

    # write to output
    mov $1, %rax
    mov $1, %rdi
    mov $output, %rsi
    mov $output_len, %rdx
    syscall

    # exit
    mov $60, %rax
    syscall

.data
input:
    .space 20
    input_len=.-input
output:
    .space 20
    output_len=.-output
