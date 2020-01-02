width=20;
length=120;
thickness=3;
offset_center_b = 20;
offset_center_t = -50;

difference()
{
    union()
    {
        cube([width, length, thickness], center=true);
        translate([0,-length/4,thickness/2]){ cube([width, length/2, 2*thickness], center=true); }
    }
// bottom servo holes:
translate([5,offset_center_b+15,0]){ cylinder(d=3.1,h=thickness+2,center=true, $fn=60); }
translate([-5,offset_center_b+15,0]){ cylinder(d=3.1,h=thickness+2,center=true, $fn=60); }
translate([5,offset_center_b-15,0]){ cylinder(d=3.1,h=thickness+2,center=true, $fn=60); }
translate([-5,offset_center_b-15,0]){ cylinder(d=3.1,h=thickness+2,center=true, $fn=60); }

// top servo holes
translate([5,offset_center_t+5,thickness/2]){ cylinder(d=3.1,h=thickness*2+2,center=true, $fn=60); }
translate([-5,offset_center_t+5,thickness/2]){ cylinder(d=3.1,h=thickness*2+2,center=true, $fn=60); }
translate([5,offset_center_t-5,thickness/2]){ cylinder(d=3.1,h=thickness*2+2,center=true, $fn=60); }
translate([-5,offset_center_t-5,thickness/2]){ cylinder(d=3.1,h=thickness*2+2,center=true, $fn=60); }

// slope
color([1,0,0])
{ 
    translate([0,-0.93*length/6,thickness+0.26*length/6])
    {
        rotate([-15,0,0]){ cube([width+2,length/3,thickness], center=true); }
        cube([width/2,length/3,thickness*6+2], center=true);
    }
    translate([0,offset_center_b,0]){ cube([width/2,length/6,thickness+2], center=true); }
    translate([0,offset_center_b+length/4+1]){ cube([width+2,length/6,thickness+2], center=true); }
}
}

cylinder(d=8,h=5,$fn=6);