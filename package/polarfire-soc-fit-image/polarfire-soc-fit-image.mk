################################################################################
#
# PolarFire SOC FIT image
#
################################################################################

POLARFIRE_SOC_FIT_IMAGE_VERSION = 2021.04
POLARFIRE_SOC_FIT_IMAGE_SITE_METHOD = git
POLARFIRE_SOC_FIT_IMAGE_SITE = https://bitbucket.microchip.com/scm/~c41329/polarfire-soc-fit-image.git
POLARFIRE_SOC_FIT_IMAGE_LICENSE = GPL-2.0 MIT 
POLARFIRE_SOC_FIT_IMAGE_LICENSE_FILES = COPYING LICENSES/GPL-2.0 LICENSES/MIT
POLARFIRE_SOC_FIT_IMAGE_DEPENDENCIES = linux host-uboot-tools

ifeq ($(BR2_PACKAGE_POLARFIRE_SOC_DTBO_ONLY),y)
define POLARFIRE_SOC_FIT_IMAGE_BUILD_CMDS
	PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_POLARFIRE_SOC_FIT_IMAGE_PLATFORM)_dtbos
endef
define POLARFIRE_SOC_FIT_IMAGE_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_POLARFIRE_SOC_FIT_IMAGE_PLATFORM)/$(f) \
			$(BINARIES_DIR))
endef
else
define POLARFIRE_SOC_FIT_IMAGE_BUILD_CMDS
	PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_POLARFIRE_SOC_FIT_IMAGE_PLATFORM).itb
endef
define POLARFIRE_SOC_FIT_IMAGE_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_POLARFIRE_SOC_FIT_IMAGE_PLATFORM)/$(f) \
			$(BINARIES_DIR))
	$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_POLARFIRE_SOC_FIT_IMAGE_PLATFORM).itb $(BINARIES_DIR)/
endef
endif

$(eval $(generic-package))
