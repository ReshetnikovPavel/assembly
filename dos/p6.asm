org 0x100
    finit
;     fld1
;     fld1
;     faddp
;     fldpi
; l:
;     fmul st1, st0
;     jmp l
;     ret
    xor cx, cx
    fild dword ptr n
    fld1
    fld1
    faddp

    ; fld1
    ; fld1
    ; fdivp

    fld st1
    fst dword ptr tmp
    mov eax, [tmp]
    shr eax, 1
    sub [magic], eax
    fld1
    fld dword ptr magic
    fdivp


lp:
    fld st0
    fld st0
    fmulp
    fld st2
    fsubp
    fabs
    fcomp qword ptr eps
    fstsw ax
    sahf
    jb r
    fld st2
    fld st1
    fdivp
    faddp
    fld st1
    fdivp
    inc cx
    jmp lp

r:
    int3
    ret
    

n:
    dd 10
eps:
    dq 0.00000001
tmp:
    dd 0
magic:
    dd 0x5f3759df
