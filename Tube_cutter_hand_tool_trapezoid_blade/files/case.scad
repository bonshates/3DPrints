use <roundedcube.scad>
$fn=80;
rotate([0,90,0])translate([-59,0,0])

difference()
{
	hull(){
		translate([0,-1,0])cylinder(r=2,19);
		translate([0,37+3-2,0])cylinder(r=2,19);
		translate([57+3-2,-1,0])cylinder(r=2,19);
		translate([57+3-2,39+3-2,0])cylinder(r=2,19);
	}

	translate([0,0,(19-15.5)/2])hull(){
		translate([0,2,0])cylinder(r=2,15.5);
		translate([0,37-2,0])cylinder(r=2,15.5);
		translate([57-2,2,0])cylinder(r=2,15.5);
		translate([57-2,39-2,0])cylinder(r=2,15.5);
	}

	translate([0,0,(19-15.5)/2])hull(){
		translate([-5,2,0])cylinder(r=2,15.5);
		translate([-5,37-2-.18,0])cylinder(r=2,15.5);
		translate([57-2,2,0])cylinder(r=2,15.5);
		translate([57-2,39-2,0])cylinder(r=2,15.5);
	}
			translate([4,2,-1])rotate([0,0,1.5])roundedcube(50,33,30,4, false);
}
