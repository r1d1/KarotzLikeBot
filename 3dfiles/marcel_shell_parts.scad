/*
 * File: marcel_shell_parts.scad
 *
 * Description:
 * Shell parts
 * head, base, middle
 * Author: R1D1
 *
 * Licence : CC-By-SA
 * */

//include <round_head.scad>

// ======================================
// Top shell Head from sphere and cut
module round_top(radius=50, hat_thickness=0.2)
{
    difference()
    {
        // Main round shape
        translate([0,0,-0.5*radius])
        {
            difference()
            {
                sphere(r=radius, $fn=100, center=true);
                sphere(r=(1.0-hat_thickness)*radius, $fn=100, center=true);
            }
        }
        // cylinder was translated -0.15*radius on z
        translate([0.,0.,-0.8*radius]){ cylinder(r=1.05*radius, h=1.6*radius, center=true); }
    }
}

// ======================================
module round_bottom(radius=50, hat_thickness=0.2)
{
    points_head = [[0.,0.], [hat_thickness*radius, 0.], [hat_thickness*radius, -0.05*radius], [0., -0.1*radius], [-10*hat_thickness,-0.1*radius], [-10*hat_thickness,0.]]; 
    rotate_extrude(angle = 30, convexity = 10, $fn=200) 
    {
        translate([0.85*(1.-hat_thickness)*radius, 0, 0])
        {
            polygon(points=points_head);
        }
    }
}

// ======================================
// Full head
module head_top_shell(head_radius, head_thickness)
{
    difference()
    {
        scale([1.0,0.8,1.0])
        {
            round_top(head_radius, head_thickness);
            round_bottom(head_radius, head_thickness);
        }
        
        // US positioning
        front_offset = 14;
        side_offset = -10;
        vert_offset = -13;
        // US sensor holes
        rotate([0,30,0])
        {
            translate([16/2+1+vert_offset,18/2+1+side_offset,1.3+front_offset])
            { cylinder(r=8.5, h=25); }
            translate([16/2+27+1+vert_offset,18/2+1+side_offset,1.3+front_offset])
            { cylinder(r=8.5, h=25); }
        }
    }
}

//head_top_shell();
// ======================================
// ======================================

// OUTSIDE SHELL
base_radius = 50;
base_height = 25;
mid_height = 75;
base_thickness = 5;
// base

// ======================================
// to clean and reorganize
module base_shell()
{
    difference()
    {
        color([1.0, 1.0, 1.0]){ cylinder(r=base_radius, h=base_height+1, $fn=200, center=false); }
        translate([0.,0.,base_thickness]){ cylinder(r=base_radius-base_thickness, h=base_height, $fn=200, center=false); }
    }
}

//base_shell();

//round_top(h_radius, h_thickness);
//round_bottom(h_radius, h_thickness);
