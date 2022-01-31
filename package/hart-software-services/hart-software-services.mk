################################################################################
 #
 # Hart Software Services
 #
################################################################################
HART_SOFTWARE_SERVICES_VERSION = 2021.11
HART_SOFTWARE_SERVICES_SITE = $(call github,polarfire-soc,hart-software-services,$(HART_SOFTWARE_SERVICES_VERSION))
HART_SOFTWARE_SERVICES_INSTALL_STAGING = NO
HART_SOFTWARE_SERVICES_INSTALL_TARGET = YES
HART_SOFTWARE_SERVICES_LICENSE = MIT
HART_SOFTWARE_SERVICES_LICENSE_FILES = LICENSE.md

ifeq ($(BR2_PACKAGE_AMP_EXAMPLES),y)
HOST_HART_SOFTWARE_SERVICES_DEPENDENCIES += uboot amp_examples
else
HOST_HART_SOFTWARE_SERVICES_DEPENDENCIES += uboot
endif

ifeq ($(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR),y)
define HOST_HART_SOFTWARE_SERVICES_BUILD_CMDS
	$(MAKE) -C $(@D)/tools/hss-payload-generator
	
	cp $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_SRC) $(@D)/tools/hss-payload-generator/src.bin
	( \
		if [ "$(BR2_PACKAGE_AMP_EXAMPLES)" = "y" ]; then \
			cp $(BINARIES_DIR)/mpfs-rpmsg-remote.elf $(@D)/tools/hss-payload-generator/amp.elf; \
		fi; \
		cd $(@D)/tools/hss-payload-generator; \
		./hss-payload-generator -c $(BR2_PACKAGE_HOST_HSS_PAYLOAD_GENERATOR_CFG) -v $(BINARIES_DIR)/payload.bin; \
	)

endef
else
define HOST_HART_SOFTWARE_SERVICES_BUILD_CMDS
endef
endif

$(eval $(host-generic-package))
