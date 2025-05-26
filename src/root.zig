//! ✨ STARGUARD Root Module
//! Version: 0.13.0
//! Last Modified: 2025-05-26 11:34:04 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with GLIMMER patterns

const builtin = @import("builtin");

// 🌌 Core system imports
pub const std = @import("std");
pub const glimmer = @import("glimmer");

// 💫 STARGUARD module exports
pub const core = struct {
    pub const system = @import("core/system/init.zig");
    pub const config = @import("core/config/settings.zig");
};

// ✨ Quantum framework exports
pub const quantum = struct {
    pub const state = @import("quantum/state/quantum_state.zig");
    pub const entangle = @import("quantum/entangle/manager.zig");
};

// 🌟 Pattern recognition exports
pub const pattern = struct {
    pub const recognition = @import("pattern/recognition/detector.zig");
    pub const matcher = @import("pattern/matcher/engine.zig");
};

// 💠 Threat analysis exports
pub const threat = struct {
    pub const detection = @import("threat/detection/analyzer.zig");
    pub const response = @import("threat/response/handler.zig");
};

// 🎇 GLIMMER optimization configuration
pub const glimmer_config = struct {
    pub const enable_quantum_patterns = true;
    pub const pattern_strength = 0.85;
    pub const coherence_threshold = 0.75;
};

// Build metadata
pub const build_info = struct {
    pub const version = "0.13.0";
    pub const timestamp = "2025-05-26 11:34:04";
    pub const debug = builtin.mode == .Debug;
};
