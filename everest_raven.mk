#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit some common Lineage stuff.
TARGET_DISABLE_EPPE := true
$(call inherit-product, vendor/everest/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/google/raviole/aosp_raven.mk)
$(call inherit-product, device/google/gs101/lineage_common.mk)

include device/google/raviole/raven/device-lineage.mk

# Device identifier. This must come after all inclusions
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 6 Pro
PRODUCT_NAME := everest_raven

#everest config
WITH_GAPPS := true
EVEREST_MAINTAINER := Prabhat Maurya
TARGET_SUPPORTS_BLUR := true
EVEREST_BUILD_TYPE := official
EVEREST_UDFPS_ANIMATIONS := true

# Boot animation
TARGET_BOOT_ANIMATION_RES := 1440

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=raven \
    PRIVATE_BUILD_DESC="raven-user 14 AP1A.240505.004 11583682 release-keys"

BUILD_FINGERPRINT := google/raven/raven:14/AP1A.240505.004/11583682:user/release-keys

$(call inherit-product, vendor/google/raven/raven-vendor.mk)
