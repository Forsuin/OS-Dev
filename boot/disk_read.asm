; load DH sectors to ES:BX from drive DL
load_disk:
    push dx ; store how many sectors to be read

    mov ah, 0x02 ; BIOS read sector function
    mov al, dh ; read DH sectors (# of sectors)
    mov ch, 0x00 ; cylinder 0
    mov dh, 0x00 ; head 0
    mov cl, 0x02 ; start reading from second sector
    int 0x13

    jc disk_error ; jump if carry flag set (error)

    pop dx
    cmp dh, al ; (AL == sectors read) != (DH == sectors expected to be read)
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG:
    db 'Disk read error!', 0