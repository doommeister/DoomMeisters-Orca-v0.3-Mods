/*Parametric bar clamp by the DoomMeister v2, with Hall-O holder

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
//parameters

SCREW_HOLE_DIA = 4;  // fixing screw size
BAR_HOLE_DIA = 8;       // clamped bar diameter
CLAMP_BOLT_DIA = 3;   // captive screw to clamp bar diameter

SCREW_HOLE_SEPERATION = 26;      // distance between the fixing screws
SCREW_HOLE_CENTRE_OFFSET = 0; // offset the clamp hole to one side, 0 for centre

hall_o = true;
HALL_O_BOLT_DIA = 3;
HALL_O_SEPERATION = 17;

CLEARANCE_SCREWS = 0.3;
CLEARANCE_BAR =  0.1;

LAYER_HEIGHT = 0.3;  // Layer height you intend to print at
LAYER_RATIO = 1.5;   // Thickness over height setting in skeinforge

//Calculated Variables
THICKNESS = round((SCREW_HOLE_DIA*0.66)/(LAYER_RATIO*LAYER_HEIGHT))*(LAYER_RATIO*LAYER_HEIGHT);
HEIGHT = round((0.8*3*CLAMP_BOLT_DIA)/LAYER_HEIGHT)*LAYER_HEIGHT;

SCREW_HOLE_RAD = (SCREW_HOLE_DIA + CLEARANCE_SCREWS) /2;
BAR_HOLE_RAD = (BAR_HOLE_DIA + CLEARANCE_BAR) /2;

SCREW_FORM_RAD = SCREW_HOLE_RAD + THICKNESS;
BAR_FORM_RAD = BAR_HOLE_RAD + THICKNESS*1.5;

NUT_HEIGHT = (0.8 * CLAMP_BOLT_DIA) + CLEARANCE_SCREWS;
NUT_OD = (1.8 * CLAMP_BOLT_DIA) + CLEARANCE_SCREWS;
CLAMP_BOLT_RAD = (CLAMP_BOLT_DIA + CLEARANCE_SCREWS) /2;
HALL_O_BOLT_RAD = (HALL_O_BOLT_DIA + CLEARANCE_SCREWS)/2;

//draw

bar_clamp();

//gubbins

module bar_clamp()
{
	difference()
	{
		union()
		{
			cylinder(r = SCREW_FORM_RAD, h = HEIGHT, $fn=100);
			translate([0,SCREW_HOLE_SEPERATION,0])cylinder(r = SCREW_FORM_RAD, h = HEIGHT, $fn=100);
			translate([0,SCREW_HOLE_SEPERATION/2 + SCREW_HOLE_CENTRE_OFFSET ,0])cylinder(r = BAR_FORM_RAD, h = HEIGHT, $fn=100);
			#translate([0,(SCREW_HOLE_SEPERATION - BAR_FORM_RAD*2)/2 + SCREW_HOLE_CENTRE_OFFSET ,0])cube([ BAR_FORM_RAD+THICKNESS,BAR_FORM_RAD*2, HEIGHT]);
			translate([-SCREW_FORM_RAD,0,0])cube([SCREW_FORM_RAD*2,SCREW_HOLE_SEPERATION,HEIGHT]);
			if(hall_o)
			{
				translate([HALL_O_SEPERATION,0,0])cylinder(r = SCREW_FORM_RAD, h = HEIGHT, $fn=100);
				translate([0,-SCREW_FORM_RAD,0])cube([HALL_O_SEPERATION,SCREW_FORM_RAD*2,HEIGHT]);			
			}

		}
		
			translate([0,0,-1])cylinder(r = SCREW_HOLE_RAD, h = HEIGHT +2 , $fn=100);
			translate([0,SCREW_HOLE_SEPERATION,-1])cylinder(r = SCREW_HOLE_RAD, h = HEIGHT + 2, $fn=100);
			translate([0,SCREW_HOLE_SEPERATION/2 + SCREW_HOLE_CENTRE_OFFSET ,-1])cylinder(r = BAR_HOLE_RAD, h = HEIGHT + 2, $fn=100);
			translate([BAR_HOLE_RAD+THICKNESS/2,(SCREW_HOLE_SEPERATION-NUT_OD)/2 + SCREW_HOLE_CENTRE_OFFSET ,-1])cube([NUT_HEIGHT,NUT_OD,HEIGHT+2]);
			#translate([-1,SCREW_HOLE_SEPERATION/2 + SCREW_HOLE_CENTRE_OFFSET ,HEIGHT/2])rotate([0,90,0])cylinder(r = CLAMP_BOLT_RAD, h = BAR_FORM_RAD+THICKNESS+2, $fn=100);
			if(hall_o)
			{
				translate([HALL_O_SEPERATION,0,-1])cylinder(r = HALL_O_BOLT_RAD, h = HEIGHT+2, $fn=100);
				#translate([HALL_O_SEPERATION-(NUT_OD/2),-SCREW_FORM_RAD-1,HEIGHT-NUT_HEIGHT])cube([NUT_OD,(SCREW_FORM_RAD*2)+2,NUT_HEIGHT+1]);
			}
	}

}



//test
echo(THICKNESS, HEIGHT,NUT_HEIGHT,NUT_OD,CLAMP_BOLT_RAD);