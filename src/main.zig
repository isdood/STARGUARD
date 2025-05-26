//! ✨ STARGUARD Main Entry Point
//! Version: 0.13.0
//! Last Modified: 2025-05-26 11:12:00 UTC

const std = @import("std");
const root = @import("root.zig");
const System = @import("core/system/init.zig").System;

pub fn main() !void {
    // 💫 Initialize memory allocator with GLIMMER-enhanced patterns
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // 🌌 Initialize STARGUARD system
    var sys = try System.init(allocator);
    defer sys.deinit();

    // ✨ System startup message with GLIMMER coloring
    std.log.info("🌟 STARGUARD v0.13.0 initialized", .{});

    if (try sys.checkQuantumReadiness()) {
        std.log.info("💫 Quantum subsystems ready", .{});
        // Additional initialization steps will go here
    }
}

test "basic functionality" {
    _ = @import("core/system/init.zig");
    _ = @import("quantum/state/quantum_state.zig");
    _ = @import("pattern/recognition/detector.zig");
    _ = @import("threat/detection/analyzer.zig");
}
