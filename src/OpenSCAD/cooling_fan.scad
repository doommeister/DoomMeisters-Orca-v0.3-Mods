use <fan_holder.scad>;
//parameters
fan_size = 60;
thickness_fan  = 25;
thickness_lower  = 29;
thickness_upper  = 10;

thickness_web = 2.8;

//calculated variables
jet_side = thickness_lower/2;
kludge = 2;
jet_width = (fan_size - (4*thickness_web))/3;
jet_height = jet_side - (3*thickness_web);
//draw

%fan_dummy();
!translate([0,0,-thickness_lower])color("blue")lower_duct();
translate([0,0,thickness_fan])color("red")upper_duct();


//modu;es

module fan_dummy()
{
fan_mount(size=fan_size, thick = thickness_fan, cutter = false);
}

module upper_duct()
{
fan_mount(size=fan_size, thick = thickness_upper, cutter = false);
}

module lower_duct()
{
difference()
{
	union()
		{
		fan_mount(size=fan_size, thick = thickness_lower, cutter = false);	
		//base
		translate([kludge,kludge,0])
		cube([fan_size-(2*kludge),fan_size-(2*kludge),thickness_web]);	
		//jet
		#translate([0,fan_size,0])
		rotate([90,0,0])
		linear_extrude(height = fan_size, convexity = 5)
		polygon(points = [ [fan_size-kludge,0], 
						[fan_size+jet_side,0],
						[fan_size,jet_side],
						[fan_size-kludge,jet_side]] 
						,convexity = 5);	
		}
		#translate([fan_size/2,thickness_web,thickness_web])cube([fan_size,jet_width,jet_height]);
		#translate([fan_size/2,(2*thickness_web)+(1*jet_width),thickness_web])cube([fan_size,jet_width,jet_height]);
		#translate([fan_size/2,(3*thickness_web)+(2*jet_width),thickness_web])cube([fan_size,jet_width,jet_height]);
	}
}