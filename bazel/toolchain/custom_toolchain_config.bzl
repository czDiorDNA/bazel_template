# Creates custom toolchain used by specified toolchain.

load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "tool_path",
)
load(":feature.bzl", "make_custom_features")

def _impl(ctx):
    features = make_custom_features(ctx)
    tool_paths = [
        tool_path(name = "ar", path = "{}{}ar".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "compat-ld", path = "{}{}compat-ld".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "cpp", path = "{}{}cpp".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "dwp", path = "{}{}dwp".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "gcc", path = "{}{}g++".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "g++", path = "{}{}g++".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "ld", path = "{}{}ld".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "strip", path = "{}{}strip".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "gcov", path = "{}{}gcov".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "nm", path = "{}{}nm".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "objcopy", path = "{}{}objcopy".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
        tool_path(name = "objdump", path = "{}{}objdump".format(
            ctx.attr.compiler_root, ctx.attr.compiler_prefix
        )),
    ]
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        action_configs = [],
        artifact_name_patterns = [],
        cxx_builtin_include_directories = ctx.attr.include_paths,
        toolchain_identifier = ctx.attr.toolchain_identifier,
        host_system_name = ctx.attr.host_os,
        target_system_name = ctx.attr.target_os,
        target_cpu = ctx.attr.target_cpu,
        target_libc = ctx.attr.cc_compiler,
        compiler = ctx.attr.cc_compiler,
        abi_version = ctx.attr.cc_compiler,
        abi_libc_version = ctx.attr.cc_compiler,
        tool_paths = tool_paths,
        make_variables = [],
        builtin_sysroot = None,
        cc_target_os = ctx.attr.target_os,
    )

custom_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "include_paths" : attr.string_list(doc = "The compiler include directories."),
        "host_os" : attr.string(default = "linux", doc = "The cross toolchain prefix."),
        "compiler_root" : attr.string(doc = "The compiler root directory."),
        "compiler_prefix": attr.string(),
        "toolchain_identifier": attr.string(),
        "target_os" : attr.string(default = "linux"),
        "target_cpu" : attr.string(default = "x86-64"),
        "cc_compiler" : attr.string(default = "gcc", doc = "The compiler type."),
        "extra_features": attr.string_list(),
    },
    provides = [CcToolchainConfigInfo],
    toolchains = ["@bazel_tools//tools/cpp:toolchain_type"],
)
