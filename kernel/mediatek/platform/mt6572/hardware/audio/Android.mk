# Copyright Statement:
#
# This software/firmware and related documentation ("MediaTek Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to MediaTek Inc. and/or its licensors.
# Without the prior written permission of MediaTek inc. and/or its licensors,
# any reproduction, modification, use or disclosure of MediaTek Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.
#
# MediaTek Inc. (C) 2010. All rights reserved.
#
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
# RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
# AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
# AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
# The following software/firmware and/or related documentation ("MediaTek Software")
# have been modified by MediaTek Inc. All revisions are subject to any receiver's
# applicable license agreements with MediaTek Inc.

#  only if use yusu audio will build this.
ifeq ($(strip $(BOARD_USES_MTK_AUDIO)),true)

LOCAL_PATH:= $(call my-dir)
LOCAL_COMMON_PATH:=../../../common

include $(CLEAR_VARS)

LOCAL_CFLAGS += -DMTK_AUDIO

ifeq ($(AUDIO_POLICY_TEST),true)
  ENABLE_AUDIO_DUMP := true
endif

ifeq ($(strip $(TARGET_BUILD_VARIANT)),eng)
  LOCAL_CFLAGS += -DDEBUG_AUDIO_PCM
endif

ifeq ($(strip $(MTK_PLATFORM)),MT6572)
  LOCAL_CFLAGS += -DMT6572
endif

ifeq ($(MTK_DIGITAL_MIC_SUPPORT),yes)
  LOCAL_CFLAGS += -DMTK_DIGITAL_MIC_SUPPORT
endif

ifeq ($(strip $(MTK_AUDENH_SUPPORT)),yes)
  LOCAL_CFLAGS += -DMTK_AUDENH_SUPPORT
endif

ifeq ($(strip $(MTK_2IN1_SPK_SUPPORT)),yes)
  LOCAL_CFLAGS += -DUSING_2IN1_SPEAKER
endif

ifeq ($(strip $(MTK_USE_ANDROID_MM_DEFAULT_CODE)),yes)
  LOCAL_CFLAGS += -DANDROID_DEFAULT_CODE
endif

ifeq ($(strip $(DMNR_TUNNING_AT_MODEMSIDE)),yes)
  LOCAL_CFLAGS += -DDMNR_TUNNING_AT_MODEMSIDE
endif

LOCAL_GENERATE_CUSTOM_FOLDER := custom:hal/audioflinger

-include $(TOPDIR)$(MTK_PATH_SOURCE)/hardware/mtk/audio/mtk_cust.mk

$(warning $(TOPDIR))

LOCAL_C_INCLUDES:= \
    ./$(TOPDIR)/mediatek/frameworks-ext/av \
    $(TOPDIR)/hardware/libhardware_legacy/include \
    $(TOPDIR)/frameworks/av/include \
    $(call include-path-for, audio-utils) \
	$(call include-path-for, audio-effects) \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/aud_drv \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/include \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/speech_driver \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio \
    $(MTK_PATH_PLATFORM)/hardware/audio/aud_drv \
    $(MTK_PATH_PLATFORM)/hardware/audio/include \
    $(MTK_PATH_PLATFORM)/hardware/audio/speech_driver \
    $(MTK_PATH_PLATFORM)/hardware/audio \
    $(MTK_PATH_SOURCE)/external/nvram/libnvram \
    $(MTK_PATH_SOURCE)/external/AudioCompensationFilter \
    $(MTK_PATH_SOURCE)/external/cvsd_plc_codec \
    $(MTK_PATH_SOURCE)/frameworks/av/include/media \
    $(MTK_PATH_SOURCE)/frameworks-ext/av/include/media \
    $(MTK_PATH_SOURCE)/frameworks-ext/av/include \
    $(MTK_PATH_SOURCE)/frameworks/av/include \
    $(MTK_PATH_SOURCE)/external/audiodcremoveflt \
    $(MTK_PATH_SOURCE)/external/audiocustparam \
    $(MTK_PATH_SOURCE)/external/AudioSpeechEnhancement/inc \
    $(MTK_PATH_SOURCE)/external/aee/binary/inc \
    $(MTK_PATH_SOURCE)/kernel/include \
    $(LOCAL_PATH)/custom \
    $(LOCAL_PATH)/custom/audio

