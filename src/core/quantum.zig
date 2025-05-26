//! ✨ STARGUARD Quantum Core
//! Version: 0.13.0
//! Last Modified: 2025-05-26 13:30:53 UTC
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
        // 💠 Initialize quantum state with proper memory allocation
        var state_instance = try allocator.create(quantum_state.QuantumState);
        errdefer allocator.destroy(state_instance);
        state_instance.* = try quantum_state.QuantumState.init(allocator);
        errdefer state_instance.deinit();

        // 🌟 Initialize entanglement manager with quantum state pointer
        var entangle_instance = try allocator.create(entangle.EntanglementManager);
        errdefer allocator.destroy(entangle_instance);
        entangle_instance.* = try entangle.EntanglementManager.init(
            allocator,
            state_instance
        );
        errdefer entangle_instance.deinit();

        // ✨ Initialize quantum ops with both dependency pointers
        var ops_instance = try allocator.create(quantum_ops.QuantumOps);
        errdefer allocator.destroy(ops_instance);
        ops_instance.* = try quantum_ops.QuantumOps.init(
            allocator,
            state_instance,
            entangle_instance
        );
        errdefer ops_instance.deinit();

        // 🎇 Return fully initialized state with GLIMMER enhancement
        return State{
            .state = state_instance,
            .ops = ops_instance,
            .entangle_manager = entangle_instance,
        };
    }

    pub fn deinit(self: *State) void {
        // 💫 Clean up in reverse initialization order with proper memory management
        self.ops.deinit();
        self.allocator.destroy(self.ops);

        self.entangle_manager.deinit();
        self.allocator.destroy(self.entangle_manager);

        self.state.deinit();
        self.allocator.destroy(self.state);
    }
};
