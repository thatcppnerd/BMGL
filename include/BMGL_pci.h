#ifndef __BMGL_PCI_H__
#define __BMGL_PCI_H__

struct PCI_Architecture
{
    unsigned int buses;
    unsigned int slots;
    unsigned int devices;
};


struct PCI_Architecture BMGL_PCI_GetArchitecture(void);

#endif