LOCAL_SRC_FILES+= \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioHardwareGeneric.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioHardwareStub.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioHardwareInterface.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/audio_hw_hal.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioAnalogControlFactory.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioAnalogFactory.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioDigitalControlFactory.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioMTKStreamManager.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioMTKStreamInClient.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioResourceFactory.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioStreamAttribute.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioUtility.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioVolumeFactory.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioMTKHeadsetMessager.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioSpeechEnhanceInfo.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioSpeechEnhLayer.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioPreProcess.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioVUnlockDL.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/aud_drv/AudioBTCVSDControl.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/speech_driver/SpeechDriverFactory.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/speech_driver/SpeechDriverLAD.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/speech_driver/SpeechMessengerCCCI.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/speech_driver/SpeechEnhancementController.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/speech_driver/SpeechBGSPlayer.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/speech_driver/SpeechPcm2way.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/speech_driver/SpeechVMRecorder.cpp \
    aud_drv/AudioAfeReg.cpp \
    aud_drv/AudioAnalogReg.cpp \
    aud_drv/AudioAnalogControl.cpp \
    aud_drv/AudioAnalogControlExt.cpp \
    aud_drv/AudioPlatformDevice.cpp \
    aud_drv/AudioMachineDevice.cpp \
    aud_drv/AudioDigitalControl.cpp \
    aud_drv/AudioInterConnection.cpp \
    aud_drv/AudioMTKHardware.cpp \
    aud_drv/AudioMTKStreamIn.cpp \
    aud_drv/AudioMTKStreamInManager.cpp \
    aud_drv/AudioMTKStreamOut.cpp \
    aud_drv/AudioMTKVolumeController.cpp \
    aud_drv/AudioResourceManager.cpp \
    aud_drv/AudioFtm.cpp \
    aud_drv/AudioParamTuning.cpp \
    aud_drv/AudioLoopbackController.cpp \
    aud_drv/LoopbackManager.cpp \
    speech_driver/SpeechPhoneCallController.cpp \
    speech_driver/SpeechLoopbackController.cpp

ifeq ($(ENABLE_AUDIO_DUMP),true)
  LOCAL_SRC_FILES += AudioDumpInterface.cpp
  LOCAL_CFLAGS += -DENABLE_AUDIO_DUMP
endif

ifeq ($(strip $(MTK_TTY_SUPPORT)),yes)
  LOCAL_CFLAGS += -DMTK_TTY_SUPPORT
endif

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper \
    libaudiodcrflt

LOCAL_SHARED_LIBRARIES += \
    libmedia \
    libcutils \
    libutils \
    libbinder \
    libhardware_legacy \
    libhardware \
    libblisrc \
    libdl \
    libnvram \
    libspeech_enh_lib \
    libpowermanager \
    libaudiocustparam \
    libaudiosetting \
    libaudiocompensationfilter \
    libcvsd_mtk \
    libaed \
    libaudioutils

	
ifeq ($(MTK_DUAL_MIC_SUPPORT),yes)
  LOCAL_CFLAGS += -DMTK_DUAL_MIC_SUPPORT
endif

ifeq ($(MTK_WB_SPEECH_SUPPORT),yes)
  LOCAL_CFLAGS += -DMTK_WB_SPEECH_SUPPORT
endif

