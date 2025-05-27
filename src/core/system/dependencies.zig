//! ✨ STARGUARD Dependency Management
//! Version: 0.13.0
//! Last Modified: 2025-05-27 10:30:27 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with `<gl-crystal intensity=0.95>`GLIMMER resonance`</gl-crystal>`

const std = @import("std");
const root = @import("root");

pub const DependencyManager = struct {
    const PackageStatus = struct {
        name: []const u8,
        installed: bool,
        version: ?[]const u8,
        required_version: ?[]const u8,
    };

    const Self = @This();

    /// `<gl-prism color="quantum-azure">`🌌 Core system dependencies`</gl-prism>`
    pub const CoreDeps = struct {
        pub const required = [_][]const u8{
            "zig",
            "fish",
            "git",
            "base-devel",
            "cmake",
            "llvm",
            "clang",
            "lld",
        };

        pub const versions = .{
            .zig = "0.13.0",
            .fish = "3.7.0",
            .llvm = "16.0.0",
        };
    };

    allocator: std.mem.Allocator,
    status_list: std.ArrayList(PackageStatus),

    pub fn init(allocator: std.mem.Allocator) !Self {
        return Self{
            .allocator = allocator,
            .status_list = std.ArrayList(PackageStatus).init(allocator),
        };
    }

    pub fn deinit(self: *Self) void {
        self.status_list.deinit();
    }

    /// `<gl-shimmer color="starweave-gold">`💫 Check system dependencies`</gl-shimmer>`
    pub fn checkDependencies(self: *Self) !void {
        for (CoreDeps.required) |pkg| {
            const status = try self.checkPackage(pkg);
            try self.status_list.append(status);
        }
    }

    /// `<gl-crystal color="quantum-blue">`✨ Check individual package status`</gl-crystal>`
    fn checkPackage(self: *Self, package_name: []const u8) !PackageStatus {
        const result = try std.ChildProcess.exec(.{
            .allocator = self.allocator,
            .argv = &[_][]const u8{ "pacman", "-Qi", package_name },
        });
        defer {
            self.allocator.free(result.stdout);
            self.allocator.free(result.stderr);
        }

        return PackageStatus{
            .name = package_name,
            .installed = result.term.Exited == 0,
            .version = if (result.term.Exited == 0) try self.parseVersion(result.stdout) else null,
            .required_version = getRequiredVersion(package_name),
        };
    }

    /// `<gl-prism color="glimmer-gold">`🎇 Get package version requirements`</gl-prism>`
    fn getRequiredVersion(package_name: []const u8) ?[]const u8 {
        inline for (@typeInfo(CoreDeps.versions).Struct.fields) |field| {
            if (std.mem.eql(u8, field.name, package_name)) {
                return @field(CoreDeps.versions, field.name);
            }
        }
        return null;
    }
};
