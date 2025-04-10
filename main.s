section .data
    pathname DD "/home/jaam/Documents/jarroyo_computer_architecture_1_2025/pixel.img"
section .bss
    buffer: resb 1
    pixels: resb 4
section .text
extern interpolacion
global _start

_start:
    ;Open for read
    mov eax,5
    mov ebx,pathname
    mov ecx,0
    int 80h

    ;file descriptor in ebx
    mov ebx,eax

    ;Stack setup 
    mov  eax,4   ;read 4 numbers
    push eax
    mov  eax,-1  ;stack end
    push eax

read:
    ;Read 
    mov eax,3
    mov ecx,buffer
    mov edx,1
    int 80h

    ;if eax == 0 (file end)
    test eax,eax
    jz   exit

    ;Conversion ascii to num
    mov eax,0
    mov ecx,0
    mov al ,[buffer]

    ;if [buffer] == 10 (new line)
    cmp eax, 10
    jne guardar
    mov ecx, 1
    mov edx, 0

conversion:
    ;if pop == -1 (no more in stack)
    pop eax
    cmp eax,-1
    je  conversion_out

    ;Multiply tens
    imul eax,ecx
    imul ecx,10
    add  edx,eax
    jmp  conversion

guardar:
    ;Substracs ascii value and stores in stack
    mov  cl ,30h 
    sub  al ,cl
    push eax 
    jmp  read 

conversion_out:
    ;store conversion (in edx)
    pop  eax
    mov  ecx,4
    sub  ecx,eax
    push eax
    lea  eax,[pixels]
    add  eax,ecx
    mov byte [eax], dl


    ;if 4 read
    pop eax
    cmp eax,1
    je write_call

    ;Set up stack
    sub  eax,1
    push eax
    mov  eax,-1
    push eax
    jmp  read

write_call:
    ;save file descriptor (ebx)
    push ebx

    ;Load arguments to stack
    lea eax,[pixels]
    add eax,3
    mov ecx,0
    mov byte cl, [eax] 
    push ecx
    sub eax, 1
    mov byte cl, [eax] 
    push ecx
    sub eax, 1
    mov byte cl, [eax] 
    push ecx
    sub eax, 1
    mov byte cl, [eax] 
    push ecx

    ;call aristas
    call interpolacion

    ;get file descriptor
    pop ebx

    ;Stack setup 
    mov  eax,4   ;read 4 numbers
    push eax
    mov  eax,-1  ;stack end
    push eax

    jmp read

exit:
    ;close file 
    mov eax, 6      
    int 0x80

    ; Exit program
    mov eax, 1              
    xor ebx, ebx           
    int 0x80              