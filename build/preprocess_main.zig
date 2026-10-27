const std = @import("std");
const Preprocessor = @import("Preprocessor.zig");

pub fn main(init: std.process.Init) !void {
    // Preprocessor never frees, so an arena is the right allocator.
    const arena = init.arena.allocator();

    const args = try init.minimal.args.toSlice(arena); // GUESS: check std.process.Args
    if (args.len != 5) {
        std.debug.print("usage: {s} <sqlite3.h> <out-sqlite3.h> <sqlite3ext.h> <out-sqlite3ext.h>\n", .{args[0]});
        std.process.exit(1);
    }

    try Preprocessor.sqlite3(arena, init.io, args[1], args[2]);
    try Preprocessor.sqlite3ext(arena, init.io, args[3], args[4]);
}
