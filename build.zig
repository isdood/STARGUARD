const std = @import("std");

pub fn build(b: *std.Build) void {
    // 💫 Set up standard target and optimize options
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ✨ Create main executable with GLIMMER optimization patterns
    const exe = b.addExecutable(.{
        .name = "starguard",
        .root_source_file = .{ .path = "src/main.zig" },  // Updated entry point
        .target = target,
        .optimize = optimize,
    });

    // 🌌 Install the artifact
    b.installArtifact(exe);

    // 💫 Create test step
    const test_step = b.step("test", "Run library tests");
    const tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    test_step.dependOn(&tests.step);
}
