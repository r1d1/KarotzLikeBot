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
include <../../cad-library/TowerPro_MicroServo9g_SG90.scad>
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
color([1.0,1.0,1.0]){ cylinder(r=base_radius,h=0.1*base_height, center=true, $fn=128); }
translate([0,0,0.2]){ color([0.0,0.0]){ cylinder(r=0.9*base_radius,h=0.1*base_height, center=true, $fn=128); } }
}
import("../../cad-library/LDR_Dummy_Model/2064_ldr.stl");
translate([20,0,0]){ import("../../cad-library/LDR_Dummy_Model/2064_ldr.stl"); }
translate([60,0,0]){ servoSG90(); }
translate([100,-0,0]){ servoSG90(); }
