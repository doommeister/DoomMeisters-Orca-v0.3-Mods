//Parametric Linear bearing holders for Orca v0.3
// By the DooMMeister 

//Released under the terms of the GNU GPL v3.0
/*
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

Bar Clamps are modified versions of the Prusa ones
// PRUSA Mendel  
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel
*/
//links
use<DoomMeisters_Orca_V0.3_X_Carriage_v5.scad>;

// parameters


LM8UU_DIA = 15; // 15 is standard, 14
LM8UU_LEN = 24; // 24 is standard

FIXING_HOLE_DIA = 4;
FIXING_HOLE_CBORE_DIA = 7;
FIXING_HOLE_SPACEING = 12;
FIXING_HOLE_SPACEING_Z = 22;
FIXING_HOLE_SPACEING_ZZ = 48;

OFFSET_Y = 20;
OFFSET_Z = 0;

CLEARANCE_1 = 0.2;
EXCESS = 10;

ZIP_TIE_WIDTH = 4;
ZIP_TIE_HEIGHT = 2.5;
ZIP_TIE_POSITION_Z = -2 ;

BUSH_OD = 14;
AXIS_TO_TOP = 20;

Z_NUT_OFFSET = 8;
Z_NUT_HOLE_SPACEING_Y = 19.65;
Z_NUT_HOLE_SPACEING_Z = 9.88;
Z_NUT_DIA = 8;
Z_NUT_BLOCK_WIDTH = 28;
Z_NUT_BLOCK_HEIGHT = 18;
Z_NUT_CLEARANCE_HOLE = 10;
m8_diameter = 9;
CORNER_RAD = 4;
SPRING_OD = 10.1;
SPRING_LEN = 25;
SPRING_COMP = 0.6;


LAYER_THICKNESS = 0.45;
NO_OF_LAYERS = 6;

clearance=0.7;

n_diff = (LM8UU_DIA/2)-5.7;
n_height = n_diff +13.7;
n_width = 6.9; // the thickness of the nut so you could use studding connectors
nh_width = 28.05;
nh_padding = 5.55;

//calculated

lm8uu_diameter= LM8UU_DIA + clearance; //
lm8uu_length=LM8UU_LEN+clearance; // 36.7 + clearance;
lm8uu_support_thickness=3.2; 
lm8uu_end_diameter=m8_diameter+1.5;

lm8uu_holder_width=lm8uu_diameter+2*lm8uu_support_thickness;
lm8uu_holder_length=lm8uu_length+2*lm8uu_support_thickness;
lm8uu_holder_height=lm8uu_diameter*0.75+lm8uu_support_thickness;
lm8uu_holder_gap=(lm8uu_holder_length-6*lm8uu_support_thickness)/2;
outer_diameter = m8_diameter/2+3.3;


// calculated variables
LM8UU_RAD = lm8uu_diameter/2;
FIXING_HOLE_RAD = (FIXING_HOLE_DIA /2) + CLEARANCE_1;
FIXING_HOLE_Y = (lm8uu_holder_length - FIXING_HOLE_SPACEING)/2;
FIXING_HOLE_X = lm8uu_holder_width /2;

FIXING_HOLE_CBORE_RAD = (FIXING_HOLE_CBORE_DIA/2) + CLEARANCE_1;

ZIP_TIE_LENGTH = lm8uu_holder_width+EXCESS;
ZIP_TIE_POSITION_X = -EXCESS/2 ;
ZIP_TIE_POSITION_Y = (lm8uu_holder_length- ZIP_TIE_WIDTH)/2 ;

Z_BLOCK_WIDTH = FIXING_HOLE_SPACEING_Z+(2*FIXING_HOLE_DIA)+2;
Z_BLOCK_LENGTH = lm8uu_length + 4;
Z_BLOCK_HEIGHT = lm8uu_diameter;
Z_BLOCK_RAD = LM8UU_RAD + FIXING_HOLE_DIA;
Z_BLOCK_CLEARANCE = 0.2; // how hunch pinch to have on bearing
Z_BLOCK_LENGTH_V3 = FIXING_HOLE_SPACEING_ZZ + (FIXING_HOLE_DIA*2);

