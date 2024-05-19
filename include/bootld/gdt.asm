%ifndef __BMGL_GDT_ASM__
%define __BMGL_GDT_ASM__

struc gdt32_seg
    limit0:         resw 1
    base0:          resw 1
    base1:          resb 1
    access_byte:    resb 1
    limit1_flags:   resb 1
    base2:          resb 1
endstruc

struc gdtr32
    size:   resw 1
    addr:   resd 1
endstruc


struc gdt64_seg
    limit0:         resw 1
    base0:          resw 1
    base1:          resb 1
    access_byte:    resb 1
    limit1_flags:   resb 1
    base2:          resb 1
    base3:          resd 1
    reserved        resd 1
endstruc

struc gdtr64
    size:   resw 1
    addr:   resq 1
endstruc

%endif