difference(){
    sphere(r=10, $fn=60, center=true);
    sphere(r=9, $fn=60, center=true);
    translate([0,0,-5]){ cube([20,20,10], center=true); }
}