use <roundedcube.scad>

$fn=80 ;

rohr = [[3,20],[4,20],[6,20],[8,20]];
module part(){
	union(){
		difference(){
			b = 108.0 ;
			h = 156.0;			
			rohrset(true,[1.0,1.0,1.0]);			
		}
	}
}

module rohrset(boo, skalierung){

	module rohr(i, abstand) {
		translate([i*(abstand-7 +(rohr[i][0]/2)) ,0,-5])union(){
			hull(){
				translate([0, -5+rohr[i][0]/2  ,-5+5+rohr[i][0]/2])scale(skalierung)sphere((rohr[i][0])/2+0.8);
				translate([0, -5+rohr[i][0]/2  ,rohr[i][1]])scale(skalierung)sphere((rohr[i][0])/2+0.8);
			}
		}
	}

	union(){
		for (i= [0:1:3]) {
			abstand = 17 ;
			
			rohr(i, abstand, skalierung);
			if(boo==true) {
				mirror([0,1,0])
				rotate([-90,0,0])
				translate([0, 0 , 5-rohr[i][0]/2 ])
				linear_extrude(rohr[i][0]/2+4)
				projection(false)rotate([90,0,0])rohr(i, abstand, skalierung);
			}
			translate([i*(abstand-6 +(rohr[i][0]/2)) ,-15,-3]){
				// color("silver")cylinder(rohr[i][1], r=(rohr[i][0])/2);
			}
		}
	}
}

h=14.5 ;


// trapezklinge = 60.5, 32, 19; 3.5 x 4; 0.66mm
w0=60.5 ;
w1=32 ;
h0 = 19;
rotate([0,0,-8])
{
	// Unterteil
	rotate([0,0,8])
	translate([8.5,-1,0]){
	difference()
	{
		roundedcube(58,16,h,4, false);
		translate([8,6,0])part();
		color("red")translate([-5,-8,7.25 - 1.75/2  +.7 ])rotate([-2,0,0])cube([70,20,1.75]);
		color("orange")translate([-5,-8,7.25 - 1.75/2  - .7 ])rotate([2,0,0])cube([70,20,1.75]);
		color("blue")translate([-5,-8,7.25 - 1.75/2])cube([57,26,1.75]);
		translate([w0/2-6,-3,-1])roundedcube(4,16.5,h-4.2,1,false);
	}
	 translate([0,12,0])cube([4,4,h]);
	}
	 
	 
	//Oberteil
	rotate([0,0,-15])
	translate([8,-2,0])
	union(){
		difference()
		{
			translate([-5,-29,0])roundedcube(72,33,h,4, false);
			translate([-0.5,-11.5,-0.5])roundedcube(62,17,h+1,2, false);
			
			translate([w0/2,0,7.25])
			linear_extrude(8)
			rotate([180,0,0])difference(){
				polygon([ [-w0/2,0] , [-w1/2, h0+.2] ,[-4.9, h0+.2],[-4.9, h0-2.3],[-5+3.3/2, h0-2.3],[-5+3.3, h0-2.7],  [-5+3.3,h0+.2],   [5-3.4,h0+.2], [5-3.4,h0-2.3], [4.9,h0-2.3], [4.9,h0+.2] , [w1/2, h0+.2],  [w0/2, 0],  [0,0] ]);
				translate([-5+3.5/2,h0-2.5,0])circle(3.3/2);
				translate([5-3.5/2,h0-2.5,0])circle(3.3/2);
			}
			
			// schrauben
			translate([w0/2-11,-h0-2.2,-1])cylinder(10,r=1.85);
			translate([w0/2-11,-h0-2.2,7.6])cylinder(8,r=3.9);
			translate([w0/2+11,-h0-2.2,-1])cylinder(10,r=1.85);
			translate([w0/2+11,-h0-2.2,7.6])cylinder(8,r=3.9);
			
			// optional M3 zur klemmung des Messers
			translate([w0/2-3.25,-h0+2.5,-1])cylinder(10,r=1.4);
			translate([w0/2-3.25,-h0+2.5,7.6])cylinder(8,r=3.18);
		
			// Kerbe Arretierung Gehaeuse
			translate([52.1,-28.3-0.7,1.5])
			minkowski()
			{
				cylinder(11, r=1.05);
				sphere(1);
			}
			
		}
		translate([w0/2-3.5,-13,0])roundedcube(3,14.5,h-7.25,1,false);
		
		translate([26.75,-0.5,6.9])
		intersection()
		{
			roundedcube(3,1.2,1.5,1,false);
			translate([0,0.55,-0.5])cube([3,1.7,5]);
		
		}
		%translate([30.25,0,8])klemmung();
	}

	translate([2,-6.6,0])rotate([0,0,-90+8])klemmung();

	// Messer
	%
	rotate([0,0,-15])
	translate([8,-2,0])
	translate([w0/2,0,7.25])
	linear_extrude(0.66)
	rotate([180,0,0])
	difference(){
		polygon([ [-w0/2,0] , [-w1/2, h0] ,[-5, h0],[-5, h0-2.5],[-5+3.5/2, h0-2.5],[-5+3.5, h0-2.5],  [-5+3.5,h0],   [5-3.5,h0], [5-3.5,h0-2.5], [5,h0-2.5], [5,h0] , [w1/2, h0],  [w0/2, 0],  [0,0] ]);
		translate([-5+3.5/2,h0-2.5,0])circle(3.5/2);
		translate([5-3.5/2,h0-2.5,0])circle(3.5/2);
	}


	// Verbindung Radien

	r0=30 ;
	r1=r0-4 ;

	difference()
	{
		translate([-r1*0.3,-r1*0.3,0])
		linear_extrude(h)
		difference(){
			circle(r0);
			circle(r1);
			
		}
		translate([10,-28,-1])cube([15,46,h+8]);
	}

}

