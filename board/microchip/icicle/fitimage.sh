#! /bin/sh

ITS_DIR=$BR2_EXTERNAL_ICICLE_PATH/board/microchip/icicle

$HOST_DIR/bin/riscv64-linux-objcopy -O binary $BINARIES_DIR/vmlinux $BINARIES_DIR/vmlinux.bin

cd $BINARIES_DIR
cp $ITS_DIR/osbi-fit-image.its $BINARIES_DIR
$HOST_DIR/bin/mkimage -f ./osbi-fit-image.its -A riscv -O linux -T flat_dt ./fitImage.fit
rm osbi-fit-image.its

