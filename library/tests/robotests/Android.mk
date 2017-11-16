LOCAL_PATH := $(call my-dir)

############################################################
# CarSetupWizardLib app just for Robolectric test target.  #
############################################################
include $(CLEAR_VARS)

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res

LOCAL_PACKAGE_NAME := CarSetupWizardLib
LOCAL_MODULE_TAGS := optional

LOCAL_USE_AAPT2 := true

LOCAL_PRIVILEGED_MODULE := true

LOCAL_STATIC_ANDROID_LIBRARIES := \
    android-support-v7-appcompat \
    android-support-v7-recyclerview

include frameworks/opt/car/setupwizard/library/common.mk

include $(BUILD_PACKAGE)

#############################################
# Car Setup Wizard Library Robolectric test target. #
#############################################
include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(call all-java-files-under, src)

# Include the testing libraries (JUnit4 + Robolectric libs).
LOCAL_STATIC_JAVA_LIBRARIES := \
    truth-prebuilt \
    mockito-robolectric-prebuilt

LOCAL_JAR_EXCLUDE_FILES := none

LOCAL_JAVA_LIBRARIES := \
    junit \
    platform-robolectric-3.4.2-prebuilt \
    sdk_vcurrent

LOCAL_INSTRUMENTATION_FOR := CarSetupWizardLib
LOCAL_MODULE := CarSetupWizardLibRoboTests

LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_JAVA_LIBRARY)

#############################################################
# Car Setup Wizard Library runner target to run the previous target. #
#############################################################
include $(CLEAR_VARS)

LOCAL_MODULE := RunCarSetupWizardLibRoboTests

LOCAL_SDK_VERSION := current

LOCAL_STATIC_JAVA_LIBRARIES := \
    CarSetupWizardLibRoboTests

LOCAL_TEST_PACKAGE := CarSetupWizardLib

LOCAL_ROBOTEST_FILES := $(filter-out %/BaseRobolectricTest.java,\
    $(call find-files-in-subdirs,$(LOCAL_PATH)/src,*Test.java,.))

#Require Robolectric 3.4.2 since the min-SDK target is 24
include prebuilts/misc/common/robolectric/3.4.2/run_robotests.mk