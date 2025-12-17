const std: type = @import("std");

pub fn build(b: *std.Build) !void {
    const target: std.Build.ResolvedTarget = b.standardTargetOptions(.{});
    const optimise: std.builtin.OptimizeMode = b.standardOptimizeOption(.{});

    // collecting all c files in src folder
    var c_src_files: std.ArrayList([]const u8) = try std.ArrayList([]const u8).initCapacity(b.allocator, 1);
    defer c_src_files.deinit(b.allocator);

    const build_root_path: []const u8 = b.build_root.path orelse return error.BUILD_ROOT_PATH_NOT_SET;
    const src_path: []const u8 = try std.fs.path.join(b.allocator, &[_][]const u8{build_root_path, "src"});

    var src_dir: std.fs.Dir = try std.fs.openDirAbsolute(src_path, .{ .iterate = true });
    defer src_dir.close();
    var src_iterator: std.fs.Dir.Iterator = src_dir.iterate();

    // iterate over all entries in src folder
    while (try src_iterator.next()) |entry| { 
        // checking if this file is valid C source
        if (entry.kind == .file and std.mem.eql(u8, ".c", std.fs.path.extension(entry.name)) == true) {
            const curr_c_filename_w_src_prepended: []const u8 = try std.fs.path.join(b.allocator, &[_][]const u8{"src", entry.name});
            try c_src_files.append(b.allocator, curr_c_filename_w_src_prepended);
        }
    }

    // adding executable step
    const exe: *std.Build.Step.Compile = b.addExecutable(.{
        .name = "asciify",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimise,
            .link_libc = true,
        }),
    });

    // adding include path
    exe.addIncludePath(b.path("include"));
    
    // adding C source files w/ flags
    exe.root_module.addCSourceFiles(.{
        // .files = &c_src_files,
        .files = c_src_files.items,
        .flags = &[_][]const u8{
            "-Wall",
            "-Wextra",
            "-Werror",
        },
    });

    // installing the executable to the parent folder
    const install_exe = b.addInstallArtifact(exe, .{
        .dest_dir = .{
            .override = .{ .custom = ".." },
        }
    });
    b.default_step.dependOn(&install_exe.step);

}