S_BLOCK_WIDTH = FIXING_HOLE_SPACEING_Z+(FIXING_HOLE_DIA)+2;
S_BLOCK_OFFSET = FIXING_HOLE_RAD +1;

LENGTH_INC = (lm8uu_holder_length*2) - 15; //length to increment on multiple bearing holders

Z_NUT_RAD = (Z_NUT_DIA/2) +0.25;
Z_NUT_HEIGHT = 0.8 * Z_NUT_DIA + CLEARANCE_1;
Z_NUT_BLOCK_LENGTH = (1.8*Z_NUT_DIA) + Z_NUT_OFFSET-LM8UU_RAD;

SPRING_RAD = (SPRING_OD/2) + clearance;
SPRING_COMP_LEN = SPRING_LEN * SPRING_COMP;


SLIPPER_THICKNESS = LAYER_THICKNESS * NO_OF_LAYERS;


//draw

/* uncomment to draw single items

color("green")translate([40,0,0])rotate([180,0,0])orca_lm8uu_edge_double(switch_nub=true);
color("blue")translate([80,0,0])rotate([180,0,0])orca_z_axis_lm8uu_single();
color("red")translate([120,0,0])rotate([180,0,0])orca_z_axis_lm8uu_double();

color("purple")translate([-40,0,0])rotate([180,0,0]) orca_lm8uu_v4();

color("pink")translate([-80,0,0])rotate([180,0,0]) orca_lm8uu_v4_slipper();
color("white")translate([-120,0,0])rotate([180,0,0]) axis_barclamp();


color("DeepSkyBlue")rotate([90,0,0])z_nut_holder();

color("Orange")translate([0,0,0])rotate([90,0,0])z_nut_holder_anti_bl(base1=true);
color("Orange")translate([-40,0,0])rotate([90,0,0])z_nut_holder_anti_bl(base1=false);

*/


plate1();


//modules

module plate1()
{
translate([0,0,-5])%cube([200,200,5]);

color("green")translate([12,20+Z_BLOCK_LENGTH+LENGTH_INC,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE])rotate([180,0,0])orca_lm8uu_edge_double(switch_nub=true);
color("blue")translate([42,20+Z_BLOCK_LENGTH_V3,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE])rotate([180,0,0])orca_z_axis_lm8uu_double();
color("red")translate([77,20+Z_BLOCK_LENGTH_V3,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE])rotate([180,0,0])orca_z_axis_lm8uu_double();

color("purple")translate([12,190,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE])rotate([180,0,0]) orca_lm8uu_v4();
color("purple")translate([12+(Z_BLOCK_WIDTH*1)+5,190,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE])rotate([180,0,0]) orca_lm8uu_v4();
color("purple")translate([12+(Z_BLOCK_WIDTH*2)+10,190,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE])rotate([180,0,0]) orca_lm8uu_v4();
color("purple")translate([12+(Z_BLOCK_WIDTH*3)+15,190,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE])rotate([180,0,0]) orca_lm8uu_v4();

//color("pink")translate([-80,0,0])rotate([180,0,0]) orca_lm8uu_v4_slipper();

color("white")translate([15,115,outer_diameter*2])rotate([180,0,0]) axis_barclamp();
color("white")translate([15,140,outer_diameter*2])rotate([180,0,0]) axis_barclamp();
color("white")translate([45,115,outer_diameter*2])rotate([180,0,0]) axis_barclamp();
color("white")translate([45,140,outer_diameter*2])rotate([180,0,0]) axis_barclamp();
color("white")translate([170,70,outer_diameter*2])rotate([180,0,0]) axis_barclamp();

color("DeepSkyBlue")translate([165,45,0])rotate([90,0,0])z_nut_holder_anti_bl(base1=true);
color("DeepSkyBlue")translate([75,160,0])rotate([90,0,0])z_nut_holder_anti_bl(base1=true);
color("DeepSkyBlue")translate([165,145,0])rotate([90,0,0])z_nut_holder_anti_bl(base1=false);
color("DeepSkyBlue")translate([50,97,0])rotate([90,0,0])z_nut_holder_anti_bl(base1=false);

//imports
color("yellow")translate([170,75,0])rotate([0,0,0])import("M8_Hall-O_holder.stl", convexity = 5);
color("yellow")translate([10,145,0])rotate([0,0,0])import("M8_Hall-O_holder.stl", convexity = 5);
color("yellow")translate([45,145,0])rotate([0,0,0])import("M8_Hall-O_holder.stl", convexity = 5);
//color("yellow")translate([75,145,0])rotate([0,0,0])import("M8_Hall-O_holder.stl", convexity = 5);


color("orange")translate([145,125,0])rotate([0,0,0])import("y_belt_tensioner_v2_T2.5_set.stl", convexity = 5);
color("orange")translate([195,178,0])rotate([0,0,90])import("y_belt_tensioner_v2_T2.5_set.stl", convexity = 5);

color("gold")translate([105,120,0])rotate([0,180,180])car_body(ext_mount=true);

}


