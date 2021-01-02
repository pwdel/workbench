/* dimensions in mm */
inch = 25.4;
lumberinch = inch*0.75;
lumbertwoinch = inch*1.5;
lumberfourinch = inch*3.5;
lumbersixinch = inch*5.5;

/* Extra cut dimension */
extracut = inch;

feet = inch*12;

/* Overall Tabletop dimensions */
tablelength = 4.67*feet;
tablewidth = 2*feet;
tabledepth = 2*inch;

/* Overall bench dimensions in feet */
benchheight = 2.75*feet;
benchwidth = 2*feet;
benchlength = 4.67*feet;

/* Top Support Depth Cut */
topsupportdepth = 2*inch;


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
/* Cut Calculations */
// Bench Posts
// Creat Cut Dimension for Posts
twobySix_cutdim = 6*feet - (6*feet-benchheight);
module cut3ft_off_twobySix() {
    color("Red")
    translate([-inch,twobySix_cutdim,-inch])
    cube([inch*12,twobySix_cutdim+6*feet,inch*12]);
}
// Bench Width Supports
// Create Cut Dimension for Side Supports
twobyFour_cutdim = 6*feet-(6*feet-benchwidth);
// Create New Side Support Part
module cut3ft_off_twobyFour() {
    color("Red")
    translate([-inch,twobyFour_cutdim,-inch])
    cube([inch*12,twobyFour_cutdim+6*feet,inch*12]);
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

// Center Supports
// Center Post
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([0,0,0]){
    twobySix_cut2ft();
}

// Center Foot
translate([-lumberfourinch/2+lumbertwoinch/2,-feet*.5,0]){
    fourbyFour_cut4ft();
}

// Side Post
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([0,0,benchwidth-lumbertwoinch/2]){
    twobySix_cut2ft();
}
// Side Foot
translate([benchwidth-lumberfourinch/2,-feet*.5,0]){
    fourbyFour_cut4ft();
}

// Bottom twobyFour
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([feet*0.75,0,lumbersixinch/2-lumbertwoinch/2]){
    twobyFour_cut3ft();
}

// Top twobyFour
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([benchheight-lumberfourinch-topsupportdepth,0,lumbersixinch/2-lumbertwoinch/2]){
    twobyFour_cut3ft();
}


// Side Supports
// Center Post
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([benchlength,0,0]){
    twobySix_cut2ft();
}

// Center Foot
translate([-lumberfourinch/2+lumbertwoinch/2,benchlength-feet*.5,0]){
    fourbyFour_cut4ft();
}

// Side Post
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([benchlength,0,benchwidth-lumbertwoinch/2]){
    twobySix_cut2ft();
}
// Side Foot
translate([benchwidth-lumberfourinch/2,benchlength-feet*.5,0]){
    fourbyFour_cut4ft();
}

// Bottom twobyFour
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([feet*0.75,0,lumbersixinch/2-lumbertwoinch/2+benchlength]){
    twobyFour_cut3ft();
}

// Top twobyFour
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([benchheight-lumberfourinch-topsupportdepth,0,lumbersixinch/2-lumbertwoinch/2+benchlength]){
    twobyFour_cut3ft();
}