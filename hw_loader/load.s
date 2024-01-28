.globl _start
.text
display_help:
    mov $1, %rax
    mov $1, %rdi
    mov $help, %rsi
    mov $help_l, %rdx
    syscall
    ret

exit_err:
    mov $1, %rdi
    mov $60, %rax
    syscall

exit:
    mov $0, %rdi
    mov $60, %rax
    syscall

open:
    mov $2, %rax
    xor %rsi, %rsi
    syscall
    test %rax, %rax
    js exit_err
    ret

_start:
    pop %rax
    cmp $2, %rax
    je 1f
    call display_help
    jmp exit_err
1:
    pop %rax
    pop %rdi
    call open

    mov %rax, %r15 # file desc
    mov %r15, %rdi
    xor %rax, %rax # read
    mov $meta, %rsi
    mov $meta_l, %rdx
    syscall
    
# .text
t:
    mov $meta, %rax
    mov (%rax), %rsi
    mov $9, %rax # mmap
    xor %rdi, %rdi
    mov $7, %rdx # PROT_READ | PROT_EXEC | PROT_WRITE
    mov $0x22, %r10 # MAP_PRIVATE | MAP_ANONYMOUS
    mov $-1, %r8
    xor %r9, %r9
    syscall

    mov %rax, %r12 # .text ptr

    xor %rax, %rax # read
    mov %r15, %rdi
    mov %rsi, %rdx
    mov %r12, %rsi
    syscall

    mov %rax, %rsi
    mov $10, %rax # mprotect
    mov %r12, %rdi
    mov $5, %rdx # PROT_READ | PROT_EXEC
    syscall

# .data
d:
    mov $meta+8, %rax
    mov (%rax), %rsi
    mov $9, %rax # mmap
    mov %r12, %rdi
    add %rsi, %rdi
    mov %rdi, %r13 # .data ptr
    mov $3, %rdx # PROT_READ | PROT_WRITE
    mov $0x22, %r10 # MAP_PRIVATE | MAP_ANONYMOUS
    mov $-1, %r8
    xor %r9, %r9
    syscall
    
    xor %rax, %rax # read
    mov %r15, %rdi
    mov %rsi, %rdx
    mov %r13, %rsi
    syscall

# .bss
b:
    mov $meta+(8*2), %rax
    mov (%rax), %rsi
    mov $9, %rax # mmap
    mov %r13, %rdi
    add %rsi, %rdi
    mov %rdi, %r14 # .bss ptr
    mov $3, %rdx # PROT_READ | PROT_WRITE
    mov $0x22, %r10 # MAP_PRIVATE | MAP_ANONYMOUS
    mov $-1, %r8
    xor %r9, %r9
    syscall

    xor %rax, %rax # read
    mov %r15, %rdi
    mov %rsi, %rdx
    mov %r14, %rsi
    syscall

    mov $meta+(8*3), %rax
    add %r12, %rax
    
    mov %r12, %rax
before_jump:
    jmp *%rax


.data
help:
.ascii "Usage: load [file]\n\n"
.ascii "load is simple binary loader written in assembly\n\n"
.ascii "Binary should follow this format:\n"
.ascii "\tfirst 8 bytes - length of .text section\n"
.ascii "\tnext 8 bytes - length of .data section\n"
.ascii "\tnext 8 bytes - length of .bss section\n"
.ascii "\tnext 8 bytes - entry point address (start of .text section is considered as 0)\n"
.ascii "\t.text, .data, and .bss sections in this particular order"
.asciz ""
help_l=.-help

meta:
.space 32
meta_l=.-meta
