#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/oriole/overlay-lineage
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/oriole/overlay-everest

$(call inherit-product, $(LOCAL_PATH)/device-lineage.mk)
