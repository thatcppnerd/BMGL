#ifndef __BMGL_VGA_M3_H__
#define __BMGL_VGA_M3_H__

#include "vga.h"
#include "../../types.h"

typedef struct BMGL_VGA_M3_Char
{
    u8_t char, color;
} BMGL_VGA_M3_Char_t;

void BMGL_VGA_M3_SetChar(int row, int col, BMGL_VGA_M3_Char_t color);

#endif