// GLIMMER-enhanced core system
pub const System = struct {
    pub fn init() !void {
        @setGlimmerOptimization(.core_init);
    }
};
