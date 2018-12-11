//cylinder(r=50, h=20, center=true);

height=200;
length=50;

color([0.2, 0.2, 0.2])
{
    translate([0,0,height/2])
    {
        cube([length,length/2,height], center=true);
    }
}