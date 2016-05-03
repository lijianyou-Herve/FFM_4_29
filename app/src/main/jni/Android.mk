MY_LOCAL_PATH		 	:=	$(call my-dir)

LOCAL_PATH		 		:=	$(MY_LOCAL_PATH)
include $(LOCAL_PATH)/ffmpeg/Android-ffmpeg.mk

LOCAL_PATH		 		:=	$(MY_LOCAL_PATH)
include $(CLEAR_VARS)
LOCAL_MODULE	 		:=  audio_mixer
LOCAL_C_INCLUDES 		:=  $(LOCAL_PATH)
LOCAL_SRC_FILES			:= 	video-trimmer.cpp
							
LOCAL_CFLAGS			:= 	-D__STDC_CONSTANT_MACROS
LOCAL_STATIC_LIBRARIES  := 	libffmpeg libavformat libavfilter libswresample libavcodec libavutil
LOCAL_LDLIBS 	 		:= -lc -lm -lz -ldl -llog 
LOCAL_CPPFLAGS			:= -std=c++11 -frtti -fexceptions -fpermissive
include $(BUILD_SHARED_LIBRARY)


