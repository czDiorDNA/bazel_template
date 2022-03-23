load("@rules_cc//cc:defs.bzl", "cc_toolchain", "cc_toolchain_suite")
load(":toolchain_info_list.bzl", "toolchain_list",
    "TOOLCHAIN_PLATFORM",
    "TOOLCHAIN_HOST_OS",
    "TOOLCHAIN_TARGET_OS",
    "TOOLCHAIN_TARGET_CPU",
    "TOOLCHAIN_COMPILER_ROOT",
    "TOOLCHAIN_COMPILER_PREFIX",
    "TOOLCHAIN_CC_COMPILER",
    "TOOLCHAIN_INCLUDE_PATHS",
)
load(":custom_toolchain_config.bzl", "custom_toolchain_config")

def make_cc_toolchain_config_name(platform):
    return "%s_cc_toolchain_config" % platform

def make_cc_toolchain_name(platform):
    return "%s_cc_toolchain" % platform

def gen_toolchain_suite():
    native.filegroup(name = "empty")
    toolchains = {}
    for info in toolchain_list:
        platform = info[TOOLCHAIN_PLATFORM]
        include_paths = info[TOOLCHAIN_INCLUDE_PATHS]
        compiler_root = info[TOOLCHAIN_COMPILER_ROOT]
        compiler_prefix = info[TOOLCHAIN_COMPILER_PREFIX]
        host_os = info[TOOLCHAIN_HOST_OS]
        target_os = info[TOOLCHAIN_TARGET_OS]
        target_cpu = info[TOOLCHAIN_TARGET_CPU]
        cc_compiler = info[TOOLCHAIN_CC_COMPILER]

        cc_toolchain_config_name = make_cc_toolchain_config_name(platform)
        cc_toolchain_name = make_cc_toolchain_name(platform)

        custom_toolchain_config(
            name = cc_toolchain_config_name,
            include_paths = include_paths,
            compiler_root = compiler_root,
            compiler_prefix = compiler_prefix,
            host_os = host_os,
            toolchain_identifier = cc_toolchain_config_name,
            target_os = target_os,
            target_cpu = target_cpu,
            cc_compiler = cc_compiler,
            extra_features = [],
        )

        cc_toolchain(
            name = cc_toolchain_name,
            toolchain_identifier = cc_toolchain_name,
            toolchain_config = ":%s" % cc_toolchain_config_name,
            all_files = ":empty",
            compiler_files = ":empty",
            dwp_files = ":empty",
            linker_files = ":empty",
            objcopy_files = ":empty",
            strip_files = ":empty",
            supports_param_files = 0,
        )

        if platform in toolchains.keys():
            fail("%s already exist!" % platform)
        else:
            toolchains[platform] = cc_toolchain_name

    cc_toolchain_suite(
        name = "custom_toolchain_suite",
        toolchains = toolchains
    )
