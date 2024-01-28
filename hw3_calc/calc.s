.global _start

.text
exit_err:
    mov $1, %rdi
    jmp exit


plus:
    add %rbx, %rax
    jmp read_arg

minus:
    sub %rbx, %rax
    jmp read_arg

divide:
    mov $0, %r8
    div %rbx
    jmp read_arg
    
multiply:
    mul %rbx
    jmp read_arg

to_int:
# reads a string from (%r8) and converts it into int;
# after execution jumps to a value contained in %rdi
# does not preserve %rax, %rbx, %rcx and %r8;
# output is in %rax
    mov $0, %rax # a number
    mov $10, %rbx # 10 is a base
    mov $0, %rcx # current digit

to_int_loop:
    movb (%r8), %cl # get current char
    cmp $0, %cl # 0 is ascii for \0
    je to_int_end
    mul %rbx
    sub $48, %cl # convert char digit to number (48 is ascii for 0)
    add %rcx, %rax # add digit to number
    inc %r8 # move index to next char
    jmp to_int_loop
to_int_end:
    jmp *%rdi


_start:
    pop %r8 # number of arguments

    cmp $1, %r8 # at least one argument besides binary name is needed
    je exit_err

    pop %r8 # binary name
    mov $plus, %rsi # %rsi contains current operation. The first arg is evaluated as 0 + arg

read_arg:
    pop %r8
    test %r8, %r8
    jz write_output

# decide if we need to parse a number or an operation
    not %r9
    test %r9, %r9
    jnz handle_number

    movb (%r8), %bl # current argument

check_plus:
    cmpb $43, %bl # if argument is `+`
    jne check_minus
    mov $plus, %rsi # rbx is current operation, in this case `+`
    je read_arg

check_minus:
    cmpb $45, %bl # if argument is `-`
    jne check_divide
    mov $minus, %rsi
    je read_arg

check_divide:
    cmpb $47, %bl # if argument is `/`
    jne check_multiply
    mov $divide, %rsi
    je read_arg

check_multiply:
    cmpb $120, %bl # if argument is `x`
    jne exit_err
    mov $multiply, %rsi
    je read_arg

handle_number:
    push %rax
    mov $execute, %rdi
    jmp to_int
execute:
    mov %rax, %rbx
    pop %rax
    jmp *%rsi

write_output:
    test %r9, %r9 # the last argument cannot be an operation
    jz exit_err

    mov $str_end-2, %rsi # byte before \n
    mov $10, %rbx
write_digits_loop:
    xor %rdx, %rdx
    div %rbx
    add $48, %rdx
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
exit:
    mov $60, %rax
    syscall


.data
str:
.space 20
.ascii "\n"
str_end:
str_len=.-str
