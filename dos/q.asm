org 0x100
    mov ah, 9
    mov dx, s
    int 21h
    int 0x20

s:
; df ~ .word
; dd ~ .long
; dq ~ .quad
; db ~ .byte
; .ascii нету (используй db)
db "hello$"
