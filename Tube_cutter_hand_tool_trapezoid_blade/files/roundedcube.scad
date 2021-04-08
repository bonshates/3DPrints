$fn=30;
// roundedcube(10,10,10,2,true);

minkowski_custom_cube(10,10,10,1, true);



module roundedcube(xdim, ydim, zdim, rad, center) {
// wenn rad  = 0 -> = 0.0001


	if (center==true) {
		hull() {
			translate([xdim/2-rad,-ydim/2+rad,-zdim/2])cylinder(zdim, r=rad+0.0001);
			translate([-xdim/2+rad,-ydim/2+rad,-zdim/2])cylinder(zdim, r=rad+0.0001);
			
			translate([xdim/2-rad,ydim/2-rad,-zdim/2])cylinder(zdim, r=rad+0.0001);
			translate([-xdim/2+rad,ydim/2-rad,-zdim/2])cylinder(zdim, r=rad+0.0001);
		}
	} else {
		hull() {
			translate([rad,rad,0])cylinder(zdim, r=rad+0.0001);
			translate([xdim-rad,ydim-rad,0])cylinder(zdim, r=rad+0.0001);
			translate([rad,ydim-rad,0])cylinder(zdim, r=rad+0.0001);
			translate([xdim-rad,rad,0])cylinder(zdim, r=rad+0.0001);
		}
	}
}


module minkowski_custom_cube(xdim, ydim, zdim, rad, center){
	if(center==true) {
		translate([-xdim/2,-ydim/2,-zdim/2])createCube(xdim, ydim, zdim, rad);
	} else {
		createCube(xdim, ydim, zdim, rad);
	}
}

module createCube(xdim, ydim, zdim, rad){
	for(i=[xdim, ydim, zdim]){
		if (i/2 < rad) {
			echo("Warnung: Radius groesser als Kantenlaenge! Wuerfel wird zur Kugel expandiert.");
		}
	}

	translate([rad,rad,rad])minkowski(){
		cube([xdim-2*rad, ydim-2*rad, zdim-2*rad]);
		sphere(rad);
	}
}