.globl _start
_start:
    pop %rcx
l:
    mov $1, %rax
    mov $1, %rdi
    pop %rsi
    mov %rsi, %rdx
read_par_loop: 
    inc %rdx
    cmpb $0, (%rdx)
    jne read_par_loop
    movb $10, (%rdx)
    inc %rdx

    sub %rsi, %rdx
    push %rcx
    syscall
    pop %rcx
    loop l

    mov $60, %rax
    syscall

.data
end:
.ascii "\n"
