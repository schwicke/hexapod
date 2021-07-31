raster=2.54;
dist = 4.5*raster;

module screwhole_mX(d, height, fact){
   headlength = 0.6*d/2+0.1;
   translate([0,2,0]){
     rotate([90, 0, 0]){
       translate([0, 0, headlength/2]){
         translate([0, 0, height/2])
         cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
         cylinder(h=10*fact*headlength, r=d+0.1, center=true, $fn=50);
       }
     }
   }
}

module nuthole_mX(d){
   s = (d==2) ? 4: (d==2.5)? 5: (d==3) ? 5.5: 0.0;
   if (s==0){
     echo ("Nut size not supported");
   }
   echo(s);
   e = s/sin(60.0);
   height = 40;
   headlength = 0.6*d/2+0.1;
   translate([0, 0, -5*headlength]){
     translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
     cylinder(h=10*headlength, d=e+0.1, center=true, $fn=6);
   }
}

module baseelement(){
     difference(){
       union(){
         difference(){
         translate([0, 0, -4])cube([38, 25, 9], center=true);
         cube([32+0.2, 50, 9], center=true);
         };
       }
       translate([-19, -8, -2])rotate([0,0,90])screwhole_mX(2, 10, 1.0);
       translate([-19,  8, -2])rotate([0,0,90])screwhole_mX(2, 10, 1.0);
       translate([19, -8, -2])rotate([0,0,-90])screwhole_mX(2, 10, 1.0);
       translate([19,  8, -2])rotate([0,0,-90])screwhole_mX(2, 10, 1.0);
  }
}
z=50;
rad=6;
fn=150;
module leg(){
     cylinder(h=z, r=rad, center=false, $fn=fn);
     sphere(r=rad, $fn=fn);
}

//translate([0,0,-z])leg();
//cylinder(h=4, r=rad+1, center=true, $fn=fn);
//sphere(r=rad-2, $fn=fn);
thickness=3;


module tiltedthing(){
     union(){
          translate([0,-5,10])rotate([30,0,0])baseelement();
          translate([0,-0.9,-3])cube([38,22,3], center=true);
          translate([0,8.55,3])cube([38,3,12], center=true);
     }
}

difference(){
     tiltedthing();
     translate([-rad-5,0,2.5])rotate([90,0,0])screwhole_mX(2, 20, 2.0);
     translate([+rad+5,0,2.5])rotate([90,0,0])screwhole_mX(2, 20, 2.0);
     rotate([0,0,180])translate([0,0,-4.6])cylinder(r=rad+1.0,h=1.5,center=true,$fn=fn);
     rotate([0,0,180])translate([0,0,-3.8])cylinder(r=5.1,h=1.1, center=true, $fn=fn);
     rotate([0,0,180])translate([0,-rad,-4.1])cube([7,12,1.1], center=true);
     translate([-dist,8.5,2])rotate([-90,0,0])nuthole_mX(2);
     translate([+dist,8.5,2])rotate([-90,0,0])nuthole_mX(2);
     
}
