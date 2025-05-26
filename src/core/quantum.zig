//! ✨ STARGUARD Quantum Core
//! Version: 0.13.0
//! Last Modified: 2025-05-26 13:05:21 UTC
//! Author: @isdood

const std = @import("std");
const quantum_state = @import("../quantum/state/quantum_state.zig");
const quantum_ops = @import("../quantum/algorithms/quantum_ops.zig");

pub const Quantum = struct {
    state: *quantum_state.QuantumState,
    ops: *quantum_ops.QuantumOps,

    pub fn init(allocator: std.mem.Allocator) !Quantum {
        return Quantum{
            .state = try quantum_state.init(allocator),
            .ops = try quantum_ops.init(allocator),
        };
    }

    pub fn deinit(self: *Quantum) void {
        self.state.deinit();
        self.ops.deinit();
    }
};
