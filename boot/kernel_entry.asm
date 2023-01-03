[bits 32]
[extern main] ; declare that we will be referencing an external symbol called 'main'
              ; so the linker can substitue the final address

call main
jmp $