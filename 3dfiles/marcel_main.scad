include <round_head.scad>
//include <marcel_inside_parts.scad>

base_shell();
body_shell();
translate([0.,0.,130]){ head_top_shell(); }
//bottom_base();
//rotate([0,0,0]){ translate([0, base_radius, 0]){ leg(); } }
//rotate([0,0,90]){ translate([0, base_radius, 0]){ leg(); } }
//rotate([0,0,180]){  translate([0, base_radius, 0]){ leg(); } }
//rotate([0,0,-90]){  translate([0, base_radius, 0]){ leg(); } }
