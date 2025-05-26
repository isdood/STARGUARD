//! ✨ STARGUARD Quantum Pattern Registry
//! Version: 0.13.0
//! Last Modified: 2025-05-26 14:57:18 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with GLIMMER patterns

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");

/// 🌌 Quantum Pattern Registry
pub const Registry = struct {
    allocator: std.mem.Allocator,
    patterns: std.AutoArrayHashMap(u64, Pattern),
    signature_index: std.StringHashMap(u64),
    coherence_map: std.AutoArrayHashMap(u64, f64),
    enhancement_factor: f64,

    const Self = @This();

    /// 💫 Initialize pattern registry with GLIMMER enhancement
    pub fn init(allocator: std.mem.Allocator) !Self {
        // 🌟 Set up GLIMMER optimization
        try glimmer.setOptimization(.quantum_registry);
        const enhancement = try glimmer.getEnhancementFactor();

        return Self{
            .allocator = allocator,
            .patterns = std.AutoArrayHashMap(u64, Pattern).init(allocator),
            .signature_index = std.StringHashMap(u64).init(allocator),
            .coherence_map = std.AutoArrayHashMap(u64, f64).init(allocator),
            .enhancement_factor = enhancement,
        };
    }

    /// ✨ Clean up registry resources
    pub fn deinit(self: *Self) void {
        var pattern_iter = self.patterns.iterator();
        while (pattern_iter.next()) |pattern| {
            pattern.value_ptr.deinit(self.allocator);
        }

        self.patterns.deinit();
        self.signature_index.deinit();
        self.coherence_map.deinit();
    }

    /// 🎇 Register new quantum pattern
    pub fn registerPattern(self: *Self, name: []const u8, signature: []const f64) !u64 {
        try glimmer.setOptimization(.pattern_register);

        // 💠 Create pattern with quantum coherence
        var pattern = try Pattern.init(
            self.allocator,
            name,
            signature,
            self.enhancement_factor
        );
        errdefer pattern.deinit(self.allocator);

        // 🌟 Store pattern with GLIMMER enhancement
        try self.patterns.put(pattern.id, pattern);
        try self.signature_index.put(pattern.name, pattern.id);
        try self.coherence_map.put(pattern.id, pattern.initial_coherence);

        return pattern.id;
    }

    /// ⚡ Lookup pattern by signature
    pub fn findPattern(self: *Self, signature: []const u8) !?*Pattern {
        try glimmer.setOptimization(.pattern_lookup);

        if (self.signature_index.get(signature)) |id| {
            return self.patterns.getPtr(id);
        }
        return null;
    }

    /// 💫 Update pattern coherence
    pub fn updateCoherence(self: *Self, id: u64, coherence: f64) !void {
        try glimmer.setOptimization(.coherence_update);

        var pattern = self.patterns.getPtr(id) orelse
        return error.PatternNotFound;

        // 🌟 Apply GLIMMER enhancement to coherence
        const enhanced_coherence = coherence * self.enhancement_factor;
        try pattern.updateCoherence(enhanced_coherence);
        try self.coherence_map.put(id, enhanced_coherence);
    }
};

/// ✨ Quantum Pattern Definition
pub const Pattern = struct {
    id: u64,
    name: []const u8,
    signature: []const f64,
    initial_coherence: f64,
    current_coherence: f64,
    last_update: i64,
    weight: f64,

    /// 🎇 Initialize pattern with quantum properties
    pub fn init(
        allocator: std.mem.Allocator,
        name: []const u8,
        signature: []const f64,
        enhancement: f64,
    ) !Pattern {
        const name_copy = try allocator.dupe(u8, name);
        errdefer allocator.free(name_copy);

        const sig_copy = try allocator.dupe(f64, signature);
        errdefer allocator.free(sig_copy);

        // 💫 Generate quantum-enhanced ID
        const quantum_id = try generateQuantumId(signature, enhancement);

        return Pattern{
            .id = quantum_id,
            .name = name_copy,
            .signature = sig_copy,
            .initial_coherence = root.Settings.Quantum.min_coherence,
            .current_coherence = root.Settings.Quantum.min_coherence,
            .last_update = std.time.timestamp(),
            .weight = 1.0,
        };
    }

    /// 💠 Clean up pattern resources
    pub fn deinit(self: *Pattern, allocator: std.mem.Allocator) void {
        allocator.free(self.name);
        allocator.free(self.signature);
    }

    /// 🌟 Update pattern coherence with GLIMMER enhancement
    pub fn updateCoherence(self: *Pattern, new_coherence: f64) !void {
        self.current_coherence = new_coherence;
        self.last_update = std.time.timestamp();
    }
};

/// ⚡ Generate quantum-enhanced pattern ID
fn generateQuantumId(signature: []const f64, enhancement: f64) !u64 {
    var hasher = std.hash.Wyhash.init(0);

    // 💫 Add quantum entropy
    for (signature) |value| {
        const enhanced = value * enhancement;
        hasher.update(std.mem.asBytes(&enhanced));
    }

    return hasher.final();
}
