# Copyright (C) 2014 The XPerience Project
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# inherit from the proprietary version
-include vendor/motorola/msm8226-common/BoardConfigVendor.mk

LOCAL_PATH := device/motorola/msm8226-common

BOARD_VENDOR := motorola-qcom

TARGET_SPECIFIC_HEADER_PATH := device/motorola/msm8226-common/include

#Qcom Kernel Header
PRODUCT_VENDOR_KERNEL_HEADERS := hardware/qcom/msm8x26/kernel-headers

# Platform
TARGET_BOARD_PLATFORM 	  := msm8226
TARGET_BOARD_PLATFORM_GPU := qcom-adreno305

# Architecture
TARGET_ARCH 			     		 := arm
TARGET_ARCH_VARIANT 		     	 := armv7-a-neon
TARGET_CPU_ABI 		 	     		 := armeabi-v7a
TARGET_CPU_ABI2 		             := armeabi
TARGET_CPU_SMP 	 	 	   			 := true
TARGET_CPU_VARIANT 		    		 := krait
TARGET_USE_QCOM_BIONIC_OPTIMIZATION  := true
TARGET_USE_KINGFISHER_OPTIMIZATION   := true
ARCH_ARM_HAVE_TLS_REGISTER           := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8226
TARGET_NO_BOOTLOADER 	     := true

# Kernel
BOARD_KERNEL_CMDLINE      := console=ttyHSL0,115200,n8 earlyprintk androidboot.console=ttyHSL0 androidboot.hardware=qcom user_debug=30 msm_rtb.filter=0x37 vmalloc=400M utags.blkdev=/dev/block/platform/msm_sdcc.1/by-name/utags androidboot.write_protect=0 androidboot.selinux=permissive
BOARD_KERNEL_BASE         := 0x00000000
BOARD_KERNEL_PAGESIZE     := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS      := --ramdisk_offset 0x01000000 --tags_offset 0x00000100

WLAN_MODULES:
	mkdir -p $(KERNEL_MODULES_OUT)/pronto
	mv $(KERNEL_MODULES_OUT)/wlan.ko $(KERNEL_MODULES_OUT)/pronto/pronto_wlan.ko
	ln -sf /system/lib/modules/pronto/pronto_wlan.ko $(TARGET_OUT)/lib/modules/wlan.ko

TARGET_KERNEL_MODULES += WLAN_MODULES

# Audio
BOARD_USES_ALSA_AUDIO 	 	 	  			:= true
AUDIO_FEATURE_DISABLED_FM 		   			:= true
AUDIO_FEATURE_ENABLED_COMPRESS_CAPTURE	    := true
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP 	    := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS          := true
AUDIO_FEATURE_ENABLED_EXTN_POST_PROC        := true
AUDIO_FEATURE_ENABLED_FLUENCE		  		:= true
AUDIO_FEATURE_ENABLED_HFP 		   			:= true
AUDIO_FEATURE_ENABLED_INCALL_MUSIC	   		:= true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS  := true
AUDIO_FEATURE_ENABLED_PCM_OFFLOAD 	   		:= true
AUDIO_FEATURE_ENABLED_PCM_OFFLOAD_24	    := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE	   		:= true
AUDIO_FEATURE_ENABLED_USBAUDIO 	            := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH 	  := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT     := true

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true

# CMHW
BOARD_HARDWARE_CLASS := $(LOCAL_PATH)/cmhw/

# Display
BOARD_EGL_CFG := $(LOCAL_PATH)/configs/egl.cfg
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_USES_C2D_COMPOSITION     := true
TARGET_USES_ION 				:= true
USE_OPENGL_RENDERER 			:= true
COMMON_GLOBAL_CFLAGS 			+= -D_ION_HEAP_MASK_COMPATIBILITY_WA

# Encryption
TARGET_HW_DISK_ENCRYPTION := true

