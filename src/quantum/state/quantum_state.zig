// GLIMMER-enhanced quantum state
pub const QuantumState = struct {
    pub fn process() !void {
        @setGlimmerOptimization(.quantum_process);
    }
};
