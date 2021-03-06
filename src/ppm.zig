const std = @import("std");

pub fn write(writer: std.fs.File.Writer, pixels: anytype) !void {
    const width = pixels.len;
    const height = pixels[0].len;

    std.log.info("writing ppm: {d} x {d}", .{ width, height });

    _ = try writer.write("P3\n");
    try writer.print("{d} {d}\n", .{ width, height });
    _ = try writer.write("255\n");

    var j: i32 = @intCast(i32, height - 1);
    while (j >= 0) {
        if (@mod(j, 10) == 0) {
            std.log.info("scanlines remaining {d} / {d}", .{ j, height });
        }
        var i: usize = 0;
        while (i < width) {
            const pixel = pixels[i][@intCast(usize, j)];

            try writer.print("{d} {d} {d}\n", .{ pixel.r, pixel.g, pixel.b });

            i += 1;
        }
        j -= 1;
    }
}
