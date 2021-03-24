#! /bin/sh

DTS_DIR=$BR2_EXTERNAL_ICICLE_PATH/board/microchip/icicle/dts
cp $DTS_DIR/../icicle-kit-es.dts $DTS_DIR
$HOST_DIR/bin/riscv64-linux-gcc -E -Wp,-MD,$DTS_DIR/icicle-kit-es.dts -nostdinc -I. -D__ASSEMBLY__ -undef -D__DTS__ -x assembler-with-cpp -o $DTS_DIR/icicle-kit-es.dtb.dts.tmp $DTS_DIR/icicle-kit-es.dts
$HOST_DIR/bin/dtc -O dtb -o $BINARIES_DIR/icicle-kit-es.dtb -b 0 -i ./ -R 4 -p 0x1000 -d $DTS_DIR/icicle-kit-es.dtb.d.dtc.tmp $DTS_DIR/icicle-kit-es.dtb.dts.tmp
