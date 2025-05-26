//! 🌌 GLIMMER Test Suite
//! Version: 0.13.0
//! Last Modified: 2025-05-26 15:09:19 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE

const std = @import("std");
const glimmer = @import("main.zig");
const testing = std.testing;

test "GLIMMER initialization" {
    try glimmer.setOptimization(.quantum_init);
    const factor = try glimmer.getEnhancementFactor();
    try testing.expect(factor > 1.0);
}

test "GLIMMER pattern switching" {
    try glimmer.setOptimization(.quantum_detect);
    const detect_factor = try glimmer.getEnhancementFactor();

    try glimmer.setOptimization(.quantum_state);
    const state_factor = try glimmer.getEnhancementFactor();

    try testing.expect(detect_factor != state_factor);
}
