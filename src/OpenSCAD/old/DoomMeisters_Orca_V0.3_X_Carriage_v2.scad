/*Orca X Bracket
By the DoomMeister

Requires MCAD Library
Openscad 12.11
My Orca V0.3 LM8UU holders
My Timing Belts Library http://www.thingiverse.com/thing:19758
The Belt clip from My Y axis belt clamp http://www.thingiverse.com/thing:16012
DXF files for sketch output

this is not a fully parametric model so be careful when adjusing things.

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

include <orca_simple_lm8uu_bearings_v6.scad>;
use <mcad\motors.scad>;
use<timing_belts.scad>;



//Geometry
HOLE_DIA = 4;
HOLE_SPACING_X12 = 10;
HOLE_SPACING_X3 = 12.5;
HOLE_SPACING_Y12 = 21.74;
HOLE_SPACING_Y13 = 69.48;
HOLE_OFFSET_X1 = 33;
HOLE_OFFSET_X3 = 31.75;
HOLE_OFFSET_Y1 = 6;

DIM_X = 70;
DIM_Y = 118;
DIM_X_SPACING = 70.2;

EXT_DIM_X = 38.018;
EXT_DIM_Y = 51.48;

CAR_THICKNESS = 12.5;
WEB_THICKNESS = 5;

BELT_OFFSET_Y = 6.5;

BELT_CLAMP_WIDTH = 15;
BELT_CLAMP_LENGTH = 18;
BELT_CLAMP_HEIGHT = 21.5+CAR_THICKNESS;
BELT_CLAMP_HOLE_RAD = 4.5;
CLAMP_HOLE_SPACING = 20;

//Parameters
HOLE_CLEARANCE = 0.3;
HOLE_RADIUS = (HOLE_DIA + HOLE_CLEARANCE)/2;
M4_EFF_DIA = (1/0.86602)*(7+HOLE_CLEARANCE);
M4_EFF_RAD = M4_EFF_DIA/2;

//COmment out to please
rotate([0,180,0])car_body(); //for object out put in correct orientation
//sketch(); //To see Assembly


module sketch()
{
//Draw 4mm plate
%linear_extrude( height = 4, convexity = 10) import(file = "x_bracket.dxf", layer = "0", center = false) ;
%translate([0,74,4])rotate([90,0,0])linear_extrude( height = 4, convexity = 10)import(file = "x_motor_bracket.dxf", layer = "0", center = false);
%translate([30,74,23.59])rotate([90,0,0])stepper_motor_mount(17);

//X bars
%translate([-210,(HOLE_SPACING_Y12 + HOLE_OFFSET_Y1+4)/2,-CAR_THICKNESS-7.5])rotate([0,90,0])cylinder(r = 4, h = 420);
%translate([-210,(HOLE_SPACING_Y12 + HOLE_OFFSET_Y1+4)/2 + DIM_X_SPACING,-CAR_THICKNESS-7.5])rotate([0,90,0])cylinder(r = 4, h = 420);

//belt
%translate([-210,(HOLE_SPACING_Y12 + HOLE_OFFSET_Y1+4)/2-BELT_OFFSET_Y,-CAR_THICKNESS-7.5-2])rotate([180,0,0])belt_length(profile = "T2.5", belt_width = 5, n = round(420/2.5));

//extruder
%translate([EXT_DIM_X,EXT_DIM_Y,-80])ext_hotend_blank();

translate([0,0,0])color("blue")car_body();



%color("red")translate([0,0,-CAR_THICKNESS])rotate([180,0,90])orca_lm8uu_v4();
%color("red")translate([DIM_X-Z_BLOCK_LENGTH,0,-CAR_THICKNESS])rotate([180,0,90])orca_lm8uu_v4();
%color("red")translate([(DIM_X-Z_BLOCK_LENGTH )/2,DIM_X_SPACING,-CAR_THICKNESS])rotate([180,0,90])orca_lm8uu_v4();
}





module car_body()
{
	difference()
	{
	union()
	{
		translate([0,0,0])rotate([180,0,90])holder_base();
		translate([DIM_X-Z_BLOCK_LENGTH,0,0])rotate([180,0,90])holder_base();
		translate([(DIM_X-Z_BLOCK_LENGTH )/2,DIM_X_SPACING,0])rotate([180,0,90])holder_base();
		#translate([(DIM_X-Z_BLOCK_LENGTH )/2,DIM_Y-Z_BLOCK_WIDTH-5,0])rotate([180,0,90])holder_base();
		translate([4,0,-CAR_THICKNESS])cube([DIM_X-8,Z_BLOCK_WIDTH,CAR_THICKNESS]);

			translate([0,Z_BLOCK_WIDTH/2,-(CAR_THICKNESS/2)])
			linear_extrude(height=CAR_THICKNESS/2, convexity=10)
			polygon(points=[[0,0],[25,70.2],[45.62,70.2],[70,0],[60,0],[40.31,55.3],[30.31,55.3],[10.62,0]] );

			translate([0,Z_BLOCK_WIDTH/2,-(CAR_THICKNESS)])
			linear_extrude(height=CAR_THICKNESS/2, convexity=10)
			polygon(points=[[0,0],[25,70.2],[45.62,70.2],[70,0],[65,0],[45.31,55.3],[25.31,55.3],[5.62,0]] );
			
		translate([-BELT_CLAMP_WIDTH,(Z_BLOCK_LENGTH/2)-BELT_OFFSET_Y+1.3,-BELT_CLAMP_HEIGHT])
		rotate([0,0,0])
		belt_clamp();
		
		translate([14.5,(Z_BLOCK_LENGTH/2)-BELT_OFFSET_Y,-BELT_CLAMP_HEIGHT-1])
		rotate([90,0,0])
		%import("y_belt_tensioner_v2_strap.stl", convexity =5);

		translate([DIM_X+BELT_CLAMP_WIDTH,(Z_BLOCK_LENGTH/2)-BELT_OFFSET_Y+1.3,-BELT_CLAMP_HEIGHT])
		rotate([0,0,0])
		mirror([ 1, 0,0 ])
		belt_clamp();

		translate([29+DIM_X,(Z_BLOCK_LENGTH/2)-BELT_OFFSET_Y,-BELT_CLAMP_HEIGHT-1])
		rotate([90,0,0])
		%import("y_belt_tensioner_v2_strap.stl", convexity =5);

	}
	fixing_holes_plate();
	fixing_holes_holder();
	}
}

module holder_base()
{
	difference()
	{
		minkowski()
			{
			translate([0,0,0])cube([Z_BLOCK_WIDTH-8,Z_BLOCK_LENGTH-8,CAR_THICKNESS*0.5]);
			translate([4,4,0])cylinder(r = 4, h = CAR_THICKNESS*0.5, $fn = 100);
			}


	}
}

module belt_clamp()
{
difference()
{
	union()
	{
		minkowski()
			{
			cube([BELT_CLAMP_WIDTH-4,BELT_CLAMP_LENGTH-4,BELT_CLAMP_HEIGHT*0.5]);
			translate([2,2,0])cylinder(r = 2, h = BELT_CLAMP_HEIGHT*0.5, $fn = 100);
			}
			translate([4,0,BELT_CLAMP_HEIGHT-CAR_THICKNESS])cube([BELT_CLAMP_WIDTH-3,BELT_CLAMP_LENGTH,CAR_THICKNESS]);
	}
	translate([BELT_CLAMP_WIDTH-1,0,-1])cube([1.2,BELT_CLAMP_LENGTH,BELT_CLAMP_HEIGHT-CAR_THICKNESS+1]);

	translate([-1,(BELT_CLAMP_LENGTH-BELT_CLAMP_HOLE_RAD+0.65)/2,BELT_CLAMP_HEIGHT-CAR_THICKNESS-7.5])rotate([0,90,0])
		cylinder(r = BELT_CLAMP_HOLE_RAD, h = BELT_CLAMP_WIDTH+2);

		translate([BELT_CLAMP_WIDTH/2,BELT_CLAMP_LENGTH+12,5])
		rotate([90,0,0])
		#clamp_holes();

		translate([BELT_CLAMP_WIDTH/2,BELT_CLAMP_LENGTH,5])
		rotate([90,0,0])
		cylinder(r=M4_EFF_RAD,h=10,$fn=6);

		translate([-BELT_CLAMP_WIDTH/2-5,-1,4])
		rotate([0,45,0])
		cube([BELT_CLAMP_WIDTH+2,BELT_CLAMP_LENGTH+2,10]);

		translate([BELT_CLAMP_LENGTH-1,BELT_CLAMP_WIDTH,-10])
		rotate([0,-45,90])
		cube([BELT_CLAMP_WIDTH+2,BELT_CLAMP_LENGTH+2,10]);


}
}

module ext_hotend_blank()
{
	cylinder(r=8, h= 100, $fn=50);
	translate([0,0,-100])cylinder(r=1.75, h= 300, $fn=50);
}

//Hole cutters
module fixing_holes_plate()
{


	#translate([HOLE_OFFSET_X1,HOLE_OFFSET_Y1,-20])cylinder(r = HOLE_RADIUS, h = 30, $fn = 100);
	#translate([HOLE_OFFSET_X1,HOLE_OFFSET_Y1,-CAR_THICKNESS-1])cylinder(r = M4_EFF_RAD, h = CAR_THICKNESS/2, $fn = 6);
	#translate([HOLE_OFFSET_X1 + HOLE_SPACING_X12,HOLE_OFFSET_Y1,-20])cylinder(r = HOLE_RADIUS, h = 30, $fn = 100);
	#translate([HOLE_OFFSET_X1 + HOLE_SPACING_X12,HOLE_OFFSET_Y1,-CAR_THICKNESS-1])cylinder(r = M4_EFF_RAD, h = CAR_THICKNESS/2, $fn = 6);

	#translate([HOLE_OFFSET_X1,HOLE_OFFSET_Y1 + HOLE_SPACING_Y12,-20])cylinder(r = HOLE_RADIUS, h = 30, $fn = 100);
	#translate([HOLE_OFFSET_X1,HOLE_OFFSET_Y1 + HOLE_SPACING_Y12,-CAR_THICKNESS-1])cylinder(r = M4_EFF_RAD, h = CAR_THICKNESS/2+1, $fn = 6);
	#translate([HOLE_OFFSET_X1 + HOLE_SPACING_X12,HOLE_OFFSET_Y1+ + HOLE_SPACING_Y12,-20])cylinder(r = HOLE_RADIUS, h = 30, $fn = 100);
	#translate([HOLE_OFFSET_X1 + HOLE_SPACING_X12,HOLE_OFFSET_Y1+ + HOLE_SPACING_Y12,-CAR_THICKNESS-1])cylinder(r = M4_EFF_RAD, h = CAR_THICKNESS/2, $fn = 6);

	//#translate([HOLE_OFFSET_X3,HOLE_OFFSET_Y1 + HOLE_SPACING_Y13,-20])cylinder(r = HOLE_RADIUS, h = 30, $fn = 100);
	//#translate([HOLE_OFFSET_X3,HOLE_OFFSET_Y1 + HOLE_SPACING_Y13,-CAR_THICKNESS-1])cylinder(r = M4_EFF_RAD, h = CAR_THICKNESS/2, $fn = 6);
	#translate([HOLE_OFFSET_X3 + HOLE_SPACING_X3,HOLE_OFFSET_Y1+ + HOLE_SPACING_Y13,-20])cylinder(r = HOLE_RADIUS, h = 30, $fn = 100);
	#translate([HOLE_OFFSET_X3 + HOLE_SPACING_X3,HOLE_OFFSET_Y1+ + HOLE_SPACING_Y13,-CAR_THICKNESS-1])cylinder(r = M4_EFF_RAD, h = CAR_THICKNESS/2, $fn = 6);

}
module fixing_holes_holder()
	{
		#translate([DIM_X-Z_BLOCK_LENGTH/2,(Z_BLOCK_WIDTH-FIXING_HOLE_SPACEING_Z)/2,1])rotate([0,180,0])fixing_holes_h();
		#translate([(Z_BLOCK_LENGTH )/2,(Z_BLOCK_WIDTH-FIXING_HOLE_SPACEING_Z)/2,1])rotate([0,180,0])fixing_holes_h();
		#translate([(DIM_X)/2,(Z_BLOCK_WIDTH-FIXING_HOLE_SPACEING_Z)/2+DIM_X_SPACING,1])rotate([0,180,0])fixing_holes_h();
	}


module fixing_holes_h(){
	hole_cutter_h();
	translate([0,FIXING_HOLE_SPACEING_Z,0])hole_cutter_h();
}
module hole_cutter_h()
{
	translate([0,0,CAR_THICKNESS/2+0.3])cylinder(r = HOLE_RADIUS, h = 30, $fn = 100);
	cylinder(r = M4_EFF_RAD, h = CAR_THICKNESS/2, $fn = 6);
}

module x_axis_belt_clamp()
{
	difference()
	{
		
		radius_block();
		translate([block_width/2,(block_length-hole_spacing)/2,-5])clamp_holes();
		translate([-1,-1,clamp_height])cube([block_width+2,block_length+2,block_height]);

	}
}

module m4_through_hole()
{
	cylinder(r=HOLE_RADIUS , h=50, $fn=100);
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
	translate([0,CLAMP_HOLE_SPACING,0])m4_through_hole();
}


//test
echo(M4_EFF_DIA);