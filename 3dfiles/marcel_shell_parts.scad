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
                //sphere(r=(1.0-hat_thickness)*radius, $fn=100, center=true);
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
            difference()
            {
                round_top(head_radius, head_thickness);
                translate([0,0,-0.5*head_radius]){ sphere(r=(1.0-head_thickness)*head_radius, $fn=100, center=true); }
            }
            round_bottom(head_radius, head_thickness);
        }
        
        // US positioning
        front_offset = 14;
        side_offset = -10;
        vert_offset = -13;
        // US sensor holes
       union()
        {
        rotate([0,30,0])
        {
            translate([16/2+1+vert_offset,18/2+1+side_offset,1.3+front_offset])
            { cylinder(r=8.5, h=50, center=true); }
            translate([16/2+27+1+vert_offset,18/2+1+side_offset,1.3+front_offset])
            { cylinder(r=8.5, h=50, center=true); }
            intersection()
            {
                translate([16/2+13.5+1+vert_offset,0,0])
                //{ cube([60,40,70], center=true); }
                scale([1.0,0.8,1.0])
                {
                }
            }
        }
        }
    }
}

//head_top_shell(60, 0.1);
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
module base_shell(radius, height, thickness)
{
    color([1.0, 1.0, 1.0])
    { 
        difference()
        {
            cylinder(r=radius, h=height, $fn=200, center=true);
            translate([0.,0., thickness]){ cylinder(r=radius-thickness, h=height, $fn=200, center=true); }
        }
    }
}

//base_shell();

//round_top(h_radius, h_thickness);
//round_bottom(h_radius, h_thickness);

// ======================================
// to clean and reorganize
base_radius = 50;
base_height = 25;
mid_height = 75;
base_thickness = 5;

module body_shell(resolution=100)
{
    // middle
    mid_factor = 0.7;
    intersection()
    {
        // Remove this translation here and then adapt B:
        //translate([0.,0.,base_height])
        translate([0., 0., 0.])
        {
                difference()
                {
                    difference()
                    {
                        color([1.0, 1.0, 1.0])
                        {
                           cylinder(r1=base_radius, r2=mid_factor*base_radius,  h=mid_height+1, $fn=resolution, center=false);
                        }
                        color([0.0, 1.0, 1.0])
                        {
                            translate([0.,0.,base_thickness]){
                            // inside void
                            cylinder(r1=base_radius-base_thickness, r2=mid_factor*(base_radius-base_thickness), h=mid_height, $fn=resolution, center=false);
                            }
                            translate([0.,0., -base_thickness]){
                                cylinder(r=(base_radius-base_thickness)-1, h=base_height+1, $fn=resolution, center=true);
                            }
                        }
                    }
                    //translate([30.,0.,mid_height]){ rotate([0,90,0]){ cylinder(r=25,h=30, $fn=200, center=true); } }
                }
        }
        // B translation needs to be adapted
        //translate([-0.65*base_radius,0.,mid_height*0.15])
        translate([-0.65*base_radius,0., -(25 - 0.15 * 75)])
        {
            rotate([90,0,0])
            {
                color([0.,0.,1.0, 0.2]){ cylinder(r=90,h=120, $fn=resolution, center=true); }
            }
        }
    }
}

//body_shell();

// ======================================
module leg(resolution=24)
{
    translate([0, -9, -9])
    rotate([0,-90,0])
    {
        linear_extrude(height = 16, center = true)
        {
            intersection()
            {
                square(20,30);
                circle(r=23, center=true, $fn=resolution);
            }
        }
    }
}

//leg();

// ======================================
module hv_side(resolution=24)
{
    difference()
    {
    intersection()
    {
        cube([80,80,6], center=true);
        translate([35,35,0])
        {
            cylinder(r=80, h=10, center=true, $fn=resolution);
        }
    }
    translate([70,70,0]){ cylinder(r=80, h=10, center=true, $fn=resolution); }
    translate([-41,41,0]){ rotate([0,0,45]){ cube([15,10,10], center=true); } }
    }
}
module head_variant(resolution=24)
{
    color([1,0,0])
    {
        translate([0,0,20]){ hv_side(resolution); }
        translate([0,0,-20]){ hv_side(resolution); }
    }
    difference()
    {
        hv_side(resolution);
        translate([7,7,0]){ scale([1.0, 1.0, 1.1]) hv_side(resolution); }
    }
}

//head_variant(resolution=256);
