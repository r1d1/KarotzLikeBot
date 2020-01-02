//width=20;
//length=55;
//length_side=37;
//thickness=2;
//offset_center_b = 20;
//offset_center_t = -50;
offset_center_b = 0;
offset_center_t = 0;

module plate_servo(length, length_side, , small=false)
{
    small_hole = 3.1;
    big_hole=8;
    thickness=2;
    width=20;
    
    difference(width, length, thickness)
    {
    union()
    {
        cube([width, length, thickness], center=true);
        //translate([0,-length/4,thickness/2]){ cube([width, length/2, 2*thickness], center=true); }
        translate([0, -(length-thickness)/2, length_side/2]){ cube([width, thickness, length_side], center=true); }
        translate([0, (length-thickness)/2, length_side/2]){ cube([width, thickness, length_side],  center=true); }

    }
    // bottom servo holes:
    if( !small )
    {
        translate([5,offset_center_b+15,0]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
        translate([-5,offset_center_b+15,0]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
        translate([5,offset_center_b-15,0]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
        translate([-5,offset_center_b-15,0]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
    }
    
    // top servo holes
    translate([5,offset_center_t+5, 0.*thickness/2]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
    translate([-5,offset_center_t+5, 0.*thickness/2]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
    translate([5,offset_center_t-5, 0.*thickness/2]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
    translate([-5,offset_center_t-5, 0.*thickness/2]){ cylinder(d=small_hole,h=thickness+2,center=true, $fn=60); }
    
    translate([0., length*0.5 - 1, length_side - 6 - big_hole*0.5]){ rotate([90,0,0]){ cylinder(d=big_hole,h=4, center=true, $fn=60); } }
    translate([0., -length*0.5+1, length_side - 6 - big_hole*0.5]){ rotate([90,0,0]){ cylinder(d=big_hole,h=4, center=true, $fn=60); } }
    }
}

length_big=55;
length_side_big=37;
plate_servo(length_big,length_side_big, small=false);

length_small=44;
length_side_small=27;
translate([0, 0, 20+length_side_big + 7]){ rotate([0,180,0]){ plate_servo(length_small,length_side_small, small=true); } }
