/* dimensions in mm */
inch = 25.4;
lumberinch = inch*0.75;
lumbertwoinch = inch*1.5;
lumberfourinch = inch*3.5;
lumbersixinch = inch*5.5;

feet = inch*12;

/* import parts */

module onebySix() { 
    color("Peru")
    import("part_files_stl/1x6.stl");
}
module twobySix() { 
    color("Peru")
    import("part_files_stl/2x6.stl");
}
module twobyFour() { 
    color("Peru")
    import("part_files_stl/2x4.stl");
}
module fourbyFour() { 
    color("Peru")
    import("part_files_stl/4x4.stl");
}
/* Cuts */
module cut3ft_off_twobySix() {
    color("Red")
    translate([-inch,feet*3,-inch])
    cube([6*inch*2,feet*2*2,inch*2*2]);
}

module cut3ft_off_twobyFour() {
    color("Red")
    translate([-inch,feet*3,-inch])
    cube([6*inch*2,feet*2*3,inch*2*4]);
}

module cut4ft_off_fourbyFour() {
    color("Red")
    translate([-inch,feet*1.5,-inch])
    cube([6*inch*2,feet*2*3,inch*2*5]);
}


/* Cut Parts */

module twobySix_cut2ft() {
    color("Peru")
    difference() {
        twobySix();
        union() {
            cut3ft_off_twobySix();
        }
    }
}

module twobyFour_cut3ft() {
    color("Peru")
    difference() {
        twobyFour();
        union() {
            cut3ft_off_twobyFour();
        }
    }
}

module fourbyFour_cut4ft() {
    color("Peru")
    difference() {
        fourbyFour();
        union() {
            cut4ft_off_fourbyFour();
        }
    }
}

/* Assemble Parts */

rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([0,0,0]){
    twobySix_cut2ft();
}

rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([feet*0.75,0,lumbersixinch/2-lumbertwoinch/2]){
    twobyFour_cut3ft();
}


rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([feet*3-lumberfourinch,0,lumbersixinch/2-lumbertwoinch/2]){
    twobyFour_cut3ft();
}


rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([0,0,feet*3-lumbertwoinch/2]){
    twobySix_cut2ft();
}

translate([-lumberfourinch/2+lumbertwoinch/2,-feet*.5,0]){
    fourbyFour_cut4ft();
}

translate([feet*3-lumberfourinch/2,-feet*.5,0]){
    fourbyFour_cut4ft();
}