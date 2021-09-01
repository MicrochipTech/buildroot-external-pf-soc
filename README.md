# Microchip PolarFire SOC buildroot external tree
## [![Microchip's polarfire-soc-buildroot-sdk](https://www.microsemi.com/images/soc/products/PolarFire_SoC/IC-MCRSM-1Pin-POLARFIRE-SOC-FPGA-straight.png)](https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga)

This repository is a buildroot external tree to support the Microchip PolarFire SOC RISC-V FPGA.
It is based on the recommended buildroot [![external tree structure]()](https://buildroot.org/downloads/manual/manual.html#customize-dir-structure) and a stripped-down version of the original Microchip PolarFire SOC Buildroot sdk [![repository]()](https://github.com/polarfire-soc/polarfire-soc-buildroot-sdk).

## Supported evalution kits
- [MPFS-ICICLE-KIT-ES](https://www.microsemi.com/existing-parts/parts/152514)

## Build instructions
To build this external tree:

```sh
git clone https://github.com/buildroot/buildroot.git -b 2021.02
git clone https://github.com/MicrochipTech/buildroot-external-pf-soc.git
cd buildroot-pf-soc-external
git checkout v2021.04
make O=$PWD BR2_EXTERNAL=$PWD -C ../buildroot icicle_defconfig
make
```

## Installation

Connect a USB cable to J11.  The first enumerated port is the HSS console and the second port is the Linux console
Connect a USB cable to J16 for transferring the Linux image
Power cycle the board and halt the hss boot console by pressing a key
type usbdmsc on the HSS console and hit enter
determine the enumerated disk on the host PC (i.e dmesg | egrep "sd|mmcblk")
unmount the disk if it automounts (i.e umount /dev/sda or umount /dev/mmcblk0)

Flash the image:
```sh
dd if=images/sdcard.img of=/dev/sdN status=progress

Reboot the icicle kit or CTRL-C on the HSS console and type boot
```


