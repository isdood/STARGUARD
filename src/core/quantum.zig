//! ✨ STARGUARD Quantum Core
//! Version: 0.13.0
//! Last Modified: 2025-05-26 13:28:15 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE

const std = @import("std");
const quantum_state = @import("../quantum/state/quantum_state.zig");
const quantum_ops = @import("../quantum/algorithms/quantum_ops.zig");
const entangle = @import("../quantum/entangle/manager.zig");

pub const State = struct {
    state: *quantum_state.QuantumState,
    ops: *quantum_ops.QuantumOps,
    entangle_manager: *entangle.EntanglementManager,

    pub fn init(allocator: std.mem.Allocator) !State {
        // Initialize components in correct order
        var quantum_state_instance = try quantum_state.QuantumState.init(allocator);
        errdefer quantum_state_instance.deinit();

        var entangle_manager_instance = try entangle.EntanglementManager.init(allocator);
        errdefer entangle_manager_instance.deinit();

        var quantum_ops_instance = try quantum_ops.QuantumOps.init(
            allocator,
            quantum_state_instance,
            entangle_manager_instance
        );
        errdefer quantum_ops_instance.deinit();

        return State{
            .state = quantum_state_instance,
            .ops = quantum_ops_instance,
            .entangle_manager = entangle_manager_instance,
        };
    }

    pub fn deinit(self: *State) void {
        self.ops.deinit();
        self.entangle_manager.deinit();
        self.state.deinit();
    }
};
