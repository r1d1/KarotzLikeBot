use <../../cad-library/Snap_fit_jointconnector/snap_fit_peg.scad>
use <../../cad-library/Snap_fit_jointconnector/snap_fit_hole.scad>

module scaled_peg()
{
    rotate([0,90,0]){
    difference()
    {
        scale([0.25,0.25,0.25]){ snap_fit_peg(); }
        translate([0,0,20]){ cylinder(d=10, h=20, center=false); }
    }
}
}
module scaled_hole()
{
    rotate([0,90,180])
    {
       scale([0.25,0.25,0.25]){ snap_fit_hole(); }
    }
}

module test_hole()
{
    difference()
{
    union()
    {
        cylinder(d=plot_diameter, h=plot_thickness, center=true, $fn=120);
        translate([plot_diameter/2,0,0])
        {
        //color([1,0,0])
        { cube([plot_diameter, plot_diameter, plot_thickness], center=true); }
        }
    }
    cylinder(d=0.6*plot_diameter, h=plot_thickness+1, center=true, $fn=120);
}
}


module peg_in_hole()
{
    scaled_hole();
    translate([-3.775,0,0]){ scaled_peg(); }
}
