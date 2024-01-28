.text
    mov $., %rax
    mov $s, %rax
    movb (%rax), %bl
    mov %rbx, %rdi
    mov $60, %rax
    syscall
.data
s:
    .ascii "0"
