    org 100h
.CODE
first:
    mov ax, <bx>
    mov <bx> + 6, ax
second: 
    mov ax, bx
    mov bx, <bx> + 14
    mov cx, <bx> + 4
    mov bx, ax
    mov <bx>, cx
third:
    mov ax, <bx> + 10
    mov cx, <bx> + 14
    mov ax, bx
    mov bx, cx
    mov <bx> + 6, ax
    mov cx, bx
    mov bx, ax
    