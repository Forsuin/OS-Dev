[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; Memory offset where we will load kernel

    mov [BOOT_DRIVE], dl ; BIOS stores boot drive in dl

    mov bp, 0x9000  ; set up stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string
    call print_newline

    call load_kernel

    call switch_to_pm   ; never return from here

    jmp $

%include "boot/print.asm"
%include "boot/GDT.asm"
%include "boot/print_PM.asm"
%include "boot/switch_to_PM.asm"
%include "boot/disk_read.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string
    call print_newline

    mov bx, KERNEL_OFFSET   ; setup parameters for load_disk function
    mov dh, 15              ; load 15 sectors (excluding boot sector)
    mov dl, [BOOT_DRIVE]    ; from boot disk
    call load_disk          ; to address KERNEL_OFFSET
    ret

[bits 32]
; this is where we arrive after switching to protected mode

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    call KERNEL_OFFSET  ; Jump to address of loaded kernel code

    jmp $

BOOT_DRIVE:
    db 0
MSG_REAL_MODE:
    db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:
    db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL:
    db "Loading kernel into memory", 0

; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55