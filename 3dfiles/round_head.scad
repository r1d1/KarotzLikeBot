// mm
h_radius=60;
h_thickness = 0.1;

// ======================================
// Head from sphere and cut
module round_top(radius=50, hat_thickness=0.2)
{
    color([1.,0.,0.])
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
}

//round_top(h_radius, h_thickness);

// ======================================
module round_bottom(radius=50, hat_thickness=0.2)
{
    points_head = [[0.,0.], [hat_thickness*radius, 0.], [hat_thickness*radius, -0.05*radius], [0., -0.1*radius], [-10*hat_thickness,-0.1*radius], [-10*hat_thickness,0.]]; 
    rotate_extrude(angle = 30, convexity = 10, $fn=200) 
    {
        translate([0.85*(1.-hat_thickness)*radius, 0, 0])
        {
            polygon(points=points_head);
            //for( i = points_head ){ translate(i){ sphere(r=0.25, center=true, $fn=50); } }
        }
    }
};

//round_bottom(h_radius, h_thickness);

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

front_offset = 14;
side_offset = -10;
vert_offset = -13;

// ======================================
// Head top shell
module head_top_shell()
{
    difference()
    {
        rotate([0,60,0])
        {
            scale([1.0,0.8,1.0])
            {
                round_top(h_radius, h_thickness);
                round_bottom(h_radius, h_thickness);
            }
        }
        // US sensor holes
        rotate([0,90,0])
        {
            color([1.0,0.0,0.0])
            {
                translate([16/2+1+vert_offset,18/2+1+side_offset,1.3+front_offset])
                { cylinder(r=8.5, h=25); }
                translate([16/2+27+1+vert_offset,18/2+1+side_offset,1.3+front_offset])
                { cylinder(r=8.5, h=25); }
            }
        }
    }
}

//head_top_shell();

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

// ======================================
// to clean and reorganize
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
                            # cylinder(r1=base_radius-base_thickness, r2=mid_factor*(base_radius-base_thickness), h=mid_height, $fn=200, center=false);
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
                color([0.,0.,1.0, 0.2]){ # cylinder(r=90,h=120, $fn=200, center=true); }
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