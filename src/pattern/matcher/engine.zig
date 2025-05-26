//! ✨ STARGUARD Pattern Matching Engine
//! Version: 0.13.0
//! Last Modified: 2025-05-26 12:05:44 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with GLIMMER patterns

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");
const quantum = @import("../../quantum/state/quantum_state.zig");

/// 🌌 Quantum-Enhanced Pattern Matching Engine
pub const MatchEngine = struct {
    allocator: std.mem.Allocator,
    quantum_state: *quantum.QuantumState,
    pattern_cache: std.AutoHashMap(u64, Pattern),
    similarity_threshold: f64,
    max_patterns: usize,

    const Self = @This();

    /// 💫 Pattern structure with GLIMMER enhancement
    pub const Pattern = struct {
        id: u64,
        signature: [32]u8,
        complexity: u32,
        weight: f64,
        quantum_fingerprint: [16]u8,
        timestamp: i64,
        matches: u32,

        pub fn init(id: u64, signature: [32]u8) Pattern {
            return .{
                .id = id,
                .signature = signature,
                .complexity = 1,
                .weight = 1.0,
                .quantum_fingerprint = [_]u8{0} ** 16,
                .timestamp = std.time.timestamp(),
                .matches = 0,
            };
        }
    };

    /// ✨ Initialize pattern matching engine
    pub fn init(allocator: std.mem.Allocator, quantum_state: *quantum.QuantumState) !Self {
        try glimmer.setOptimization(.pattern_init);

        return Self{
            .allocator = allocator,
            .quantum_state = quantum_state,
            .pattern_cache = std.AutoHashMap(u64, Pattern).init(allocator),
            .similarity_threshold = root.Settings.Pattern.min_confidence,
            .max_patterns = root.Settings.Pattern.max_cache_size,
        };
    }

    /// 🌟 Clean up engine resources
    pub fn deinit(self: *Self) void {
        self.pattern_cache.deinit();
    }

    /// 💠 Register a new pattern with quantum enhancement
    pub fn registerPattern(self: *Self, signature: [32]u8) !u64 {
        try glimmer.setOptimization(.pattern_register);

        if (self.pattern_cache.count() >= self.max_patterns) {
            try self.prunePatterns();
        }

        const id = try self.generatePatternId();
        var pattern = Pattern.init(id, signature);

        // Generate quantum fingerprint
        try self.quantum_state.analyze(signature[0..], &pattern.quantum_fingerprint);

        try self.pattern_cache.put(id, pattern);
        return id;
    }

    /// 🌌 Match data against registered patterns
    pub fn matchPattern(self: *Self, data: []const u8) !?MatchResult {
        try glimmer.setOptimization(.pattern_match);

        var best_match: ?MatchResult = null;
        var best_similarity: f64 = self.similarity_threshold;

        var quantum_signature: [32]u8 = undefined;
        try self.quantum_state.analyze(data, &quantum_signature);

        var it = self.pattern_cache.iterator();
        while (it.next()) |entry| {
            const similarity = try self.calculateSimilarity(quantum_signature, entry.value_ptr.*);

            if (similarity > best_similarity) {
                best_similarity = similarity;
                best_match = MatchResult{
                    .pattern_id = entry.value_ptr.id,
                    .similarity = similarity,
                    .quantum_confidence = try self.quantum_state.getWeight(),
                };
            }
        }

        if (best_match) |*match| {
            try self.updatePatternStats(match.pattern_id, match.similarity);
        }

        return best_match;
    }

    /// 💫 Match result structure
    pub const MatchResult = struct {
        pattern_id: u64,
        similarity: f64,
        quantum_confidence: f32,
    };

    /// ✨ Calculate pattern similarity with quantum weighting
    fn calculateSimilarity(self: *Self, signature: [32]u8, pattern: Pattern) !f64 {
        var matched_bits: u32 = 0;
        const quantum_weight = try self.quantum_state.getWeight();

        for (signature, 0..) |byte, i| {
            matched_bits += @popCount(u8, byte ^ pattern.signature[i]);
        }

        const base_similarity = 1.0 - @as(f64, @floatFromInt(matched_bits)) / (32.0 * 8.0);
        return base_similarity * quantum_weight * pattern.weight;
    }

    /// 🌟 Update pattern statistics
    fn updatePatternStats(self: *Self, id: u64, similarity: f64) !void {
        if (self.pattern_cache.getPtr(id)) |pattern| {
            pattern.matches += 1;
            pattern.weight = (pattern.weight * 0.9) + (similarity * 0.1);
            pattern.complexity = @max(1, @min(16, pattern.complexity + 1));
        }
    }

    /// 💠 Prune least valuable patterns
    fn prunePatterns(self: *Self) !void {
        const target_size = self.max_patterns * 3 / 4;

        while (self.pattern_cache.count() > target_size) {
            var lowest_weight: f64 = 1.0;
            var lowest_id: ?u64 = null;

            var it = self.pattern_cache.iterator();
            while (it.next()) |entry| {
                if (entry.value_ptr.weight < lowest_weight) {
                    lowest_weight = entry.value_ptr.weight;
                    lowest_id = entry.key_ptr.*;
                }
            }

            if (lowest_id) |id| {
                _ = self.pattern_cache.remove(id);
            }
        }
    }

    /// 🌌 Generate unique pattern ID
    fn generatePatternId(self: *Self) !u64 {
        _ = self;
        var rng = std.rand.DefaultPrng.init(@bitCast(std.time.timestamp()));
        return rng.random().int(u64);
    }
};

/// Pattern matching errors
pub const PatternError = error{
    PatternNotFound,
    PatternCacheFull,
    InvalidSignature,
    QuantumAnalysisFailed,
    SimilarityError,
};
