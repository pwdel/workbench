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

// depth of table down onto legs
topsupportdepth = 2*inch;
// lip of table hanging over sides
tablelip = 1*inch;

tablelength = 5*feet;
tablewidth = 3*feet;
tabledepth = 2*inch;

/* Overall bench dimensions in feet */
// subtract table depth to get table height
benchheight = 2.5*feet - tabledepth; 
benchwidth = tablewidth-tablelip*2;
benchlength = tablelength-lumbersixinch-tablelip;

/* Secondary dimensions */
// height of bottom support post
bottomsupportheight = feet*.75;



/* tabletop */
module tableTop() {
    color("Brown")
    cube([tablewidth,tablelength,tabledepth]);
}

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
// Cut Feet to Specification
fourbyFour_cutdim = 1*feet;
module cut4ft_off_fourbyFour() {
    color("Red")
    translate([-inch,fourbyFour_cutdim,-inch])
    cube([feet,feet*6,feet]);
}
// Cut Support Holes in Feet
module cutfeetsupporthole() {
    color("Red")
    translate([lumberfourinch/4,fourbyFour_cutdim/4,0])
    cube([lumbertwoinch,lumbersixinch,feet]);
}

// Cut Top Notches In Legs
module cutlegtopnotch() {
    color("Red")
    translate([lumbersixinch/2-lumbertwoinch/2,benchheight-lumberfourinch-topsupportdepth,-inch])
    cube([lumbertwoinch,lumberfourinch+extracut+topsupportdepth,feet]);
    }
// Cut Bottom Noches In Legs
module cutlegbottomnotch() {
    color("Red")
    translate([lumbersixinch/2-lumbertwoinch/2,bottomsupportheight,-inch])
    cube([lumbertwoinch,lumberfourinch,feet]);
    }    
    
/* Finished, Cut Parts */
// cut twobySix to length
module twobySix_cut2ft() {
    color("Peru")
    difference() {
        twobySix();
        union() {
            cut3ft_off_twobySix();
        }
    }
}
// cut twobyFour to length
module twobyFour_cut3ft() {
    color("SaddleBrown")
    difference() {
        twobyFour();
        union() {
            cut3ft_off_twobyFour();
        }
    }
}
// cut fourbyFour to length
module fourbyFour_cut4ft() {
    color("Peru")
    difference() {
        fourbyFour();
        union() {
            cut4ft_off_fourbyFour();
        }
    }
}
// Cut support feet with hole in center
// fourbyFour();
//cut4ft_off_fourbyFour();
// cutfeetsupporthole();
module supportfeet() {
    color("SaddleBrown")
    difference() {
        fourbyFour_cut4ft(); {
            union() {
                cutfeetsupporthole();
            }
        }
    }
}

translate([0,0,0])
supportfeet();

module leg() {
    color("Peru")
    difference() {
        twobySix_cut2ft(); {
            union() {
                cutlegbottomnotch();
                cutlegtopnotch();
            }
        }
    }
}


/* Test Area */





// Assemble Parts 
// Center Supports

// Center Post - A
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([tablelip,0,tablelip]){
    leg();
}

// Center Foot - A
translate([lumbertwoinch/2-lumberfourinch/2+tablelip,lumbersixinch/2+tablelip-fourbyFour_cutdim/2,-120]){
    supportfeet();
}

// Side Post Leg - B
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([tablelip,0,benchwidth+inch/2]){
    leg();
}
// Side Foot - B
translate([benchwidth-lumberfourinch/2+lumbertwoinch/2+inch/2,lumbersixinch/2+tablelip-fourbyFour_cutdim/2,0]){
    supportfeet();
}

// Bottom twobyFour - AB_Bottom
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([bottomsupportheight,tablelip,lumbersixinch/2+tablelip-lumbertwoinch/2]){
    twobyFour_cut3ft();
}

// Top twobyFour AB_Top
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([benchheight-lumberfourinch-topsupportdepth,tablelip,lumbersixinch/2+tablelip-lumbertwoinch/2]){
    twobyFour_cut3ft();
}


// Far Side Supports
// Center Post - C
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([benchlength,0,tablelip]){
    leg();
}

// Center Foot - C
translate([tablelip-lumberfourinch/2+lumbertwoinch/2,benchlength-tablelip-lumbersixinch/2,-120]){
    supportfeet();
}

// Side Post - D
rotate(90,[1,0,0])
rotate(90,[0,1,0])
translate([benchlength,0,benchwidth++inch/2]){
    leg();
}
// Side Foot - D
translate([benchwidth-lumberfourinch/2+lumbertwoinch/2+inch/2,benchlength-feet*.5,0]){
    supportfeet();
}

// Bottom twobyFour - CD_Bottom
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([bottomsupportheight,tablelip,lumbersixinch/2-lumbertwoinch/2+benchlength]){
    twobyFour_cut3ft();
}
// Top twobyFour - CD_Top
rotate(-90,[0,0,1])
rotate(-90,[0,1,0])
translate([benchheight-lumberfourinch-topsupportdepth,tablelip,lumbersixinch/2-lumbertwoinch/2+benchlength]){
    twobyFour_cut3ft();
}

// Place tableTop
translate([0,0,benchheight-topsupportdepth]){
    tableTop();
}