// --- Parameters ---
num_slots = 10;          // How many wires to hold
housing_width = 2.8;     // Standard is 2.54mm, we add a gap for fit
housing_depth = 2.8;     // Depth of the plastic connector
wall_thickness = 1.5;    // Thickness of the dividers
rail_height = 12;        // Height of the frame
back_thickness = 2;      // Thickness of the back plate

// --- Calculations ---
slot_pitch = housing_width + wall_thickness;
total_width = (slot_pitch * num_slots) + wall_thickness;

// --- The Model ---
union() {
    // 1. The Back Plate
    cube([total_width, back_thickness, rail_height]);

    // 2. The Teeth (Dividers)
    for (i = [0 : num_slots]) {
        translate([i * slot_pitch, back_thickness, 0])
            cube([wall_thickness, housing_depth + 2, rail_height]);
    }
    
    // 3. Optional: Front Lip (to keep wires from sliding out)
    translate([0, back_thickness + housing_depth, 0])
        cube([total_width, 1, 2]); 
}