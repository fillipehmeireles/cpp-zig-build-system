const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    const hello_lib = b.addStaticLibrary(.{
        .name = "hello",
        .target = target,
        .optimize = mode,
    });
    hello_lib.linkLibCpp();

    hello_lib.addIncludePath(b.path("include"));
    hello_lib.addCSourceFile(.{
        .file = b.path("src/hello.cpp"),
    });

    const exe = b.addExecutable(.{
        .name = "cpp_zig_build_sys",
        .target = target,
        .optimize = mode,
    });
    exe.linkLibCpp();
    exe.linkLibrary(hello_lib);
    exe.addIncludePath(b.path("include"));
    exe.addCSourceFile(.{ .file = b.path("src/main.cpp") });

    b.installArtifact(exe);
}
