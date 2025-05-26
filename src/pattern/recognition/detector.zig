// GLIMMER-enhanced pattern recognition
pub const PatternDetector = struct {
    pub fn detect() !void {
        @setGlimmerOptimization(.pattern_detect);
    }
};
