# Defines a list of toolchain information.

TOOLCHAIN_PLATFORM        = "platform"
TOOLCHAIN_HOST_OS         = "host_os"
TOOLCHAIN_TARGET_OS       = "target_os"
TOOLCHAIN_TARGET_CPU      = "target_cpu"
TOOLCHAIN_COMPILER_ROOT   = "compiler_root"
TOOLCHAIN_COMPILER_PREFIX = "compiler_prefix"
TOOLCHAIN_CC_COMPILER     = "cc_compiler"
TOOLCHAIN_INCLUDE_PATHS   = "include_paths"

toolchain_list = (
    {
        TOOLCHAIN_PLATFORM: "linux_arm_on_linux",
        TOOLCHAIN_HOST_OS: "linux",
        TOOLCHAIN_TARGET_OS: "linux",
        TOOLCHAIN_TARGET_CPU: "arm",
        TOOLCHAIN_COMPILER_ROOT: "/usr/local/arm-linux-gnueabihf/bin/",
        TOOLCHAIN_COMPILER_PREFIX: "arm-linux-gnueabihf-",
        TOOLCHAIN_CC_COMPILER: "g++",
        TOOLCHAIN_INCLUDE_PATHS: [
            "/usr/local/arm-linux-gnueabihf/include",
            "/usr/local/arm-linux-gnueabihf/arm-linux-gnueabihf/include",
            "/usr/local/arm-linux-gnueabihf/arm-linux-gnueabihf/libc/usr/include",
            "/usr/local/arm-linux-gnueabihf/lib/gcc/arm-linux-gnueabihf/7.5.0/include"
        ],
    },
)
