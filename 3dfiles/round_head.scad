//cylinder(r=50, h=20, center=true);

// mm
length=50;
h_radius=50;
h_thickness = 0.1;

// Head from sphere and cut
module round_top(radius, hat_thickness)
{
   
    difference()
    {
        // Main round shape
        translate([0,0,-0.5*radius])
        {
            difference()
            {
                color([1.,0.,0.]){ sphere(r=radius, $fn=100, center=true); }
                color([1.,0.,0.]){ sphere(r=(1.0-hat_thickness)*radius, $fn=100, center=true); }
            }
        }
        // cylinder was translated -0.15*radius on z
        translate([0.,0.,-0.8*radius]){ cylinder(r=1.05*radius, h=1.6*radius, center=true); }
    }
}

module round_bottom(radius, hat_thickness)
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

// round head
module round_hat()
{
    difference()
    {
        round_top();
        translate([0,0,-10])
        {
            rotate_extrude(angle=30, $fn=200)
            {
            translate([168,0,0]){ square([20,20]); }
            }
        }
    }
}

module round_eye(radius, length)
{
    // length = 0.2* radius seems nice
    // eye
    rotate([0,90,0])
    { 
        difference()
        {
        cylinder(r=0.2*radius, h=length, center=true);
        translate([0,0,0.0875*radius]){ color([0.1,0.1,0.9,0.4]){ cylinder(r=0.175*radius, h=0.0625*radius, center=true); } }
        }
    }
}

module eye_placeholder(radius, length){ rotate([0,90,0]){ cylinder(r=radius, h=length, center=true); } }


rotate([0,45,0])
{
    round_top(h_radius, h_thickness);
    round_bottom(h_radius, h_thickness);
}
translate([0.60*h_radius,0,0.1*h_radius]){ round_eye(h_radius, 0.2*h_radius); }
translate([0.60*h_radius,0,-0.35*h_radius]){ round_eye(h_radius, 0.2*h_radius); }

difference()
{
//round_top(h_radius, h_thickness);
//translate([0.80*h_radius,0,0]){ eye_placeholder(0.2*h_radius, 0.2*h_radius); }
//translate([0.80*h_radius,0,0]){ round_eye(h_radius, 0.2*h_radius); }
}
//difference()
{
//round_bottom(h_radius, h_thickness);
//translate([0.80*h_radius,0,0]){ eye_placeholder(0.2*h_radius, 0.2*h_radius); }
//translate([0.80*h_radius,0,0]){ round_eye(h_radius, 0.2*h_radius); }
}
//translate([0.80*h_radius,0,0]){ round_eye(h_radius); }

/*

// IMPORTED HC-SR04 US MODEL
translate([0, 0, 0])
{
rotate([0,90,0])
{
    import("/home/erwan/Documents/RobotMaker/cad-library/HC-SR04_-_Ultrasonic_sensor_fingerprint_Empreinte_Ultrason/files/us.stl");
}
}*/
