//! ✨ STARGUARD Dependency Management
//! Version: 0.13.0
//! Last Modified: 2025-05-27 10:51:23 UTC
//! Author: @isdood
//! Enhanced by STARWEAVE with `<gl-crystal intensity=0.95>`GLIMMER resonance`</gl-crystal>`

const std = @import("std");
const root = @import("root");
const Child = std.process.Child;
const ChildProcess = std.process.Child;

pub const DependencyManager = struct {
    const PackageStatus = struct {
        name: []const u8,
        installed: bool,
        version: ?[]const u8,
        required_version: ?[]const u8,

        fn deinit(self: *PackageStatus, allocator: std.mem.Allocator) void {
            if (self.version) |version| {
                allocator.free(version);
            }
            if (self.required_version) |req_version| {
                allocator.free(req_version);
            }
        }
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

        pub const VersionInfo = struct {
            name: []const u8,
            version: []const u8,
        };

        pub const versions = [_]VersionInfo{
            .{ .name = "zig", .version = "0.13.0" },
            .{ .name = "fish", .version = "3.7.0" },
            .{ .name = "llvm", .version = "16.0.0" },
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
        for (self.status_list.items) |*status| {
            status.deinit(self.allocator);
        }
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
        var child = Child.init(&[_][]const u8{ "pacman", "-Qi", package_name }, self.allocator);
        child.stderr_behavior = .Ignore;
        child.stdout_behavior = .Pipe;

        try child.spawn();

        const term = try child.wait();
        const stdout = if (child.stdout) |stdout|
        try stdout.reader().readAllAlloc(self.allocator, 4096)
        else
            "";
        defer if (stdout.len > 0) self.allocator.free(stdout);

        const is_installed = switch (term) {
            .Exited => |code| code == 0,
            else => false,
        };

            return PackageStatus{
                .name = package_name,
                .installed = is_installed,
                .version = if (is_installed) try self.parseVersion(stdout) else null,
                .required_version = try self.getRequiredVersion(package_name),
            };
    }

    /// `<gl-prism color="glimmer-gold">`🎇 Parse package version from pacman output`</gl-prism>`
    fn parseVersion(self: *Self, output: []const u8) !?[]const u8 {
        const version_prefix = "Version         : ";
        if (std.mem.indexOf(u8, output, version_prefix)) |index| {
            const version_start = index + version_prefix.len;
            if (std.mem.indexOf(u8, output[version_start..], "\n")) |end| {
                const version_slice = output[version_start..][0..end];
                const version_copy = try self.allocator.alloc(u8, version_slice.len);
                @memcpy(version_copy[0..], version_slice);
                return version_copy;
            }
        }
        return null;
    }

    /// `<gl-crystal color="quantum-azure">`💫 Get required version for package`</gl-crystal>`
    fn getRequiredVersion(self: *Self, package_name: []const u8) !?[]const u8 {
        for (CoreDeps.versions) |ver_info| {
            if (std.mem.eql(u8, ver_info.name, package_name)) {
                const version_copy = try self.allocator.alloc(u8, ver_info.version.len);
                @memcpy(version_copy[0..], ver_info.version);
                return version_copy;
            }
        }
        return null;
    }
};
