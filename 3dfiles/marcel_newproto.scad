use <head_servo_connector2.scad>
use <internal_parts.scad>

base_diameter=100;
base_thickness=3;

plot_diameter=10;
plot_thickness=7;

module connectors()
{
    // Foot connectors
    for(angle = [0,90,180,270])
    {
        rotate([0,0,angle])
        {
            translate([base_diameter*0.45,0,6.25+base_thickness/2]){ peg_in_hole(); }
        }
    }
    // Shell connectors
    for(angle = [45,135,225,315])
    {
        rotate([0,0,angle])
        {
            // foot peg-in-hole
            translate([base_diameter*0.33,0,6.25+base_thickness/2]){ peg_in_hole(); }
            // shell peg-in-hole
            translate([base_diameter*0.27,0,6.25+base_thickness/2+30]){ peg_in_hole(); }
            //translate([base_diameter*0.27,0,6.25+base_thickness/2+10]){ scaled_hole(); cube([plot_thickness,plot_thickness,plot_thickness], center=true); }
        }
    }
}

//connectors();

shell_points=[[22,0],[22+3,0],
              [20+3,25],[0+3,100],
              [0,100],[20,25]];
            // 4th [15+3,60], 7th ,[15,60]

//for( p = shell_points ){ translate([p[0], p[1], 0]) { color([1,0,0]){ sphere(r=0.6, $fn=30);} } }

module shell()
{
    rotate_extrude(convexity = 10, $fn = 100)
    {
        translate([base_diameter*0.25, 0, 0]){ polygon( points=shell_points); }
    }
}

// Joint
//translate([base_diameter*0.5-10,0,6.25+base_thickness/2]){ peg_in_hole(); }
//translate([base_diameter*0.5+2,0,6.25+base_thickness/2]){ cube([4,10,10], center=true); }

// ---------------------------------------------------
// Old code
// ---------------------------------------------------

//for leg:
include <marcel_shell_parts.scad>

module symbol()
{
    union()
    {
        difference()
        {
            #cylinder(r=15,h=2, center=true);
            #cylinder(r=11,h=3, center=true);
        }
        translate([21, 0, 0]){ cube([20, 5, 2], center=true); }
    }
}

head_long_radius = 60;
head_thickness = 0.1;

base_radius = 60;
base_height = 25;
mid_height = 75;
base_thickness = 3;

darkgrey=[0.2, 0.2, 0.2];
white=[1.0, 1.0, 1.0];
red=[1.0, 0.0, 0.0];
blue=[0.0, 0.0, 1.0];
cyan=[0.0, 1.0, 1.0];
ocean=[0.0, 0.467, 0.745];
darkblue=[];
//#0000A0
lightblue=[0.678, 0.847, 0.901];
//#ADD8E6
// 173, 216, 230

// background
/*
color([0.7,0.9,0.6]) { translate([-100,0,200]){ cube([2,2000,500], center=true); } }
color([0.9,0.9,0.5]) { translate([0,0,-5]){ cube([500,2000,2], center=true); } }
*/
// BASE
module base()
{
    color([1,0,0]){ cylinder(r=base_radius, h=base_thickness, $fn=90, center=true); }
}
//#shell();

// make a loop to test various color scheme
color_vec =[
            //[-4, darkgrey, red  ],
            //[-3, darkgrey, blue ],
            //[-2, darkgrey, white],
            //[-1, darkgrey, cyan ],
            [0, darkgrey, ocean],
            //1, white , red  ],
            //2, white , blue ],
            //3, white , white],
            //4, white , cyan ],
            //[5, white , ocean]
            ];

color_vec=[red, blue, white, cyan, ocean, darkgrey, white, blue];

shell_resolution = 200;

//for(colors=color_vec)
//for(color1=[red, blue, white, cyan, ocean], color2=[darkgrey, white, blue])
{
    //translate([0., 150*colors[0], 0])
    translate([0., 150*color_vec[0], 0])
    {
        //difference()
        {
        union()
        {
        translate([0.,0., base_height/2])
        {
            //color(colors[1])
            color(color_vec[1])
            {
                //base_shell(base_radius, base_height, base_thickness);
            }
        }

        // top body
        base_height = 25;
        translate([0., 0., base_height])
        {
            color(color_vec[5])
            {
               //body_shell(shell_resolution);
                rotate([0,0,-90])
                {
                    //body_shell(base_radius=60, base_thickness=5, resolution=100);
                }
            }
        }

        // Neck
        //neck_shell();

        }

        //translate([47,0,40]){ rotate([0, 80, 0]){ symbol(); } }
        }
    }
}

