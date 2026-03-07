// Parametric hydro halo / watering ring with friction-fit stem
//
// Copyright 2021 Keegan McAllister
// License: CC-BY 4.0
// https://creativecommons.org/licenses/by/4.0/

include <MCAD/units.scad>

// Inner diameter of halo (mm)
halo_id = 120.0;

// Portion of circle to enclose (degrees)
halo_angle = 300;

// Width of water channel inside halo (mm)
channel_width = 8.0;

// Thickness of material (mm)
thickness = 1.0;

// Number of side holes
num_holes = 6;

// Include holes on the ends as well?
end_holes = true;

// Hole diameter (mm)
hole_id = 1.5;

// Inner diameter of stem (mm)
stem_id = 4.5;

// Length of stem (mm)
stem_length = 6.0;

// Height of bumper under stem (mm)
bumper_height = 0.6;

// Width of bumper under stem (mm)
bumper_width = 1.0;

// Ask OpenSCAD for rounder circles with more edges
$fa = 6;
$fs = 0.25;

outer_width = channel_width + 2*thickness;

hole_spacing = halo_angle / (num_holes + 1);

stem_od = stem_id + 2*thickness;

module hemicircle(d) {
    difference() {
        circle(d=d);

        translate(-d/2 * X)
        square([d, d]);
    }
}

module stem_pos(dz=channel_width/2 + thickness) {
    rotate(halo_angle/2 * Z)
    translate(dz * Z)
    translate((halo_id + outer_width)/2 * X)
    children();
}

module halo_profile() {
    hemicircle(d=outer_width);

    translate(-outer_width/2 * X)
    square([outer_width, thickness]);
}

module halo_shell() {
    // channel
    rotate_extrude(angle=halo_angle)
    translate((halo_id + outer_width)/2 * X)
    rotate(180*Z)
    translate(-thickness*Y)
    difference() {
        halo_profile();
        hemicircle(d=channel_width);
    }

    // end caps
    // epsilon fudge factor avoids manifold issues
    for (t=[0, halo_angle-epsilon]) {
        rotate(t*Z)
        translate((halo_id + outer_width)/2*X)
        translate(thickness*Z)
        rotate(-90*X)
        linear_extrude(height=thickness)
        difference() {
            halo_profile();

            if (end_holes) {
                translate(-hole_id/2 * Y)
                circle(d=hole_id);
            }
        }
    }

    // stem
    stem_pos()
    cylinder(d=stem_od, h=stem_length);

    // bumper (prevents tube from sealing against channel)
    stem_pos(dz=thickness + bumper_height/2)
    cube([bumper_width, stem_id*1.5, bumper_height], center=true);
}

difference() {
    halo_shell();

    // holes
    for (i=[1:num_holes]) {
        rotate(i*hole_spacing * Z)
        translate((thickness + hole_id/2) * Z)
        translate((halo_id/2 - thickness) * X)
        rotate(90 * Y)
        cylinder(d=hole_id, h=3*thickness);
    }

    // hollow out stem, into channel
    stem_pos()
    translate(-(thickness + epsilon)*Z)
    cylinder(d=stem_id, h=stem_length+thickness+2*epsilon);
}