ifeq ($(strip $(MTK_FM_SUPPORT)),yes)
    ifeq ($(strip $(MTK_FM_TX_SUPPORT)),yes)
        ifeq ($(strip $(MTK_FM_TX_AUDIO)),FM_DIGITAL_OUTPUT)
            LOCAL_CFLAGS += -DFM_DIGITAL_OUT_SUPPORT
        endif
        ifeq ($(strip $(MTK_FM_TX_AUDIO)),FM_ANALOG_OUTPUT)
            LOCAL_CFLAGS += -DFM_ANALOG_OUT_SUPPORT
        endif
    endif
    ifeq ($(strip $(MTK_FM_RX_SUPPORT)),yes)
        ifeq ($(strip $(MTK_FM_RX_AUDIO)),FM_DIGITAL_INPUT)
            LOCAL_CFLAGS += -DFM_DIGITAL_IN_SUPPORT
        endif
        ifeq ($(strip $(MTK_FM_RX_AUDIO)),FM_ANALOG_INPUT)
            LOCAL_CFLAGS += -DFM_ANALOG_IN_SUPPORT
        endif
    endif
endif

ifeq ($(HAVE_MATV_FEATURE),yes)
    LOCAL_CFLAGS += -DMATV_AUDIO_SUPPORT
endif

ifeq ($(MTK_ENABLE_MD1),yes)
  LOCAL_CFLAGS += -DMTK_ENABLE_MD1
endif

ifeq ($(MTK_ENABLE_MD2),yes)
  LOCAL_CFLAGS += -DMTK_ENABLE_MD2
endif

ifeq ($(MTK_DUAL_MIC_SUPPORT),yes)
  LOCAL_CFLAGS += -DMTK_DUAL_MIC_SUPPORT
endif

ifeq ($(MTK_WB_SPEECH_SUPPORT),yes)
  LOCAL_CFLAGS += -DMTK_WB_SPEECH_SUPPORT
endif

ifeq ($(MTK_BT_SUPPORT),yes)
  ifeq ($(MTK_BT_PROFILE_A2DP),yes)
  LOCAL_CFLAGS += -DWITH_A2DP
  endif
else
  ifeq ($(strip $(BOARD_HAVE_BLUETOOTH)),yes)
    LOCAL_CFLAGS += -DWITH_A2DP
  endif  
endif

# SRS Processing
ifeq ($(strip $(HAVE_SRSAUDIOEFFECT_FEATURE)),yes)
LOCAL_CFLAGS += -DHAVE_SRSAUDIOEFFECT
endif
# SRS Processing

# Audio HD Record
ifeq ($(MTK_AUDIO_HD_REC_SUPPORT),yes)
    LOCAL_CFLAGS += -DMTK_AUDIO_HD_REC_SUPPORT
endif
# Audio HD Record

# Native Audio Preprocess
ifeq ($(strip $(NATIVE_AUDIO_PREPROCESS_ENABLE)),yes)
    LOCAL_CFLAGS += -DNATIVE_AUDIO_PREPROCESS_ENABLE
endif
# Native Audio Preprocess

#Temp tag for FM support WIFI-Display output
LOCAL_CFLAGS += -DMTK_FM_SUPPORT_WFD_OUTPUT

LOCAL_ARM_MODE := arm
LOCAL_MODULE := libaudio.primary.default
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)


# The default audio policy, for now still implemented on top of legacy
# policy code
include $(CLEAR_VARS)
  
LOCAL_CFLAGS += -DMTK_AUDIO  
ifeq ($(HAVE_MATV_FEATURE),yes)
    LOCAL_CFLAGS += -DMATV_AUDIO_SUPPORT
endif

ifeq ($(DISABLE_EARPIECE),yes)
    LOCAL_CFLAGS += -DDISABLE_EARPIECE
endif

ifeq ($(strip $(MTK_USE_ANDROID_MM_DEFAULT_CODE)),yes)
  LOCAL_CFLAGS += -DANDROID_DEFAULT_CODE
endif

