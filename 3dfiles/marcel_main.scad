// for body shell (to change):
//include <round_head.scad>

//for leg:
include <marcel_inside_parts.scad>
include <marcel_shell_parts.scad>

module symbol()
{
    union()
    {
        difference()
        {
            cylinder(r=15,h=2, center=true);
            cylinder(r=11,h=3, center=true);
        }
        translate([21, 0, 0]){ cube([20, 5, 2], center=true); }
    }
}

head_long_radius = 60;
head_thickness = 0.1;

base_radius = 50;
base_height = 25;
mid_height = 75;
base_thickness = 5;

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

shell_resolution = 200;

for(colors=color_vec)
//for(color1=[red, blue, white, cyan, ocean], color2=[darkgrey, white, blue])
{
    translate([0., 150*colors[0], 0])
    {
        //difference()
        {
        union()
        {
        translate([0.,0., base_height/2])
        {
            color(colors[1])
            {
                base_shell(base_radius, base_height, base_thickness);
            }
        }

        // top body
        base_height = 25;
        translate([0., 0., base_height])
        {
            color(colors[1]){ body_shell(shell_resolution); }
        }

        // Head
        color(colors[2])
        translate([10.,0.,130])
        {
            rotate([0,60,0])
            {
                head_top_shell(head_long_radius, head_thickness);
            }
        }

        // Neck
        //neck_shell();

        base_angle = 45;
        color(colors[2])
        {
            rotate([0,0, base_angle+0]){ translate([0, base_radius, 0]){ leg(shell_resolution); } }
            rotate([0,0, base_angle+90]){ translate([0, base_radius, 0]){ leg(shell_resolution); } }
            rotate([0,0, base_angle+180]){  translate([0, base_radius, 0]){ leg(shell_resolution); } }
            rotate([0,0, base_angle+270]){  translate([0, base_radius, 0]){ leg(shell_resolution); } }
        }
        }

        //translate([47,0,40]){ rotate([0, 80, 0]){ symbol(); } }
        }
    }
}
