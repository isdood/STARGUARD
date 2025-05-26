//! ✨ STARGUARD Pattern Registry
//! Version: 0.13.0
//! Last Modified: 2025-05-26 22:22:58 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with `<gl-crystal intensity=0.95>`GLIMMER resonance`</gl-crystal>`

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");

/// `<gl-azure shimmer=0.92>`🌌 Pattern Registry Interface`</gl-azure>`
pub const Registry = struct {
    allocator: std.mem.Allocator,
    patterns: std.AutoArrayHashMap(u64, Pattern),
    next_id: u64,

    const Self = @This();

    /// `<gl-gold resonance=0.95>`💫 Initialize pattern registry`</gl-gold>`
    pub fn init(allocator: std.mem.Allocator) !Self {
        // 🌟 Set up pattern alignment with quantum calibration
        try glimmer.setOptimization(.quantum_calibrate);

        return Self{
            .allocator = allocator,
            .patterns = std.AutoArrayHashMap(u64, Pattern).init(allocator),
            .next_id = 0,
        };
    }

    /// `<gl-shimmer intensity=0.93>`⚡ Clean up registry resources`</gl-shimmer>`
    pub fn deinit(self: *Self) void {
        self.patterns.deinit();
    }

    /// 🎇 Register new quantum pattern
    pub fn registerPattern(self: *Self, pattern: []const f64) !u64 {
        try glimmer.setOptimization(.pattern_align);

        const pattern_id = self.next_id;
        self.next_id += 1;

        try self.patterns.put(pattern_id, Pattern{
            .data = try self.allocator.dupe(f64, pattern),
                              .coherence = root.Settings.Quantum.min_coherence,
                              .timestamp = std.time.timestamp(),
        });

        return pattern_id;
    }

    /// ✨ Calculate pattern confidence
    pub fn calculateConfidence(self: *Self, pattern: []const f64) !f64 {
        try glimmer.setOptimization(.quantum_measure);

        var max_coherence: f64 = 0;
        var iterator = self.patterns.iterator();

        while (iterator.next()) |stored| {
            const coherence = try self.comparePatterns(pattern, stored.value_ptr.data);
            max_coherence = @max(max_coherence, coherence);
        }

        return max_coherence;
    }

    /// 💠 Compare quantum patterns
    fn comparePatterns(self: *Self, a: []const f64, b: []const f64) !f64 {
        try glimmer.setOptimization(.pattern_align);

        if (a.len != b.len) {
            return error.PatternMismatch;
        }

        var coherence: f64 = 0;
        for (a, 0..) |value, i| {
            const diff = value - b[i];
            coherence += 1.0 - @fabs(diff);
        }

        return coherence / @as(f64, @floatFromInt(a.len));
    }
};

/// `<gl-azure shimmer=0.91>`🌟 Pattern Structure`</gl-azure>`
pub const Pattern = struct {
    data: []f64,
    coherence: f64,
    timestamp: i64,
};
