const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "starguard",
        .root_source_file = .{ .cwd_relative = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    // 🌟 Add GLIMMER dependency
    const glimmer_module = b.createModule(.{
        .root_source_file = .{ .cwd_relative = "libs/glimmer/src/main.zig" },
        .imports = &.{},
    });
    exe.addModule("glimmer", glimmer_module);

    // ✨ Add quantum detection modules
    const quantum_detection = b.createModule(.{
        .root_source_file = .{ .cwd_relative = "src/quantum/detection/core/detector.zig" },
        .imports = &.{
            .{ .name = "glimmer", .module = glimmer_module },
        },
    });
    exe.addModule("quantum_detection", quantum_detection);

    b.installArtifact(exe);

    // 🎇 Add test step
    const main_tests = b.addTest(.{
        .root_source_file = .{ .cwd_relative = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    main_tests.addModule("glimmer", glimmer_module);
    main_tests.addModule("quantum_detection", quantum_detection);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
