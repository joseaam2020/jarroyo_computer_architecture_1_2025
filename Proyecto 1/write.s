section .data
    filename DD "interpolacion.img"
    newline db 0xa
section .bss 
    wbuffer: resb 4
    wByte: resb 1
section .text
global write
write:
    ;open file for write
    mov eax, 5          
    mov ebx, filename   
    mov ecx, 0x442      
    mov edx, 420       
    int 0x80            

    mov edx, eax ;file descriptor

    ;Return address
    pop eax 

    ;value to write
    pop ebx

    ;save return address
    push eax

    ;save file descriptor
    push edx 


    ;Conversion de num a ascii
    mov ecx, 0      ;counter
    mov eax, ebx

conversion_num:

    mov ebx, 10     ;divide value by 10
    xor edx, edx
    div ebx

    add edx, 0x30   ;residue (edx) has value to write (plus 0x30 in ascii)
    lea ebx, [wbuffer]
    add ebx, ecx
    mov byte [ebx],dl

    add ecx, 1
    cmp eax, 0
    jne conversion_num


write_loop:

    ;extract value from buffer
    sub ecx, 1
    lea ebx, [wbuffer]
    add ebx, ecx
    mov byte al, [ebx] 
    mov byte [wByte], al

    pop ebx  ;file descriptor
    push ecx ;save counter

    ;write value
    mov eax, 4          
    mov ecx, wByte    
    mov edx, 1          
    int 0x80

    pop ecx ;retrieve counter

    push ebx  ;file descriptor

    cmp ecx, 0
    jne write_loop

    pop ebx   ;file descriptor

    ;write value
    mov eax, 4          
    mov ecx, newline    
    mov edx, 1          
    int 0x80

    ;close file 
    mov eax, 6      ; sys_close
    int 0x80

    ret