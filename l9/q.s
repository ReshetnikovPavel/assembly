.globl print

print:
    push %rbp
    mov %rsp, %rbp
    push $0
    and $~15, %rsp

    mov %rdi, %rsi
    lea s(%rip), %rdi
    call printf@plt

    mov %rbp, %rsp
    pop %rbp
    ret

s:
.asciz "%d\n"
