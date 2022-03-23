load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def make_custom_features(ctx):
    flags = [
        "-static-libstdc++",
    ]
    if ctx.attr.compiler_prefix == "arm-linux-gnueabihf-":
        flags = ["-static"]
    return [feature(
        name = "default_linker_features",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = ([
                    flag_group(
                        flags = flags
                    )
                ])
            )
        ]
    )]
