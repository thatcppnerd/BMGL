%ifndef __BMGL_TO_STR_ASM__
%define __BMGL_TO_STR_ASM__

; eax - signed integer
; es:bx - string ptr
itoa32:


; eax - unsigned integer
; es:bx - string buf ptr
uitoa32:
    push eax
    push bx
    
    ui32_clear_dest_buf:
        mov dword [es:bx], 0
        add bx, 4
        mov dword [es:bx], 0
        and bx, 4
        mov dword [es:bx], 0
        sub bx, 8
    

    ui32_zero?:
        cmp eax, 0
        jne ui32_convert
    ui32_zero:
        mov byte [es:bx], '0'
        mov byte [es:bx + 1], 0
        jmp ui32_done

    ui32_convert: 
        ui32_cvt_check:
            



    ui32_done:
        pop bx
        pop eax
        ret



itoh:


%endif