// New cooler support
module support_bottom()
{
    color([0.0, 0.75, 0.5])
    { 
        difference()
        {
            union()
            {
                cube([26,30,20], center=true);
                translate([0,-30, 30]){ cube([26,30,80], center=true); }
            }
    
            translate([0,0,base_connector_height+length_big*0.5-10])
            {
                union()
                {
                    // perpendicular hole small servo
                    translate([0, -30, 0]){ color([1,1,1]){ cube([28,17,44], center=true); } }
                    translate([0, (length_side_big - 10)*1, 0])
                    {
                        rotate([90,0,0])
                        {
                            // imprint servos
                            // big side servo
                            //translate([0, 0, 17.5]){ #cube([20,55,37], center=true); }
                            // small side servo
                            translate([0, 0, 20+length_side_big + 7 - 12.5]){ rotate([0,180 ,0]){ #cube([20,44,27], center=true); } }
                        }
                    }
                    translate([0,7.75,-37])
                    {
                        rotate([-25,0,0]){ cube([28,43,16], center=true); }
                        translate([0,-17.75, 9.5]){ cube([28,10,15], center=true); }
                    }
                }
            }
        }
    }
}

// horizontal servo
length_big=55;
length_side_big=37;
length_small=44;
length_side_small=27;

base_connector_length=80;
base_connector_width=20;
base_connector_height=25;

// -------------------------
// Vertical bottom joint
module vertical_servo()
{
    translate([0, 0, base_connector_height+length_big*0.5])
    {
        translate([0, (length_side_big - 10)*1, 0])
        {
            rotate([90,0,0])
            {
                //cube([20,55,37], center=true);
                plate_servo(length_big,length_side_big);
                translate([0, 0, 20+length_side_big + 7]){ rotate([0,180 ,0]){ plate_servo(length_small,length_side_small, small=true); } }
            }
        }
    
        translate([0, -12.5, 0]){ color([0,1,0]){ cube([20, 40, length_side_big], center=true); } }
        color([0,0,1]){ cylinder(d=8, h=length_big, center=true, $fn=60); }
    }
}

// -------------------------
// Horizontal servo
module horizontal_servo()
{
    translate([0, 0, 148])
    {
        // Top joint
        translate([0, (length_side_big - 10)*1, 0])
        {
        rotate([90,90,0])
        {
            translate([23.5,0,13.5]){ rotate([0,-60,0]){ plate_servo(length_big,length_side_big); } }
            translate([0, 0, 20+length_side_big + 7]){ rotate([0,180,0]){ plate_servo(length_small,length_side_small); } }
        }
        }
    
        rotate([0,90,0])
        {
            translate([0, -12.5, 0]){ color([0,1,0])
            {
                cube([20, 40, length_side_big], center=true); }
            }
            color([0,0,1]){ cylinder(d=8, h=length_big, center=true, $fn=60); }
        }
    }
}

//--------------------------------------------
module m3(length=10)
{
    // head
    translate([0, 0, 0]){ cylinder(d=6, h=2.5, $fn=60, center=true); }
    translate([0, 0, 0.5*length]){ cylinder(d=3, h=length, $fn=60, center=true); }
}

//--------------------------------------------
//test in-between servos connector supported by shell/inside structure
module top_connector(offset=0)
{
    translate([0,0,90+offset])
    {
        //scale([0.9,1.2,1.0])

        difference()
        {
            union()
            {
                sphere(r=40, $fn=120, center=true);
                translate([0,50,20])
                {
                    rotate([-60,0,0]){ translate([0,-14,-30]){ cube([58,40,40],center=true); } }
                }
            }
            translate([0,0,-25]){ cube([80,80,40], center=true); }
            translate([0,-10,30]){ rotate([30,0,0]){ cube([80,100,30],center=true); } }
            translate([-38,0,20]){ cube([15,80,40], center=true); }
            translate([38,0,20]){ cube([15,80,40], center=true); }
            translate([0,45,20]){ rotate([15,0,0]){ cube([62,22,35], center=true); } }
            translate([0,30,34]){ rotate([-30,0,0]){ translate([0,0,0]) cube([62,10,10], center=true); } }
            
            color([1.0,0.0,0.0])
            {
                //#rotate([30,0,0]){ translate([0,5,6]) cube([61.1,20,6], center=true); }
                //#translate([0,8,-3]) rotate([60,0,0]){ translate([0, 10, 0]) cube([61.1,8,15], center=true); }
                //#translate([0, 5, 0]){ cube([61,25,9], center=true); }
                //scale([1.2, 0.9, 1.0]){ translate([0, 5, 2.55]){ cylinder(r=31, h=5, $fn=120, center=true); } }
            }
            translate([0,0,-4]) cylinder(r=30, h=10, center=true, $fn=120);
            
            // Back shape
            translate([27,37,17]) rotate([0*15,0*15,-45]){ cube([25,15,34], center=true); }
            translate([15,40,17]) rotate([0,0,-20]){ cube([35,10,34], center=true); }
            translate([-27,37,17]) rotate([0,0,45]){ cube([25,15,34], center=true); }
            translate([-15,40,17]) rotate([0,0,20]){ cube([35,10,34], center=true); }
            
            translate([0, 0, 17])
            {
                union()
                rotate([90,-30,90])
                {
                    translate([15, 1,  0]){ cube([20.5,5,55.5], center=true); }
                    translate([20, 1,-15]){ rotate([90, 0, 0]){ m3(16); } }
                    translate([20, 1, -5]){ rotate([90, 0, 0]){ m3(16); } }
                    translate([20, 1,  5]){ rotate([90, 0, 0]){ m3(16); } }
                    translate([20, 1, 15]){ rotate([90, 0, 0]){ m3(16); } }
                    translate([10, 1,-15]){ rotate([90, 0, 0]){ m3(16); } }
                    translate([10, 1, -5]){ rotate([90, 0, 0]){ m3(16); } }
                    translate([10, 1,  5]){ rotate([90, 0, 0]){ m3(16); } }
                    translate([10, 1, 15]){ rotate([90, 0, 0]){ m3(16); } }
                }
            }
        }
    }
}

//--------------------------------------------

module top_neck_holder(offset=0)
{
    translate([0,0,90+offset])
    {
        difference()
        {
            cylinder(h=15, r=42, $fn=120, center=true);
            translate([0,0,2]){ cylinder(h=15, r=40, $fn=120, center=true); }
            translate([0,0,2]){ rotate([5,0,0]){ cylinder(r=45, h=10); } }
        }
        cylinder(r1=10,r2=7,h=10, $fn=120, center=true);
        translate([0,0,10]){ cylinder(r=3, h=10, $fn=120, center=true); }
        
        radius = 38;
        angles = [65, 115];
        points = [for(a = [angles[0]:1:angles[1]]) [radius * cos(a), radius * sin(a)]];
        translate([0,0,-42.5-40+offset])
        {
            #union()
            difference()
            {
                linear_extrude(65) polygon(concat([[0, 0]], points));
                translate([0,12, 32])
                {
                    cube([50,26,67], center=true);
                    translate([0, 13.5+0.5, -7]){ cube([20,5,55], center=true); }
                }
                translate([5,37,10]){ rotate([90,0,0]){ m3(16); } }
                translate([5,37,20]){ rotate([90,0,0]){ m3(16); } }
                translate([5,37,30]){ rotate([90,0,0]){ m3(16); } }
                translate([5,37,40]){ rotate([90,0,0]){ m3(16); } }
                translate([-5,37,10]){ rotate([90,0,0]){ m3(16); } }
                translate([-5,37,20]){ rotate([90,0,0]){ m3(16); } }
                translate([-5,37,30]){ rotate([90,0,0]){ m3(16); } }
                translate([-5,37,40]){ rotate([90,0,0]){ m3(16); } }
                
                translate([0,37,-3]){ rotate([45,0,0]){ cube([35,25,10], center=true) ; } }
            }
        }
    }
    
}

//--------------------------------------------
// Head
module face()
{
    rotate([0,0,-90])
    {
        translate([25.,0.,170])
        {
            rotate([0,60,0])
            {
                head_top_shell(head_long_radius, head_thickness, head_color=color_vec[4]);
            }
        }
    }
}
//--------------------------------------------
/* //screw tests
translate([0,-10, 1.20]){ m3(10); }
m3(16);
translate([0,10,0]){ m3(40); }
*/
//--------------------------------------------
// ACTIVATE PARTS :
base_bool = false;
neck_bool = false;
head_bool = false;

//--------------------------------------------
// Plates base :

if( base_bool ){ translate([0,0,base_thickness*0.5]){ base(); } }
if( base_bool )
{
    translate([0,0,base_thickness*1.5])
    {
        color([1.0, 0.75, 0.0]){ cylinder(r=0.8*base_radius, h=base_thickness, $fn=120, center=true); }
    }
}

base_foot_angle = 45;
if( base_bool )
{
    color(color_vec[4])
    {
        // leg/foot
        rotate([0,0, base_foot_angle+0]){ translate([0, 11+base_radius+2, 7.5]){ leg(shell_resolution); } }
        rotate([0,0, base_foot_angle+90]){ translate([0, 11+base_radius+2, 7.5]){ leg(shell_resolution); } }
        rotate([0,0, base_foot_angle+180]){  translate([0, 11+base_radius+2, 7.5]){ leg(shell_resolution); } }
        rotate([0,0, base_foot_angle+270]){  translate([0, 11+base_radius+2, 7.5]){ leg(shell_resolution); } }
        
        // foot connector
        rotate([0,0, base_foot_angle+0]){ translate([0, base_radius, 9]){ cube([10,8,15], center=true); } }
        rotate([0,0, base_foot_angle+90]){ translate([0, base_radius, 9]){ cube([10,8,15], center=true); } }
        rotate([0,0, base_foot_angle+180]){  translate([0, base_radius, 9]){ cube([10,8,15], center=true); } }
        rotate([0,0, base_foot_angle+270]){  translate([0, base_radius, 9]){ cube([10,8,15], center=true); } }
    }
}

//--------------------------------------------
// Bottom servo support
// base_thickness*1.5
if( neck_bool ){ translate([0, 0, base_thickness*5.5]){ support_bottom(); } }
if( neck_bool ){ vertical_servo(); }
if( neck_bool ){ color([0.5,0.5,1.0]) top_neck_holder(10); }

if( head_bool ){ top_connector(10); }
if( head_bool ){ horizontal_servo(); }
if( head_bool ){ face(); }


//rotate([30,0,0]){ translate([0,0,0]) cube([61.1,20,6], center=true); }
//translate([0,0,0]) rotate([60,0,0]){ translate([0, 10, 0]) cube([61.1,8,15], center=true); }
//translate([0, 5, 0]){ cube([61,25,9], center=true); }
//scale([1.2, 0.9, 1.0]){ translate([0, 5, 2.55]){ cylinder(r=31, h=5, $fn=120, center=true); } }
//translate([0,0,0]) cylinder(r=30, h=10, center=true, $fn=120);
//radius = 20;
angles2 = [0, 30];
//points2 = [for(a = [angles2[0]:1:angles2[1]]) [radius * cos(a), radius * sin(a)]];
hole_length = 20;
points2 = [for(a = [angles2[0]:1:angles2[1]]) [hole_length * cos(a), hole_length* sin(a), 0]];
points3 = concat([[0,0,0], [0.5*hole_length*cos(30), 0.5*hole_length*sin(30), 0], [0.5*hole_length*cos(30),0,0]]);
//rotate([0,0,0]){ linear_extrude(5) polygon(concat([[10, 0]], points2)); }
for(p=points3)
{
    translate(p){ sphere(r=0.5, $fn=60); }
}


/*
// Dump
scale([0.7,1.1,1.0]) cylinder(r=40, h=100, $fn=120, center=true);
//sphere(r=40, $fn=120, center=true);
translate([0,0,-25]){ cube([80,90,40],center=true); }
translate([0,-10,40]){ rotate([30,0,0]){ cube([80,110,40],center=true); } }
*/
  