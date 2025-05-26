//! ✨ STARGUARD Quantum Metrics System
//! Version: 0.13.0
//! Last Modified: 2025-05-26 14:59:01 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with GLIMMER patterns

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");

/// 🌌 Quantum Metrics Interface
pub const Metrics = struct {
    allocator: std.mem.Allocator,
    pattern_stats: std.AutoArrayHashMap(u64, PatternMetrics),
    coherence_history: CircularBuffer,
    total_detections: u64,
    start_time: i64,
    enhancement_factor: f64,

    const Self = @This();

    /// 💫 Initialize quantum metrics
    pub fn init(allocator: std.mem.Allocator) !Self {
        // 🌟 Set up GLIMMER optimization
        try glimmer.setOptimization(.metrics_init);
        const enhancement = try glimmer.getEnhancementFactor();

        return Self{
            .allocator = allocator,
            .pattern_stats = std.AutoArrayHashMap(u64, PatternMetrics).init(allocator),
            .coherence_history = try CircularBuffer.init(
                allocator,
                root.Settings.Quantum.max_entanglement
            ),
            .total_detections = 0,
            .start_time = std.time.timestamp(),
            .enhancement_factor = enhancement,
        };
    }

    /// ✨ Clean up metrics resources
    pub fn deinit(self: *Self) void {
        self.pattern_stats.deinit();
        self.coherence_history.deinit();
    }

    /// 🎇 Record quantum detection
    pub fn recordDetection(self: *Self, pattern: []const f64) !void {
        try glimmer.setOptimization(.metrics_record);

        // 💠 Generate quantum signature
        const signature = try self.generateSignature(pattern);

        // 🌟 Update pattern metrics
        var stats = try self.getOrCreateMetrics(signature);
        try stats.recordDetection(self.enhancement_factor);

        // ⚡ Update global metrics
        self.total_detections += 1;
        try self.coherence_history.push(self.calculateCoherence(pattern));
    }

    /// 💫 Get pattern detection rate
    pub fn getDetectionRate(self: *Self) f64 {
        const elapsed = @as(f64, @floatFromInt(
            std.time.timestamp() - self.last_detection
        ));
        return @intToFloat(f64, self.total_detections) / elapsed;
    }

    /// 🌌 Calculate quantum coherence
    fn calculateCoherence(self: *Self, pattern: []const f64) f64 {
        var coherence: f64 = 0.0;
        for (pattern) |value| {
            coherence += value * self.enhancement_factor;
        }
        return coherence / @intToFloat(f64, pattern.len);
    }

    /// 🎇 Get or create pattern metrics
    fn getOrCreateMetrics(self: *Self, signature: u64) !*PatternMetrics {
        const gop = try self.pattern_stats.getOrPut(signature);
        if (!gop.found_existing) {
            gop.value_ptr.* = PatternMetrics{
                .detections = 0,
                .first_seen = std.time.timestamp(),
                .last_seen = std.time.timestamp(),
                .coherence_sum = 0,
            };
        }
        return gop.value_ptr;
    }

    /// ✨ Generate quantum signature
    fn generateSignature(self: *Self, pattern: []const f64) !u64 {
        _ = self;
        var hasher = std.hash.Wyhash.init(0);
        for (pattern) |value| {
            hasher.update(std.mem.asBytes(&value));
        }
        return hasher.final();
    }
};

/// 💫 Pattern-specific metrics
const PatternMetrics = struct {
    detections: u64,
    first_seen: i64,
    last_seen: i64,
    coherence_sum: f64,

    /// 🌟 Record pattern detection
    pub fn recordDetection(self: *PatternMetrics, enhancement: f64) !void {
        self.detections += 1;
        self.last_seen = std.time.timestamp();
        self.coherence_sum += enhancement;
    }

    /// ✨ Get average coherence
    pub fn getAverageCoherence(self: *const PatternMetrics) f64 {
        return self.coherence_sum / @as(f64, @floatFromInt(self.detections));
    }
};

/// 🎇 Circular buffer for coherence history
const CircularBuffer = struct {
    buffer: []f64,
    head: usize,
    size: usize,
    allocator: std.mem.Allocator,

    /// 💠 Initialize circular buffer
    pub fn init(allocator: std.mem.Allocator, capacity: usize) !CircularBuffer {
        const buffer = try allocator.alloc(f64, capacity);
        return CircularBuffer{
            .buffer = buffer,
            .head = 0,
            .size = 0,
            .allocator = allocator,
        };
    }

    /// ⚡ Clean up buffer
    pub fn deinit(self: *CircularBuffer) void {
        self.allocator.free(self.buffer);
    }

    /// 🌟 Push value to buffer
    pub fn push(self: *CircularBuffer, value: f64) !void {
        self.buffer[self.head] = value;
        self.head = (self.head + 1) % self.buffer.len;
        self.size = std.math.min(self.size + 1, self.buffer.len);
    }
};
