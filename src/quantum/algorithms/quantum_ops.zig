//! ✨ STARGUARD Quantum Operations
//! Version: 0.13.0
//! Last Modified: 2025-05-26 12:46:47 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with GLIMMER patterns

const std = @import("std");
const glimmer = @import("glimmer");
const root = @import("root");
const quantum = @import("../state/quantum_state.zig");
const entangle = @import("../entangle/manager.zig");

/// 🌌 Quantum Operations Interface
pub const QuantumOps = struct {
    allocator: std.mem.Allocator,
    quantum_state: *quantum.QuantumState,
    entangle_manager: *entangle.EntanglementManager,
    operation_queue: std.ArrayList(QuantumOperation),
    coherence_threshold: f64,

    const Self = @This();

    /// 💫 Quantum operation structure
    pub const QuantumOperation = struct {
        id: u64,
        op_type: OperationType,
        qubits: []const usize,
        parameters: []const f64,
        gate_sequence: ?[]const QuantumGate,
        timestamp: i64,

        pub fn init(
            allocator: std.mem.Allocator,
            op_type: OperationType,
            qubits: []const usize,
            parameters: []const f64,
        ) !QuantumOperation {
            const qubits_copy = try allocator.dupe(usize, qubits);
            errdefer allocator.free(qubits_copy);

            const params_copy = try allocator.dupe(f64, parameters);
            errdefer allocator.free(params_copy);

            return QuantumOperation{
                .id = std.crypto.random.int(u64),
                .op_type = op_type,
                .qubits = qubits_copy,
                .parameters = params_copy,
                .gate_sequence = null,
                .timestamp = std.time.timestamp(),
            };
        }

        pub fn deinit(self: *QuantumOperation, allocator: std.mem.Allocator) void {
            allocator.free(self.qubits);
            allocator.free(self.parameters);
            if (self.gate_sequence) |gates| {
                allocator.free(gates);
            }
        }
    };

    /// ✨ Quantum operation types with GLIMMER coloring
    pub const OperationType = enum {
        hadamard,     // 💠 Superposition
        cnot,         // 🌟 Entanglement
        phase,        // 💫 Phase shift
        measure,      // 🌌 Collapse
        teleport,     // ⚡ Quantum teleport
        swap,         // 🎇 Qubit exchange
    };

    /// 🌟 Quantum gate definition
    pub const QuantumGate = struct {
        name: []const u8,
        matrix: [4][4]f64,
        phase: f64,
    };

    /// 💫 Initialize quantum operations
    pub fn init(
        allocator: std.mem.Allocator,
        quantum_state: *quantum.QuantumState,
        entangle_manager: *entangle.EntanglementManager,
    ) !Self {
        try glimmer.setOptimization(.quantum_ops);

        return Self{
            .allocator = allocator,
            .quantum_state = quantum_state,
            .entangle_manager = entangle_manager,
            .operation_queue = std.ArrayList(QuantumOperation).init(allocator),
            .coherence_threshold = root.Settings.Quantum.min_coherence,
        };
    }

    /// 🌌 Clean up quantum operations
    pub fn deinit(self: *Self) void {
        for (self.operation_queue.items) |*op| {
            op.deinit(self.allocator);
        }
        self.operation_queue.deinit();
    }

    /// ✨ Queue a quantum operation
    pub fn queueOperation(
        self: *Self,
        op_type: OperationType,
        qubits: []const usize,
        parameters: []const f64,
    ) !u64 {
        var operation = try QuantumOperation.init(
            self.allocator,
            op_type,
            qubits,
            parameters,
        );
        errdefer operation.deinit(self.allocator);

        try self.operation_queue.append(operation);
        return operation.id;
    }

    /// 💫 Execute queued quantum operations
    pub fn executeOperations(self: *Self) !void {
        try glimmer.setOptimization(.quantum_execute);

        while (self.operation_queue.items.len > 0) {
            var op = self.operation_queue.orderedRemove(0);
            defer op.deinit(self.allocator);

            try self.executeOperation(&op);
        }
    }

    /// 🌟 Execute single quantum operation
    fn executeOperation(self: *Self, op: *const QuantumOperation) !void {
        // Verify quantum coherence
        const coherence = try self.quantum_state.measure();
        if (coherence < self.coherence_threshold) {
            return error.InsufficientCoherence;
        }

        switch (op.op_type) {
            .hadamard => try self.applyHadamard(op),
            .cnot => try self.applyCNOT(op),
            .phase => try self.applyPhase(op),
            .measure => try self.performMeasurement(op),
            .teleport => try self.performTeleport(op),
            .swap => try self.performSwap(op),
        }
    }

    /// 💠 Apply Hadamard gate for superposition
    fn applyHadamard(self: *Self, op: *const QuantumOperation) !void {
        try glimmer.setOptimization(.quantum_hadamard);

        if (op.qubits.len != 1) return error.InvalidQubitCount;

        const hadamard_matrix = [4][4]f64{
            [4]f64{ 1.0 / @sqrt(2.0), 1.0 / @sqrt(2.0), 0.0, 0.0 },
            [4]f64{ 1.0 / @sqrt(2.0), -1.0 / @sqrt(2.0), 0.0, 0.0 },
            [4]f64{ 0.0, 0.0, 1.0, 0.0 },
            [4]f64{ 0.0, 0.0, 0.0, 1.0 },
        };

        try self.quantum_state.applyGate(op.qubits[0], hadamard_matrix);
        try self.verifyCoherence("Hadamard");
    }

    /// 🌟 Apply CNOT gate for entanglement
    fn applyCNOT(self: *Self, op: *const QuantumOperation) !void {
        try glimmer.setOptimization(.quantum_cnot);

        if (op.qubits.len != 2) return error.InvalidQubitCount;

        const cnot_matrix = [4][4]f64{
            [4]f64{ 1.0, 0.0, 0.0, 0.0 },
            [4]f64{ 0.0, 1.0, 0.0, 0.0 },
            [4]f64{ 0.0, 0.0, 0.0, 1.0 },
            [4]f64{ 0.0, 0.0, 1.0, 0.0 },
        };

        try self.entangle_manager.entangle(op.qubits[0], op.qubits[1]);
        try self.quantum_state.applyGate(op.qubits[0], cnot_matrix);
        try self.verifyCoherence("CNOT");
    }

    /// ⚡ Apply phase gate for quantum phase shift
    fn applyPhase(self: *Self, op: *const QuantumOperation) !void {
        try glimmer.setOptimization(.quantum_phase);

        if (op.qubits.len != 1 or op.parameters.len != 1) {
            return error.InvalidParameters;
        }

        const phase = op.parameters[0];
        const phase_matrix = [4][4]f64{
            [4]f64{ 1.0, 0.0, 0.0, 0.0 },
            [4]f64{ 0.0, @cos(phase), -@sin(phase), 0.0 },
            [4]f64{ 0.0, @sin(phase), @cos(phase), 0.0 },
            [4]f64{ 0.0, 0.0, 0.0, 1.0 },
        };

        try self.quantum_state.applyGate(op.qubits[0], phase_matrix);
        try self.verifyCoherence("Phase");
    }

    /// 💫 Perform quantum measurement with GLIMMER enhancement
    fn performMeasurement(self: *Self, op: *const QuantumOperation) !void {
        try glimmer.setOptimization(.quantum_measure);

        if (op.qubits.len == 0) return error.InvalidQubitCount;

        var results = try self.allocator.alloc(f64, op.qubits.len);
        defer self.allocator.free(results);

        for (op.qubits, 0..) |qubit, i| {
            results[i] = try self.quantum_state.measureQubit(qubit);
        }

        // Apply GLIMMER enhancement to measurement results
        const glimmer_factor = try glimmer.getEnhancementFactor();
        for (results) |*result| {
            result.* *= glimmer_factor;
        }

        try self.verifyCoherence("Measurement");
    }

    /// 🎇 Perform quantum teleportation
    fn performTeleport(self: *Self, op: *const QuantumOperation) !void {
        try glimmer.setOptimization(.quantum_teleport);

        if (op.qubits.len != 2) return error.InvalidQubitCount;

        // Create EPR pair for teleportation
        try self.entangle_manager.entangle(op.qubits[0], op.qubits[1]);

        // Perform Bell measurement
        try self.applyCNOT(&QuantumOperation{
            .id = 0,
            .op_type = .cnot,
            .qubits = op.qubits[0..2],
            .parameters = &[_]f64{},
            .gate_sequence = null,
            .timestamp = std.time.timestamp(),
        });

        try self.applyHadamard(&QuantumOperation{
            .id = 0,
            .op_type = .hadamard,
            .qubits = op.qubits[0..1],
            .parameters = &[_]f64{},
            .gate_sequence = null,
            .timestamp = std.time.timestamp(),
        });

        try self.verifyCoherence("Teleport");
    }

    /// ✨ Perform qubit swap with GLIMMER optimization
    fn performSwap(self: *Self, op: *const QuantumOperation) !void {
        try glimmer.setOptimization(.quantum_swap);

        if (op.qubits.len != 2) return error.InvalidQubitCount;

        // Implement swap using three CNOT gates
        for (0..3) |_| {
            try self.applyCNOT(&QuantumOperation{
                .id = 0,
                .op_type = .cnot,
                .qubits = op.qubits[0..2],
                .parameters = &[_]f64{},
                .gate_sequence = null,
                .timestamp = std.time.timestamp(),
            });
        }

        try self.verifyCoherence("Swap");
    }

    /// 🌌 Verify quantum coherence after operation
    fn verifyCoherence(self: *Self, op_name: []const u8) !void {
        const coherence = try self.quantum_state.measure();
        if (coherence < self.coherence_threshold) {
            std.log.warn("⚠️ Low coherence after {s} operation: {d:.4}", .{op_name, coherence});
            return error.DecoherenceError;
        }
        std.log.info("✨ {s} operation completed - Coherence: {d:.4}", .{op_name, coherence});
    }

/// Quantum operation errors
pub const QuantumError = error{
    InsufficientCoherence,
    InvalidOperation,
    QubitOutOfRange,
    DecoherenceError,
    TeleportationFailed,
    GateApplicationFailed,
    InvalidQubitCount,  // Add this
    InvalidParameters,  // Add this
};

};
