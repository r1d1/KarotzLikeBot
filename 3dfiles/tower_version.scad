//cylinder(r=50, h=20, center=true);

height=400;
length=50;

module robot(l_ear, r_ear)
{
    // invoke each component:

    // body
    // head
    // actuators
    color([0.2, 0.2, 0.2])
    {
        translate([0,0,height/2])
        {
            //cube([length,length/2,height], center=true);
        }
    }
    difference()
    {
        rotate([0,0,22.5])
        {
            cylinder(h=20,r1=30,r2=10,$fn=8, center=true);
        }
        translate([-8-10,0,0]){ rotate([0,-30,0]){ color([1.0, 0.0, 0.0]){ cube([30,60,40], center=true); } } }
        //translate([0,0,0]){ color([0.0, 1.0, 0.0]){ cube([20,20,10], center=true); } }
    }
}

//robot();
//cube([20,20,20], center=true);
points_h = [[30,0],[20,20],[-20,20], [-20,-20], [20,-20]]; //,[0,-10],[-10,-10],[-10,0],[-10,10]];
//linear_extrude(height = 40, center = true, convexity = 10, twist = 0*360, slices = 200, scale = 0.6, $fn = 16)
{
    //translate([40,0,0])
    {
        //circle(r=15, center=true, $fn=64);
        //square(size=[25,25], center=true);
        //polygon(points=points_h);
    }
}

// Head from sphere and cut
module head_test()
{
    translate([0,0,-100])
    {
    difference()
    {
        sphere(r=0.5*height, $fn=200, center=true);
        translate([0,0,-30]){ sphere(r=0.5*height, $fn=200, center=true); }
        translate([0.,0.,-0.15*height]){ cylinder(r=0.6*height, h=0.8*height, center=true); }
    }
    }
    
    // head from rotate extrude:
    points_head = [[30,0],[15,-15],[0,-15], [0,0]]; //,[0,-10],[-10,-10],[-10,0],[-10,10]];
    rotate_extrude(angle = 30, convexity = 10, $fn=200) 
    {
        translate([140,0,0]){ polygon(points=points_head); }
    }
};

// round head
module round_hat()
{
    difference()
    {
        head_test();
        translate([0,0,-10])
        {
            rotate_extrude(angle=30, $fn=200)
            {
            translate([168,0,0]){ square([20,20]); }
            }
        }
    }
}

module round_eye()
{
    // eye
    translate([0.35*height, 0, 0])
    {
        rotate([0,90,0])
        { 
            difference()
            {
            cylinder(r=30, h=60, center=true);
            translate([0,0,35]){ cylinder(r=25, h=25, center=true); }
            }
        }
    }
}

round_hat();
round_eye();
