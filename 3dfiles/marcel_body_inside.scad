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

// include components lib:
include <../../cad-library/US_sensor_HC-SR04/hc-sr04-ultrasonic-sensor.scad>
path_cadlib = "../../cad-library";

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

base_radius = 50;
base_height = 100;
difference()
{
color([1.0,0.0,0.0,0.5]){ cylinder(r=base_radius,h=base_height); }
translate([0,0,10]){ color([1.0,0.0,0.0]){ cylinder(r=0.9*base_radius,h=1.1*base_height); } }
}
