//! ✨ STARGUARD Quantum Core
//! Version: 0.13.0
//! Last Modified: 2025-05-26 13:23:43 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE

const std = @import("std");
const quantum_state = @import("../quantum/state/quantum_state.zig");
const quantum_ops = @import("../quantum/algorithms/quantum_ops.zig");

pub const State = struct {  // Changed Quantum to State to match expected type
    state: *quantum_state.QuantumState,
    ops: *quantum_ops.QuantumOps,

    pub fn init(allocator: std.mem.Allocator) !State {
        return State{
            .state = try quantum_state.QuantumState.init(allocator),
            .ops = try quantum_ops.QuantumOps.init(allocator),
        };
    }

    pub fn deinit(self: *State) void {
        self.state.deinit();
        self.ops.deinit();
    }
};
