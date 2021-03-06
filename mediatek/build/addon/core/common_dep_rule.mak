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

#################################################################
# for fm feature


ifeq (MT5192_FM, $(strip $(MTK_FM_CHIP)))
  ifeq (no, $(strip $(MTK_MT519X_FM_SUPPORT)))
    $(call dep-err-seta-or-setb,MTK_MT519X_FM_SUPPORT,yes,MTK_FM_CHIP,non MT519X_FM)
  endif
endif

ifeq (MT6620_FM, $(strip $(MTK_FM_CHIP)))
  ifeq (yes, $(strip $(MTK_MT519X_FM_SUPPORT)))
    $(call dep-err-seta-or-setb,MTK_MT519X_FM_SUPPORT,no,MTK_FM_CHIP,non MT6620_FM)
  endif
endif

#Mark for early porting
#ifeq (MT6620_FM, $(strip $(MTK_FM_CHIP)))
#  ifneq (mt6620, $(strip $(CUSTOM_KERNEL_FM)))
#    $(call dep-err-seta-or-setb,CUSTOM_KERNEL_FM,mt6620,MTK_FM_CHIP,MT6620_FM)
#  endif
#endif

ifeq (MT5192_FM, $(strip $(MTK_FM_CHIP)))
  ifneq (, $(strip $(CUSTOM_KERNEL_FM)))
    $(call dep-err-seta-or-setb,MTK_FM_CHIP,non MT5192_FM,CUSTOM_KERNEL_FM,)
  endif
endif

#################################################################
# for camera feature
#Mark for early porting
#ifneq ($(strip $(CUSTOM_HAL_CAMERA)), $(strip $(CUSTOM_KERNEL_CAMERA)))
#    $(call dep-err-seta-or-setb,CUSTOM_HAL_CAMERA,$(CUSTOM_KERNEL_CAMERA),CUSTOM_KERNEL_CAMERA,$(CUSTOM_HAL_CAMERA))
#endif

##################################################################
# dependency between AST TD modem & MMSYS1
##################################################################
ifeq (AST_TL1_TDD, $(strip $(MODEM_L1_3GSOLUTION)))
  ifneq (yes,$(strip $(MTK_ASTBSP_SUPPORT)))
    # MMSYS1 is required to be powered on when using AST TD modem
    # We, here, should reminder customer to change modem
    # NOT confuse them to change the option setting in modem.mk
    $(call dep-err-seta-or-onb,CUSTOM_MODEM,non $(CUSTOM_MODEM),MTK_ASTBSP_SUPPORT)
  endif
endif

##############################################################
# for resolution check

ifeq (MT6573,$(strip $(MTK_PLATFORM)))
  ifneq (,$(strip $(LCM_WIDTH)))
    ifeq ($(call gt,$(LCM_WIDTH),320),T)
      ifneq (,$(strip $(LCM_HEIGHT)))
        ifeq ($(call gt,$(LCM_HEIGHT),480),T)
          ifeq (2G,$(strip $(CUSTOM_DRAM_SIZE)))
            $(call dep-err-common, resolution should not be higher than HVGA(320*480) when CUSTOM_DRAM_SIZE=$(CUSTOM_DRAM_SIZE))
          endif
        endif
      endif
    endif
  endif
endif

##############################################################
# for MTK_GEMINI_3G_SWITCH
# Rule: When GEMINI = no, then MTK_GEMINI_3G_SWITCH = no.
# Rule: When EVB = yes, then MTK_GEMINI_3G_SWITCH = no.
# Rule: When MTK_MODEM_SUPPORT!=modem_3g (modem_3g_tdd/modem_3g_fdd), then MTK_GEMINI_3G_SWITCH = no.
# Rule: When GEMINI = yes, EVB=no and MTK_MODEM_SUPPORT=modem_3g, then MTK_GEMINI_3G_SWITCH =yes

ifeq (no,$(strip $(GEMINI)))
  ifeq (yes,$(strip $(MTK_GEMINI_3G_SWITCH)))
    $(call dep-err-common, please turn off MTK_GEMINI_3G_SWITCH when GEMINI=no)
  endif
endif

ifeq (yes,$(strip $(EVB)))
  ifeq (yes,$(strip $(MTK_GEMINI_3G_SWITCH)))
    $(call dep-err-common, please turn off MTK_GEMINI_3G_SWITCH when EVB=yes)
  endif
endif

#ifeq ($(findstring modem_3g,$(MTK_MODEM_SUPPORT)),)
#  ifeq (yes,$(strip $(MTK_GEMINI_3G_SWITCH)))
#    $(call dep-err-common, please turn off MTK_GEMINI_3G_SWITCH when MTK_MODEM_SUPPORT is not 3g)
#  endif
#endif

#ifeq (yes,$(strip $(GEMINI)))
#  ifeq (no,$(strip $(EVB)))
#    ifneq ($(findstring modem_3g,$(MTK_MODEM_SUPPORT)),)
#      ifeq (no,$(strip $(MTK_GEMINI_3G_SWITCH)))
#        $(call dep-err-common, please turn on MTK_GEMINI_3G_SWITCH when GEMINI=yes, EVB=no and MTK_MODEM_SUPPORT is modem_3g_tdd/modem_3g_fdd)
#      endif
#    endif
#  endif
#endif

##############################################################
# for share modem

ifeq (2,$(strip $(MTK_SHARE_MODEM_SUPPORT)))
  ifeq ($(call gt,$(MTK_SHARE_MODEM_CURRENT),2),T)
    $(call dep-err-common, please set MTK_SHARE_MODEM_CURRENT as 2 or 1 or 0 when MTK_SHARE_MODEM_SUPPORT=2)
  endif
endif

ifeq (1,$(strip $(MTK_SHARE_MODEM_SUPPORT)))
  ifeq ($(call gt,$(MTK_SHARE_MODEM_CURRENT),1),T)
    $(call dep-err-common, please set MTK_SHARE_MODEM_CURRENT as 1 or 0 when MTK_SHARE_MODEM_SUPPORT=1)
  endif
endif

ifneq ($(strip $(MTK_DT_SUPPORT)),yes)
  ifeq (yes,$(strip $(GEMINI)))
    ifneq (2,$(strip $(MTK_SHARE_MODEM_CURRENT)))
      $(call dep-err-common, please set MTK_SHARE_MODEM_CURRENT=2 when GEMINI=yes)
    endif
  endif
endif

ifeq (no,$(strip $(GEMINI)))
  ifneq (1,$(strip $(MTK_SHARE_MODEM_CURRENT)))
    $(call dep-err-common, please set MTK_SHARE_MODEM_CURRENT=1 when GEMINI=no)
  endif
endif

##############################################################
# for mtk sec modem

ifeq (yes,$(strip $(MTK_SEC_MODEM_AUTH)))
  ifeq (no,$(strip $(MTK_SEC_MODEM_ENCODE)))
    $(call dep-err-ona-or-offb, MTK_SEC_MODEM_ENCODE, MTK_SEC_MODEM_AUTH)
  endif
endif

