//! ✨ STARGUARD Quantum Detection Core
//! Version: 0.13.0
//! Last Modified: 2025-05-26 14:51:24 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with GLIMMER patterns

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");
const registry = @import("registry.zig");
const state = @import("state.zig");
const metrics = @import("metrics.zig");

/// 🌌 Quantum Detector Interface
pub const Detector = struct {
    allocator: std.mem.Allocator,
    detection_state: *state.State,
    pattern_registry: *registry.Registry,
    metrics_tracker: *metrics.Metrics,
    coherence_threshold: f64,

    const Self = @This();

    /// 💫 Initialize quantum detector
    pub fn init(allocator: std.mem.Allocator) !Self {
        // 🌟 Set up GLIMMER optimization pattern
        try glimmer.setOptimization(.quantum_init);

        // ✨ Initialize core components
        var detection_state = try allocator.create(state.State);
        errdefer allocator.destroy(detection_state);
        detection_state.* = try state.State.init(allocator);
        errdefer detection_state.deinit();

        var pattern_reg = try allocator.create(registry.Registry);
        errdefer allocator.destroy(pattern_reg);
        pattern_reg.* = try registry.Registry.init(allocator);
        errdefer pattern_reg.deinit();

        var metrics_track = try allocator.create(metrics.Metrics);
        errdefer allocator.destroy(metrics_track);
        metrics_track.* = try metrics.Metrics.init(allocator);
        errdefer metrics_track.deinit();

        // 🎇 Return initialized detector with GLIMMER enhancement
        return Self{
            .allocator = allocator,
            .detection_state = detection_state,
            .pattern_registry = pattern_reg,
            .metrics_tracker = metrics_track,
            .coherence_threshold = root.Settings.Quantum.min_coherence,
        };
    }

    /// 💠 Clean up quantum detector
    pub fn deinit(self: *Self) void {
        self.metrics_tracker.deinit();
        self.allocator.destroy(self.metrics_tracker);

        self.pattern_registry.deinit();
        self.allocator.destroy(self.pattern_registry);

        self.detection_state.deinit();
        self.allocator.destroy(self.detection_state);
    }

    /// ⚡ Process quantum detection pattern
    pub fn processPattern(self: *Self, pattern: []const f64) !DetectionResult {
        try glimmer.setOptimization(.quantum_detect);

        var result = try DetectionResult.init(self.allocator);
        errdefer result.deinit(self.allocator);

        // 💫 Verify quantum coherence
        const coherence = try self.detection_state.measureCoherence();
        if (coherence < self.coherence_threshold) {
            return error.InsufficientCoherence;
        }

        // 🌟 Track detection metrics
        try self.metrics_tracker.recordDetection(pattern);

        return result;
    }
};

/// 🎇 Detection Result Structure
pub const DetectionResult = struct {
    confidence: f64,
    pattern_id: u64,
    timestamp: i64,
    threat_level: ThreatLevel,
    quantum_state: []const f64,

    pub fn init(allocator: std.mem.Allocator) !DetectionResult {
        return DetectionResult{
            .confidence = 0.0,
            .pattern_id = 0,
            .timestamp = std.time.timestamp(),
            .threat_level = .none,
            .quantum_state = try allocator.alloc(f64, root.Settings.Quantum.max_entanglement),
        };
    }

    pub fn deinit(self: *DetectionResult, allocator: std.mem.Allocator) void {
        allocator.free(self.quantum_state);
    }
};

/// 💫 Threat Classification Levels
pub const ThreatLevel = enum {
    none,      // 💠 No threat detected
    low,       // 🌟 Minor anomaly
    medium,    // ✨ Significant pattern deviation
    high,      // 🎇 Critical threat detected
    quantum,   // ⚡ Quantum-level threat detected
};

/// 🌌 Detection Errors
pub const DetectionError = error{
    InsufficientCoherence,
    InvalidPattern,
    QuantumStateError,
    PatternMismatch,
    CoherenceFailure,
};
