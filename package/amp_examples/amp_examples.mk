################################################################################
 #
 # Microchip AMP FreeRTOS Example
 #
################################################################################
AMP_EXAMPLES_VERSION = v2021.11
AMP_EXAMPLES_SITE = https://github.com/polarfire-soc/polarfire-soc-amp-examples.git
AMP_EXAMPLES_SITE_METHOD = git
AMP_EXAMPLES_INSTALL_TARGET = NO
AMP_EXAMPLES_INSTALL_IMAGES = YES
AMP_EXAMPLES_LICENSE = MIT
AMP_EXAMPLES_LICENSE_FILES = LICENSE.md

define AMP_EXAMPLES_BUILD_CMDS
	make -C $(@D)/mpfs-rpmsg-freertos CROSS_COMPILE=$(TARGET_CROSS) REMOTE=1
endef

define AMP_EXAMPLES_INSTALL_IMAGES_CMDS
	cp $(@D)/mpfs-rpmsg-freertos/Remote-Default/mpfs-rpmsg-remote.elf $(BINARIES_DIR)
endef

$(eval $(generic-package))
