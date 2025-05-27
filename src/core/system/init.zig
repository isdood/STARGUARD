//! ✨ STARGUARD System Initialization
//! Version: 0.13.0
//! Last Modified: 2025-05-27 08:08:07 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with `<gl-crystal intensity=0.95>`GLIMMER resonance`</gl-crystal>`

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");

/// `<gl-azure shimmer=0.92>`🌌 System Configuration`</gl-azure>`
pub const SystemConfig = struct {
    allocator: std.mem.Allocator,
    optimization_level: glimmer.OptimizationPattern = .quantum_calibrate,
    enhancement_factor: f64 = root.Settings.Glimmer.enhancement_factor,
    quantum_resonance: f64 = root.Settings.Glimmer.quantum_resonance,
};

/// `<gl-gold resonance=0.95>`💫 System Initialization`</gl-gold>`
pub const System = struct {
    allocator: std.mem.Allocator,
    config: SystemConfig,
    is_initialized: bool,
    quantum_matrix: []f64,
    glimmer_matrix: ?[]f64,

    const Self = @This();

    /// 🌟 Initialize system
    pub fn init(allocator: std.mem.Allocator) !Self {
        // ✨ Set up quantum calibration
        try glimmer.setOptimization(.quantum_calibrate);

        const quantum_matrix = try allocator.alloc(f64, root.Settings.Quantum.max_entanglement);
        errdefer allocator.free(quantum_matrix);

        // 💫 Initialize quantum states
        for (quantum_matrix) |*cell| {
            cell.* = root.Settings.Quantum.min_coherence;
        }

        return Self{
            .allocator = allocator,
            .config = .{
                .allocator = allocator,
                .optimization_level = .quantum_calibrate,
                .enhancement_factor = root.Settings.Glimmer.enhancement_factor,
                .quantum_resonance = root.Settings.Glimmer.quantum_resonance,
            },
            .is_initialized = true,
            .quantum_matrix = quantum_matrix,
            .glimmer_matrix = null,
        };
    }

    /// 🎇 Initialize GLIMMER matrix
    pub fn initializeGlimmerMatrix(self: *Self, crystal_coherence: f64) !void {
        if (self.glimmer_matrix != null) {
            self.allocator.free(self.glimmer_matrix.?);
        }

        // ⚡ Allocate GLIMMER matrix with immutability
        const matrix = try self.allocator.alloc(f64, root.Settings.Glimmer.matrix_size);
        errdefer self.allocator.free(matrix);

        // 💠 Initialize GLIMMER patterns with crystal coherence
        for (matrix) |*cell| {
            cell.* = crystal_coherence * self.config.enhancement_factor;
        }

        self.glimmer_matrix = matrix;
    }

    /// `<gl-shimmer intensity=0.93>`⚡ Clean up system resources`</gl-shimmer>`
    pub fn deinit(self: *Self) void {
        if (self.glimmer_matrix) |matrix| {
            self.allocator.free(matrix);
        }
        self.allocator.free(self.quantum_matrix);
        self.is_initialized = false;
    }
};
