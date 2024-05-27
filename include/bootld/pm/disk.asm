

; push dest (dword)
; push lba (dword)
; push count (word, limit = 255)
__read_disk:
    pop word [__rd_count]
    pop dword [__rd_lba]
    pop dword [__rd_dest]
    __read_disk_start:
        ; nop command
        mov dx, 0x1F7
        xor eax, eax
        out dx, al

        ; setup registers
        sub dx, 6 ; 0x1F1
        out dx, al

        inc dx ; 0x1F2
        mov ax, word [__rd_count] ; get count
        out dx, al

        inc dx ; 0x1F3
        mov eax, dword [__rd_lba]; get lba
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

        mov word [timeout], 0

        __rd_wait:
            inc word [timeout] ; ++timeout
            ; check timeout
            cmp word [timeout], 0
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

                jmp __read_disk_start


            __rd_still_time:
                ; get status reg
                in al, dx
                test al, 0x80 ; test bsy
                jnz __rd_wait ; not done

        __rd_ready: ; read in data
            mov eax, 256 ; 1 sector = 256 words
            mov cx, word [__rd_count]
            mul cx ; 256 * count

            mov cx, ax
            dec cx
            mov dx, 0x1F0
            mov edi, dword [__rd_dest]
            rep insw ; load

            ret



__rd_dest :     dd 0 
__rd_lba :      dd 0
__rd_count :    dw 0
timeout: dw 0

