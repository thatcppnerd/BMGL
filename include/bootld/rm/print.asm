%ifndef __BMGL_PRINT_ASM__
%define __BMGL_PRINT_ASM__

bits 16

global print

; void print(const char* addr)
; es:bx - addr
    print:
        push ax
        push bx
        push es

        mov ah, 0x0E

        print_check_addr:
            cmp bx, 0xFFFF ; is offset at limit?
            jl print_check_done ; not yet
        print_shift_segment: ; offset limit is reached, do something
            push ax

            mov ax, es ; load segment
            inc ax ; shift segment by 16 bytes
            mov es, ax ; store shifted segment

            sub bx, 0x10 ; compensate offset 

            pop ax
        print_check_done:
            mov al, [es:bx]
            cmp al, 0 ; is current char null?
            je print_done ; yes
        print_do: ; no
            int 10h ; print char

            inc bx
            jmp print_check_addr 
        print_done:
            pop es
            pop bx
            pop ax
            ret

%endif