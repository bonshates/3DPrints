//// Number of fragments
$fn = 40;

// --- Parameters ---
places = 20;         // Updated to 20 for future expansion
stick_height = 30;   // Height of the forks
stick_width  = 4;    // Width of each fork tooth
stick_depth  = 2;    // Thickness of the rail
stick_space  = 1.7;  // Gap between teeth
stick_socket = 2;    // Thickness of the base connection
stick_corr   = 0.2;  // Tolerance for 3D printed fit

// Gap between the two rows (90mm for your wire length)
stick_dist   = 98; 

// --- Main Layout for Build Plate ---

// Row 1
rotate([0,90,0]) side();

// Row 2 (Spaced for 90mm wires)
translate([90, 0, 0]) rotate([0,90,0]) side();

// Connectors
translate([-15, 0, 0]) connector();
translate([-30, 0, 0]) connector();
translate([-45, 0, 0]) connectorandhole(); 

// --- Modules ---

module side() {
  total_length = (places + 1) * stick_width + places * stick_space;
  
  for(i=[-places/2 : places/2]) {
    translate([0, i * (stick_width + stick_space), 0]) {
      stick();
    }
  }
  
  // Upper base rail
  translate([0, 0, -stick_socket/2]) 
    cube([stick_depth, total_length, stick_socket], center=true);
  
  // Bottom attachment rail
  difference() {
    translate([0, 0, -stick_socket*2]) 
        cube([stick_depth, total_length, stick_socket*2], center=true);
    
    // Notches for the connectors
    // Using 3 notches spaced across the 20-place length
    for(i=[-1:1]) { 
      translate([0, i * (total_length/2.5), -stick_socket*2 - stick_corr])
        cube([stick_depth + 2*stick_corr, stick_width + stick_space + stick_corr, 2*stick_socket], center=true);
    }
  }
}

module stick() {
  translate([0, 0, stick_height/2]) cube([stick_depth, stick_width, stick_height], center=true);
  translate([0, 0, stick_height]) rotate([0, 90, 0]) 
    cylinder(d=stick_width + stick_space/3, h=stick_depth, center=true);
}

module connector() {
  translate([0, 0, -stick_socket/2]) 
    cube([stick_width + stick_space, stick_dist, stick_socket], center=true);
  
  translate([0, -stick_dist/2 + stick_width, stick_socket*3/2]) clip_head();
  translate([0, +stick_dist/2 - stick_width, stick_socket*3/2]) clip_head();
}

module clip_head() {
  difference() {
    cube([stick_width + stick_space, 2 * stick_width, 3 * stick_socket], center=true);
    translate([0, 0, stick_socket/2]) 
        cube([stick_width + stick_space + stick_corr, stick_depth - stick_corr, 2 * stick_socket + stick_corr], center=true);
  }
}

module connectorandhole() {
  connector();
  for(side = [-1, 1]) {
    translate([0, side * (stick_dist/2 - 4 * stick_width), 0]) 
    difference() {
        translate([stick_width/2 + stick_socket * 1.5, 0, -stick_socket/2]) 
            cylinder(r=stick_width * 1.5, h=stick_socket, center=true);
        translate([stick_width/2 + stick_socket * 1.5, 0, -stick_socket/2]) 
            cylinder(r=stick_width/2, h=stick_socket + stick_corr, center=true);
    }
  }
}