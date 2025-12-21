//// Number of fragments
$fn = 40;

places = 30; // Number of wire slots

// --- Dimensions ---
stick_width  = 4;
stick_height = 30;
stick_depth  = 2;
stick_space  = 1.7;
stick_socket = 2;
stick_dia    = 3;
stick_corr   = 0.2;

// Updated for 90mm wire length (gap between the forks)
stick_dist   = 98; 

// Calculate total length of the side rail
total_rail_length = (places + 1) * stick_width + places * stick_space;

// --- Main Layout ---

// Side Row 1
rotate([0,90,0]) side();

// Side Row 2 (90mm away)
translate([90,0,0]) rotate([0,90,0]) side();

// The Floor (Connects the two sides)
translate([45, 0, -stick_socket*2]) floor_plate();

// Connectors & Mounting Pieces (Printed separately)
translate([-20, 0, 0]) connector();
translate([-40, 0, 0]) connector();
translate([-100, 0, 0]) connectorandhole();

// --- Modules ---

module floor_plate() {
    // The plate that sits under the wires
    // Width is stick_dist to overlap with the side bases
    cube([stick_dist, total_rail_length, 1], center=true);
}

module side() {
  for(i=[-places/2:places/2]) {
    translate([0, i*(stick_width+stick_space), 0]) {
      stick();
    }
  }
  // Upper base rail
  translate([0, 0, -stick_socket/2]) 
    cube([stick_depth, total_rail_length, stick_socket], center=true);
  
  // Bottom attachment rail with notches for the clips
  difference() {
    translate([0, 0, -stick_socket*2]) 
        cube([stick_depth, total_rail_length, stick_socket*2], center=true);
    for(i=[-2:2]) {
      translate([0, +i/2*(places/2-1)*(stick_width+stick_space), -stick_socket*2-stick_corr])
        cube([stick_depth+2*stick_corr, stick_width+stick_space+stick_corr, 2*stick_socket], center=true);
    }
  }
}

module stick() {
  translate([0, 0, stick_height/2]) cube([stick_depth, stick_width, stick_height], center=true);
  translate([0, 0, stick_height]) rotate([0, 90, 0]) 
    cylinder(d=stick_width+stick_space/3, h=stick_depth, center=true);
}

module connectorandhole() {
  connector();
  // Mounting ears
  translate([0, -stick_dist/2+4*stick_width, 0]) difference() {
    translate([stick_width/2+stick_socket*3/2, 0, -stick_socket/2]) cylinder(r=stick_width*3/2, h=stick_socket, center=true);
    translate([stick_width/2+stick_socket*3/2, 0, -stick_socket/2]) cylinder(r=stick_width/2, h=stick_socket+stick_corr, center=true);
  }
  translate([0, +stick_dist/2-4*stick_width, 0]) difference() {
    translate([stick_width/2+stick_socket*3/2, 0, -stick_socket/2]) cylinder(r=stick_width*3/2, h=stick_socket, center=true);
    translate([stick_width/2+stick_socket*3/2, 0, -stick_socket/2]) cylinder(r=stick_width/2, h=stick_socket+stick_corr, center=true);
  }
}

module connector() {
  translate([0, 0, -stick_socket/2]) cube([stick_width+stick_space, stick_dist, stick_socket], center=true);
  
  // Clip 1
  translate([0, -stick_dist/2+stick_width, stick_socket*3/2]) difference() {
    cube([stick_width+stick_space, 2*stick_width, 3*stick_socket], center=true);
    translate([0, 0, stick_socket/2]) cube([stick_width+stick_space+stick_corr, stick_depth-stick_corr, 2*stick_socket+stick_corr], center=true);
  }
  
  // Clip 2
  translate([0, +stick_dist/2-stick_width, stick_socket*3/2]) difference() {
    cube([stick_width+stick_space, 2*stick_width, 3*stick_socket], center=true);
    translate([0, 0, stick_socket/2]) cube([stick_width+stick_space+stick_corr, stick_depth-stick_corr, 2*stick_socket+stick_corr], center=true);
  }
}