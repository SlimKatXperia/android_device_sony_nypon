#
# Copyright (C) 2014 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit the proprietary counterpart
$(call inherit-product-if-exists, vendor/sony/nypon/nypon-vendor.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += device/sony/nypon/overlay

# Target device Specific headers
TARGET_SPECIFIC_HEADER_PATH += device/sony/nypon/include

# Inherit the montblanc-common definitions
$(call inherit-product, device/sony/montblanc-common/montblanc.mk)

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.google.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal mdpi hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

# Configuration scripts
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/fstab.st-ericsson:root/fstab.st-ericsson \
   $(LOCAL_PATH)/config/init.st-ericsson.device.rc:root/init.st-ericsson.device.rc \
   $(LOCAL_PATH)/prebuilt/logo-540x960.rle:root/logo.rle \
   $(LOCAL_PATH)/../../../vendor/slim/prebuilt/common/bootanimation/480.zip:system/media/bootanimation.zip

# Configuration scripts
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/prebuilt/hw_config.sh:system/etc/hw_config.sh

# USB function switching
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/init.st-ericsson.usb.rc:root/init.st-ericsson.usb.rc

# Media Profiles
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/media_profiles.xml:system/etc/media_profiles.xml

# Key layouts and touchscreen
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/AB8500_Hs_Button.kl:system/usr/keylayout/AB8500_Hs_Button.kl \
   $(LOCAL_PATH)/config/simple_remote.kl:system/usr/keylayout/simple_remote.kl \
   $(LOCAL_PATH)/config/so34-buttons.kl:system/usr/keylayout/so34-buttons.kl \
   $(LOCAL_PATH)/config/STMPE-keypad.kl:system/usr/keylayout/STMPE-keypad.kl \
   $(LOCAL_PATH)/config/tc3589x-keypad.kl:system/usr/keylayout/tc3589x-keypad.kl \
   $(LOCAL_PATH)/config/ux500-ske-keypad.kl:system/usr/keylayout/ux500-ske-keypad.kl \
   $(LOCAL_PATH)/config/ux500-ske-keypad-qwertz.kl:system/usr/keylayout/ux500-ske-keypad-qwertz.kl \
   $(LOCAL_PATH)/config/sensor00_f11_sensor0.idc:system/usr/idc/sensor00_f11_sensor0.idc \
   $(LOCAL_PATH)/config/synaptics_rmi4_i2c.idc:system/usr/idc/synaptics_rmi4_i2c.idc

# Misc configuration files
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/button_light_curve.cfg:system/etc/button_light_curve.cfg \
   $(LOCAL_PATH)/config/cflashlib.cfg:system/etc/cflashlib.cfg \
   $(LOCAL_PATH)/config/flashled_param_config.cfg:system/etc/flashled_param_config.cfg \
   $(LOCAL_PATH)/config/dash.conf:system/etc/dash.conf

# patched JB cn_binary
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/cn_server:system/bin/cn_server

# Barometar permissions
PRODUCT_COPY_FILES += \
   frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml

# Android kind of memory
PRODUCT_PROPERTY_OVERRIDES += ro.build.characteristics=nosdcard

# PC Companion kind of memory
PRODUCT_PROPERTY_OVERRIDES += ro.semc.product.user_storage=emmc_only

# NFC Support
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/config/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/config/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# TWRP
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/config/twrp.fstab:recovery/root/etc/twrp.fstab

# Inhert dalvik heap values from aosp
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# Inhert vendor proprietary files
$(call inherit-product-if-exists, vendor/sony/nypon/nypon-vendor.mk)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.hwui.texture_cache_size=11 \
  ro.hwui.layer_cache_size=9 \
  ro.hwui.path_cache_size=3 \
  ro.sf.lcd_density=240

# Hardware video codecs configurations
PRODUCT_PROPERTY_OVERRIDES += \
  ste.video.dec.mpeg4.in.size=8192 \
  ste.video.enc.out.buffercnt=5 \
  ste.video.dec.recycle.delay=1 \
  ste.special_fast_dormancy=false \
  ste.video.decoder.max.hwmem=0x3600000 \
  ste.video.decoder.max.res=1080p \
  ste.video.decoder.h264.max.lev=4.2

PRODUCT_PROPERTY_OVERRIDES += \
  ro.service.swiqi.supported=false \
  persist.service.swiqi.enable=0

# NFC
PRODUCT_PROPERTY_OVERRIDES += \
  ro.nfc.on.default=false \
  ro.nfc.se.sim.enable=true \
  ro.nfc.se.smx.enable=false \
  ro.nfc.icon.enable=true \
  ro.nfc.vendor.name=nxp

# System props for SOLS
PRODUCT_PROPERTY_OVERRIDES += \
  ro.semc.sols.product-code=105 \
  ro.semc.sols.company-code=5

# OTA Updater
PRODUCT_PROPERTY_OVERRIDES += otaupdater.otaid=buildid
PRODUCT_PROPERTY_OVERRIDES += otaupdater.otaver=buildver
PRODUCT_PROPERTY_OVERRIDES += otaupdater.otatime=buildtime
PRODUCT_PACKAGES += OTAUpdater
