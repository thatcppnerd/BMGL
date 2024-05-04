#ifndef __BMGL_PCI_H__
#define __BMGL_PCI_H__

struct PCI_Arch
{
    unsigned int buses;
    unsigned int slots;
    unsigned int devices;
};

struct PCI_DeviceInfo
{
    unsigned int functions;

    unsigned short device, vendor;
}

struct PCI_Architecture BMGL_PCI_GetArchitecture(void);
struct PCI_DeviceInfo   BMGL_PCI_GetDeviceInfo(void);
#endif