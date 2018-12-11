include <../froggy/lasercutting/boards.scad>

height=200;
length=100;

// RPi
color([1., 0., 0.])
{
    //cube([length,length/2,height], center=true);
    //translate([0,0,76.5]){ rpi_case_rs(); }
}

// Body
color([0.2, 0.2, 0.2, 0.8])
{
    body_height = 0.8*height;
    translate([0,0,body_height/2])
    {
        //cylinder(r1=length, r2=0.8*length, h=body_height, center=true, $fn=100);
    }
}

// leg
{
leg_height = 0.8*height;
leg_width = 0.7*length;
color([0.9, 0.9, 0.8, 1.0])
{
    translate([0,0,leg_height/2])
    {
        cube([leg_width,leg_width, leg_height], center=true);
    }
}
color([0.2, 0.9, 0.8, 1.0])
{
    cube([leg_width,leg_width, leg_height], center=true);
}
}
