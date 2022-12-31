[org 0x7c00]

    mov [BOOT_DRIVE], dl

    mov bp, 0x8000 ; set stack in open memory
    mov sp, bp

    mov bx, 0x9000 ; load 5 sectors to 0x0000(ES):0x9000(BX)
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call load_disk

    mov dx, [0x9000]
    call print_hex  ; print first loaded word, which should be 0xdada

    mov dx, [0x9000 + 512]
    call print_hex  ; print first word from second loaded sector, should be 0xface

    jmp $

    %include "src/print.asm"
    %include "src/disk_read.asm"


BOOT_DRIVE: db 0


; zero padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface