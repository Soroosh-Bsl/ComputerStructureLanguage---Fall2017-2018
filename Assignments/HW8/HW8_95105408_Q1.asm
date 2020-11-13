include 'emu8086.inc'
    org 100h
.DATA
    sum: dw 0h
.CODE
start:

input:
    mov ah, 01
    int 021h
    cmp al, 13
    je calc  
    sub al, 48
    mov cl, al
    mov ax, 10 
    imul bx  
    mov bx, ax
    add bl, cl 
    cmp cl, 13
    jne input 
    
calc:  
    mov cx, 1
    mov dx, 0
    push dx   
calc_loop:
    cmp cx, bx
    je finish  
    mov dx, 0
    mov ax, bx
    div cx
    cmp dx, 0
    jne no   
    
    pop dx
    add dx, cx
    push dx
    
    inc cx
    cmp cx, cx
    je calc_loop   
no:
    inc cx
    cmp cx, cx
    je calc_loop     
finish:
    pop dx
    add dx, bx
    push dx 
    pop ax
    
    mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h
    call PRINT_NUM  
    RET  
    
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
END