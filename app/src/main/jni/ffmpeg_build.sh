#!/bin/bash

#!/bin/bash
NDK=/Users/wyl/ndk/android-ndk-r10d

# PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
# PLATFORM=$NDK/platforms/android-14/arch-arm




# 新建
#!/bin/bash
#不同架构的相关设置

#ABI 脚本
#填写配置清单

ANDROID_ABI=arm
# ANDROID_ABI=x86
#ANDROID_ABI=x86_64
# ANDROID_ABI=mips
#ANDROID_ABI=mips64
# ANDROID_ABI=arm64-v8a
# ANDROID_ABI=armeabi-v7a
#ANDROID_ABI=arm

# NDK的路径，根据自己的安装位置进行设置
NDK=/Users/wyl/ndk/android-ndk-r10d

# Toolchains 的版本
GCCVER=4.9

# cpu名
cpu=armv7-a
# cpu=x86
# cpu=armv8-a
# cpu=mips

#编译适配的最低版本
ANDROID_API=android-17

#填写配置完成

#注意 注意库文件的连接顺序，在libavcodec 内会引用libavformat 的函数，如果把libavformat 放在libavcodec的后面， 会导致链接失败。

# Set up ABI variables
if [ "${ANDROID_ABI}" = "x86" ] ; then
    TARGET_TUPLE="i686-linux-android"
    PATH_HOST="x86"
    PLATFORM_SHORT_ARCH="x86"
elif [ "${ANDROID_ABI}" = "x86_64" ] ; then
    TARGET_TUPLE="x86_64-linux-android"
    PATH_HOST="x86_64"
    PLATFORM_SHORT_ARCH="x86_64"
    HAVE_64=1
elif [ "${ANDROID_ABI}" = "mips" ] ; then
    TARGET_TUPLE="mipsel-linux-android"
    PATH_HOST=$TARGET_TUPLE
    PLATFORM_SHORT_ARCH="mips"
elif [ "${ANDROID_ABI}" = "mips64" ] ; then
    TARGET_TUPLE="mips64el-linux-android"
    PATH_HOST=$TARGET_TUPLE
    PLATFORM_SHORT_ARCH="mips64"
    HAVE_64=1
elif [ "${ANDROID_ABI}" = "arm64-v8a" ] ; then
    TARGET_TUPLE="aarch64-linux-android"
    PATH_HOST=$TARGET_TUPLE
    HAVE_ARM=1
    HAVE_64=1
    PLATFORM_SHORT_ARCH="arm64"
elif [ "${ANDROID_ABI}" = "armeabi-v7a" -o "${ANDROID_ABI}" = "armeabi" ] ; then
    TARGET_TUPLE="arm-linux-androideabi"
    PATH_HOST=$TARGET_TUPLE
    HAVE_ARM=1
    PLATFORM_SHORT_ARCH="arm"
elif [ "${ANDROID_ABI}" = "arm" -o "${ANDROID_ABI}" = "armeabi" ] ; then
    TARGET_TUPLE="arm-linux-androideabi"
    PATH_HOST=$TARGET_TUPLE
    HAVE_ARM=1
    PLATFORM_SHORT_ARCH="arm"
else
    echo "Unknown ABI: '${ANDROID_ABI}'. Die, die, die!"
    exit 2
fi


# 编译针对的平台，可以根据自己的需求进行设置
# 这里选择最低支持android-14, arm架构，生成的so库是放在
# libs/armeabi文件夹下的，若针对x86架构，要选择arch-x86
# PLATFORM=${NDK}/platforms/${ANDROID_API}/arch-${PLATFORM_SHORT_ARCH}

# 工具链的路径，根据编译的平台不同而不同
# arm-linux-androideabi-4.9与上面设置的PLATFORM对应，4.9为工具的版本号，
# 根据自己安装的NDK版本来确定，一般使用最新的版本

#PREBUILT=$NDK/toolchains/${PATH_HOST}-${GCCVER}/prebuilt/linux-x86_64/bin

#工具目录
PREBUILT=`echo ${NDK}/toolchains/${PATH_HOST}-${GCCVER}/prebuilt/\`uname|tr A-Z a-z\`-*/bin/`
# PREBUILT=`echo ${NDK}/toolchains/${PATH_HOST}-${GCCVER}/prebuilt/windows-x86_64/bin/`



# PREBUILT=$NDK/toolchains/${PATH_HOST}-${GCCVER}/prebuilt/darwin-x86_64

echo "----------------ffmepg PREBUILT--------------------------"+$PREBUILT


PLATFORM=$NDK/platforms/${ANDROID_API}/arch-${PLATFORM_SHORT_ARCH}
# PLATFORM=$NDK/platforms/${ANDROID_API}/arch-x86



