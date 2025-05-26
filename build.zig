const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "starguard",
        .root_source_file = .{ .cwd_relative = "src/main.zig" }, // 💫 Updated to use cwd_relative
        .target = target,
        .optimize = optimize,
    });

    // 🌟 Add GLIMMER dependency
    const glimmer_module = b.addModule("glimmer", .{
        .source_file = .{ .cwd_relative = "libs/glimmer/src/main.zig" }, // 💫 Updated path syntax
        .dependencies = &.{},
    });
    exe.addModule("glimmer", glimmer_module);

    // ✨ Add quantum detection modules
    const quantum_detection = b.addModule("quantum_detection", .{
        .source_file = .{ .cwd_relative = "src/quantum/detection/core/detector.zig" }, // 💫 Updated path syntax
        .dependencies = &.{
            .{ .name = "glimmer", .module = glimmer_module },
        },
    });
    exe.addModule("quantum_detection", quantum_detection);

    b.installArtifact(exe);

    // 🎇 Add test step
    const main_tests = b.addTest(.{
        .root_source_file = .{ .cwd_relative = "src/main.zig" }, // 💫 Updated path syntax
        .target = target,
        .optimize = optimize,
    });
    main_tests.addModule("glimmer", glimmer_module);
    main_tests.addModule("quantum_detection", quantum_detection);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
