/*Y axis Tensioner Block for Orca 0.3 or similar, V2
By the DoomMeister
Released under the terms of the GNU GPL v3.0 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

//Parameters

block_width = 12;
dist_frog_to_belt = 14;
hole_diameter = 4;
hole_diameter_tensioner = 4;
hole_spacing = 20;
belt_width = 10;
belt_height  = 1.75; //T5 = 2.5 T2.5 = 1.75
clamp_height = 3;

nut_width = 3 ;
nut_af = 7;

clearance = 0.3;
excess = 10;

//derived measurments
block_length = hole_spacing+block_width;
belt_h_clearance = belt_height +1;
belt_h_clamp = belt_height /2;
hole_rad = hole_diameter / 2 + clearance;
hole_rad_t = hole_diameter_tensioner / 2 + clearance;
nipple_rad = (dist_frog_to_belt - belt_h_clearance - belt_h_clamp)/2.05;
block_height = dist_frog_to_belt + belt_h_clearance;


//draw
y_axis_belt_tensioner_set();


module y_axis_belt_tensioner_set()
{
	y_axis_tensioner_block();
	translate([-(nipple_rad*2)+3,10,0])rotate([0,90,0])y_axis_tensioner_nipple();
	translate([-(nipple_rad*2)- 6- block_width,0,0])y_axis_belt_clamp();
}

//modules
module y_axis_tensioner_block()
{
	difference()
	{
		
		radius_block();
		translate([-1,(block_length-belt_width)/2,block_height-belt_h_clearance])cube([block_width+2,belt_width,belt_h_clearance+1]);
		translate([-1,(block_length-belt_width)/2,-1])cube([block_width+2,belt_width,belt_h_clamp+1]);

		translate([block_width/2,(block_length-hole_spacing)/2,-5])clamp_holes();
		translate([-block_width-1,(block_length)/2,(block_height-belt_h_clearance)/2])rotate([0,90,0])m4_through_hole_tensioner();

		translate([(block_width-nut_width)/2,(block_length-nut_af)/2,-5])nut_guide();
	}
}

module y_axis_belt_clamp()
{
	difference()
	{
		
		radius_block();
		translate([block_width/2,(block_length-hole_spacing)/2,-5])clamp_holes();
		translate([-1,-1,clamp_height])cube([block_width+2,block_length+2,block_height]);

	}
}

module y_axis_tensioner_nipple()
{
	difference()
	{
		union()
		{
				rotate([-90,0,0])cylinder(r= nipple_rad-0.5 , h = belt_width, fn=100);
				translate([0,-2,0])rotate([-90,0,0])cylinder(r= nipple_rad+1 , h = 2, fn=100);
				translate([0,belt_width,0])rotate([-90,0,0])cylinder(r= nipple_rad+1 , h = 2, fn=100);
		}
		translate([-0,-3,-nipple_rad-3])cube([nipple_rad+3,block_width+6,nipple_rad*2+6]);
		translate([-nipple_rad+1.5,belt_width/2,0])rotate([0,90,0])m4_through_hole();
	}
}

module m4_through_hole()
{
	cylinder(r=hole_rad , h=50, $fn=100);
}

module m4_through_hole_tensioner()
{
	cylinder(r=hole_rad_t , h=50, $fn=100);
}

module radius_block()
{
block_rad = block_width/2;
translate([block_rad,block_rad,0])cylinder(r= block_rad, h= block_height, $fn=100);
translate([0,block_rad,0])cube([block_width,hole_spacing,block_height]);
translate([block_rad,block_rad+hole_spacing,0])cylinder(r= block_rad, h= block_height, $fn=100);
}


module clamp_holes()
{
	m4_through_hole();
	translate([0,hole_spacing,0])m4_through_hole();
}

module nut_guide()
{
	cube([nut_width + clearance, nut_af + clearance, 30]);
}

//test

echo(nipple_rad);