include 'emu8086.inc'
    org 100h
.DATA           
    str db 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    substr db 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    replace_str db 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    n dw 0
    r dw 0
    a dw 0
    b dw 0
    command db 'c'
    counter dw 0
    check dw 0
    first_index dw 0 
    first_set dw 0
    
.CODE
;jmp count
start_n:
    mov bx, 0 
input_n:
    mov ah, 01
    int 021h
    mov [n], bx
    cmp al, 13
    je input_str  
    sub al, 48
    mov cl, al
    mov ax, 10 
    imul bx  
    mov bx, ax
    add bl, cl 
    cmp cl, 13
    jne input_n
start_r:  
     mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h
    mov bx, 0    
input_r:
    mov ah, 01
    int 021h   
    mov [r], bx 
    cmp al, 13
    je input_substr  
    sub al, 48
    mov cl, al
    mov ax, 10 
    imul bx  
    mov bx, ax
    add bl, cl 
    cmp cl, 13
    jne input_r
input_str: 
    mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h 
         
    mov cx, [n]
    mov dx, 0 
    lea bx, str
input_loop_str:
    mov ah, 01h
    int 021h
    mov <bx>, al
    inc dx
    inc bx
    cmp dx, cx
    jl input_loop_str 
    mov bx, 0
    jmp input_command  
input_substr: 
    mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h 
    mov cx, [r]
    mov dx, 0 
    lea bx, substr
input_loop_substr:
    mov ah, 01h
    int 021h
    mov <bx>, al
    inc dx
    inc bx
    cmp dx, cx
    jl input_loop_substr 
    cmp [command], 'r'
    jne action
    jmp input_replace_str 
input_a: 
     mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h
    mov bx, 0    
input_a_loop:
    mov ah, 01
    int 021h   
    mov [a], bx
    mov [r], bx
    cmp al, 13
    je input_b  
    sub al, 48
    mov cl, al
    mov ax, 10 
    imul bx  
    mov bx, ax
    add bl, cl 
    cmp cl, 13
    jne input_a_loop
input_b: 
    mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h
    mov bx, 0
input_b_loop:
    mov ah, 01
    int 021h    
    mov [b], bx
    cmp al, 13
    je input_substr  
    sub al, 48
    mov cl, al
    mov ax, 10 
    imul bx  
    mov bx, ax
    add bl, cl 
    cmp cl, 13
    jne input_b_loop  
    
input_replace_str:  
     mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h
    mov cx, [b]
    mov dx, 0 
    lea bx, replace_str
input_loop_replace_str:
    mov ah, 01h
    int 021h
    mov <bx>, al
    inc dx
    inc bx
    cmp dx, cx
    jl input_loop_replace_str 
    jmp action
    
input_command:
     mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h
    mov ah, 01h
    int 021h
    mov [command], al
    jmp do
do:
    cmp [command], 'r'
    je input_a  
    jmp start_r
action:
    cmp [command], 'r'
    je replace
    jmp count
replace:
    call count
    mov bx, 0
before_index:
    cmp bx, [first_index]
    jge sub_itself
    mov dl, [str] + bx
    mov ah, 02h
    int 021h
    inc bx
    jmp before_index
sub_itself:
    mov bx, 0
sub_itself_loop: 
    cmp bx, [b]
    jge after_index
    mov dl, [replace_str] + bx 
    mov ah, 02h
    int 021h
    inc bx
    jmp sub_itself_loop
after_index:
    mov bx, [first_index]
    add bx, [a]
after_index_loop:
    cmp bx, [n]
    jge return
    mov dl, [str] + bx
    mov ah, 02h
    int 021h
    inc bx
    jmp after_index_loop
count:
    mov bx, 0
    mov cx, 0
count_loop:
    mov dl, [str] + bx 
    mov ax, bx
    mov bx, cx
    mov dh, [substr] + bx 
    mov bx, ax
    cmp dl, dh
    je next_char 
    mov [check], 0
    jmp next
next_char:
    cmp [check], 0
    je push_index
    inc cx
    cmp cx, [r]
    je found
    inc bx
    cmp bx, [n]
    jl count_loop
    jmp finish   
push_index:
    mov [first_index], bx
    push bx
    mov [check], 1
    jmp next_char
save_first:
    mov [first_index], bx
    mov [first_set], 1
    jmp resume_found
found: 
    pop bx   
    cmp [first_set], 0
    je save_first
resume_found:
    inc [counter]
    inc bx
    mov cx, 0
    cmp bx, [n]
    jl count_loop
    jmp finish
next:
    mov cx, 0
    inc bx
    cmp bx, [n]
    jl count_loop
    jmp finish 
    
finish:
    mov ah, 02h
    mov dl, 10
    int 021h
    mov ah, 02h
    mov dl, 13
    int 021h
    cmp [command], 'r'
    je return   
    mov ax, [counter]
    call PRINT_NUM
return:
    RET
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
END