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

//arduino();
base_radius = 50;
base_height = 100;

centerability = false;

// approx dimensions
circle(r=base_radius);
cylinder(r=1, h=130);

//translate([-11.4, -6.3, 50.]){ rotate([0,0,0]){ servoSG90(); } }
//translate([0., -11.4, 110]){ rotate([0, 90, 90]){ servoSG90(); } }


//difference()
{
    translate([0,0, 35])
    {
        intersection()
        {
            cube([30,20,70], center=true); 
            rotate([90,0, 0]){ cylinder(r=36, h=20, center=true); }
        }
    }
    //translate([0,0, 35]){ #cube([20,21,60], center=true); }
    //cylinder(r1=30, r2=20, h=50, $fn=4, center=true);
}

/*
Useless now:
module bottom_base()
{
  difference()
  {
    color([1.0,1.0,1.0]){ cylinder(r=base_radius,h=0.1*base_height, center=centerability, $fn=128); }
    translate([0,0,0.2]){ color([0.0,0.0]){ cylinder(r=0.9*base_radius,h=0.1*base_height, center=centerability, $fn=128); } }
  }
}

bottom_base();
*/


translate([55,0,0])
{
 import("../../cad-library/LDR_Dummy_Model/2064_ldr.stl"); 
}


