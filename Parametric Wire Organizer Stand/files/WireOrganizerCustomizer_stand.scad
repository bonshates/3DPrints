// Radius of Circle
circleRadius = 2; // [1:0.25:15]

// Width of Post
postWidth = 3; // [0.5:0.5:10]

// Height of Post Before Circle
postHeightBeforeCircle = 10; // [0:0.5:40]

// Width of Base
baseWidth = 3; // [1:0.25:10]

// Width of Gap Between Posts
gap = 2.5; // [1:0.5:15]

// number of posts
numPosts = 11; // [1:1:20]

// depth of holder
depth = 17; // [1:1:50]

// overall length
distance = 200; // [1:30:500]

// width of spacers
spacerWidth = 9; // [1:10:50]

// calculated variables
postHeight = postHeightBeforeCircle + circleRadius;
totalLength = (numPosts * postWidth) + (gap * (numPosts - 1));

// Model Generation
module left() {
	cube ([depth,totalLength,baseWidth]);
	
	for (i = [0 : postWidth + gap : totalLength]){
		translate([0, i, baseWidth]){
			cube([depth, postWidth, postHeight]);
		}
		translate([0, (i+postWidth/2), postHeight+baseWidth]){
			rotate([0, 90, 0]){
				cylinder(h=depth, r=circleRadius);
			}
		}
	}
}

module right(){
    translate([distance-depth,0,0]){
        left();
        };
    }

module complete() {
    left();
    right();
    posThirdSpacer = (numPosts)*(postWidth+gap)-spacerWidth-gap;
    cube ([distance,spacerWidth,baseWidth]);
    translate([0,posThirdSpacer, 0]){
        cube ([distance,spacerWidth,baseWidth]);
        }
    translate([0,posThirdSpacer/2, 0]){
        cube ([distance,spacerWidth,baseWidth]);
        }
    }

complete();