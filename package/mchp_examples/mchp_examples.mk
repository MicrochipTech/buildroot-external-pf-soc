################################################################################
 #
 # Microchip Examples
 #
################################################################################
MCHP_EXAMPLES_VERSION = a6a6ddb437b6de24ddd195d60713a78c1c5dd8e3
MCHP_EXAMPLES_SITE = https://github.com/polarfire-soc/polarfire-soc-linux-examples.git
MCHP_EXAMPLES_SITE_METHOD = git


EXAMPLE_DIRS += can gpio system-services ethernet fpga-fabric-interfaces dma pdma
EXAMPLE_FILES += can/uio-can-example gpio/led-blinky system-services/system-services-example fpga-fabric-interfaces/lsram/uio-lsram-read-write dma/uio-dma-interrupt pdma/pdma-ex
EXAMPLE_TARGET_DIR = /opt/microchip/

define MCHP_EXAMPLES_INSTALL_DIRS
	$(foreach d,$(EXAMPLE_DIRS), \
		rm -rf $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d)$(sep))
endef

define MCHP_EXAMPLES_INSTALL_TARGET_CMDS
        $(INSTALL) -d $(TARGET_DIR)$(EXAMPLE_TARGET_DIR) 
	$(foreach d,$(EXAMPLE_DIRS), \
		rm -rf $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)$(d)$(sep))

        echo $(EXAMPLE_FILES)
	$(foreach example_file,$(EXAMPLE_FILES), \
		$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/$(dir $(example_file)) $(notdir $(example_file)) CC=$(TARGET_CC); \
                $(INSTALL) -D -m 775 $(@D)/$(example_file) $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)/$(dir $(example_file));)

	ln -s $(EXAMPLE_TARGET_DIR)/ethernet/iio-http-server  $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)/iiohttpserver

endef

define MCHP_EXAMPLES_INSTALL_INIT_SYSTEMD
$(INSTALL) -D -m 644 $(@D)/ethernet/iio-http-server/collection/collectdiio.service \
        $(TARGET_DIR)/usr/lib/systemd/system/collectdiio.service
endef

define MCHP_EXAMPLES_INSTALL_INIT_SYSV
# iiohttp server
$(INSTALL) -D -m 775 $(@D)/ethernet/iio-http-server/collection/collectdiio.busybox \
        $(TARGET_DIR)/etc/init.d/collectdiio
# busy box init requires script renames
mv $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.{sh,systemd}
mv $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.{busybox,sh}
chmod +x $(TARGET_DIR)$(EXAMPLE_TARGET_DIR)ethernet/iio-http-server/run.sh

endef

$(eval $(generic-package))