# FM
TARGET_QCOM_NO_FM_FIRMWARE := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Media
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# Motorola
TARGET_USES_MOTOROLA_LOG := true

# Power
TARGET_POWERHAL_VARIANT := qcom
CM_POWERHAL_EXTENSION := falcon

# Partitions
BOARD_FLASH_BLOCK_SIZE 	   := 131072

# Qualcomm support
COMMON_GLOBAL_CFLAGS 	 += -DQCOM_BSP
COMMON_GLOBAL_CFLAGS 	 += -DQCOM_HARDWARE
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_QCOM_BSP 	 := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT 	     := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4  	     := true
COMMON_GLOBAL_CFLAGS 		     += -DNO_SECURE_DISCARD
TARGET_RECOVERY_FSTYPE_MOUNT_OPTIONS := ext4=max_batch_time=0,commit=1,data=ordered,nobarrier,errors=panic,nodelalloc|f2fs=errors=recover
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
$(warning "USING F2FS for userdata")

# This ensures the needed build tools are available.
# TODO: make non-linux builds happy with external/f2fs-tool; system/extras/f2fs_utils
ifeq ($(HOST_OS),linux)
TARGET_USERIMAGES_USE_F2FS := true
endif

LOCAL_FORCE_STATIC_EXECUTABLE := true

# Vold
BOARD_VOLD_DISC_HAS_MULTIPLE_MAJORS := true
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR    := true
BOARD_VOLD_MAX_PARTITIONS 	    	:= 40
TARGET_USE_CUSTOM_LUN_FILE_PATH     := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# Wifi
BOARD_HAS_QCOM_WLAN 		 	 := true
BOARD_WLAN_DEVICE   		 	 := qcwcn
BOARD_HOSTAPD_DRIVER   		 	 := NL80211
BOARD_HOSTAPD_PRIVATE_LIB 	 	 := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_DRIVER 	 := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
WIFI_DRIVER_MODULE_PATH  	 	 := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME 	 	 := "wlan"
WPA_SUPPLICANT_VERSION 	  	 	 := VER_0_8_X

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

#Doug Lea's Mallog a Memory allocator
MALLOC_IMPL := dlmalloc

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
 ifeq ($(TARGET_BUILD_VARIANT),user)
 ifeq ($(WITH_DEXPREOPT),)
 WITH_DEXPREOPT := true
 WITH_DEXPREOPT_BOOT_IMG_ONLY := false
 endif
 endif
endif
WITH_DEXPREOPT_BOOT_IMG_ONLY ?= true

# Enable Minikin text layout engine (will be the default soon)
USE_MINIKIN := true

### Webkit and browser do not loose time on it remove if not maked a first build before
PRODUCT_PREBUILT_WEBVIEWCHROMIUM := yes

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

#EXPERIMENTAL FEATURES
#TARGET_LDPRELOAD := libNimsWrap.so

#Selinux
-include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
    device/motorola/msm8226-common/sepolicy

BOARD_SEPOLICY_UNION += \
    akmd8963.te \
    atvc.te \
    batt_health.te \
    device.te \
    file_contexts \
    file.te \
    init.te \
    init_shell.te \
    keystore.te \
    mediaserver.te \
    mm-qcamerad.te \
    mpdecision.te \
    platform_app.te \
    property_contexts \
    property.te \
    rild.te \
    rmt_storage.te \
    system_app.te \
    thermal-engine.te


#ril
#BOARD_RIL_CLASS := ../../../device/motorola/msm8226-common/ril/

#symlink the webchromium
#ln -sf out/target/product/falcon/system/lib/libwebviewchromium.so out/target/product/falcon/system/app/Webview/lib/arm/libwebviewchromium.so
webcrhom:
	ln -sf /system/lib/libwebviewchromium.so $(TARGET_OUT)/app/Webview/lib/arm/libwebviewchromium.so

TARGET_WEBVIEW += webcrhom


##config for neew recovery based on philz