LOCAL_C_INCLUDES:= \
    ./$(TOPDIR)/mediatek/frameworks-ext/av \
    $(TOPDIR)/hardware/libhardware_legacy/include \
    $(TOPDIR)/frameworks/av/include \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/aud_drv \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/include \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/speech_driver \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio \
    $(MTK_PATH_PLATFORM)/hardware/audio/aud_drv \
    $(MTK_PATH_PLATFORM)/hardware/audio/include \
    $(MTK_PATH_PLATFORM)/hardware/audio/speech_driver \
    $(MTK_PATH_PLATFORM)/hardware/audio \
    $(MTK_PATH_SOURCE)/external/nvram/libnvram \
    $(MTK_PATH_SOURCE)/external/AudioCompensationFilter \
    $(MTK_PATH_SOURCE)/external/HeadphoneCompensationFilter \
    $(MTK_PATH_SOURCE)/external/audiocustparam \
    $(MTK_PATH_SOURCE)/frameworks/av/include/media \
    $(MTK_PATH_SOURCE)/frameworks/av/include \
    $(MTK_PATH_SOURCE)/frameworks-ext/av/include/media \
    $(MTK_PATH_SOURCE)/frameworks-ext/av/include \
    $(MTK_PATH_SOURCE)/external/audiodcremoveflt \
    $(MTK_PATH_SOURCE)/external/aee/binary/inc \
    $(MTK_PATH_SOURCE)/kernel/include \
    $(LOCAL_PATH)/custom \
    $(LOCAL_PATH)/custom/audio

LOCAL_SRC_FILES := \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioPolicyManagerBase.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioPolicyCompatClient.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/audio_policy_hal.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioPolicyManagerDefault.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioMTKPolicyManager.cpp

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libmedia \
    libaudiosetting \
    libaed \
    libaudiocustparam

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper

LOCAL_MODULE := audio_policy.default
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional

ifeq ($(MTK_BT_SUPPORT),yes)
  ifeq ($(MTK_BT_PROFILE_A2DP),yes)
  LOCAL_CFLAGS += -DWITH_A2DP
  endif
else
  ifeq ($(strip $(BOARD_HAVE_BLUETOOTH)),yes)
    LOCAL_CFLAGS += -DWITH_A2DP
  endif  
endif

ifeq ($(HAVE_MATV_FEATURE),yes)
    LOCAL_CFLAGS += -DMATV_AUDIO_SUPPORT
endif

ifeq ($(strip $(MTK_FM_SUPPORT)),yes)
    ifeq ($(strip $(MTK_FM_TX_SUPPORT)),yes)
        ifeq ($(strip $(MTK_FM_TX_AUDIO)),FM_DIGITAL_OUTPUT)
            LOCAL_CFLAGS += -DFM_DIGITAL_OUT_SUPPORT
        endif
        ifeq ($(strip $(MTK_FM_TX_AUDIO)),FM_ANALOG_OUTPUT)
            LOCAL_CFLAGS += -DFM_ANALOG_OUT_SUPPORT
        endif
    endif
    ifeq ($(strip $(MTK_FM_RX_SUPPORT)),yes)
        ifeq ($(strip $(MTK_FM_RX_AUDIO)),FM_DIGITAL_INPUT)
            LOCAL_CFLAGS += -DFM_DIGITAL_IN_SUPPORT
        endif
        ifeq ($(strip $(MTK_FM_RX_AUDIO)),FM_ANALOG_INPUT)
            LOCAL_CFLAGS += -DFM_ANALOG_IN_SUPPORT
        endif
    endif
endif

ifeq ($(HAVE_MATV_FEATURE),yes)
    ifeq ($(MTK_MATV_ANALOG_SUPPORT),yes)
        LOCAL_CFLAGS += -DMATV_AUDIO_LINEIN_PATH
    endif
endif

#Temp tag for FM support WIFI-Display output
LOCAL_CFLAGS += -DMTK_FM_SUPPORT_WFD_OUTPUT

include $(BUILD_SHARED_LIBRARY)

# The a2dp hardware interface
include $(CLEAR_VARS)

