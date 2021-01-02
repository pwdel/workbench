/* dimensions in mm */
inch = 25.4;
lumberinch = inch*0.75;
lumbertwoinch = inch*1.5;
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


/* Cuts */

module cut2ft_off_twobySix() {
    color("Red")
    translate([0,feet*4,0])
    cube([lumbersixinch,feet*2,lumbertwoinch]);
}



/* Cut Parts */

module twobySix_cut2ft() {
    color("Peru")
    difference() {
        twobySix()
        union() {
            cut2ft_off_twobySix();
        }
    }
}

twobySix_cut2ft();

// twobySix();