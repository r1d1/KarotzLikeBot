// mm
h_radius=60;
h_thickness = 0.1;


// ======================================
// round head
// Test of generation with extrusion
module round_hat()
{
    //difference()
    {
        round_top(h_radius, h_thickness);
        translate([0,0,-10])
        {
            rotate_extrude(angle=30, $fn=200)
            {
                translate([168,0,0]){ square([20,20]); }
            }
        }
    }
}

//round_hat();

// ======================================
module round_eye(radius=12, length=10)
{
    // length = 0.2* radius seems nice
    // eye
    rotate([0,90,0])
    { 
        difference()
        {
        cylinder(r=radius, h=length, center=true);
        translate([0,0,0.5*length]){ color([0.1,0.1,0.9,0.4]){ cylinder(r=0.875*radius, h=0.3125*radius, center=true); } }
        }
    }
}

//translate([0,15,0]){ round_eye(); }

// ======================================
module eye_placeholder(radius, length){ rotate([0,90,0]){ cylinder(r=radius, h=length, center=true); } }
//translate([0,-15,0]){ eye_placeholder(12,10); }

// ======================================

//translate([0.60*h_radius,0,0.1*h_radius]){ round_eye(h_radius, 0.2*h_radius); }
//translate([0.60*h_radius,0,-0.35*h_radius]){ round_eye(h_radius, 0.2*h_radius); }

// Holder / test
/*difference()
{
round_bottom(h_radius, h_thickness);
translate([0.80*h_radius,0,0]){ eye_placeholder(0.2*h_radius, 0.2*h_radius); }
translate([0.80*h_radius,0,0]){ round_eye(h_radius, 0.2*h_radius); }
}
translate([0.80*h_radius,0,0]){ round_eye(h_radius); }
*/



// ======================================
//include <../../cad-library/US_sensor_HC-SR04/hc-sr04-ultrasonic-sensor.scad>
// IMPORTED HC-SR04 US MODEL
/*
translate([13, -10, 13])
{
    rotate([0,90,0])
    {
        import("/home/erwan/Documents/RobotMaker/cad-library/HC-SR04_-_Ultrasonic_sensor_fingerprint_Empreinte_Ultrason/files/us.stl");
        import("/home/erwan/Documents/RobotMaker/cad-library/PING_sensor_holder/files/PingBlock-v1.stl");
        import("/home/erwan/Documents/RobotMaker/cad-library/US_sensor_HC-SR04/hc-sr04-ultrasonic-sensor.scad");
        //full_sensor();
    }
}*/


// ======================================
// to clean and reorganize
base_radius = 50;
base_height = 25;
mid_height = 75;
base_thickness = 5;

module body_shell()
{
    // middle
    mid_factor = 0.7;
    intersection()
    {
        // Remove this translation here and then adapt B:
        translate([0.,0.,base_height])
        {
                difference()
                {
                    difference()
                    {
                        color([1.0, 1.0, 1.0])
                        {
                           cylinder(r1=base_radius, r2=mid_factor*base_radius,  h=mid_height+1, $fn=200, center=false);
                        }
                        color([0.0, 1.0, 1.0])
                        {
                            translate([0.,0.,base_thickness]){
                            // inside void
                            cylinder(r1=base_radius-base_thickness, r2=mid_factor*(base_radius-base_thickness), h=mid_height, $fn=200, center=false);
                            }
                        }
                    }
                    //translate([30.,0.,mid_height]){ rotate([0,90,0]){ cylinder(r=25,h=30, $fn=200, center=true); } }
                }
        }
        // B translation needs to be adapted
        translate([-0.65*base_radius,0.,mid_height*0.15])
        {
            rotate([90,0,0])
            {
                color([0.,0.,1.0, 0.2]){ cylinder(r=90,h=120, $fn=200, center=true); }
            }
        }
    }
}

//body_shell();
// ======================================
module arduino_placeholder()
{
    translate([0,0,40])
    {
        rotate([0,-90,0])
        {
            translate([-37.5,-26.5,0])
            {
            // 75x53
            import("/home/erwan/Documents/RobotMaker/cad-library/Arduino_Uno_Snug_Case/files/arduino_uno_top.stl");
            import("/home/erwan/Documents/RobotMaker/cad-library/Arduino_Uno_Snug_Case/files/arduino_uno_bottom.stl");
            }
        }
    }
}

//arduino_placeholder();
// ======================================
