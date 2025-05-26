//! ✨ STARGUARD Core Engine
//! Version: 0.13.0
//! Last Modified: 2025-05-26 12:12:22 UTC
//! Author: @isdood

const std = @import("std");
const glimmer = @import("glimmer");

pub const CoreEngine = struct {
    pub fn init() !void {
        try glimmer.setOptimization(.core_init);
    }
};