#里面的各种编译工具
CROSS_COMPILE=${PREBUILT}${TARGET_TUPLE}-

CCPATH=${CROSS_COMPILE}gcc
# CCPATH=$PREBUILT/bin/arm-linux-androideabi-gcc 

CROSSPATH=${CROSS_COMPILE}

NMPATH=${CROSS_COMPILE}nm

FFMEPGBUILD1=${CROSS_COMPILE}ar

FFMEPGBUILD2=${CROSS_COMPILE}ar

echo "----------------ffmepg configure--------------------------"+$PREBUILT
echo "----------------ffmepg configure--------------------------"+$PLATFORM

echo "----------------ffmepg configure--------------------------"+$PREBUILT
echo "----------------ffmepg configure--------------------------"+$PLATFORM

# 

function build_one
{
echo "----------------ffmepg configure--------------------------"
./configure \
  `_="1 标准选项"` \
    --prefix=$PREFIX \
  `_="2 授权选项"` \
    --enable-gpl \
    --enable-version3 \
  `_="3 编译配置选项,别用--disable-all"` \
    --disable-shared \
    --enable-static \
    --enable-small \
  `_="4 编译可执行程序的选项"` \
    --disable-programs  \
    --enable-ffmpeg \
  `_="5 生成文档选项"` \
    --disable-doc \
  `_="6 编译库选项，这里9个库，5个不用编译，4个编译"` \
    --disable-avdevice \
    --disable-postproc\
    --disable-swscale \
    --disable-avresample \
    --disable-network \
    --disable-yasm \
  `_="7 硬件加速组建配置"` \
  `_="8 独立指定每个组件的具体item的可用性"` \
  `_="9 外部库选项"` \
  `_="10 编译选项,制定cpu架构，cpu名，引用库等"` \
    --target-os=linux \
    --arch=$ANDROID_ABI \
    --cpu=$cpu \
    --enable-cross-compile \
    --cc=$CCPATH \
    --cross-prefix=$CROSS_COMPILE \
    --nm=$NMPATH \
    --sysroot=$PLATFORM \
    --pkg-config=pkg-config \
    --extra-cflags="-fpic -DANDROID -DHAVE_SYS_UIO_H=1 -I${LIB_INC} -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums  -fno-strict-aliasing -finline-limit=300 $OPTIMIZE_CFLAGS " \
    --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L$LIB_LIB -nostdlib -lc -lm -ldl -llog  $PLATFORM/usr/lib/crtbegin_dynamic.o $PLATFORM/usr/lib/crtend_android.o " \
    --extra-libs="-lgcc " \
  `_="12 优化选项"` \
    --enable-asm \
  `_="13 ffmpeg开发者选项"` \
    --disable-stripping \
  `_="自己根据不同的cpu加的单独列出的选项"` \
  $ADDITIONAL_CONFIGURE_FLAG || exit 1
    
sed -i "s/HAVE_LOG2 1/HAVE_LOG2 0/g" config.h
sed -i "s/HAVE_LOG2F 1/HAVE_LOG2F 0/g" config.h
sed -i "s/HAVE_LOG10F 1/HAVE_LOG10F 0/g" config.h

echo "----------------ffmepg build 1--------------------------"
sudo make clean || exit 1
sudo make  -j4 install || exit 1
echo "----------------ffmepg build 2 --------------------------"
sudo $FFMEPGBUILD1 d libavcodec/libavcodec.a inverse.o || exit 1
sudo $FFMEPGBUILD2 rcs $PREFIX/lib/libffmpeg.a cmdutils.o ffmpeg_filter.o ffmpeg_opt.o  ffmpeg.o|| exit 1
}

# # CPU=x86
CPU=$cpu
# CPU=one



# arm
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=neon -marm -march=$CPU -mtune=cortex-a9 -Os -fno-ident -fdata-sections -ffunction-sections -fomit-frame-pointer"

# x86
  # OPTIMIZE_CFLAGS="-march=atom -ffast-math -msse3 -mfpmath=sse -march=i686 -Os -fno-ident -fdata-sections -ffunction-sections -fomit-frame-pointer"


PREFIX=$(pwd)/../out_2.7/${CPU}-neon
LIB_INC="${PREFIX}/include"
LIB_LIB="${PREFIX}/lib"
export PKG_CONFIG_LIBDIR=$PREFIX/lib/pkgconfig
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
ADDITIONAL_CONFIGURE_FLAG="--enable-neon --disable-debug"
# ADDITIONAL_CONFIGURE_FLAG=""

build_one
