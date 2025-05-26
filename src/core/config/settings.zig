//! ✨ STARGUARD Configuration Settings
//! Version: 0.13.0
//! Last Modified: 2025-05-26 11:42:28 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with GLIMMER patterns

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");

/// 🌌 STARGUARD System Configuration
pub const Settings = struct {
    /// Core system settings
    pub const System = struct {
        /// Maximum number of concurrent quantum operations
        pub const max_quantum_ops: u32 = 64;

        /// Default system memory limit (in MB)
        pub const memory_limit_mb: u32 = 512;

        /// GLIMMER pattern enhancement level
        pub const glimmer_level: f32 = 0.85;

        /// System check interval (in milliseconds)
        pub const check_interval_ms: u32 = 100;
    };

    /// 💫 Quantum configuration
    pub const Quantum = struct {
        /// Minimum acceptable quantum coherence level
        pub const min_coherence: f64 = 0.75;

        /// Maximum entanglement depth
        pub const max_entanglement: u32 = 32;

        /// Decoherence timeout (in milliseconds)
        pub const decoherence_timeout_ms: u32 = 500;

        /// Quantum state vector size
        pub const state_vector_size: usize = 1 << 12;
    };

    /// ✨ Pattern recognition settings
    pub const Pattern = struct {
        /// Maximum pattern cache size
        pub const max_cache_size: usize = 1024;

        /// Minimum pattern match confidence
        pub const min_confidence: f64 = 0.80;

        /// Pattern update interval (in milliseconds)
        pub const update_interval_ms: u32 = 250;

        /// Maximum pattern complexity
        pub const max_complexity: u32 = 16;
    };

    /// 🌟 Threat detection configuration
    pub const Threat = struct {
        /// Analysis threshold for threat detection
        pub const analysis_threshold: f64 = 0.85;

        /// Maximum threat cache size
        pub const max_threat_cache: usize = 512;

        /// Threat level scaling factor
        pub const level_scale: f32 = 1.5;

        /// Response timeout (in milliseconds)
        pub const response_timeout_ms: u32 = 1000;
    };

    /// 💠 Runtime configuration management
    pub const Runtime = struct {
        allocator: std.mem.Allocator,
        settings_map: std.StringHashMap([]const u8),

        const Self = @This();

        /// Initialize runtime configuration
        pub fn init(allocator: std.mem.Allocator) !Self {
            try glimmer.setOptimization(.config_init);

            return Self{
                .allocator = allocator,
                .settings_map = std.StringHashMap([]const u8).init(allocator),
            };
        }

        /// Clean up runtime configuration
        pub fn deinit(self: *Self) void {
            var it = self.settings_map.iterator();
            while (it.next()) |entry| {
                self.allocator.free(entry.value_ptr.*);
            }
            self.settings_map.deinit();
        }

        /// Set a runtime configuration value
        pub fn setValue(self: *Self, key: []const u8, value: []const u8) !void {
            const key_owned = try self.allocator.dupe(u8, key);
            errdefer self.allocator.free(key_owned);

            const value_owned = try self.allocator.dupe(u8, value);
            errdefer self.allocator.free(value_owned);

            if (self.settings_map.fetchPut(key_owned, value_owned)) |old| {
                self.allocator.free(old.key);
                self.allocator.free(old.value);
            }
        }

        /// Get a runtime configuration value
        pub fn getValue(self: Self, key: []const u8) ?[]const u8 {
            return self.settings_map.get(key);
        }
    };
};

/// Configuration error types
pub const ConfigError = error{
    InvalidSetting,
    ValueOutOfRange,
    MemoryLimitExceeded,
    ConfigurationLocked,
};
