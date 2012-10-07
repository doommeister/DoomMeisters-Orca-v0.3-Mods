/*Orca V3 X carriage V2.5 with selectable belt profile 
By the DoomMeister
Based on Raggies X Carriage found at 
"Orca Series linear bearing lm8uu x-carriage - better/newest version"
http://www.thingiverse.com/thing:15420
Also requires my timing belt library found here
http://www.thingiverse.com/thing:19758

*/
use<timing_belts.scad>;
	
profile_t = "T2.5";//adjust profile to suit "T2.5", "T5", "T10", "MXL"
x_offset = 95.5;// set to 95.5, 95.9,96.9 etc to suit based on backing thickess varriable in timing_belts

difference()
{
union()
{
	//get base file
	translate([52.5,0,0])import("orca_03_linear_bearing_x-carriage.v2.5.STL", convexity=5);
	
	// fill up teeth holes
	translate([94.9,12.25,20.1])cube([3,10.25,10.2]);
	translate([94.9,-27.5,20.1])cube([3,15.25,10.2]);

	//make new slot using timing belt library

}


	
	translate([95.5,30,20.2])rotate([0,0,270])#scale([1,1.2,1])belt_length(profile = profile_t, belt_width = 10.2, n = 30);

}