// Klemmstück
module klemmung(){
	linear_extrude(3)
	rotate([180,0,0])
	union(){
		difference(){
			polygon([ [-w0/2,0] , [-w1/2, h0] ,[-5, h0],[-5, h0-2.5],[-5+3.5/2, h0-2.5],[-5+3.5, h0-2.5],  [-5+3.5,h0],   [5-3.5,h0], [5-3.5,h0-2.5], [5,h0-2.5], [5,h0] , [w1/2, h0],  [w0/2, 0],  [0,0] ]);
			translate([-5+3.5/2,h0-2.5,0])circle(3.5/2);
			translate([5-3.5/2,h0-2.5,0])circle(3.5/2);
			translate([-w0/2,0,0])square([w0,12]);
			translate([-5.75,h0-4.5,0])square([11.5,5]);
		}

		translate([-11,h0+2.2,0])
		difference(){
			circle(3.5);
			circle(2);
		}
		translate([11,h0+2.2,0])
		difference(){
			circle(3.5);
			circle(2);
		}
	}
}


// Gehaeuse
// stehend:
translate([80,0,1])rotate([0,90,0])translate([-59,0,0])

// zu Teil ausgerichtet liegend:
//translate([00,0,0])rotate([0,0,-15])translate([2 +16.1,-40+8.8,-18+15.5])
union(){

	translate([42,-0.7,4])minkowski(){
		cylinder(11, r=1);
		sphere(1);
	}
	difference()
	{
		// Aussen
		hull(){
			translate([0,-1,0])cylinder(r=2,h+5);
			translate([0,37+3-2,0])cylinder(r=2,h+5);
			translate([57+3-2,-1,0])cylinder(r=2,h+5);
			translate([57+3-2,39+3-2,0])cylinder(r=2,h+5);
		}

		// selbe Kontur wie Werkzeug
		translate([0,0,(h+4.5-h+1)/2])hull(){
			translate([0,2,0])cylinder(r=2,h+1);
			translate([0,37-2,0])cylinder(r=2,h+1);
			translate([57-2,2,0])cylinder(r=2,h+1);
			translate([57-2,39-2,0])cylinder(r=2,h+1);
		}

		// verlaengert nach aussen fuer geraden Einschub
		translate([0,0,(h+4.5-h+1)/2])hull(){
			translate([-5,2,0])cylinder(r=2,h+1);
			translate([-5,37-2-.18,0])cylinder(r=2,h+1);
			translate([57-2,2,0])cylinder(r=2,h+1);
			translate([57-2,39-2,0])cylinder(r=2,h+1);
		}
		
		// Seiten oeffnen, Material sparen
		translate([4,2,-1])rotate([0,0,1.5])roundedcube(50,33,30,4, false);

	}
}