[org 0x7c00]

    mov bp, 0x9000  ; set up stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call switch_to_pm   ; never return from here

    jmp $

%include "src/print.asm"
%include "src/GDT.asm"
%include "src/print_PM.asm"
%include "src/PMSwitch.asm"

[bits 32]
; this is where we arrive after switching to protected mode

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

MSG_REAL_MODE:
    db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:
    db "Successfully landed in 32-bit Protected Mode", 0

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55