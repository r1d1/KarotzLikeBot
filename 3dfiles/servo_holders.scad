height = 75; // mm
height_hole = 55; // mm
width = 40;
depth =  10;
head_radius=3.06;

module support()
{
    difference()
    {
        cube([height, width, depth], center=true);
        translate([15+0.*width,0,0])
        {
            cube([height_hole+1, 0.65*width, depth+2], center=true);
            translate([-height_hole*0.45,0,0])
            {
                //cylinder(h=depth+2, r=0.75*width*0.5, center=true, $fn=6); 
                cylinder(h=depth+2, r=0.75*width*0.5, center=true, $fn=6); 

            }
        }
        translate([-height/2, width/2, 0.]){ rotate([0.0,0.0,45.0]){ cube([0.5*(depth+2), 0.5*(depth+2), depth+2], center=true); } }
        translate([-height/2, -width/2, 0.]){ rotate([0.0,0.0,45.0]){ cube([0.5*(depth+2), 0.5*(depth+2), depth+2], center=true); } }
        translate([height/2, -0.55*width/2, 0.]){ rotate([0.0,0.0,45.0]){ cube([0.5*(depth+2), 0.5*(depth+2), depth+2], center=true); } }
        translate([height/2, 0.55*width/2, 0.]){ rotate([0.0,0.0,45.0]){ cube([0.5*(depth+2), 0.5*(depth+2), depth+2], center=true); } }
    
    translate([0,width*0.415,0])
    {
        translate([0.45*height_hole,0,0]){ rotate([90,0,0]){ cylinder(h=0.55*0.35*width,d=3, $fn=60, center=true); } }
        translate([-0.15*height_hole,0,0]){ rotate([90,0,0]){ cylinder(h=0.55*0.35*width,d=3, $fn=60, center=true); } }

        color([0,0.5,1])
        {
        translate([0.45*height_hole,-2.25,0]){ rotate([90,0,0]){ cylinder(h=0.4*0.55*0.35*width,d=8, $fn=60, center=true); } }
        translate([-0.15*height_hole,-2.25,0]){ rotate([90,0,0]){ cylinder(h=0.4*0.55*0.35*width,d=8, $fn=60, center=true); } }
        }
    }
    translate([0,-width*0.415,0])
    {
        translate([0.45*height_hole,0,0]){ rotate([90,0,0]){ cylinder(h=0.55*0.35*width,d=3, $fn=60, center=true); } }
        translate([-0.15*height_hole,0,0]){ rotate([90,0,0]){ cylinder(h=0.55*0.35*width,d=3, $fn=60, center=true); } }
        
        color([0,0.5,1])
        {
        translate([0.45*height_hole, 2.25,0])
        {
           rotate([90,0,0]){ cylinder(h=0.4*0.55*0.35*width, d=8, $fn=60, center=true); }
        }
        translate([-0.15*height_hole, 2.25,0])
        {
            rotate([90,0,0]){ cylinder(h=0.4*0.55*0.35*width, d=8, $fn=60, center=true); }
        }
        }
    }
    translate([-0.5*height,0.,0.])
    {
       color([0.,0.5,1.0])
       {
           cube([depth,depth,depth+1], center=true);
           rotate([0,90,0])
           {
               translate([0,0,8]){ cylinder(d=3,h=10, $fn=60, center=true); }
               translate([0,0,13.5]){ #cylinder(r=head_radius, h=3, $fn=6, center=true); }
           }
       }
    }
    }
}


translate([-10,-0.60*width,0]){ support(); }
translate([10.,-0.60*width,0]){ rotate([0,-90,0]){ middle_bar(); } }
translate([10.,0.60*width,0]){ rotate([0,0,180]){ support(); } }
//color([1.0,0.,0.,0.5]){ support(); }

translate([-10.,0.60*width,0]){ rotate([0,-90,0]){ middle_bar(); } }
//translate([-0.5*(height-0.7*depth),0,0.5*50]){ rotate([0,0,0]){ { middle_bar(); } } }
//translate([0.,0.,width*0.5]){ support(); }
//translate([0.,0.,-width*0.5]){ support(); }

module middle_bar()
{
    difference()
    {
        color([0.,1.0,0.5]){ cube([depth,depth,67.5], center=true); }
        translate([depth/2,0,-25]){ cube([depth+1,depth+1,depth+0.25], center=true); }
        translate([depth/2,0,25]){ cube([depth+1,depth+1,depth+0.25], center=true); }
    }
}

//rotate([0,0,0]){ cylinder(d=3,h=10, $fn=60, center=true); }
//rotate([0,90,0]){ cylinder(d=6,h=3, $fn=60, center=true); }
//rotate([0,0,0]){ cylinder(d=8,h=3, $fn=60, center=true); }
//cylinder(r=head_radius, h=6, $fn=6, center=true);