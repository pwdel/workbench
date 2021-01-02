/* dimensions in mm
*/
inch = 25.4;
lumberinch = inch*0.75;
lumbertwoinch = inch*1.5;
lumberfourinch = inch*3.5;
lumbersixinch = inch*5.5;
feet = inch*12;

module onebysix(); {
    color("Peru")
    cube([lumberfourinch,feet*6,lumberfourinch]);
}