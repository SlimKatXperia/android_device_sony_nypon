$(call inherit-product, device/sony/nypon/nypon.mk)

# Inherit Slim common GSM stuff.
$(call inherit-product, vendor/slim/config/gsm.mk)

# Inherit Slim common Phone stuff.
$(call inherit-product, vendor/slim/config/common_full_phone.mk)

# Enhanced NFC
$(call inherit-product, vendor/slim/config/nfc_enhanced.mk)

PRODUCT_NAME := slim_nypon
PRODUCT_DEVICE := nypon
PRODUCT_BRAND := Sony
PRODUCT_MANUFACTURER := Sony
PRODUCT_MODEL := Xperia P
