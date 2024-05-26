#ifndef __ATA_H__
#define __ATA_H__

typedef u32_t LBA_t;

int BMGL_ATA_ReadSectorsPIO(LBA_t lba, int sectors, void* dest);
int BMGL_ATA_WriteSectorsPIO(LBA_t lba, int s0ectors, void* src);



#endif