
ata_delay_400ns:
    push dx
    push ax

    ; read status register x15
    mov dx, 0x1F7

    in al, dx
    in al, dx
    in al, dx
    in al, dx
    in al, dx

    in al, dx
    in al, dx
    in al, dx
    in al, dx
    in al, dx

    in al, dx
    in al, dx
    in al, dx
    in al, dx
    in al, dx
    
    pop ax
    pop dx
    ret
