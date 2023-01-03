[bits 16]

;switch to protected mode
switch_to_pm:
    cli ; turn of interrupts until protected mode interrupt vector is set up

    lgdt [gdt_descriptor]

    mov eax, cr0    ; to switch to protected mode, set first bit of cr0
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm    ; force CPU to flush cache of pre-fetched and 
                            ;real-mode decoded instructions


[bits 32]
; initialize registers and stack in PM

init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000    ; update stack position so it's at the top of free space
    mov esp, ebp

    call BEGIN_PM