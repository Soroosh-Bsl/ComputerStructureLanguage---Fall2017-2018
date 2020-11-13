include 'emu8086.inc'
    org 100h
.DATA
    str db '?.!  ? salam?!  ? . ! eyvay ? $'
.CODE
    
start:
    mov bx, 0
    mov al, 1
    mov dx, 0   
_loop:
    mov cl, [str]+bx  
    cmp cl, 10
    je count
    cmp cl, 12
    je count
    cmp cl, 13
    je count
    cmp cl, '?'
    je count
    cmp cl, ';'
    je count
    cmp cl, ','
    je count
    cmp cl, '!'
    je count  
    cmp cl, '.'
    je count
    cmp cl, ' '
    je count  
    cmp cl, '$'
    je finish
    inc bx  
    mov al, 0
    jmp _loop
    
count:     
    inc bx
    cmp al, 0
    jne _loop
    mov al, 1
    inc dx
    jmp _loop 
finish:
    mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h    
    mov ax, dx
    call PRINT_NUM  
    RET  
    
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
END