

; push dest (dword)
; push lba (dword)
; push count (word, limit = 255)
__read_disk:
    push ebp
    mov ebp, esp
    add ebp, 8
    __rd_start:
        ; ata nop command
        mov dx, 0x1F7
        xor eax, eax
        out dx, al

        ; setup registers
        sub dx, 6 ; 0x1F1
        out dx, al

        inc dx ; 0x1F2
        mov ax, word [ebp + 0] ; get count
        out dx, al

        inc dx ; 0x1F3
        mov eax, dword [ebp + 2]; get lba
        out dx, al

        inc dx ; 0x1F4
        shr eax, 8
        out dx, al

        inc dx ; 0x1F5
        shr eax, 8
        out dx, al

        inc dx ; 0x1F6
        and al, 0x0F
        or al, 0xE0
        out dx, al

        inc dx ; 0x1F7
        mov al, 0x20
        out dx, al

        ; 400 ns delay
        mov ecx, 15
        rep in al, dx

        mov word [ebp + 10], 0 ; init timeout

        __rd_wait:
            inc word [ebp + 10] ; ++timeout
            ; check timeout
            cmp word [ebp + 10], 0
            jne __rd_still_time

            __rd_no_time:
                ; do software reset
                mov dx, 0x3F6
                mov al, 0x04
                out dx, al

                ; delay
                mov dx, 0x1F7
                mov ecx, 15 * 15
                rep in al, dx

                mov dx, 0x3F6
                xor eax, eax
                out dx, al

                jmp __rd_start


            __rd_still_time:
                ; get status reg
                in al, dx
                test al, 0x80 ; test bsy
                jnz __rd_wait ; not done

        __rd_ready: ; read in data
            mov eax, 256 ; 1 sector = 256 words
            mov cx, word [ebp + 2]
            mul cx ; 256 * count

            mov cx, ax
            mov dx, 0x1F0
            mov edi, dword [ebp + 6]
            rep insw ; load

            mov word [ebp + 10], 0 ; reset memory location

            mov eax, 0 ; return code
            
            pop ebp
            ret



