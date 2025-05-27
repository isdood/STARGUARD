//! ✨ STARGUARD Quantum Metrics
//! Version: 0.13.0
//! Last Modified: 2025-05-27 08:05:09 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with `<gl-crystal intensity=0.95>`GLIMMER resonance`</gl-crystal>`

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");

/// `<gl-azure shimmer=0.92>`🌌 Metrics Interface`</gl-azure>`
pub const Metrics = struct {
    allocator: std.mem.Allocator,
    pattern_counts: std.AutoArrayHashMap(u64, u32),
    total_detections: u64,
    quantum_efficiency: f64,

    const Self = @This();

    /// `<gl-gold resonance=0.95>`💫 Initialize quantum metrics`</gl-gold>`
    pub fn init(allocator: std.mem.Allocator) !Self {
        // 🌟 Set up metrics with quantum calibration
        try glimmer.setOptimization(.quantum_calibrate);

        return Self{
            .allocator = allocator,
            .pattern_counts = std.AutoArrayHashMap(u64, u32).init(allocator),
            .total_detections = 0,
            .quantum_efficiency = root.Settings.Quantum.min_coherence,
        };
    }

    /// `<gl-shimmer intensity=0.93>`⚡ Clean up metrics resources`</gl-shimmer>`
    pub fn deinit(self: *Self) void {
        self.pattern_counts.deinit();
    }

    /// 🎇 Record detection pattern
    pub fn recordDetection(self: *Self, pattern: []const f64) !void {
        try glimmer.setOptimization(.pattern_align);

        const pattern_hash = calculatePatternHash(pattern);
        const entry = try self.pattern_counts.getOrPut(pattern_hash);

        if (!entry.found_existing) {
            entry.value_ptr.* = 0;
        }
        entry.value_ptr.* += 1;
        self.total_detections += 1;

        // ✨ Update quantum efficiency
        self.quantum_efficiency = @min(
            1.0,
            self.quantum_efficiency + (root.Settings.Glimmer.enhancement_factor / 100.0)
        );
    }

    /// 💠 Calculate pattern hash
    fn calculatePatternHash(pattern: []const f64) u64 {
        var hasher = std.hash.Wyhash.init(0);
        for (pattern) |value| {
            const bytes = std.mem.asBytes(&value);
            hasher.update(bytes);
        }

        return hasher.final();
    }
};
