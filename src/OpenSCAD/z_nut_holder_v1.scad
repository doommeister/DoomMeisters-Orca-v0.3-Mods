LM8UU_DIA = 14;
n_diff = (LM8UU_DIA/2)-5.7;


n_height = n_diff +13.7;
n_width = 6.9; // the thickness of the nut so you could use studding connectors
nh_width = 28.05;
nh_padding = 5.55;


z_nut_holder_base();

module z_nut_holder_base()
{
	difference()
	{
	union()
		{	
		linear_extrude(height = n_width)
			polygon(points=[[0,0],[0,n_height],[7.4,n_height],[7.4,n_height-3.82],[nh_width/2,n_height-7.64],[20.65,n_height-3.82],[20.65,n_height],[nh_width,n_height],[nh_width,0]]);
		
			translate([0,0,-nh_padding])
				linear_extrude(height = nh_padding)
					polygon(points=[[0,0],[0,n_height],[nh_width,n_height],[nh_width,0]]);
			translate([0,0,n_width])
				linear_extrude(height = nh_padding)
					polygon(points=[[0,0],[0,n_height],[nh_width,n_height],[nh_width,0]]);

	}
			translate([nh_width/2,n_height,-nh_padding-1])
				linear_extrude(height = 2 + (nh_padding*2) + n_width)
					circle(r=9.2/2, $fn=100);



	}
}





echo( n_diff, n_height);