module lm8uu()
{
	rotate([90,0,0])
	difference()
	{
		cylinder(r=LM8UU_RAD-0.35, lm8uu_length);
		translate([0,0,-1])cylinder(r=4, lm8uu_length+2);
	}


}

module orca_lm8uu_edge_single(holes=false) // single bearing holder with screw holes on the edge, fits x and y axis
{
	difference()
	{
		union()
		{
			minkowski()
			{
				cube([S_BLOCK_WIDTH-CORNER_RAD ,Z_BLOCK_LENGTH-CORNER_RAD ,Z_BLOCK_HEIGHT*0.6]);
				translate([CORNER_RAD/2,CORNER_RAD/2,0])cylinder(r = CORNER_RAD/2, h = Z_BLOCK_HEIGHT*0.6, $fn = 100);
			}
		}
		translate([-1,-1,-Z_BLOCK_HEIGHT+ Z_BLOCK_CLEARANCE])cube([Z_BLOCK_WIDTH+2,Z_BLOCK_LENGTH+2,Z_BLOCK_HEIGHT]);

		translate([(S_BLOCK_WIDTH-lm8uu_diameter)/2+S_BLOCK_OFFSET,2,-Z_BLOCK_HEIGHT/1.8])cube([lm8uu_diameter,Z_BLOCK_LENGTH-4,Z_BLOCK_HEIGHT]);
		translate([(S_BLOCK_WIDTH-lm8uu_end_diameter)/2+S_BLOCK_OFFSET,-1,-Z_BLOCK_HEIGHT/1.8])cube([lm8uu_end_diameter,Z_BLOCK_LENGTH+2,Z_BLOCK_HEIGHT]);

		translate([S_BLOCK_WIDTH/2+S_BLOCK_OFFSET,2,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= LM8UU_RAD, h = lm8uu_length, $fn=100);
		translate([S_BLOCK_WIDTH/2+S_BLOCK_OFFSET,-1,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= lm8uu_end_diameter/2, h = lm8uu_length+6, $fn=100);
		if(holes)
		{
			translate([(S_BLOCK_WIDTH-lm8uu_diameter-S_BLOCK_OFFSET)/2,(Z_BLOCK_LENGTH-FIXING_HOLE_SPACEING)/2,-50]) fixing_holes();
		}

		//test section
		//translate([0,-Z_BLOCK_LENGTH/2,0])cube([S_BLOCK_WIDTH,Z_BLOCK_LENGTH,Z_BLOCK_HEIGHT*1.2]);// section block 
	}
}

module orca_lm8uu_edge_double(switch_nub=true)  //double bearing holder with screw holes on the edge, fits x and y axis
{
	difference()
	{
		union()
		{
			orca_lm8uu_edge_single();
			translate([-2,0,Z_BLOCK_CLEARANCE])cube([S_BLOCK_WIDTH-lm8uu_diameter-S_BLOCK_OFFSET+2,Z_BLOCK_LENGTH+LENGTH_INC,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE]);
			translate([0,LENGTH_INC,0])orca_lm8uu_edge_single();

			#translate([-2,Z_BLOCK_LENGTH-2,Z_BLOCK_CLEARANCE])cube([S_BLOCK_WIDTH-lm8uu_diameter-S_BLOCK_OFFSET+4,LENGTH_INC-lm8uu_length,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE]);
			if(switch_nub)
			{
				#translate([-8,0,Z_BLOCK_CLEARANCE])cube([8,6,Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE]);
				#translate([-8,3,Z_BLOCK_CLEARANCE])cylinder(r = 3,h=Z_BLOCK_HEIGHT*1.2-Z_BLOCK_CLEARANCE, $fn=100);
			}
		}
	translate([(S_BLOCK_WIDTH-lm8uu_diameter-S_BLOCK_OFFSET)/2,(Z_BLOCK_LENGTH+LENGTH_INC-FIXING_HOLE_SPACEING)/2,-50]) fixing_holes();
	}
}


module orca_z_axis_lm8uu_single() //sbushing holder for the z axis fit between the 2 pairs of holes on the side plate
{
	difference()
	{
		union()
		{
			minkowski()
			{
				cube([Z_BLOCK_WIDTH-CORNER_RAD *2,Z_BLOCK_LENGTH_V3-CORNER_RAD *2,Z_BLOCK_HEIGHT*0.6]);
				translate([CORNER_RAD ,CORNER_RAD ,0])cylinder(r = CORNER_RAD , h = Z_BLOCK_HEIGHT*0.6, $fn = 100);
			}
		}
		translate([-1,-1,-Z_BLOCK_HEIGHT+ Z_BLOCK_CLEARANCE])cube([Z_BLOCK_WIDTH+2,Z_BLOCK_LENGTH_V3+2,Z_BLOCK_HEIGHT]);

		translate([(Z_BLOCK_WIDTH-lm8uu_diameter)/2,(Z_BLOCK_LENGTH_V3-lm8uu_length)/2,-Z_BLOCK_HEIGHT/1.8])cube([lm8uu_diameter,lm8uu_length,Z_BLOCK_HEIGHT]);
		translate([(Z_BLOCK_WIDTH-lm8uu_end_diameter)/2,-1,-Z_BLOCK_HEIGHT/1.8])cube([lm8uu_end_diameter,Z_BLOCK_LENGTH_V3+2,Z_BLOCK_HEIGHT]);

		translate([Z_BLOCK_WIDTH/2,(Z_BLOCK_LENGTH_V3-lm8uu_length)/2,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= LM8UU_RAD, h = lm8uu_length, $fn=100);
		translate([Z_BLOCK_WIDTH/2,-1,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= lm8uu_end_diameter/2, h = Z_BLOCK_LENGTH_V3+6, $fn=100);

		translate([(Z_BLOCK_WIDTH-FIXING_HOLE_SPACEING_Z)/2,FIXING_HOLE_SPACEING_ZZ+4,-50]) rotate([0,0,-90]) fixing_holes_zz();
		//test section
		//translate([0,-Z_BLOCK_LENGTH/2,0])cube([Z_BLOCK_WIDTH,Z_BLOCK_LENGTH,Z_BLOCK_HEIGHT*1.2]);// section block 
	}
}

module orca_z_axis_lm8uu_double() //sbushing holder for the z axis fit between the 2 pairs of holes on the side plate
{
	difference()
	{
		union()
		{
			orca_lm8uu_v4(holes=false);
			translate([0,Z_BLOCK_LENGTH_V3-Z_BLOCK_LENGTH,0])orca_lm8uu_v4(holes=false);
		}


		translate([(Z_BLOCK_WIDTH-FIXING_HOLE_SPACEING_Z)/2,FIXING_HOLE_SPACEING_ZZ+4,-50]) rotate([0,0,-90]) fixing_holes_zz();

	}
}


module orca_lm8uu_v4(holes=true) // prefered beaing holder with screw either side, fits x and y axis
{
	difference()
	{
		union()
		{
			

		minkowski()
			{
			translate([0,0,0])cube([Z_BLOCK_WIDTH-CORNER_RAD*2,Z_BLOCK_LENGTH-CORNER_RAD*2,Z_BLOCK_HEIGHT*0.6]);
			translate([CORNER_RAD ,CORNER_RAD ,0])cylinder(r = CORNER_RAD, h = Z_BLOCK_HEIGHT*0.6, $fn = 100);
			}
			//translate([Z_BLOCK_WIDTH/2,0,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= Z_BLOCK_RAD, h = Z_BLOCK_LENGTH, fn=100); //
		}
		translate([-1,-1,-Z_BLOCK_HEIGHT+ Z_BLOCK_CLEARANCE])cube([Z_BLOCK_WIDTH+2,Z_BLOCK_LENGTH+2,Z_BLOCK_HEIGHT]);

		translate([(Z_BLOCK_WIDTH-lm8uu_diameter)/2,2,-Z_BLOCK_HEIGHT/1.8])cube([lm8uu_diameter,Z_BLOCK_LENGTH-4,Z_BLOCK_HEIGHT]);
		translate([(Z_BLOCK_WIDTH-lm8uu_end_diameter)/2,-1,-Z_BLOCK_HEIGHT/1.8])cube([lm8uu_end_diameter,Z_BLOCK_LENGTH+2,Z_BLOCK_HEIGHT]);

		translate([Z_BLOCK_WIDTH/2,2,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= LM8UU_RAD, h = lm8uu_length, $fn=100);
		%translate([Z_BLOCK_WIDTH/2,lm8uu_length+2,LM8UU_RAD-0.5])lm8uu();
		translate([Z_BLOCK_WIDTH/2,-1,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= lm8uu_end_diameter/2, h = lm8uu_length+6, $fn=100);
	if(holes)
		{
		translate([(Z_BLOCK_WIDTH-FIXING_HOLE_SPACEING_Z)/2,Z_BLOCK_LENGTH/2,-50]) rotate([0,0,-90]) fixing_holes_z();
		}


		//test section
		//translate([0,-Z_BLOCK_LENGTH/2,0])cube([Z_BLOCK_WIDTH,Z_BLOCK_LENGTH,Z_BLOCK_HEIGHT*1.2]);// section block 
	}

}

module orca_lm8uu_v4_slipper() // prefered beaing holder with screw either side, fits x and y axis
{
	difference()
	{
		union()
		{
			

		minkowski()
			{
			translate([0,0,0])cube([Z_BLOCK_WIDTH-CORNER_RAD*2,Z_BLOCK_LENGTH-CORNER_RAD*2,SLIPPER_THICKNESS*0.5]);
			translate([CORNER_RAD ,CORNER_RAD ,0])cylinder(r = CORNER_RAD, h = SLIPPER_THICKNESS*0.5, $fn = 100);
			}
			//translate([Z_BLOCK_WIDTH/2,0,LM8UU_RAD-0.5]) rotate([-90,0,0]) cylinder(r= Z_BLOCK_RAD, h = Z_BLOCK_LENGTH, fn=100); //
		}

		translate([(Z_BLOCK_WIDTH-FIXING_HOLE_SPACEING_Z)/2,Z_BLOCK_LENGTH/2,-50]) rotate([0,0,-90]) fixing_holes_z();

	}
}

module axis_barclamp(){


difference(){
	union(){
		
		translate([outer_diameter, outer_diameter, 0])cylinder(h =outer_diameter*2, r = outer_diameter, $fn = 20);
		translate([outer_diameter, 0, 0])cube([17.5,outer_diameter*2,outer_diameter*2]);
	}

	translate([9, outer_diameter/2+1, 0])cube([18,05,20]);
	translate([outer_diameter, outer_diameter, 0]) #cylinder(h =20, r = m8_diameter/2, $fn = 18);
	translate([17, 17, 7.5]) rotate([90, 0, 0]) #cylinder(h =20, r = m8_diameter/2, $fn = 10);
	translate([0,0,-1])cube([1.2,outer_diameter*2,(outer_diameter*2)+2]);
	}
}

module z_nut_holder()
{
	difference()
	{
	rotate([0,0,0])z_nut_holder_base();
	translate([(nh_width-Z_NUT_HOLE_SPACEING_Y)/2,80,(Z_NUT_BLOCK_HEIGHT- Z_NUT_HOLE_SPACEING_Z)/2]) rotate([90,0,0])fixing_holes_z_nut();

	}
}

module z_nut_holder_anti_bl(base1=true)
{
	difference()
	{
	rotate([0,0,0])z_nut_holder_base_anti_bl(base=base1);
	translate([(nh_width-Z_NUT_HOLE_SPACEING_Y)/2,80,(Z_NUT_BLOCK_HEIGHT- Z_NUT_HOLE_SPACEING_Z)/2]) rotate([90,0,0])fixing_holes_z_nut();
	}



}


//sub modules


module z_nut_holder_base()
{
	difference()
	{
	union()
		{	
		translate([0,0,nh_padding])
		linear_extrude(height = n_width)
			polygon(points=[[0,0],[0,n_height],[7.4,n_height],[7.4,n_height-3.82],[nh_width/2,n_height-7.64],[20.65,n_height-3.82],[20.65,n_height],[nh_width,n_height],[nh_width,0]]);
		
			translate([0,0,])
				linear_extrude(height = nh_padding)
					polygon(points=[[0,0],[0,n_height],[nh_width,n_height],[nh_width,0]]);
			translate([0,0,n_width+nh_padding])
				linear_extrude(height = nh_padding)
					polygon(points=[[0,0],[0,n_height],[nh_width,n_height],[nh_width,0]]);

	}
			translate([nh_width/2,n_height,-1])
				linear_extrude(height = 2 + (nh_padding*2) + n_width)
					circle(r=9.2/2, $fn=100);

	}
}

module z_nut_holder_base_anti_bl(base=false)
{
	difference()
	{
	union()
		{	

	if(base)
		{

		translate([0,0,nh_padding])
		linear_extrude(height = n_width, convexity = 5)
			polygon(points=[[0,0],[0,n_height],
							[7.4,n_height],
							[7.4,n_height-3.82],
							[nh_width/2,n_height-7.64],
							[20.65,n_height-3.82],
							[20.65,n_height],
							[nh_width,n_height],
							[nh_width,0]]);
		
		translate([0,0,0])
		linear_extrude(height = nh_padding, convexity = 5)
			polygon(points=[[0,0],[0,n_height],
							[nh_width,n_height],
							[nh_width,0]]);
		translate([0,0,n_width+nh_padding])
		linear_extrude(height = SPRING_COMP_LEN, convexity = 5)
			polygon(points=[[0,0],[0,n_height],
							[nh_width,n_height],
							[nh_width,0]]);
		//Nut2
		translate([0,0,nh_padding+n_width+SPRING_COMP_LEN])
		linear_extrude(height = n_width, convexity = 5)
			polygon(points=[[0,0],[0,n_height],
							[7.4,n_height],
							[7.4,n_height-3.82],
							[nh_width/2,n_height-7.64],
							[20.65,n_height-3.82],
							[20.65,n_height],
							[nh_width,n_height],
							[nh_width,0]]);
		//stop					
		translate([0,0,(2*n_width)+nh_padding+SPRING_COMP_LEN])
		linear_extrude(height = nh_padding, convexity = 5)
			polygon(points=[[0,0],[0,(n_height*1.5)-3],
							[3,n_height*1.5],
							[nh_width-3,n_height*1.5],
							[nh_width,(n_height*1.5)-3],
							[nh_width,0]]);

		}
		if(!base)
			{

		translate([0,0,nh_padding])
		linear_extrude(height = n_width+1.25, convexity = 5)
			polygon(points=[[0,0],[0,n_height],
							[7.4,n_height],
							[7.4,n_height-3.82],
							[nh_width/2,n_height-7.64],
							[20.65,n_height-3.82],
							[20.65,n_height],
							[nh_width,n_height],
							[nh_width,0]]);
		
		translate([0,0,0])
		linear_extrude(height = nh_padding, convexity = 5)
			polygon(points=[[0,0],[0,n_height],
							[nh_width,n_height],
							[nh_width,0]]);
				translate([0,0,n_width+nh_padding+1.25])
				linear_extrude(height = nh_padding, convexity = 5)
					polygon(points=[[0,0],[0,n_height],
							[nh_width,n_height],
							[nh_width,0]]);
			}
			


	}
			translate([nh_width/2,n_height,-1])
			linear_extrude(height = 2 + ((nh_padding + n_width)*2) + SPRING_COMP_LEN, convexity = 5)
					circle(r=9.2/2, $fn=100);

			translate([nh_width/2,n_height,n_width+nh_padding])
			linear_extrude(height =SPRING_COMP_LEN, convexity = 5)
					circle(r=SPRING_RAD, $fn=100);

	}
}

module z_nut_holder_base()
{
	difference()
	{
	union()
		{	
		translate([0,0,nh_padding])
		linear_extrude(height = n_width)
			polygon(points=[[0,0],[0,n_height],[7.4,n_height],[7.4,n_height-3.82],[nh_width/2,n_height-7.64],[20.65,n_height-3.82],[20.65,n_height],[nh_width,n_height],[nh_width,0]]);
		
			translate([0,0,])
				linear_extrude(height = nh_padding)
					polygon(points=[[0,0],[0,n_height],[nh_width,n_height],[nh_width,0]]);
			translate([0,0,n_width+nh_padding])
				linear_extrude(height = nh_padding)
					polygon(points=[[0,0],[0,n_height],[nh_width,n_height],[nh_width,0]]);

	}
			translate([nh_width/2,n_height,-1])
				linear_extrude(height = 2 + (nh_padding*2) + n_width)
					circle(r=9.2/2, $fn=100);

	}
}





module fixing_holes(){
	hole_cutter();
	translate([0,FIXING_HOLE_SPACEING,0])hole_cutter();
}

module fixing_holes_z(){
	hole_cutter();
	translate([0,FIXING_HOLE_SPACEING_Z,0])hole_cutter();
}

module fixing_holes_zz(){
	fixing_holes_z();
	translate([FIXING_HOLE_SPACEING_ZZ,0,0])fixing_holes_z();
}

module fixing_holes_z_nut(){
	hole_cutter();
	translate([Z_NUT_HOLE_SPACEING_Y,0,0])hole_cutter();
	translate([0,Z_NUT_HOLE_SPACEING_Z,0])hole_cutter();
	translate([Z_NUT_HOLE_SPACEING_Y,Z_NUT_HOLE_SPACEING_Z,0])hole_cutter();
}

module hole_cutter(){
	union(){
		cylinder( r = FIXING_HOLE_RAD, h = 100, $fn=100);
		translate([0,0,99])cylinder( r =FIXING_HOLE_CBORE_RAD, h = 10, $f=100);

	}
}

module zip_tie_cutter()
{
	cube([ZIP_TIE_LENGTH,ZIP_TIE_WIDTH,ZIP_TIE_HEIGHT]);
}