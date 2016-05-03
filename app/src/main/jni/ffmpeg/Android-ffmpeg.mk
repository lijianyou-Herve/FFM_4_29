LOCAL_PATH		 				:=	$(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE				:= libavcodec
LOCAL_SRC_FILES				:= lib/libavcodec.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)
 
include $(CLEAR_VARS)
LOCAL_MODULE				:= libavformat
LOCAL_SRC_FILES				:= lib/libavformat.a
LOCAL_EXPORT_C_INCLUDES		:= $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)
 
include $(CLEAR_VARS)
LOCAL_MODULE				:= libavutil
LOCAL_SRC_FILES				:= lib/libavutil.a
LOCAL_EXPORT_C_INCLUDES		:= $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)
 
include $(CLEAR_VARS)
LOCAL_MODULE				:= libavfilter
LOCAL_SRC_FILES				:= lib/libavfilter.a
LOCAL_EXPORT_C_INCLUDES		:= $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)
 
include $(CLEAR_VARS)
LOCAL_MODULE				:= libswresample
LOCAL_SRC_FILES				:= lib/libswresample.a
LOCAL_EXPORT_C_INCLUDES		:= $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE				:= libffmpeg
LOCAL_SRC_FILES				:= lib/libffmpeg.a
LOCAL_EXPORT_C_INCLUDES		:= $(LOCAL_PATH)/include
include $(PREBUILT_STATIC_LIBRARY)
