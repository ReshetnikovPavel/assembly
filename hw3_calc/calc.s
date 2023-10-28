.global _start

.text
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
# does not preserve %rax, %rbx, %rcx and %r8; so, save them somewhere :)
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
    jmp %rdi


_start:
    pop %r8 # number of arguments
    pop %r8 # binary name
    mov $1, %rdi
    jz exit

    pop %r8 # pointer to argument string
    mov $read_arg, %rdi # where to go after to_int execution
    jmp to_int

read_arg:
    pop %r8
    test %r8,  %r8
    jz write_output
    movb (%r8), %bl # current argument, operation or number


check_plus:
    cmp $43, %rbx # if argument is `+`
    jne check_minus
    mov $plus, %rsi # rbx is current operation, in this case `+`
    je read_arg

check_minus:
    cmp $45, %rbx # if argument is `-`
    jne check_divide
    mov $minus, %rsi
    je read_arg

check_divide:
    cmp $47, %rbx # if argument is `/`
    jne check_multiply
    mov $divide, %rsi
    je read_arg

check_multiply:
    cmp $120, %rbx # if argument is `x`
    jne handle_second_arg
    mov $multiply, %rsi
    je read_arg

handle_second_arg:
    push %rax
    mov $execute, %rdi
    jmp to_int
execute:
    mov %rax, %rbx
    pop %rax
    jmp %rsi

write_output:
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
