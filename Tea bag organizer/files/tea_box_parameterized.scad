// The width of the external wall. Calculated for 0.4mm nozzle, modify for other nozzle or beefing up
ext_wall_width = 1.6;
// The width of the cover wall, which will be cut out of the external wall. Calculated for 0.4mm nozzle, modify for other nozzle or beefing up. Default is half the external wall size.
cover_wall_width = 0.8;
// The width of the internal wall. Calculated for 0.4mm nozzle, modify for other nozzle or beefing up
int_wall_width = 0.8;
// The dimension of the cell in the X direction. Change if you want to shorten or lengthen the box, and mind the resulting box size!
cell_x = 69.6;
// The dimension of the cell in the Y direction. Change if you want to shorten or lengthen the box, and mind the resulting box size!
cell_y = 69.6;
// Number of cells in the X direction.
x_cells = 3;
// Number of cells in the Y direction.
y_cells = 2;
// Margin for each cover wall. Suggested between 0.2 for very exact printers and snug fit to 0.4-0.6 for easy cover pop and/or more extruding or less accurate printers.
wall_margin = 0.2;

// -----------------------------------------------------------------
// Box with cutouts
// -----------------------------------------------------------------

// Design calculated values
cell_z = 71.2 - 1.6;
x_size = 2*ext_wall_width + (x_cells - 1)*int_wall_width + x_cells*cell_x;
y_size = 2*ext_wall_width + (y_cells - 1)*int_wall_width + y_cells*cell_y;

max_size = max(x_size, y_size);

rhomb_x = cell_x/2 - 10;
rhomb_y = cell_z/2 - 8;

function bigRhombus() = [
    [0, -rhomb_y], // bottom point
    [-rhomb_x, 0], // left point
    [0, rhomb_y], // top point
    [rhomb_x, 0]
];

module box() {
    difference(){
        cube([x_size, y_size, 79.2]);
        translate([ext_wall_width, ext_wall_width, 1.6])
            cube([x_size - 2*ext_wall_width, y_size - 2*ext_wall_width, 78]); // internal space
        translate([-1, -1, 71.2]) cube([x_size+2, 1+cover_wall_width, 9]); // inset for cover
        translate([-1, y_size-cover_wall_width, 71.2]) cube([x_size+2, 1+cover_wall_width, 9]); // inset for cover
        translate([-1, -1, 71.2]) cube([1+cover_wall_width, y_size+2, 9]); // inset for cover
        translate([x_size-cover_wall_width, -1, 71.2]) cube([1+cover_wall_width, y_size+2, 9]); // inset for cover
    }
    // Internal walls
    if (x_cells > 1) {
        for (i = [ 1 : x_cells-1 ]) {
            translate([i*cell_x, 1, 0]) cube([int_wall_width, y_size-2, 79.2]);
        }
    }
    if (y_cells > 1) {
        for (i = [ 1 : y_cells-1 ]) {
            translate([1, i*cell_x, 0]) cube([x_size-2, int_wall_width, 79.2]);
        }
    }
}

module cutoutX() {
    translate([x_size, 0, 0]) rotate([0,0,90]) cutoutY();
}

module cutoutY() {
    p_midhorz = cell_x / 2;
    p_midvert = cell_z / 2 + 2;
    translate([p_midhorz, max_size+10, p_midvert]) rotate([90,0,0]) linear_extrude(max_size+20) {
    polygon(bigRhombus());
    translate([rhomb_x, rhomb_y*0.68, 0]) scale([0.32, 0.32, 0.32]) polygon(bigRhombus());
    translate([-rhomb_x, rhomb_y*0.68, 0]) scale([0.32, 0.32, 0.32]) polygon(bigRhombus());
    translate([rhomb_x, -rhomb_y*0.68, 0]) scale([0.32, 0.32, 0.32]) polygon(bigRhombus());
    translate([-rhomb_x, -rhomb_y*0.68, 0]) scale([0.32, 0.32, 0.32]) polygon(bigRhombus());
    }
}

// Cutouts in the sides
difference() {
    box();
    for (i = [ 0 : x_cells-1 ]) {
        translate([ext_wall_width + i*(cell_x + int_wall_width), 0, 1.6]) cutoutY();
    }
    for (i = [ 0 : y_cells-1 ]) {
        translate([0, ext_wall_width + i*(cell_y + int_wall_width), 1.6]) cutoutX();
    }
}


// -----------------------------------------------------------------
// Box cover
// -----------------------------------------------------------------

x_csize = 2*ext_wall_width + (x_cells - 1)*int_wall_width + x_cells*cell_x + 2*wall_margin;
y_csize = 2*ext_wall_width + (y_cells - 1)*int_wall_width + y_cells*cell_y + 2*wall_margin;
cover_offset = cover_wall_width + wall_margin;

module cbox() {
    difference(){
        cube([x_csize, y_csize, 9.6]);
        translate([cover_offset, cover_offset, 1.6])
            cube([x_csize - 2*cover_offset, y_csize - 2*cover_offset, 10]); // internal space
    }
}

translate([0, y_size+50, 0]) cbox();
