section .data
    pathname DD "/home/jaam/Documents/jarroyo_computer_architecture_1_2025/aristas.img"
section .bss
    pixels: resb 4
    aristas: resb 8
section .text
global aristas
aristas:
    ;Save arguments in pixels
    lea eax, [pixels]
    add eax,3
    pop ecx
    mov byte [eax], cl  
    sub ecx,1
    pop ecx
    mov byte [eax], cl  
    sub ecx,1
    pop ecx
    mov byte [eax], cl  
    sub ecx,1
    pop ecx
    mov byte [eax], cl  

    ;Arista1 
    lea eax, [pixels]    ;2/3 * pixel1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;1/3 * pixel2
    add eax, 1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(2/3*pixel1)+(1/3*pixel2)
    add eax,ecx

    lea ebx,[aristas]
    mov byte [ebx], al

    ;Arista2 
    lea eax, [pixels]    ;1/3 * pixel1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;2/3 * pixel2
    add eax, 1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(2/3*pixel1)+(1/3*pixel2)
    add eax,ecx

    lea ebx,[aristas]
    add ebx,1
    mov byte [ebx], al


    ;Arista3 
    lea eax, [pixels]    ;2/3 * pixel1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;1/3 * pixel3
    add eax, 2
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(2/3*pixel1)+(1/3*pixel3)
    add eax,ecx

    lea ebx,[aristas]
    add ebx,2
    mov byte [ebx], al
    
    ;Arista4 
    lea eax, [pixels]    ;2/3 * pixel2
    add eax, 1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;1/3 * pixel4
    add eax,3
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(2/3*pixel2)+(1/3*pixel4)
    add eax,ecx

    lea ebx,[aristas]
    add ebx,3
    mov byte [ebx], al
    
    ;Arista5 
    lea eax, [pixels]    ;1/3 * pixel1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;2/3 * pixel3
    add eax, 2
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(1/3*pixel1)+(2/3*pixel3)
    add eax,ecx

    lea ebx,[aristas]
    add ebx,4
    mov byte [ebx], al

    ;Arista6 
    lea eax, [pixels]    ;1/3 * pixel2
    add eax, 1
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;2/3 * pixel4
    add eax, 3
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(1/3*pixel2)+(2/3*pixel4)
    add eax,ecx

    lea ebx,[aristas]
    mov byte [ebx], al

    ;Arista7 
    lea eax, [pixels]    ;2/3 * pixel3
    add eax, 2
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;1/3 * pixel4
    add eax, 3
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(2/3*pixel3)+(1/3*pixel4)
    add eax,ecx

    lea ebx,[aristas]
    add ebx,6
    mov byte [ebx], al

    ;Arista8 
    lea eax, [pixels]    ;1/3 * pixel3
    add eax, 2
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 1
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    push eax             ;save result 

    lea eax, [pixels]    ;2/3 * pixel4
    add eax, 3
    mov ebx, 0
    mov byte bl, [eax]
    mov eax, 2
    mov ecx, 3
    xor edx, edx
    imul eax,ebx
    div ecx

    pop ecx              ;(2/3*pixel3)+(1/3*pixel4)
    add eax,ecx

    lea ebx,[aristas]
    add ebx,6
    mov byte [ebx], al