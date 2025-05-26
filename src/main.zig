//! ✨ STARGUARD Main Entry Point
//! Version: 0.13.0
//! Last Modified: 2025-05-26 11:26:24 UTC

const std = @import("std");
const root = @import("root.zig");
const System = @import("core/system/init.zig").System;
const detector = @import("pattern/recognition/detector.zig");
const quantum = @import("quantum/state/quantum_state.zig");

pub fn main() !void {
    // 💫 Initialize memory allocator with GLIMMER-enhanced patterns
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // 🌌 Initialize quantum state
    var quantum_state = try quantum.QuantumState.init(allocator);
    defer quantum_state.deinit();

    // ✨ Perform initial quantum measurement
    const initial_measurement = try quantum_state.measure();
    std.log.info("🌌 Initial quantum coherence: {d:.4}", .{initial_measurement});

    // 💫 Initialize STARGUARD system
    var sys = try System.init(allocator);
    defer sys.deinit();

    // 🌟 System startup message with GLIMMER coloring
    std.log.info("✨ STARGUARD v0.13.0 initialized", .{});

    // 🌌 Initialize pattern detection system
    var pattern_detector = try detector.PatternDetector.init(allocator, &quantum_state);
    defer pattern_detector.deinit();

    if (try sys.checkQuantumReadiness()) {
        std.log.info("💫 Quantum subsystems ready", .{});

        // Perform quantum-enhanced pattern detection
        const test_data = "test pattern";
        if (try pattern_detector.detect(test_data)) |pattern| {
            std.log.info("✨ Pattern detected with confidence: {d:.4}", .{pattern.confidence});

            // 🌌 Verify quantum coherence after pattern detection
            const post_measure = try quantum_state.measure();
            std.log.info("💫 Post-detection quantum coherence: {d:.4}", .{post_measure});
        }
    } else {
        std.log.warn("🌌 Quantum subsystems not ready - check coherence levels", .{});
    }
}

test "basic functionality" {
    _ = @import("core/system/init.zig");
    _ = @import("quantum/state/quantum_state.zig");
    _ = @import("pattern/recognition/detector.zig");
    _ = @import("threat/detection/analyzer.zig");
}
