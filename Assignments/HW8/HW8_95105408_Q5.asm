include 'emu8086.inc'
    org 100h
start: 
input_n:
    mov ah, 01
    int 021h
    cmp al, 13
    je input_r  
    sub al, 48
    mov cl, al
    mov ax, 10 
    imul bx  
    mov bx, ax
    add bl, cl 
    cmp cl, 13
    jne input_n 
input_r:
    mov ah, 01
    int 021h
    cmp al, 13
    je calc  
    sub al, 48
    mov cl, al
    mov ax, 10 
    imul dx  
    mov dx, ax
    add dl, cl 
    cmp cl, 13
    jne input_r 
calc:
     push bx
     push dx
     call com  
    
     pop ax
     cmp cx, cx
     je finish
com:   
    pop ax
    pop bx
    pop dx
    push ax
    push dx
    push bx 
    cmp bx, dx
    je com_eq
    cmp bx, 1
    je com_one
    dec dx
    push dx
    push bx
    call com 
    pop ax
    pop bx
    pop dx
    push ax
    dec bx
    dec dx
    push dx
    push bx
    call com
    pop ax
    add cx, ax 
    pop bx
    add bx, ax
    add cx, bx
    pop ax
    push bx
    push ax 
    RET  
com_eq:
    pop ax
    pop ax
    pop ax
    push 1
    push ax
    RET
com_one:
    pop ax
    pop ax
    pop ax
    push dx
    push ax
    RET
finish:
    mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h  
    mov ah, 0    
    mov al, bl
    call PRINT_NUM
    RET  
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
END