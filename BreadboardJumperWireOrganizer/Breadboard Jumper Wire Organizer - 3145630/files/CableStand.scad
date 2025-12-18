//// Number of fragments
$fn              = 40;


places=30;

stick_width  = 4;
stick_height = 30;
stick_depth  = 2;
stick_space  = 1.7;
stick_socket = 2;
stick_dia    = 3;
stick_dist   = 180;
stick_corr   = 0.2;


rotate([0,90,0])side();
translate([50,0,0]) rotate([0,90,0])side();
translate([100,0,0]) rotate([0,90,0])side();
translate([-20,0,0])connector();
translate([-40,0,0])connector();
translate([-60,0,0])connector();
translate([-80,0,0])connector();
translate([-100,0,0])connectorandhole();

module side() {
  for(i=[-places/2:places/2]) {
    translate([0,i*(stick_width+stick_space),0]) {
      stick();
    }
  }
  translate([0,0,-stick_socket/2])cube([stick_depth,(places+1)*stick_width+places*stick_space,stick_socket],center=true);
  difference() {
    translate([0,0,-stick_socket*2])cube([stick_depth,(places+1)*stick_width+places*stick_space,stick_socket*2],center=true);
    for(i=[-2:2]) {
      translate([0,+i/2*(places/2-1)*(stick_width+stick_space),-stick_socket*2-stick_corr])cube([stick_depth+2*stick_corr,stick_width+stick_space+stick_corr,2*stick_socket],center=true);
    }
  }
}

module stick() {
  translate([0,0,stick_height/2])cube([stick_depth,stick_width,stick_height],center=true);
  translate([0,0,stick_height])rotate([0,90,0])cylinder(d=stick_width+stick_space/3,h=stick_depth,center=true);
}

module connectorandhole() {
  connector();
  translate([0,-stick_dist/2+4*stick_width,0])difference() {
    translate([stick_width/2+stick_socket*3/2,0,-stick_socket/2])cylinder(r=stick_width*3/2,h=stick_socket,center=true);
    translate([stick_width/2+stick_socket*3/2,0,-stick_socket/2])cylinder(r=stick_width/2,h=stick_socket+stick_corr,center=true);
  }
  translate([0,+stick_dist/2-4*stick_width,0])difference() {
    translate([stick_width/2+stick_socket*3/2,0,-stick_socket/2])cylinder(r=stick_width*3/2,h=stick_socket,center=true);
    translate([stick_width/2+stick_socket*3/2,0,-stick_socket/2])cylinder(r=stick_width/2,h=stick_socket+stick_corr,center=true);
  }
}

module connector() {
  translate([0,0,-stick_socket/2]) cube([stick_width+stick_space,stick_dist,stick_socket],center=true);
  for (i=[-2:2]) {
    translate([0,-stick_dist/2+stick_width,stick_socket*3/2]) difference() {
      cube([stick_width+stick_space,2*stick_width,3*stick_socket],center=true);
      translate([0,0,stick_socket/2])cube([stick_width+stick_space+stick_corr,stick_depth-stick_corr,2*stick_socket+stick_corr],center=true);
    }
  }
  translate([0,+stick_dist/2-stick_width,stick_socket*3/2]) difference() {
    cube([stick_width+stick_space,2*stick_width,3*stick_socket],center=true);
    translate([0,0,stick_socket/2])cube([stick_width+stick_space+stick_corr,stick_depth-stick_corr,2*stick_socket+stick_corr],center=true);
  }
  translate([0,0,stick_socket*3/2]) difference() {
    cube([stick_width+stick_space,2*stick_width,3*stick_socket],center=true);
    translate([0,0,stick_socket/2])cube([stick_width+stick_space+stick_corr,stick_depth-stick_corr,2*stick_socket+stick_corr],center=true);
  }
}
