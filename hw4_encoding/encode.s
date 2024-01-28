.globl _start

.text
exit_err:
    mov $1, %rdi
exit:
    mov $60, %rax
    syscall

to_int:
    push %rbx
    mov $0, %rax
    mov $10, %rbx
    mov $0, %rcx
1:
    movb (%rdi), %cl
    cmp $0, %cl
    je 1f
    cmp $10, %cl
    je 1f
    cmp $32, %cl
    je 1f

    cmp $48, %cl
    jl exit_err
    cmp $57, %cl
    jg exit_err

    mul %rbx
    sub $48, %cl
    add %rcx, %rax
    inc %rdi
    jmp 1b
1:
    pop %rbx
    ret

.macro digit_to_char r1
    cmp $10, \r1
    jge 1f
    add $48, \r1
    jmp 2f
1:
    add $55, \r1
2:
.endm

_start:
    mov $0, %rax
    mov $0, %rdi
    mov $str, %rsi
    mov $str_len, %rdx
    syscall

    mov $str, %rdi
    call to_int
    mov %rax, %rbx

    inc %rdi
    call to_int

    cmp $2, %rbx
    jl exit_err
    cmp $36, %rbx
    jg exit_err

    mov $str_end-2, %rsi
write_digits_loop:
    xor %rdx, %rdx
    div %rbx
    digit_to_char %rdx
    mov %dl, (%rsi)
    dec %rsi
    test %rax, %rax
    jnz write_digits_loop

    mov $1, %rax
    mov $1, %rdi
    inc %rsi
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
