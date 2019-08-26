/*
 * File: marcel_body_inside.scad
 *
 * Description:
 * Body inside+components
 * (base+miidle)
 * Author: R1D1
 *
 * Licence : CC-By-SA
 * */

// Include all placeholder components models:
include <../../cad-library/US_sensor_HC-SR04/hc-sr04-ultrasonic-sensor.scad>
include <TowerPro_MicroServo9g_SG90.scad>

path_cadlib = "../../cad-library";

module arduino()
{
    translate([0,0,20])
    {
        rotate([0,-0,0])
        {
            translate([-37.5,-26.5,0])
            {
            // 75x53
            import("../../cad-library/Arduino_Uno_Snug_Case/files/arduino_uno_top.stl");
            import("../../cad-library/Arduino_Uno_Snug_Case/files/arduino_uno_bottom.stl");
            }
        }
    }
}

module middle_support()
{
    intersection()
    {
        cube([35,20,70], center=true); 
        translate([0,0, -5]){ rotate([90,0, 0]){ cylinder(r=40, h=20, center=true); } }
    }
}

//arduino();
base_radius = 50;
base_height = 100;
shell_thickness = 5;

centerability = false;

// approx dimensions
//circle(r=base_radius-2*shell_thickness);
//cylinder(r=base_radius-shell_thickness, h=2, center=true);
//cylinder(r=1, h=130);


// External components
/*
translate([-11.4, -6.3, 50.5]){ rotate([0,0,0]){ servoSG90(); } }
translate([0., -11.4, 110]){ rotate([0, 90, 90]){ servoSG90(); } }
translate([28, 10, 98]){ rotate([180,-90,0]){ full_sensor(); } }
*/

/*
difference()
{
    translate([0,0, 35])
    {
        middle_support();
    }
    translate([0,0, 30]){ 
    cylinder(r1=30, r2=20, h=50, $fn=4, center=true);
    scale([0.8, 1.1, 0.8]){ middle_support(); }
    }

    //#cube([20,21,60], center=true); 
}*/

/*
translate([55,-10,0]){ import("../../cad-library/LDR_Dummy_Model/2064_ldr.stl"); }
translate([55,0,0]){ import("../../cad-library/LDR_Dummy_Model/2064_ldr.stl"); }
translate([60,0,0]){ import("../../cad-library/fischertechnik_SG90_mini_servo_system/files/03_Gear_Z10_adapter_v2.stl"); }
*/

//pole_radius = 2.5;
pole_rad = 10;
//pole_len=110;
pole_len=60;
pole_position = 20;
angles_1 = [0,30,60,90,120,150,180,210,240,270,300,330];
angles_2=[45,135,225,315];
//angles_2=[0,60,120,180,240,300];

/*
for(angle=angles_2)
{
    rotate([0,0,angle]){ translate([20,0,0]){ color("red"){ cylinder(r=pole_rad, h=100, $fn=6); } } }
}*/
/*
translate([20,10,0]){ cylinder(r=pole_radius, h=100, $fn=6); }
translate([-20,10,0]){ cylinder(r=pole_radius, h=100, $fn=6); }
translate([-20,-10,0]){ cylinder(r=pole_radius, h=100, $fn=6); }
translate([20,-10,0]){ cylinder(r=pole_radius, h=100, $fn=6); }
*/

module vbar(pole_radius, pole_length)
{
    cube([pole_radius, pole_radius, pole_length], center=true);
}

module interbar(pole_radius)
{
    cube([pole_radius, 0.75*pole_radius, 60], center=true);
}

module support()
{
    //cylinder(r=base_radius-shell_thickness, h=2, center=true);
    translate([pole_position,pole_position,pole_len/2]){ color("red"){ vbar(pole_rad, pole_len); } }
    translate([pole_position,-pole_position,pole_len/2]){ color("red"){ vbar(pole_rad, pole_len); } }
    translate([-pole_position,-pole_position,pole_len/2]){ color("red"){ vbar(pole_rad, pole_len); } }
    translate([-pole_position,pole_position,pole_len/2]){ color("red"){ vbar(pole_rad, pole_len); } }
    for(comb=[0,1])
    {
        rotate([0,0,comb*90])
        {
            for(i=[0 : 0])
            {
                for(side=[-pole_position,pole_position])
                {
                    translate([0,side,i*51+27]){ color("blue"){ rotate([0,-40,0]){ interbar(pole_rad); } } }
                    translate([0,side,i*51+27]){ color("blue"){ rotate([0,40,0]){  interbar(pole_rad); } } }
                }
            }
        }
    }
}

//full_support();

module top_shape()
{
    difference()
    {
        cube([11,11,13], center=true);
        cube([5,5,20], center=true);
    }
}

module full_support()
{
difference()
{
    support();
    translate([0,0,pole_len])
    {
        translate([pole_position, pole_position, 0]){ top_shape(); } 
        translate([pole_position, -pole_position, 0]){ top_shape(); }
        translate([-pole_position, -pole_position, 0]){ top_shape(); }
        translate([-pole_position, pole_position, 0]){ top_shape(); }
    }
}
}

//cylinder(r=base_radius-shell_thickness, h=2, center=true);
intersection()
{
    difference()
    {
        cube([55,55,10], center=true);
        translate([0,0,-pole_len-1])
        {
            difference()
            {
                full_support();
                translate([0,0,-(pole_len-6.40)]){ color("green"){ scale(1,1,1.005){ full_support(); } } }
            }
        }
        translate([-11,-6.5,-13]){ rotate([0,0,0]){ servoSG90(); } }
    }
    union()
    {
        translate([11,11,0]){ color("red"){ cylinder(r=19,h=12, center=true); } }
        translate([11,-11,0]){ color("red"){ cylinder(r=19,h=12, center=true); } }
        translate([-11,-11,0]){ color("red"){ cylinder(r=19,h=12, center=true); } }
        translate([-11,11,0]){ color("red"){ cylinder(r=19,h=12, center=true); } }
    }
}
