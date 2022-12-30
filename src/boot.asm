[org 0x7c00]
;mov ah, 0x0e ; enable tty

mov bx, HELLO_MSG
call print_string
call print_newline

mov bx, GOODBYE_MSG
call print_string
call print_newline

call print_newline
call print_newline

mov dx, 0x1234
call print_hex


jmp $

%include "src/print.asm"

HELLO_MSG:
    db 'Hello, World!', 0

GOODBYE_MSG:
    db 'Goodbye!', 0

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55