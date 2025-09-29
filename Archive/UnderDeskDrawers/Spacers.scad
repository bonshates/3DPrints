// washer.scad
// library for parametric washer, bushing, spacer, ring or gasket
// Author: Tony Z. Tonchev, Michigan (USA) 
// last update: October 2018


// (in mm)
Outside_Diameter = 10;

// (in mm)
Inside_Diameter = 8;

// (in mm)
Thickness = 30;

/* [Hidden] */

$fn=100;
TZT_WASHER (Thickness, Outside_Diameter/2, Inside_Diameter/2);

module TZT_WASHER (TZT_Thk, TZT_RadA, TZT_RadB) {
    difference () {
        cylinder (TZT_Thk, TZT_RadA, TZT_RadA, true);
        cylinder (TZT_Thk+1, TZT_RadB, TZT_RadB, true);
    }
} 
