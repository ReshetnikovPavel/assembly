.globl _start


.text

color:
    push %rbx
    push %rcx
    movb (%rdi), %al
    mov $code, %rbx
    movb %al, (%rbx)

    mov $1, %rax
    mov $1, %rdi
    mov $scolor, %rsi
    mov $lcolor, %rdx
    syscall
    pop %rcx
    pop %rbx
    ret

reset:
    push %rbx
    push %rcx
    mov $1, %rax
    mov $1, %rdi
    mov $sreset, %rsi
    mov $lreset, %rdx
    syscall
    pop %rcx
    pop %rbx
    ret

write_slice:
    push %rbx
    push %rcx
    sub %rsi, %rdx
    inc %rdx
    mov $1, %rax
    mov $1, %rdi
    syscall
    pop %rcx
    pop %rbx
    ret

_start:
    pop %rax
    cmp $2, %rax
    jne exit_err
    pop %rax

#open
    pop %rdi
    mov $2, %rax
    xor %rsi, %rsi
    syscall

    cmp $-1, %rax
    je exit_err
    mov %rax, %r9

read:
    mov %r9, %rdi
    mov $0, %rax
    mov $contents, %rsi
    mov $4096, %rdx
    syscall
    mov %rax, %r10

    cmp $4096, %r10
    je 1f
    add $contents, %rax
    movb $0, (%rax)
1:
    mov $contents, %rbx
    mov %rbx, %rcx

    jmp decide_first_word_color

handle_line:
    inc %rcx
    mov %rcx, %rbx

decide_first_word_color:
    cmpb $32, (%rcx)
    je set_tab_first_word_color
    cmpb $9, (%rcx)
    je set_tab_first_word_color
    mov $FIRST_WORD_COLOR, %rdi
    mov $1, %r8
    jmp begin_leading_spaces
set_tab_first_word_color:
    mov $TAB_FIRST_WORD_COLOR, %rdi
    xor %r8, %r8
    jmp begin_leading_spaces

eat_leading_spaces:
    inc %rcx
begin_leading_spaces:
    cmpb $32, (%rcx)
    je eat_leading_spaces
    cmpb $9, (%rcx)
    je eat_leading_spaces
    jmp begin_eat_first_word

eat_first_word:
    inc %rcx
begin_eat_first_word:
    cmpb $0, (%rcx)
    je end_eat_first_word
    cmpb $10, (%rcx)
    je end_eat_first_word
    cmpb $32, (%rcx)
    je end_eat_first_word
    cmpb $9, (%rcx)
    jne eat_first_word
end_eat_first_word:
    call color
    mov %rbx, %rsi
    mov %rcx, %rdx
    call write_slice

    cmpb $10, (%rcx)
    je handle_line

    cmpb $0, (%rcx)
    jne 1f
    cmp $4096, %r10
    je read
    jne exit

    1:
    inc %rcx
    mov %rcx, %rbx


decide_other_color:
    test %r8, %r8
    jz set_tab_other_color
    mov $TAB_OTHER_COLOR, %rdi
    jmp end_decide_other_color
set_tab_other_color:
    mov $OTHER_COLOR, %rdi
end_decide_other_color:

eat_other_begin:
    cmpb $0, (%rcx)
    je eat_other_end
    cmpb $10, (%rcx)
    je eat_other_end
    inc %rcx
    jmp eat_other_begin
eat_other_end:
    call color
    mov %rbx, %rsi
    mov %rcx, %rdx
    call write_slice

    cmpb $10, (%rcx)
    je handle_line

    cmp $4096, %r10
    je read

exit:
    call reset
    mov $0, %rdi
    mov $60, %rax
    syscall

exit_err:
    call reset
    mov $1, %rdi
    mov $60, %rax
    syscall


.data
FIRST_WORD_COLOR: .byte 48+2
OTHER_COLOR: .byte 48+5
TAB_FIRST_WORD_COLOR: .byte 48+6
TAB_OTHER_COLOR: .byte 48+4

scolor:
.byte 0x1b
.ascii "[3"
code:
.ascii "0m"
lcolor=.-scolor

sreset:
.byte 0x1b
.ascii "[m"
lreset=.-sreset

contents:
.space 4096
