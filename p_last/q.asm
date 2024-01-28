org 0x100
s:
    mov ax, 2

    int 10h
    push 0x800
    рор es
    xor di, di
    mov al, 0
    mov сх, 255

l:
    stosb
    inc di
    inc al
    loop l
    mov ah, 0
    int 16h
    ret

