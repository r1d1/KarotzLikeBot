//include <round_head.scad>
//include <marcel_inside_parts.scad>
include <marcel_shell_parts.scad>

head_long_radius = 60;
head_thickness = 0.1;
//base_shell();
//body_shell();

// Head
translate([10.,0.,130])
{
    rotate([0,60,0])
    {
        head_top_shell(head_long_radius, head_thickness);
    }
}
base_radius = 50;
base_height = 25;
mid_height = 75;
base_thickness = 5;

translate([0.,0., base_height/2])
{
    base_shell(base_radius, base_height, base_thickness);
}
//bottom_base();
//rotate([0,0,0]){ translate([0, base_radius, 0]){ leg(); } }
//rotate([0,0,90]){ translate([0, base_radius, 0]){ leg(); } }
//rotate([0,0,180]){  translate([0, base_radius, 0]){ leg(); } }
//rotate([0,0,-90]){  translate([0, base_radius, 0]){ leg(); } }
