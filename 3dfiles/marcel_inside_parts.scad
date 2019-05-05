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

centerability = false;

// approx dimensions
circle(r=base_radius);
cylinder(r=1, h=130);

translate([-11.4, -6.3, 50.5]){ rotate([0,0,0]){ servoSG90(); } }
translate([0., -11.4, 110]){ rotate([0, 90, 90]){ servoSG90(); } }
translate([28, 10, 98]){ rotate([180,-90,0]){ full_sensor(); } }

difference()
{
    translate([0,0, 35])
    {
        middle_support();
    }
    translate([0,0, 30]){ 
    //cylinder(r1=30, r2=20, h=50, $fn=4, center=true);
    scale([0.8, 1.1, 0.8]){ middle_support(); }
    }

    //#cube([20,21,60], center=true); }
}


translate([55,-10,0]){ import("../../cad-library/LDR_Dummy_Model/2064_ldr.stl"); }
translate([55,0,0]){ import("../../cad-library/LDR_Dummy_Model/2064_ldr.stl"); }
translate([60,0,0]){ import("../../cad-library/fischertechnik_SG90_mini_servo_system/files/03_Gear_Z10_adapter_v2.stl"); }

//translate([20,10,0]){ cylinder(r=2.5, h=100, $fn=6); }
//translate([-20,10,0]){ cylinder(r=2.5, h=100, $fn=6); }
//translate([-20,-10,0]){ cylinder(r=2.5, h=100, $fn=6); }
//translate([20,-10,0]){ cylinder(r=2.5, h=100, $fn=6); }
