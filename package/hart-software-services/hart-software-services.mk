################################################################################
 #
 # Heart Software Services
 #
################################################################################
HART_SOFTWARE_SERVICES_VERSION = 2021.04
HART_SOFTWARE_SERVICES_SITE = $(call github,polarfire-soc,hart-software-services,$(HART_SOFTWARE_SERVICES_VERSION))
HART_SOFTWARE_SERVICES_INSTALL_STAGING = NO
HART_SOFTWARE_SERVICES_INSTALL_TARGET = YES
HART_SOFTWARE_SERVICES_LICENSE = MIT
HART_SOFTWARE_SERVICES_LICENSE_FILES = LICENSE.md
HART_SOFTWARE_SERVICES_DEPENDENCIES = uboot


ifeq ($(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR),y)
define HOST_HART_SOFTWARE_SERVICES_BUILD_CMDS
	$(MAKE) -C $(@D)/tools/hss-payload-generator
	cp $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_SRC) src.bin
	$(@D)/tools/hss-payload-generator/hss-payload-generator -c $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_CFG) -v $(BINARIES_DIR)/payload.bin
	rm src.bin
endef
else
define HOST_HART_SOFTWARE_SERVICES_BUILD_CMDS
endef
endif

$(eval $(host-generic-package))
