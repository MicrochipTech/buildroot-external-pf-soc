################################################################################
#
# dt-overlay-pf-soc
#
################################################################################

DT_OVERLAY_PF_SOC_VERSION = v2021.11
DT_OVERLAY_PF_SOC_SITE_METHOD = git
DT_OVERLAY_PF_SOC_SITE = https://github.com/MicrochipTech/dt-overlay-pf-soc.git
DT_OVERLAY_PF_SOC_LICENSE = GPL-2.0 MIT
DT_OVERLAY_PF_SOC_LICENSE_FILES = COPYING LICENSES/GPL-2.0 LICENSES/MIT
DT_OVERLAY_PF_SOC_DEPENDENCIES = linux host-uboot-tools

ifeq ($(BR2_PACKAGE_DT_OVERLAY_PF_SOC_ONLY),y)
define DT_OVERLAY_PF_SOC_BUILD_CMDS
	PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_DT_OVERLAY_PF_SOC_PLATFORM)_dtbos
endef
define DT_OVERLAY_PF_SOC_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_PF_SOC_PLATFORM)/$(f) \
			$(BINARIES_DIR))
endef
else
define DT_OVERLAY_PF_SOC_BUILD_CMDS
	PATH="$(LINUX_DIR)/scripts/dtc:$(HOST_DIR)/bin:$(PATH)" $(MAKE) DTC="$(LINUX_DIR)/scripts/dtc/dtc" KERNEL_DIR="$(LINUX_DIR)" -C $(@D) $(BR2_PACKAGE_DT_OVERLAY_PF_SOC_PLATFORM).itb
endef
define DT_OVERLAY_PF_SOC_INSTALL_TARGET_CMDS
	$(foreach f,$(notdir $(wildcard $(@D)/*/*.dtbo)),
		$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_PF_SOC_PLATFORM)/$(f) \
			$(BINARIES_DIR))
	$(INSTALL) -m 0644 -D $(@D)/$(BR2_PACKAGE_DT_OVERLAY_PF_SOC_PLATFORM).itb $(BINARIES_DIR)/
endef
endif

$(eval $(generic-package))
