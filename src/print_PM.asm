[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a string which is pointed to by the address in ebx
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY ; start of video memory

print_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je return

    mov [edx], ax ; store char and attributes at current character cell

    add ebx, 1
    add edx, 2
    jmp print_pm_loop

return_pm:
    popa
    ret