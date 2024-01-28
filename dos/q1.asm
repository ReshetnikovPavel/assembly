org 0x100
    mov ax, 0x2
    int 10h
    push 0xb800
    pop es
    mov byte [es:0], 100
    mov byte [es:1], 0x35
    mov byte [es:2], 97
    mov ah, 0
    int 16h
    ret

s:
; df ~ .word
; dd ~ .long
; dq ~ .quad
; db ~ .byte
; .ascii нету (используй db)
db "hello$"
