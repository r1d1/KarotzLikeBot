include <marcel_shell_parts.scad>

head_long_radius = 60;
head_thickness = 0.1;

//offset(r = -1)
{
    //projection(cut = false)
    //translate([10.,0.,130])
    {
        rotate([0,60,0])
        //rotate([0,-15,-90])
        {
            head_top_shell(head_long_radius, head_thickness);
        }
    }
}