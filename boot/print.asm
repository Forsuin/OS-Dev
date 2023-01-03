; prints a string which is pointed to by the address in bx
print_string:
    pusha ; don't step on user's values
    mov ah, 0x0e

print_start:
    mov al, [bx]

    cmp al, 0
    je return

    int 0x10
    add bx, 1
    jmp print_start

return:
    popa
    ret

; prints a new line
print_newline:
    pusha

    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10

    popa
    ret

; prints hex value located in dx
print_hex:
    pusha

    mov cx, 0 ; cx is loop index

hex_loop:
    cmp cx, 4
    je hex_end    

    mov ax, dx ; ax is working register
    and ax, 0x000f ; get last 4 bits
    add al, 0x30 ; convert to 0-9 ASCII
    cmp al, 0x39
    jle step2   ; if numeric digit
    add al, 7   ; get to correct A-F ASCII value  

step2:
    mov bx, HEX_OUT + 5 ; base + length of HEX_OUT string
    sub bx, cx ; subtract index from length of string
    mov [bx], al
    shr dx, 4 ; shift next hex digit over to be printed next iteration

    add cx, 1
    jmp hex_loop

hex_end:
    mov bx, HEX_OUT
    call print_string

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserved memory for new string