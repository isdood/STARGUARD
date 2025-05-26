//! ✨ STARGUARD Core Initialization
//! Version: 0.13.0
//! Last Modified: 2025-05-26

const std = @import("std");
const quantum = @import("../quantum.zig");
const glimmer = @import("glimmer");

/// 🌟 GLIMMER-enhanced core system initialization
pub const System = struct {
    quantum_state: quantum.State,
    config: SystemConfig,
    allocator: std.mem.Allocator,  // Required for Zig 0.13.0 memory management

    const Self = @This();

    /// System configuration with GLIMMER optimization patterns
    pub const SystemConfig = struct {
        optimization_level: glimmer.OptLevel,
        quantum_awareness: bool,
        max_entropy_threshold: f64,

        /// Initialize default configuration
        pub fn default() SystemConfig {
            return .{
                .optimization_level = .adaptive,
                .quantum_awareness = true,
                .max_entropy_threshold = 0.85,
            };
        }
    };

    /// Initialize the system with GLIMMER optimizations
    pub fn init(allocator: std.mem.Allocator) !Self {
        // 💫 Set core GLIMMER optimization for initialization phase
        try glimmer.setOptimization(.core_init);

        // 🌌 Initialize quantum state with proper error handling
        var quantum_state = try quantum.State.init(allocator);
        errdefer quantum_state.deinit();

        const config = SystemConfig.default();

        // ✨ Log initialization with GLIMMER-enhanced formatting
        std.log.info("🌟 {s}", .{"Initializing STARGUARD core system..."});

        return Self{
            .quantum_state = quantum_state,
            .config = config,
            .allocator = allocator,
        };
    }

    /// Deinitialize and cleanup system resources
    pub fn deinit(self: *Self) void {
        self.quantum_state.deinit();
        // 💫 GLIMMER-enhanced shutdown message
        std.log.info("✨ {s}", .{"STARGUARD core system shutdown complete"});
    }

    /// Update system configuration with GLIMMER optimizations
    pub fn updateConfig(self: *Self, new_config: SystemConfig) !void {
        try glimmer.setOptimization(.config_update);
        self.config = new_config;
        try self.quantum_state.recalibrate(self.allocator, new_config.max_entropy_threshold);
    }

    /// Check system quantum readiness
    pub fn checkQuantumReadiness(self: Self) !bool {
        try glimmer.setOptimization(.quantum_check);
        return try self.quantum_state.isReady() and self.config.quantum_awareness;
    }
};

/// Error set for system initialization
pub const SystemError = error{
    QuantumStateInitFailed,
    ConfigurationError,
    GlimmerOptimizationFailed,
    OutOfMemory,  // Required for Zig 0.13.0 memory handling
};