ifeq ($(strip $(TARGET_BUILD_VARIANT)),eng)
  LOCAL_CFLAGS += -DDEBUG_AUDIO_PCM
endif

LOCAL_CFLAGS += -DMTK_AUDIO  

ifeq ($(strip $(MTK_USE_ANDROID_MM_DEFAULT_CODE)),yes)
  LOCAL_CFLAGS += -DANDROID_DEFAULT_CODE
endif

LOCAL_C_INCLUDES:= \
    ./$(TOPDIR)/mediatek/frameworks-ext/av \
    $(TOPDIR)/hardware/libhardware_legacy/include \
    $(TOPDIR)/frameworks/av/include \
    $(call include-path-for, audio-utils) \
	$(call include-path-for, audio-effects) \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/aud_drv \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/include \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio/speech_driver \
    $(MTK_PATH_SOURCE)/platform/common/hardware/audio \
    $(MTK_PATH_PLATFORM)/hardware/audio/aud_drv \
    $(MTK_PATH_PLATFORM)/hardware/audio/include \
    $(MTK_PATH_PLATFORM)/hardware/audio/speech_driver \
    $(MTK_PATH_PLATFORM)/hardware/audio \
    $(MTK_PATH_SOURCE)/external/nvram/libnvram \
    $(MTK_PATH_SOURCE)/external/AudioCompensationFilter \
    $(MTK_PATH_SOURCE)/external/HeadphoneCompensationFilter \
    $(MTK_PATH_SOURCE)/frameworks/av/include/media \
    $(MTK_PATH_SOURCE)/frameworks/av/include \
    $(MTK_PATH_SOURCE)/frameworks-ext/av/include/media \
    $(MTK_PATH_SOURCE)/frameworks-ext/av/include \
    $(MTK_PATH_SOURCE)/external/audiodcremoveflt \
    $(MTK_PATH_SOURCE)/external/AudioSpeechEnhancement/inc \
    $(MTK_PATH_SOURCE)/external/audiocustparam \
    $(MTK_PATH_SOURCE)/external/cvsd_plc_codec \
    $(MTK_PATH_SOURCE)/external/aee/binary/inc \
    $(MTK_PATH_SOURCE)/kernel/include

LOCAL_SRC_FILES+= \
    $(LOCAL_COMMON_PATH)/hardware/audio/A2dpAudioInterface.cpp\
    $(LOCAL_COMMON_PATH)/hardware/audio/a2dpaudio_hw_hal.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioHardwareGeneric.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioHardwareStub.cpp \
    $(LOCAL_COMMON_PATH)/hardware/audio/AudioHardwareInterface.cpp

LOCAL_STATIC_LIBRARIES := \
    libmedia_helper

LOCAL_SHARED_LIBRARIES += \
    libmedia \
    libcutils \
    libutils \
    libbinder \
    libhardware_legacy \
    libhardware \
    libaed \
    libaudio.primary.default

ifeq ($(MTK_BT_SUPPORT),yes)
    ifeq ($(MTK_BT_PROFILE_A2DP),yes)
        LOCAL_SHARED_LIBRARIES += libmtkbtextadpa2dp
        LOCAL_CFLAGS += -DWITH_BLUETOOTH -D__BTMTK__
        LOCAL_CFLAGS += -DWITH_A2DP
        MTK_BT_PATH := $(TOP)/frameworks/bluetooth/blueangel
        LOCAL_C_INCLUDES += $(call include-path-for, bluez) $(MTK_BT_PATH)/btadp_ext/include
    endif
else
    ifeq ($(BOARD_HAVE_BLUETOOTH),true)
        LOCAL_SHARED_LIBRARIES += liba2dp
        LOCAL_CFLAGS += -DWITH_BLUETOOTH
        LOCAL_CFLAGS += -DWITH_A2DP
        LOCAL_C_INCLUDES += $(call include-path-for, bluez)    
    endif
endif

LOCAL_ARM_MODE := arm
LOCAL_MODULE := libaudio.a2dp.default
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

endif
