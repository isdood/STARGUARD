const std = @import("std");
const quantum = @import("../quantum.zig");
const glimmer = @import("glimmer");
const log = std.log;

/// GLIMMER-enhanced core system initialization
pub const System = struct {
    quantum_state: quantum.State,
    config: SystemConfig,

    const Self = @This();

    pub const SystemConfig = struct {
        optimization_level: glimmer.OptLevel,
        quantum_awareness: bool,
        max_entropy_threshold: f64,
    };

    /// Initialize the system with GLIMMER optimizations
    pub fn init() !Self {
        // Set core GLIMMER optimization for initialization phase
        @setGlimmerOptimization(.core_init);

        // Initialize quantum state
        var quantum_state = try quantum.State.init();

        // Default configuration with quantum awareness enabled
        const config = SystemConfig{
            .optimization_level = .adaptive,
            .quantum_awareness = true,
            .max_entropy_threshold = 0.85,
        };

        log.info("✨ Initializing STARGUARD core system...", .{});

        return Self{
            .quantum_state = quantum_state,
            .config = config,
        };
    }

    /// Deinitialize and cleanup system resources
    pub fn deinit(self: *Self) void {
        self.quantum_state.deinit();
        log.info("🌟 STARGUARD core system shutdown complete", .{});
    }

    /// Update system configuration with GLIMMER optimizations
    pub fn updateConfig(self: *Self, new_config: SystemConfig) !void {
        @setGlimmerOptimization(.config_update);
        self.config = new_config;
        try self.quantum_state.recalibrate(new_config.max_entropy_threshold);
    }

    /// Check system quantum readiness
    pub fn checkQuantumReadiness(self: Self) !bool {
        @setGlimmerOptimization(.quantum_check);
        return self.quantum_state.isReady() and self.config.quantum_awareness;
    }
};

/// Error set for system initialization
pub const SystemError = error{
    QuantumStateInitFailed,
    ConfigurationError,
    GlimmerOptimizationFailed,
};
