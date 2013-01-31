// wardrobe.scad
// 
// created on 2013/01/07
// by charlyoleg
// with the help of open source tools and inspirations of cool people
// license: CC BY-SA
//

// this is a modular wardrobe
// The modules have the same width and height. The length is a multiple of the width
// The modules are designed in oder to be put one over the other to create a wardrobe.
// This let you rearrange your wardrobe, create seats, tables or walls of cases.
// A module can be also use as a crate for moving.

// to do
// - solve the issue of reamer_diameter in corners
// -- plank_yx_middle_bottom / plank_zy_middle
// -- plank_xy / plank_zx
// -- plank_yx_side / plank_zy_side



// ###################### //
// parameters
// ###################### //

// module parameters
module_width = 400;
//module_length = 3*module_width
//m1_length = 1*module_width;
//m2_length = 2*module_width;
//m3_length = 3*module_width;
//m4_length = 4*module_width;
//m5_length = 5*module_width;
module_height = 430; // To get a discretisation vertically by 100 mm, respect the rule i*100+vertical_fitting_depth

// supplier parameters
// plank1 28x100x2200
// leroymerlin 28x100x2200 planche en chêne raboté : 20.50 euros
// leroymerlin 28x100x2500 planche en douglas raboté : 10.50 euros
// leroymerlin 25x100x2400 planche en sapin brut : 5.90 euros
// leroymerlin 22x100x1800 planche en sapin raboté : (lot de 3) 11.50 euros
// leroymerlin 14x105x2000 volige en sapin, classe 2 : 2.06 euros
// leroymerlin 38x60x2500 lambourde en sapin, classe 2 : 3.05 euros
// leroymerlin 50x50x2500 chevron en sapin, classe 2 : 3.90 euros
// leroymerlin 27x200x2000 planche en sapin, classe 2 : 3.90 euros
// leroymerlin 36x97x3000 chevron en sapin, classe 2 : 4.75 euros
// leroymerlin 27x150x2500 planche en sapin, classe 2 : 5.40 euros
// leroymerlin 27x200x2500 planche de coffrage en sapin : 5.50 euros
// leroymerlin 25x100x2500 planche en sapin brut : 5.90 euros
// leroymerlin 40x75x3000 lambourde en pin, classe 4 : 5.95 euros
// leroymerlin 25x150x2400 planche en sapin brute : 6.90 euros
// leroymerlin 30x62x2500 tasseau concept bois brut en sapin brut : 6.90 euros
// leroymerlin 21x70x2400 tasseau en sapin raboté : 7.10 euros
// leroymerlin 27x70x2400 tasseau en sapin raboté : 8.50 euros
// leroymerlin 38x150x3000 1/2 bastaing en sapin, classe 2 : 8.90 euros
// leroymerlin 32x150x3000 1/2 bastaing en sapin, classe 2 : 8.90 euros
// leroymerlin 27x96x2500 lame à volet en douglas raboté : 8.95 euros
// leroymerlin 28x50x2500 battement de volet en douglas raboté : 8.95 euros
// leroymerlin 25x200x2400 planche en sapin brut : 8.95 euros
// leroymerlin 45x120x3000 bois d'ossature en sapin : 9.30 euros
// leroymerlin 27x145x2400 planche de terrasse Kuhmo en pin : 9.36 euros
// leroymerlin 19x90x2100 planche de terrasse Lofti en bankirai : 9.43 euros
// leroymerlin 28x120x3000 planche en pin, classe 4 : 9.45 euros
// leroymerlin 27x200x4000 planche en sapin, classe 2 : 9.75 euros
// leroymerlin 45x120x3000 lisse basse en sapin, classe 3 : 9.90 euros
// leroymerlin 28x100x2480 lame pour barrière en douglas raboté : 9.95 euros
// leroymerlin 27x140x2500 planche de terrasse en douglas, Naterial : 9.97 euros
// leroymerlin 27x95x2400 tasseau brut en sapin : 10.90 euros
// leroymerlin 28x96x2400 planche en sapin raboté : 10.95 euros
// leroymerlin 45x145x3000 lisse basse en sapin, classe 3 : 10.95 euros
// leroymerlin 27x146x4000 planche de terrasse Kiréo en pin : 11.32 euros
plank_thickness = 28;
plank1_width = 100;
//plank_length = 2200;
// plank2 28x49x2200 (can be made by cutting plank1)
plank2_width = 49;
slab_thickness = 5;
//slab_width1 = 400;
//slab_width2 = 400;
//dowel_diameter = 10;
//dowel_length = 40;

// cnc parameters
reamer_diameter = 10;
reamer_diameter_constraint = 1; // '0' for raw desing. '1' for bevel. '2' for round

// fitting parameters
// slab assembly
//slab_recess_depth = 10; // this is when the slab is fix in a groove
//slab_groove_depth = 5;
//slab_groove_depth_small = 5;
//slab_groove_depth_large = 10;
slab_fitting_width = 10;
slab_fitting_width_small = 10; // 5 if plank_yx_width=plank2_width
slab_fitting_depth_horizontal = slab_thickness; // 5
slab_fitting_depth_vertical = slab_thickness+2; // 7
// vertical fitting
vertical_fitting_depth = 30;
vertical_fitting_angle = 60;
vertical_fitting_leg_width = 100;
vertical_fitting_arc_radius = 10;
// frame fitting general
//horizontal_fitting_angle = 80; // don't use trapeze for fitting because it causes disassembling
remaining_plank_thickness = 10;
// plank_x_fitting
corner_x_fitting_depth = 5;
//corner_x_fitting_position = vertical_fitting_depth + remaining_plank_thickness; // 40
corner_x_fitting_position = plank2_width-corner_x_fitting_depth; // 45
// plan_fitting
plan_fitting_depth = plank_thickness/2;
plan_fitting_length = 40;
plan2_fitting_length = 20;
// stud
//stud1_width = 40;
// slab

// choose plank width
plank_xy_width = plank2_width;
plank_yx_width = plank1_width;

// opening
opening_fastening_width1 = 20;
opening_fastening_width2 = 20;
opening_fastening_thickness = 5;
opening_fastening_space = 10;
opening_fastening_diameter = 15;
opening_fastening_height = 10;

// cad parameters
remove_skin = 1;                  // This is used for boolean volume operation
break_view_length = 0; //200;     // Set it to 200 to get a break up view of the wardrobe module
cutting_edge = 2;                 // Set it to 0 to get the normal defintion of the plank. Set it to 2 to make visible the plank limits.
vertical_fitting_cutting_edge = 0;

// ###################### //
// calculation
// ###################### //

vertical_fitting_slope_width = vertical_fitting_depth/tan(vertical_fitting_angle);
vertical_fitting_reamer_corner_position_x = vertical_fitting_arc_radius * (1/sin(vertical_fitting_angle)-1/tan(vertical_fitting_angle));
vertical_fitting_reamer_corner_position_z = vertical_fitting_arc_radius;
vertical_fitting_reamer_corner_position_z2 = vertical_fitting_arc_radius * (1-cos(vertical_fitting_angle));
vertical_fitting_reamer_corner_position_x2 = vertical_fitting_reamer_corner_position_z2 / tan(vertical_fitting_angle);
//echo("vertical_fitting_reamer_corner_position_x, vertical_fitting_reamer_corner_position_z:");
//echo(vertical_fitting_reamer_corner_position_x);
//echo(vertical_fitting_reamer_corner_position_z);

//stud2_with = (plank1_width-stud1_width)/2;
//stud_depth = plank_thickness-remaining_plank_thickness;

// plank_length
//pxz_length = n*module_width
pxz_sub_length = 0;
pzx_length = module_height-2*plank1_width+2*plan_fitting_length;
pyz_side_length = module_width-2*remaining_plank_thickness;
pzy_side_length = module_height-2*plank1_width+2*plan_fitting_length;
pyz_middle_length = module_width-2*plank_thickness+2*corner_x_fitting_depth;
pzy_middle_length = module_height-2*plank2_width-2*plank_thickness+4*corner_x_fitting_depth;
//pxy_length = n*module_width-2*plank_thickness+2*corner_x_fitting_depth;
pxy_sub_half_length = plank_thickness-corner_x_fitting_depth;
pyx_length = module_width-2*plank_thickness-2*plank_xy_width+2*corner_x_fitting_depth+2*plan2_fitting_length;

// slab size
slab_horizontal_sub_width1_side = plank_thickness-corner_x_fitting_depth+plank_yx_width-slab_fitting_width;
slab_horizontal_sub_width1_middle =  plank_yx_width/2-slab_fitting_width;
slab_horizontal_sub_width2 = plank_thickness-corner_x_fitting_depth+plank_xy_width-slab_fitting_width;
slab_horizontal_width2 = module_width-2*slab_horizontal_sub_width2;
echo("slab_horizontal_width2",slab_horizontal_width2);
slab_vertical_sub_width2 = plank1_width-slab_fitting_width;
slab_vertical_width2 = module_height-2*slab_vertical_sub_width2;
echo("slab_vertical_width2",slab_vertical_width2);
slab_vertical_side_sub_width1 = remaining_plank_thickness+plank1_width-slab_fitting_width;
slab_vertical_side_width1 = module_width-2*slab_vertical_side_sub_width1;
slab_vertical_rear_side_sub_width1 = plank1_width-slab_fitting_width;
slab_vertical_rear_middle_sub_width1 = plank1_width/2-slab_fitting_width;

// height
module_height_effective = module_height - vertical_fitting_depth;
echo("module_height_effective:", module_height_effective);

// ###################### //
// volume descriptions
// ###################### //

// trapeze definition

module sub_vertical_trapeze(bottom_a, bottom_b, bottom_c, bottom_d, top_a, top_b, top_c, top_d){
  polyhedron(
    points = [
      bottom_a,
      bottom_b,
      bottom_c,
      bottom_d,
      top_a,
      top_b,
      top_c,
      top_d],
    triangles=[
      [1,0,2], [3,2,0],
      [0,1,4], [5,4,1],
      [1,2,5], [6,5,2],
      [2,3,6], [7,6,3],
      [3,0,7], [4,7,0],
      [7,4,6], [6,4,5]],
    convexity=30);
}

module check_sub_vertical_trapeze(){
  ba = [2,2,1];
  bb = [2,-1,1];
  bc = [-3,-5,1];
  bd = [-1,3,1];
  ta = [3,4,3];
  tb = [3,-2,3];
  tc = [-4,-4,3];
  td = [-3,2,3];
  sub_vertical_trapeze(ba, bb, bc, bd, ta, tb, tc, td);
}
//check_sub_vertical_trapeze();

module vertical_trapeze_square(bottom, top){
  bx = abs(bottom[0]);
  by = abs(bottom[1]);
  bz = bottom[2];
  tx = abs(top[0]);
  ty = abs(top[1]);
  tz = top[2];
  ba = [  bx,  by, bz];
  bb = [  bx, -by, bz];
  bc = [ -bx, -by, bz];
  bd = [ -bx,  by, bz];
  ta = [  tx,  ty, tz];
  tb = [  tx, -ty, tz];
  tc = [ -tx, -ty, tz];
  td = [ -tx,  ty, tz];
  sub_vertical_trapeze(ba, bb, bc, bd, ta, tb, tc, td);
}

module vertical_trapeze_square_half(bottom, top){
  bx = abs(bottom[0]);
  by = abs(bottom[1]);
  bz = bottom[2];
  tx = abs(top[0]);
  ty = abs(top[1]);
  tz = top[2];
  ba = [  bx,  by, bz];
  bb = [  bx, -by, bz];
  bc = [   0, -by, bz];
  bd = [   0,  by, bz];
  ta = [  tx,  ty, tz];
  tb = [  tx, -ty, tz];
  tc = [   0, -ty, tz];
  td = [   0,  ty, tz];
  sub_vertical_trapeze(ba, bb, bc, bd, ta, tb, tc, td);
}

module vertical_trapeze_square_quater(bottom, top){
  bx = abs(bottom[0]);
  by = abs(bottom[1]);
  bz = bottom[2];
  tx = abs(top[0]);
  ty = abs(top[1]);
  tz = top[2];
  ba = [  bx,  by, bz];
  bb = [  bx,   0, bz];
  bc = [   0,   0, bz];
  bd = [   0,  by, bz];
  ta = [  tx,  ty, tz];
  tb = [  tx,   0, tz];
  tc = [   0,   0, tz];
  td = [   0,  ty, tz];
  sub_vertical_trapeze(ba, bb, bc, bd, ta, tb, tc, td);
}

module check_vertical_trapeze_square(){
  vertical_trapeze_square([3,2,1], [2,3,3]);
  vertical_trapeze_square_half([3,2,6], [2,3,8]);
  vertical_trapeze_square_quater([3,2,11], [2,3,12]);
  vertical_trapeze_square([3,2,16], [2,3,15]);  // Yahoo! The top face can be bellow the bottom face!
}
//check_vertical_trapeze_square();

// positionning

module plank_test(){
  difference(){
    cube([8,5,2]);
    union(){
      translate([-1,-1,1])
      cube([3,7,2]);
      translate([7,1,-1])
      cylinder(r=0.5,h=4);
      translate([6,1,-1])
      cylinder(r=0.5,h=4);
    }
  }
}

module plank_flip_according(a_direction, a_x, a_y, a_z){
  if(a_direction=="i"){
    //translate([0,0,0])
    //rotate([0,0,0])
    child(0);
  } else if(a_direction=="x"){
    translate([0,a_y,a_z])
    rotate([180,0,0])
    child(0);
  } else if(a_direction=="y"){
    translate([a_x,0,a_z])
    rotate([0,180,0])
    child(0);
  } else if(a_direction=="z"){
    translate([a_x,a_y,0])
    rotate([0,0,180])
    child(0);
  } else {
    echo("ERR450: Error, this plank_flip_direction doesn't exist!");
  }
}

module check_plank_flip_according(){
  union(){
    translate([0,0,0])
    plank_flip_according("i",8,5,2)
    plank_test();
    translate([0,0,10])
    plank_flip_according("x",8,5,2)
    plank_test();
    translate([0,0,20])
    plank_flip_according("y",8,5,2)
    plank_test();
    translate([0,0,30])
    plank_flip_according("z",8,5,2)
    plank_test();
    //translate([0,0,40])
    //plank_flip_according("x",8,5,2)
    //  union(){
    //    //plank_flip_according("y",8,5,2)
    //    plank_test();
    //  }
    //translate([0,0,50])
    //plank_flip_according("y",8,5,2)
    //plank_flip_according("x",8,5,2)
    //plank_test();
  }
}
//check_plank_flip_according();

module plank_rotate_from_xy_to(a_new_direction, a_length_x, a_width_y, a_thickness_z){
  if (a_new_direction=="xy"){
    translate([0,0,0])
    rotate([0,0,0])
    child(0);
  } else if (a_new_direction=="xz"){
    translate([0,a_thickness_z,0])
    rotate([90,0,0])
    child(0);
  } else if (a_new_direction=="yx"){
    translate([0,0,a_thickness_z])
    rotate([180,0,90])
    child(0);
  } else if (a_new_direction=="yz"){
    translate([0,0,0])
    rotate([90,0,90])
    child(0);
  } else if (a_new_direction=="zx"){
    translate([0,0,0])
    rotate([0,-90,-90])
    child(0);
  } else if (a_new_direction=="zy"){
    translate([a_thickness_z,0,0])
    rotate([0,-90,0])
    child(0);
  } else {
    echo("ERR451: Error, this plank_rotate_direction doesn't exist!");
  }
}

module check_plank_rotate_from_xy_to(){
  translate([0,0,0])
  plank_rotate_from_xy_to("xy",8,5,2)
  plank_test();
  translate([0,0,10])
  plank_rotate_from_xy_to("xz",8,5,2)
  plank_test();
  translate([0,0,20])
  plank_rotate_from_xy_to("yx",8,5,2)
  plank_test();
  translate([0,0,30])
  plank_rotate_from_xy_to("yz",8,5,2)
  plank_test();
  translate([0,0,40])
  plank_rotate_from_xy_to("zx",8,5,2)
  plank_test();
  translate([0,0,50])
  plank_rotate_from_xy_to("zy",8,5,2)
  plank_test();
  translate([0,0,60])
  plank_rotate_from_xy_to("zy",8,5,2)
  plank_flip_according("x",8,5,2)
  plank_test();
}
//check_plank_rotate_from_xy_to();

//module test_openscad_limitation(){
//  translate([10,0,5])
//  plank_flip_according("x",8,5,2)
//  child(0);
//}
//test_openscad_limitation() plank_test();

//module plank_xy_place_into_module(a_flip, a_direction, a_part_x_max, a_part_x, a_part_y, a_part_z, a_local_x, a_local_y, a_local_z, a_length_x, a_width_y, a_thickness_z){
module plank_xy_place_into_module(a_direction, a_part_x_max, a_part_x, a_part_y, a_part_z, a_local_x, a_local_y, a_local_z, a_length_x, a_width_y, a_thickness_z){
  translate([
    a_part_x*module_width+(a_part_x==a_part_x_max?1:0)*break_view_length+(a_part_x==a_part_x_max?-1:1)*a_local_x
      +(a_part_x==0?0:(a_part_x==a_part_x_max?-1:-1/2))*(((a_direction=="yx")||(a_direction=="zx")?a_width_y:0)+((a_direction=="yz")||(a_direction=="zy")?a_thickness_z:0)),
    a_part_y*(module_width+break_view_length)+(a_part_y==1?-1:1)*a_local_y
      +(a_part_y==1?-1:0)*(((a_direction=="xy")||(a_direction=="zy")?a_width_y:0)+((a_direction=="xz")||(a_direction=="zx")?a_thickness_z:0)),
    a_part_z*(module_height+break_view_length)+(a_part_z==1?-1:1)*a_local_z
      +(a_part_z==1?-1:0)*(((a_direction=="xz")||(a_direction=="yz")?a_width_y:0)+((a_direction=="xy")||(a_direction=="yx")?a_thickness_z:0))])
  //plank_rotate_from_xy_to(a_direction, a_length_x, a_width_y, a_thickness_z)
  //plank_flip_according(a_flip, a_length_x, a_width_y, a_thickness_z)
  child(0);
}

module check_plank_xy_place_into_module(){
  union(){
    translate([0,0,0])
    plank_xy_place_into_module("xy", 3, 0, 0, 0, 0, 0, 0, 8,5,2)
    plank_rotate_from_xy_to("xy", 8,5,2)
    plank_flip_according("i", 8,5,2)
    plank_test();
    translate([0,0,0])
    plank_xy_place_into_module("xy", 3, 0, 1, 1, 0, 0, 0, 8,5,2)
    plank_rotate_from_xy_to("xy", 8,5,2)
    plank_flip_according("i", 8,5,2)
    plank_test();
    translate([0,0,0])
    plank_xy_place_into_module("yx", 3, 0, 0, 0, 0, 0, 0, 8,5,2)
    plank_rotate_from_xy_to("yx", 8,5,2)
    plank_flip_according("i", 8,5,2)
    plank_test();
    translate([0,0,0])
    plank_xy_place_into_module("yx", 3, 0, 0, 1, 0, 0, 0, 8,5,2)
    plank_rotate_from_xy_to("yx", 8,5,2)
    plank_flip_according("i", 8,5,2)
    plank_test();
    translate([0,0,0])
    plank_xy_place_into_module("zx", 3, 0, 0, 0, 0, 0, 0, 8,5,2)
    plank_rotate_from_xy_to("zx", 8,5,2)
    plank_flip_according("i", 8,5,2)
    plank_test();
    translate([0,0,0])
    plank_xy_place_into_module("zx", 3, 0, 1, 0, 0, 0, 0, 8,5,2)
    plank_rotate_from_xy_to("zx", 8,5,2)
    plank_flip_according("i", 8,5,2)
    plank_test();
  }
}
//check_plank_xy_place_into_module();

// vertical_fitting

module cut_vertical_fitting_bottom(){
  l_half_trapeze_width = module_width/2-vertical_fitting_leg_width;
  l_remove_skin = 3*remove_skin;
  union(){
    translate([-l_remove_skin, plank1_width, -l_remove_skin])
    cube([module_width+2*l_remove_skin, cutting_edge+l_remove_skin, plank_thickness+2*l_remove_skin]);
    translate([module_width/2, plank1_width, plank_thickness+l_remove_skin])
    rotate([0,90,-90])
    vertical_trapeze_square_half(
      [plank_thickness+2*l_remove_skin, l_half_trapeze_width, 0],
      [plank_thickness+2*l_remove_skin, l_half_trapeze_width-vertical_fitting_slope_width+vertical_fitting_reamer_corner_position_x2, vertical_fitting_depth-vertical_fitting_reamer_corner_position_z2]);
    difference(){
      union(){
        translate([vertical_fitting_leg_width-vertical_fitting_reamer_corner_position_x, plank1_width-vertical_fitting_reamer_corner_position_z2, -l_remove_skin])
        cube([2*l_half_trapeze_width+2*vertical_fitting_reamer_corner_position_x, vertical_fitting_reamer_corner_position_z2+l_remove_skin, plank_thickness+2*l_remove_skin]);
      }
      union(){
        translate([vertical_fitting_leg_width-vertical_fitting_reamer_corner_position_x, plank1_width-vertical_fitting_reamer_corner_position_z, -2*l_remove_skin])
        //rotate([0,0,0])
        cylinder(r=vertical_fitting_arc_radius, h=plank_thickness+4*l_remove_skin, center=false);
        translate([module_width-(vertical_fitting_leg_width-vertical_fitting_reamer_corner_position_x),plank1_width-vertical_fitting_reamer_corner_position_z,-2*l_remove_skin])
        //rotate([0,0,0])
        cylinder(r=vertical_fitting_arc_radius, h=plank_thickness+4*l_remove_skin, center=false);
      }
    }
    translate([vertical_fitting_leg_width+vertical_fitting_slope_width+vertical_fitting_reamer_corner_position_x,plank1_width-vertical_fitting_depth, -l_remove_skin])
    cube([2*l_half_trapeze_width-2*vertical_fitting_slope_width-2*vertical_fitting_reamer_corner_position_x,vertical_fitting_arc_radius, plank_thickness+2*l_remove_skin]);
    //color([0.9,0.1,0.1])
    translate([vertical_fitting_leg_width+vertical_fitting_slope_width+vertical_fitting_reamer_corner_position_x,plank1_width-vertical_fitting_depth+vertical_fitting_reamer_corner_position_z,-l_remove_skin])
    //rotate([0,0,0])
    cylinder(r=vertical_fitting_arc_radius, h=plank_thickness+2*l_remove_skin, center=false);
    //color([0.9,0.1,0.1])
    translate([module_width-(vertical_fitting_leg_width+vertical_fitting_slope_width+vertical_fitting_reamer_corner_position_x),plank1_width-vertical_fitting_depth+vertical_fitting_reamer_corner_position_z,-l_remove_skin])
    //rotate([0,0,0])
    cylinder(r=vertical_fitting_arc_radius, h=plank_thickness+2*l_remove_skin, center=false);
  }
}
//cut_vertical_fitting_bottom();
//vertical_fitting_arc_radius = 20;

module cut_vertical_fitting_top(){
  l_remove_skin = 2*remove_skin;
  difference(){
    union(){
      translate([-l_remove_skin, plank1_width-vertical_fitting_depth, -l_remove_skin])
      cube([module_width+2*l_remove_skin, vertical_fitting_depth+l_remove_skin+cutting_edge, plank_thickness+2*l_remove_skin]);
    }
    union(){
      translate([0, 2*plank1_width-1*vertical_fitting_depth, plank_thickness])
      rotate([180,0,0])
      cut_vertical_fitting_bottom();
    }
  }
}
//cut_vertical_fitting_top();

// this is exactly the same as cut_vertical_fitting_bottom(), but that's way it fix an openscad bug
module cut_vertical_fitting_bottom2(){
  l_remove_skin = 1*remove_skin;
  difference(){
    union(){
      translate([-l_remove_skin, plank1_width-vertical_fitting_depth, -l_remove_skin])
      cube([module_width+2*l_remove_skin, vertical_fitting_depth+l_remove_skin+cutting_edge, plank_thickness+2*l_remove_skin]);
    }
    union(){
      translate([0, 2*plank1_width-1*vertical_fitting_depth, plank_thickness])
      rotate([180,0,0])
      cut_vertical_fitting_top();
    }
  }
}
//cut_vertical_fitting_bottom2();

// cut plank extremity corner to fii the cnc reamer diameter constraint.
module cut_cnc_bevel(a_height){
  if(reamer_diameter_constraint==1){
    rotate([0,0,45])
    translate([-reamer_diameter/2, -reamer_diameter/2, 0])
    cube([reamer_diameter,reamer_diameter, a_height]);
  } else if(reamer_diameter_constraint==2){
    difference(){
      union(){
        translate([-reamer_diameter/2, -reamer_diameter/2, 0])
        cube([reamer_diameter,reamer_diameter, a_height]);
      }
      union(){
        translate([reamer_diameter/2, reamer_diameter/2, -remove_skin])
        cylinder(r=reamer_diameter/2, h=a_height+2*remove_skin);
        //translate([reamer_diameter/2, -reamer_diameter/2, -remove_skin])
        //cylinder(r=reamer_diameter/2, h=a_height+2*remove_skin);
        //translate([-reamer_diameter/2, -reamer_diameter/2, -remove_skin])
        //cylinder(r=reamer_diameter/2, h=a_height+2*remove_skin);
        //translate([-reamer_diameter/2, reamer_diameter/2, -remove_skin])
        //cylinder(r=reamer_diameter/2, h=a_height+2*remove_skin);
      }
    }
  }
}
//cut_cnc_bevel(30);

module cut_plank_corner(a_length_x, a_width_y, a_thickness_z, a_x0y0, a_x0y1, a_x1y1, a_x1y0){
  union(){
    if(a_x0y0==1){
      translate([0,0,-remove_skin])
      rotate([0,0,0])
      cut_cnc_bevel(a_thickness_z+2*remove_skin);
    }
    if(a_x0y1==1){
      translate([0,a_width_y,-remove_skin])
      rotate([0,0,270])
      cut_cnc_bevel(a_thickness_z+2*remove_skin);
    }
    if(a_x1y1==1){
      translate([a_length_x,a_width_y,-remove_skin])
      rotate([0,0,180])
      cut_cnc_bevel(a_thickness_z+2*remove_skin);
    }
    if(a_x1y0==1){
      translate([a_length_x,0,-remove_skin])
      rotate([0,0,90])
      cut_cnc_bevel(a_thickness_z+2*remove_skin);
    }
  }
}

// plank

module cut_plank_xz_a(n){
  l_length = n*module_width;
  l_connection_xy_x = plank_thickness-corner_x_fitting_depth-cutting_edge;
  //echo("dbg325",l_length, l_connection_xy_x, n, module_width);
  union(){
    // connexion to plank_xy
    translate([l_connection_xy_x, plank1_width-corner_x_fitting_position-plank_thickness-cutting_edge, plank_thickness-corner_x_fitting_depth-cutting_edge])
    cube([l_length-2*l_connection_xy_x, plank_thickness+2*cutting_edge, corner_x_fitting_depth+remove_skin+cutting_edge]);
    // connexion to plank_zx
    for(i=[0:n]){
      translate([((i==0)||(i==n)?-2:-1)*plank1_width/2-cutting_edge+i*module_width,-remove_skin, plank_thickness-plan_fitting_depth-cutting_edge])
      cube([((i==0)||(i==n)?2:1)*plank1_width+2*cutting_edge,plan_fitting_length+remove_skin+cutting_edge, plan_fitting_depth+remove_skin+cutting_edge]);
      //cube([plank1_width+(i==0||i==n?1:0)*remove_skin,plan_fitting_length+remove_skin, plan_fitting_depth+remove_skin]);
    }
    // connexion to plank_yz_middle
    if(n>=2){
      for(i=[1:n-1]){
        translate([-plank_thickness/2-cutting_edge+i*module_width,-remove_skin, plank_thickness-corner_x_fitting_depth-cutting_edge])
        cube([plank_thickness+2*cutting_edge,plank1_width+2*remove_skin+2*cutting_edge, corner_x_fitting_depth+remove_skin+cutting_edge]);
      }
    }
  }
}
//cut_plank_xz_a(3);

module cut_plank_xz_b(n){
  l_length = n*module_width;
  union(){
    // connexion to plank_yz
    translate([-remove_skin, -remove_skin, remaining_plank_thickness-cutting_edge])
    cube([remove_skin+remaining_plank_thickness+cutting_edge, plank1_width+2*remove_skin, plank_thickness+cutting_edge+remove_skin]);
    translate([-remove_skin, -remove_skin, plank_thickness-remaining_plank_thickness-cutting_edge])
    cube([remove_skin+plank_thickness+cutting_edge, plank1_width+2*remove_skin, remaining_plank_thickness+cutting_edge+remove_skin]);
    translate([l_length-remaining_plank_thickness-cutting_edge, -remove_skin, remaining_plank_thickness-cutting_edge])
    cube([remove_skin+remaining_plank_thickness+cutting_edge, plank1_width+2*remove_skin, plank_thickness+cutting_edge+remove_skin]);
    translate([l_length-plank_thickness-cutting_edge, -remove_skin, plank_thickness-remaining_plank_thickness-cutting_edge])
    cube([remove_skin+plank_thickness+cutting_edge, plank1_width+2*remove_skin, remaining_plank_thickness+cutting_edge+remove_skin]);
  }
}
//cut_plank_xz_b(3);

module cut_plank_xz_c(n){
  union(){
    // slab
    for(i=[1:n]){
      assign(l_groove_border1=(i==1?slab_vertical_rear_side_sub_width1:slab_vertical_rear_middle_sub_width1),
          l_groove_border2=(i==n?slab_vertical_rear_side_sub_width1:slab_vertical_rear_middle_sub_width1)){
        translate([l_groove_border1+(i-1)*module_width-cutting_edge,-remove_skin,-remove_skin])
        cube([module_width-l_groove_border1-l_groove_border2+2*cutting_edge, slab_fitting_width+cutting_edge+remove_skin, slab_fitting_depth_vertical+cutting_edge+remove_skin]);
      }
    }
  }
}
// cut_plank_xz_c(3);

module cut_plank_xz_d(n){
  union(){
    // opening_fastening
    for(i=[1:n]){
      assign(l_opening_fastening1=(i==1?plank1_width:plank1_width/2)+opening_fastening_space,
          l_opening_fastening2=(i==n?plank1_width:plank1_width/2)+opening_fastening_width1+opening_fastening_space){
        translate([l_opening_fastening1+(i-1)*module_width-cutting_edge,-remove_skin,plank_thickness-opening_fastening_width2-cutting_edge])
        cube([opening_fastening_width1+2*cutting_edge, opening_fastening_thickness+cutting_edge+remove_skin, opening_fastening_width2+cutting_edge+remove_skin]);
        translate([-l_opening_fastening2+i*module_width-cutting_edge,-remove_skin,plank_thickness-opening_fastening_width2-cutting_edge])
        cube([opening_fastening_width1+2*cutting_edge, opening_fastening_thickness+cutting_edge+remove_skin, opening_fastening_width2+cutting_edge+remove_skin]);
      }
    }
  }
}
// cut_plank_xz_d(3);

module cut_plank_yz_a(){
  //l_length = module_width-2*remaining_plank_thickness;
  l_length = pyz_side_length;
  union(){
    // connexion to plank_xy
    translate([-remaining_plank_thickness+plank_thickness-corner_x_fitting_depth-cutting_edge, plank1_width-corner_x_fitting_position-plank_thickness-cutting_edge, plank_thickness-corner_x_fitting_depth-cutting_edge])
    cube([l_length-2*(plank_thickness-remaining_plank_thickness-corner_x_fitting_depth-cutting_edge), plank_thickness+2*cutting_edge, corner_x_fitting_depth+remove_skin+cutting_edge]);
    // connexion to plank_zy
    for(i=[0:1]){
      translate([-plank1_width-cutting_edge+i*l_length,-remove_skin, plank_thickness-plan_fitting_depth-cutting_edge])
      cube([2*plank1_width+2*cutting_edge,plan_fitting_length+remove_skin+cutting_edge, plan_fitting_depth+remove_skin+cutting_edge]);
    }
    translate([plank1_width-slab_fitting_width-cutting_edge, -remove_skin, -remove_skin])
    cube([slab_vertical_side_width1+2*cutting_edge, slab_fitting_width+cutting_edge+remove_skin, slab_fitting_depth_vertical+cutting_edge+remove_skin]);
  }
}
//cut_plank_yz_a;

module cut_plank_yz_b(){
  //l_length = module_width-2*remaining_plank_thickness;
  l_length = pyz_side_length;
  union(){
    // connexion to plank_xz
    translate([-remove_skin, -remove_skin, remaining_plank_thickness-cutting_edge])
    cube([remove_skin+plank_thickness-2*remaining_plank_thickness+cutting_edge, plank1_width+2*remove_skin, plank_thickness+cutting_edge+remove_skin]);
    translate([l_length-plank_thickness+2*remaining_plank_thickness-cutting_edge, -remove_skin, remaining_plank_thickness-cutting_edge])
    cube([remove_skin+plank_thickness-2*remaining_plank_thickness+cutting_edge, plank1_width+2*remove_skin, plank_thickness+cutting_edge+remove_skin]);
  }
}
//cut_plank_yz_b;

module cut_plank_zx_a(){
  //l_length = module_height-2*plank1_width+2*plan_fitting_length;
  l_length = pzx_length;
  union(){
    translate([-remove_skin,-remove_skin,plank_thickness-plan_fitting_depth-cutting_edge])
    cube([plan_fitting_length+remove_skin+cutting_edge, plank1_width+2*remove_skin, plan_fitting_depth+remove_skin+cutting_edge]);
    translate([l_length-plan_fitting_length-cutting_edge, -remove_skin, plank_thickness-plan_fitting_depth-cutting_edge])
    cube([plan_fitting_length+remove_skin+cutting_edge, plank1_width+2*remove_skin, plan_fitting_depth+remove_skin+cutting_edge]);
  }
}
//cut_plank_zx_a();

module cut_plank_zx_b(){
  l_length = pzx_length;
  union(){
    translate([plan_fitting_length-slab_fitting_width-cutting_edge, plank1_width-slab_fitting_width-cutting_edge, plank_thickness-slab_fitting_depth_vertical-cutting_edge])
    cube([slab_vertical_width2+2*cutting_edge, slab_fitting_width+cutting_edge+remove_skin, slab_fitting_depth_vertical+cutting_edge+remove_skin]);
  }
}
//cut_plank_zx_b();

module cut_plank_zx_c(){
  l_length = pzx_length;
  union(){
    translate([plan_fitting_length-slab_fitting_width-cutting_edge, -remove_skin, plank_thickness-slab_fitting_depth_vertical-cutting_edge])
    cube([slab_vertical_width2+2*cutting_edge, slab_fitting_width+cutting_edge+remove_skin, slab_fitting_depth_vertical+cutting_edge+remove_skin]);
  }
}
//cut_plank_zx_c();

module cut_plank_xy_a(n){
  l_length = n*module_width-2*pxy_sub_half_length;
  l_zx_side_visible = plank1_width-plank_thickness+corner_x_fitting_depth;
  l_zx_depth_visible = corner_x_fitting_position+plank_thickness+plan_fitting_length-plank1_width;
  union(){
    if(n>=2){
      for(i=[1:n-1]){
        //connexion to plank_zx_middle
        translate([-plank1_width/2-cutting_edge+i*module_width-pxy_sub_half_length,plank_xy_width-corner_x_fitting_depth-cutting_edge,-remove_skin])
        cube([plank1_width+2*cutting_edge, corner_x_fitting_depth+cutting_edge+remove_skin, l_zx_depth_visible+remove_skin+cutting_edge]);
        //connexion to plank_yz_middle
        translate([-plank_thickness/2-cutting_edge+i*module_width-pxy_sub_half_length,-remove_skin,plank_thickness-corner_x_fitting_depth-cutting_edge])
        cube([plank_thickness+2*cutting_edge,plank_xy_width+2*remove_skin,corner_x_fitting_depth+cutting_edge+remove_skin]);
        //connexion to plank_zy_middle
        translate([-plank_thickness/2-cutting_edge+i*module_width-pxy_sub_half_length,-remove_skin,-remove_skin])
        cube([plank_thickness+2*cutting_edge,plank2_width+cutting_edge+remove_skin,corner_x_fitting_depth+cutting_edge+remove_skin]);
      }
    }
    for(i=[0:1]){
      //connexion to plank_zx_side
      translate([-l_zx_side_visible-cutting_edge+i*l_length,plank_xy_width-corner_x_fitting_depth-cutting_edge, -remove_skin])
      cube([2*l_zx_side_visible+2*cutting_edge,corner_x_fitting_depth+cutting_edge+remove_skin,l_zx_depth_visible+cutting_edge+remove_skin]);
      //connexion to plank_zy_side
      translate([-corner_x_fitting_depth-cutting_edge+i*l_length,-remove_skin, -remove_skin])
      cube([2*corner_x_fitting_depth+2*cutting_edge,plank_xy_width+2*remove_skin,l_zx_depth_visible+cutting_edge+remove_skin]);
    }
  }
}
//cut_plank_xy_a(3);

module cut_plank_xy_b(n){
  l_length = n*module_width-2*pxy_sub_half_length;
  union(){
    if(n>=2){
      for(i=[1:n-1]){
        //connexion to plank_yx_middle
        translate([-plank_yx_width/2-cutting_edge+i*module_width-pxy_sub_half_length,-remove_skin,0])
        cube([plank_yx_width+2*cutting_edge,plan2_fitting_length+cutting_edge+remove_skin,plan_fitting_depth+cutting_edge+remove_skin]);
        //echo("dbg225: check openscad loop behavior");
        //echo(i);
      }
    }
    for(i=[0:1]){
      //connexion to plank_yx_side
      translate([-plank_yx_width-cutting_edge+i*l_length,-remove_skin,0])
      cube([2*plank_yx_width+2*cutting_edge,plan2_fitting_length+cutting_edge+remove_skin,plan_fitting_depth+cutting_edge+remove_skin]);
    }
  }
}
//cut_plank_xy_b(3);

module cut_plank_xy_c(n){
  l_length = n*module_width-2*pxy_sub_half_length;
  l_nocut_side = plank_thickness-corner_x_fitting_depth+plank_yx_width-slab_fitting_width-cutting_edge-pxy_sub_half_length;
  l_nocut_middle = plank_yx_width/2-slab_fitting_width-cutting_edge;
  union(){
    for(i=[1:n]){
      //connexion to slab_horizontal
      translate([(i==1?l_nocut_side:l_nocut_middle)+(i-1)*module_width-pxy_sub_half_length, -remove_skin, 0])
      cube([module_width-(i==1?l_nocut_side:l_nocut_middle)-(i==n?l_nocut_side:l_nocut_middle), slab_fitting_width+cutting_edge+remove_skin, slab_fitting_depth_horizontal+cutting_edge+remove_skin]);
    }
  }
}
//cut_plank_xy_c(3);

module plank_xz_front_top(n){
  l_length = n*module_width;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      for(i=[1:n]){
        translate([(i-1)*module_width,-vertical_fitting_cutting_edge,0])
        cut_vertical_fitting_top();
      }
      cut_plank_xz_a(n);
      cut_plank_xz_b(n);
      //cut_plank_xz_c(n); // uncomment if you want the footprint of the slab, to make a vault for example
      cut_plank_xz_d(n);
    }
  }
}
//plank_xz_front_top(3);

module plank_xz_front_bottom(n){
  l_length = n*module_width;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      for(i=[1:n]){
        translate([(i-1)*module_width,-vertical_fitting_cutting_edge,0])
        //cut_vertical_fitting_bottom();
        cut_vertical_fitting_bottom2();
      }
      cut_plank_xz_a(n);
      cut_plank_xz_b(n);
      //cut_plank_xz_c(n); // uncomment if you want the footprint of the slab
      cut_plank_xz_d(n);
    }
  }
}
//plank_xz_front_bottom(3);

module plank_xz_rear_top(n){
  l_length = n*module_width;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      for(i=[1:n]){
        translate([(i-1)*module_width,-vertical_fitting_cutting_edge,0])
        cut_vertical_fitting_top();
      }
      cut_plank_xz_a(n);
      cut_plank_xz_b(n);
      cut_plank_xz_c(n);
    }
  }
}
//plank_xz_rear_top(3);

module plank_xz_rear_bottom(n){
  l_length = n*module_width;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      for(i=[1:n]){
        translate([(i-1)*module_width,-vertical_fitting_cutting_edge,0])
        //cut_vertical_fitting_bottom();
        cut_vertical_fitting_bottom2();
      }
      cut_plank_xz_a(n);
      cut_plank_xz_b(n);
      cut_plank_xz_c(n);
    }
  }
}
//plank_xz_rear_bottom(3);

//module test_openscad_limitation_2(n,m){
//  l_length = n*40;
//  l_width = m*40;
//  color([0.2,0.2,0.9])
//  difference(){
//    cube([l_length, l_width, 30]);
//    union(){
//      for(i=[1:n]){
//        for(j=[1:m]){
//          translate([-20+i*40,-20+j*40,-1])
//          cylinder(r=15, h=32, $fn=64);
//        }
//      }
//    }
//  }
//}
//test_openscad_limitation_2(19,19);

module plank_zx_front_middle(){
  //l_length = module_height-2*plank1_width+2*plan_fitting_length;
  l_length = pzx_length;
  color([0.2,0.9,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      cut_plank_zx_a();
      //cut_plank_zx_b();   // uncomment if you want plank_zx_front_middle = plank_zx_rear_middle
      //cut_plank_zx_c();   // uncomment if you want plank_zx_front_middle = plank_zx_rear_middle
      // connexion to zy_middle
      translate([-remove_skin, plank1_width/2-plank_thickness/2-cutting_edge, -remove_skin])
      cube([l_length+2*remove_skin, plank_thickness+2*cutting_edge,  corner_x_fitting_depth+cutting_edge+remove_skin]);
      cut_plank_corner(l_length, plank1_width, plank_thickness,1,1,1,1);
    }
  }
}
//plank_zx_front_middle();

module plank_zx_front_side(){
  //l_length = module_height-2*plank1_width+2*plan_fitting_length;
  l_length = pzx_length;
  color([0.2,0.9,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      // connexion to plank_xz
      cut_plank_zx_a();
      //cut_plank_zx_b();   // uncomment if you want plank_zx_front_side = plank_zx_rear_side
      // connexion to plank_zy
      translate([-remove_skin, -remove_skin, -remove_skin])
      cube([l_length+2*remove_skin, remaining_plank_thickness+cutting_edge+remove_skin,  plank_thickness-remaining_plank_thickness+cutting_edge+remove_skin]);
      translate([-remove_skin, -remove_skin, -remove_skin])
      cube([l_length+2*remove_skin, plank_thickness+cutting_edge+remove_skin, remaining_plank_thickness+cutting_edge+remove_skin]);
      cut_plank_corner(l_length, plank1_width, plank_thickness,0,1,1,0);
    }
  }
}
//plank_zx_front_side();

module plank_zx_rear_middle(){
  //l_length = module_height-2*plank1_width+2*plan_fitting_length;
  l_length = pzx_length;
  color([0.2,0.9,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      cut_plank_zx_a();
      cut_plank_zx_b();
      cut_plank_zx_c();
      // connexion to zy_middle
      translate([-remove_skin, plank1_width/2-plank_thickness/2-cutting_edge, -remove_skin])
      cube([l_length+2*remove_skin, plank_thickness+2*cutting_edge,  corner_x_fitting_depth+cutting_edge+remove_skin]);
      cut_plank_corner(l_length, plank1_width, plank_thickness,1,1,1,1);
    }
  }
}
//plank_zx_rear_middle();

module plank_zx_rear_side(){
  //l_length = module_height-2*plank1_width+2*plan_fitting_length;
  l_length = pzx_length;
  color([0.2,0.9,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      // connexion to plank_xz
      cut_plank_zx_a();
      cut_plank_zx_b();
      // connexion to plank_zy
      translate([-remove_skin, -remove_skin, -remove_skin])
      cube([l_length+2*remove_skin, remaining_plank_thickness+cutting_edge+remove_skin,  plank_thickness-remaining_plank_thickness+cutting_edge+remove_skin]);
      translate([-remove_skin, -remove_skin, -remove_skin])
      cube([l_length+2*remove_skin, plank_thickness+cutting_edge+remove_skin, remaining_plank_thickness+cutting_edge+remove_skin]);
      cut_plank_corner(l_length, plank1_width, plank_thickness,0,1,1,0);
    }
  }
}
//plank_zx_rear_side();

module plank_yz_side_top(){
  //l_length = module_width-2*remaining_plank_thickness;
  l_length = pyz_side_length;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      translate([-remaining_plank_thickness,-vertical_fitting_cutting_edge,0])
      cut_vertical_fitting_top();
      cut_plank_yz_a();
      cut_plank_yz_b();
    }
  }
}
//plank_yz_side_top();

module plank_yz_side_bottom(){
  //l_length = module_width-2*remaining_plank_thickness;
  l_length = pyz_side_length;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      translate([-remaining_plank_thickness,-vertical_fitting_cutting_edge,0])
      cut_vertical_fitting_bottom2();
      cut_plank_yz_a();
      cut_plank_yz_b();
    }
  }
}
//plank_yz_side_bottom();

module plank_zy_side(){
  //l_length = module_height-2*plank1_width+2*plan_fitting_length;
  l_length = pzy_side_length;
  color([0.2,0.9,0.9])
  difference(){
    cube([l_length, plank1_width, plank_thickness]);
    union(){
      // connexion to plank_yz
      cut_plank_zx_a();
      cut_plank_zx_b();
      // connexion to plank_zx
      translate([-remove_skin, -remove_skin, -remove_skin])
      cube([l_length+2*remove_skin, plank_thickness-2*remaining_plank_thickness+cutting_edge+remove_skin,  plank_thickness-remaining_plank_thickness+cutting_edge+remove_skin]);
      cut_plank_corner(l_length, plank1_width, plank_thickness,0,1,1,0);
    }
  }
}
//plank_zy_side();

module plank_yz_middle_top(){
  //l_length = module_width-2*plank_thickness+2*corner_x_fitting_depth;
  l_length = pyz_middle_length;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank2_width, plank_thickness]);
    union(){
      translate([-plank_thickness+corner_x_fitting_depth,-plank1_width+plank2_width-vertical_fitting_cutting_edge,0])
      cut_vertical_fitting_top();
    }
  }
}
//plank_yz_middle_top();

module plank_yz_middle_bottom(){
  //l_length = module_width-2*plank_thickness+2*corner_x_fitting_depth;
  l_length = pyz_middle_length;
  color([0.2,0.2,0.9])
  difference(){
    cube([l_length, plank2_width, plank_thickness]);
    union(){
      translate([-plank_thickness+corner_x_fitting_depth,-plank1_width+plank2_width-vertical_fitting_cutting_edge,0])
      cut_vertical_fitting_bottom2();
    }
  }
}
//plank_yz_middle_bottom();

module plank_zy_middle(){
  //l_length = module_height-2*plank2_width-2*plank_thickness+2*corner_x_fitting_depth;
  l_length = pzy_middle_length;
  color([0.2,0.9,0.9])
  union(){
    cube([l_length, plank2_width, plank_thickness]);
  }
}
//plank_zy_middle();

module plank_xy_top(n){
  l_length = n*module_width-2*pxy_sub_half_length;
  color([0.9,0.2,0.9])
  difference(){
    cube([l_length, plank_xy_width, plank_thickness]);
    union(){
      cut_plank_xy_a(n);
      translate([0,0,plan_fitting_depth-cutting_edge])
      cut_plank_xy_b(n);
      translate([0,0,plank_thickness-slab_fitting_depth_horizontal-cutting_edge])
      cut_plank_xy_c(n);
    }
  }
}
//plank_xy_top(3);
//wardrobe_frame(3);

module plank_xy_bottom(n){
  l_length = n*module_width-2*pxy_sub_half_length;
  color([0.9,0.2,0.9])
  difference(){
    cube([l_length, plank_xy_width, plank_thickness]);
    union(){
      cut_plank_xy_a(n);
      translate([0,0,-remove_skin])
      cut_plank_xy_b(n);
      translate([0,0,-remove_skin])
      cut_plank_xy_c(n);
    }
  }
}
//plank_xy_bottom(3);

module cut_plank_yx_a(){
  l_length = pyx_length;
  union(){
    translate([-remove_skin,-remove_skin,0])
    cube([plan2_fitting_length+remove_skin+cutting_edge, plank_yx_width+2*remove_skin, plan_fitting_depth+remove_skin+cutting_edge]);
    translate([l_length-plan2_fitting_length-cutting_edge, -remove_skin, 0])
    cube([plan2_fitting_length+remove_skin+cutting_edge, plank_yx_width+2*remove_skin, plan_fitting_depth+remove_skin+cutting_edge]);
  }
}
//cut_plank_yx_a();

module cut_plank_yx_b(){
  l_length = pyx_length;
  l_zy_visible = plan2_fitting_length;
  union(){
    // connexion to plank_yz
    translate([-remove_skin,plank_yx_width/2-plank_thickness/2-cutting_edge,-remove_skin])
    cube([l_length+2*cutting_edge,plank_thickness+2*cutting_edge,corner_x_fitting_depth+cutting_edge+remove_skin]);
    // connexion to plank_zy
    for(i=[0:1]){
      translate([-l_zy_visible-cutting_edge+i*l_length,plank_yx_width/2-plank_thickness/2-cutting_edge,plank_thickness-corner_x_fitting_depth-cutting_edge])
      cube([2*l_zy_visible+2*cutting_edge,plank_thickness+2*cutting_edge,corner_x_fitting_depth+cutting_edge+remove_skin]);
    }
  }
}
//cut_plank_yx_b();

//module cut_plank_yx_c(){
//  l_length = pyx_length;
//  l_zx_depth_visible = corner_x_fitting_position+plank_thickness+plan_fitting_length-plank1_width;
//  union(){
//    // plank_zx are emerging
//    translate([-remove_skin,-remove_skin,plank_thickness-l_zx_depth_visible-cutting_edge])
//    cube([corner_x_fitting_depth+remove_skin+cutting_edge, plank_yx_width+2*remove_skin, l_zx_depth_visible+remove_skin+cutting_edge]);
//    translate([l_length-corner_x_fitting_depth-cutting_edge, -remove_skin, plank_thickness-l_zx_depth_visible-cutting_edge])
//    cube([corner_x_fitting_depth+remove_skin+cutting_edge, plank_yx_width+2*remove_skin, l_zx_depth_visible+remove_skin+cutting_edge]);
//  }
//}
////cut_plank_yx_c();

module cut_plank_yx_d(){
  l_length = pyx_length;
  l_zx_depth_visible = corner_x_fitting_position+plank_thickness+plan_fitting_length-plank1_width;
  l_zy_side_visible = remaining_plank_thickness+plank1_width-(plank_thickness-corner_x_fitting_depth+plank_xy_width-plan2_fitting_length);
  union(){
    // plank_zx are emerging
    translate([-remove_skin,-remove_skin,plank_thickness-l_zx_depth_visible-cutting_edge])
    cube([l_zy_side_visible+remove_skin+cutting_edge, corner_x_fitting_depth+cutting_edge+remove_skin, l_zx_depth_visible+remove_skin+cutting_edge]);
    translate([l_length-l_zy_side_visible-cutting_edge, -remove_skin, plank_thickness-l_zx_depth_visible-cutting_edge])
    cube([l_zy_side_visible+remove_skin+cutting_edge, corner_x_fitting_depth+cutting_edge+remove_skin, l_zx_depth_visible+remove_skin+cutting_edge]);
  }
}
//cut_plank_yx_d();

module cut_plank_yx_e(a_groove_width){
  l_length = pyx_length;
  union(){
    translate([plan2_fitting_length-slab_fitting_width-cutting_edge, 0, 0])
    cube([l_length-2*plan2_fitting_length+2*slab_fitting_width+2*cutting_edge, a_groove_width+cutting_edge+remove_skin, slab_fitting_depth_horizontal+remove_skin+cutting_edge]);
  }
}
//cut_plank_yx_e(slab_fitting_width_small);


module plank_yx_middle_top(){
  l_length = pyx_length;
  color([0.2,0.9,0.2])
  difference(){
    cube([l_length, plank_yx_width, plank_thickness]);
    union(){
      translate([0,0,plank_thickness-plan_fitting_depth-cutting_edge])
      cut_plank_yx_a();
      cut_plank_yx_b();
      //cut_plank_yx_c();
      translate([0,-remove_skin,-remove_skin])
      cut_plank_yx_e(slab_fitting_width_small);
      translate([0,plank_yx_width-slab_fitting_width_small-cutting_edge,-remove_skin])
      cut_plank_yx_e(slab_fitting_width_small);
      cut_plank_corner(l_length, plank_yx_width, plank_thickness,1,1,1,1);
    }
  }
}
//plank_yx_middle_top();

module plank_yx_middle_bottom(){
  l_length = pyx_length;
  color([0.2,0.9,0.2])
  difference(){
    cube([l_length, plank_yx_width, plank_thickness]);
    union(){
      translate([0,0,-remove_skin])
      cut_plank_yx_a();
      cut_plank_yx_b();
      //cut_plank_yx_c();
      translate([0,-remove_skin,plank_thickness-slab_fitting_depth_horizontal-cutting_edge])
      cut_plank_yx_e(slab_fitting_width);
      translate([0,plank_yx_width-slab_fitting_width-cutting_edge,plank_thickness-slab_fitting_depth_horizontal-cutting_edge])
      cut_plank_yx_e(slab_fitting_width);
      cut_plank_corner(l_length, plank_yx_width, plank_thickness,1,1,1,1);
    }
  }
}
//plank_yx_middle_bottom();

module plank_yx_side_top(){
  l_length = pyx_length;
  color([0.2,0.9,0.2])
  difference(){
    cube([l_length, plank_yx_width, plank_thickness]);
    union(){
      translate([0,0,plank_thickness-plan_fitting_depth-cutting_edge])
      cut_plank_yx_a();
      //cut_plank_yx_b();
      //cut_plank_yx_c();
      cut_plank_yx_d();
      translate([0,plank_yx_width-slab_fitting_width_small-2*cutting_edge,-remove_skin])
      cut_plank_yx_e(slab_fitting_width_small);
      cut_plank_corner(l_length, plank_yx_width, plank_thickness,0,1,1,0);
    }
  }
}
//plank_yx_side_top();

module plank_yx_side_bottom(){
  l_length = pyx_length;
  color([0.2,0.9,0.2])
  difference(){
    cube([l_length, plank_yx_width, plank_thickness]);
    union(){
      translate([0,0,-remove_skin])
      cut_plank_yx_a();
      //cut_plank_yx_b();
      //cut_plank_yx_c();
      cut_plank_yx_d();
      translate([0,plank_yx_width-slab_fitting_width-cutting_edge,plank_thickness-slab_fitting_depth_horizontal-cutting_edge])
      cut_plank_yx_e(slab_fitting_width);
      cut_plank_corner(l_length, plank_yx_width, plank_thickness,0,1,1,0);
    }
  }
}
//plank_yx_side_bottom();


// wardrobe_frame

module wardrobe_frame_front(n){
  l_pxy_length = n*module_width;
  l_pzx_length = pzx_length;
  union(){
    plank_xy_place_into_module("xz", n, 0, 1, 0, 0, 0, 0, l_pxy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("xz", l_pxy_length,plank1_width,plank_thickness)
    plank_flip_according("z", l_pxy_length,plank1_width,plank_thickness)
    plank_xz_front_bottom(n);
    plank_xy_place_into_module("xz", n, 0, 1, 1, 0, 0, 0, l_pxy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("xz", l_pxy_length,plank1_width,plank_thickness)
    plank_flip_according("i", l_pxy_length,plank1_width,plank_thickness)
    plank_xz_front_top(n);
    for(i=[0:n]){
      plank_xy_place_into_module("zx", n, i, 1, 0, 0, 0, plank1_width-plan_fitting_length, l_pzx_length,plank1_width,plank_thickness)
      plank_rotate_from_xy_to("zx", l_pzx_length,plank1_width,plank_thickness)
      plank_flip_according((i==n?"z":"i"), l_pzx_length,plank1_width,plank_thickness)
      if(i==0||i==n){
        plank_zx_front_side();
      } else {
        plank_zx_front_middle();
      }
    }
  }
}
//wardrobe_frame_front(3);

module wardrobe_frame_rear(n){
  l_pxy_length = n*module_width;
  l_pzx_length = pzx_length;
  union(){
    plank_xy_place_into_module("xz", n, 0, 0, 0, 0, 0, 0, l_pxy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("xz", l_pxy_length,plank1_width,plank_thickness)
    plank_flip_according("x", l_pxy_length,plank1_width,plank_thickness)
    plank_xz_rear_bottom(n);
    plank_xy_place_into_module("xz", n, 0, 0, 1, 0, 0, 0, l_pxy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("xz", l_pxy_length,plank1_width,plank_thickness)
    plank_flip_according("y", l_pxy_length,plank1_width,plank_thickness)
    plank_xz_rear_top(n);
    for(i=[0:n]){
      plank_xy_place_into_module("zx", n, i, 0, 0, 0, 0, plank1_width-plan_fitting_length, l_pzx_length,plank1_width,plank_thickness)
      plank_rotate_from_xy_to("zx", l_pzx_length,plank1_width,plank_thickness)
      plank_flip_according((i==0?"y":"x"), l_pzx_length,plank1_width,plank_thickness)
      if(i==0||i==n){
        plank_zx_rear_side();
      } else {
        plank_zx_rear_middle();
      }
    }
  }
}
//wardrobe_frame_rear(3);

module wardrobe_frame_left(n){
  l_pyz_length = pyz_side_length;
  l_pzy_length = pzy_side_length;
  union(){
    plank_xy_place_into_module("yz", n, n, 0, 1, 0, remaining_plank_thickness, 0, l_pyz_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("yz", l_pyz_length,plank1_width,plank_thickness)
    plank_flip_according("y", l_pyz_length,plank1_width,plank_thickness)
    plank_yz_side_top();
    plank_xy_place_into_module("yz", n, n, 0, 0, 0, remaining_plank_thickness, 0, l_pyz_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("yz", l_pyz_length,plank1_width,plank_thickness)
    plank_flip_according("x", l_pyz_length,plank1_width,plank_thickness)
    plank_yz_side_bottom();
    plank_xy_place_into_module("zy", n, n, 0, 0, 0, remaining_plank_thickness, plank1_width-plan_fitting_length, l_pzy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("zy", l_pzy_length,plank1_width,plank_thickness)
    plank_flip_according("y", l_pzy_length,plank1_width,plank_thickness)
    plank_zy_side();
    plank_xy_place_into_module("zy", n, n, 1, 0, 0, remaining_plank_thickness, plank1_width-plan_fitting_length, l_pzy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("zy", l_pzy_length,plank1_width,plank_thickness)
    plank_flip_according("x", l_pzy_length,plank1_width,plank_thickness)
    plank_zy_side();
  }
}
//wardrobe_frame_left(3);

module wardrobe_frame_right(n){
  l_pyz_length = pyz_side_length;
  l_pzy_length = pzy_side_length;
  union(){
    plank_xy_place_into_module("yz", n, 0, 0, 1, 0, remaining_plank_thickness, 0, l_pyz_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("yz", l_pyz_length,plank1_width,plank_thickness)
    plank_flip_according("i", l_pyz_length,plank1_width,plank_thickness)
    plank_yz_side_top();
    plank_xy_place_into_module("yz", n, 0, 0, 0, 0, remaining_plank_thickness, 0, l_pyz_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("yz", l_pyz_length,plank1_width,plank_thickness)
    plank_flip_according("z", l_pyz_length,plank1_width,plank_thickness)
    plank_yz_side_bottom();
    plank_xy_place_into_module("zy", n, 0, 0, 0, 0, remaining_plank_thickness, plank1_width-plan_fitting_length, l_pzy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("zy", l_pzy_length,plank1_width,plank_thickness)
    plank_flip_according("i", l_pzy_length,plank1_width,plank_thickness)
    plank_zy_side();
    plank_xy_place_into_module("zy", n, 0, 1, 0, 0, remaining_plank_thickness, plank1_width-plan_fitting_length, l_pzy_length,plank1_width,plank_thickness)
    plank_rotate_from_xy_to("zy", l_pzy_length,plank1_width,plank_thickness)
    plank_flip_according("z", l_pzy_length,plank1_width,plank_thickness)
    plank_zy_side();
  }
}
//wardrobe_frame_right(3);

module wardrobe_frame_middle(n,i){
  l_pyz_length = pyz_middle_length;
  l_pzy_length = pzy_middle_length;
  union(){
    plank_xy_place_into_module("yz", n, i, 0, 1, 0, plank_thickness-corner_x_fitting_depth, 0, l_pyz_length,plank2_width,plank_thickness)
    plank_rotate_from_xy_to("yz", l_pyz_length,plank2_width,plank_thickness)
    plank_flip_according("i", l_pyz_length,plank2_width,plank_thickness)
    plank_yz_middle_top();
    plank_xy_place_into_module("yz", n, i, 0, 0, 0, plank_thickness-corner_x_fitting_depth, 0, l_pyz_length,plank2_width,plank_thickness)
    plank_rotate_from_xy_to("yz", l_pyz_length,plank2_width,plank_thickness)
    plank_flip_according("z", l_pyz_length,plank2_width,plank_thickness)
    plank_yz_middle_bottom();
    plank_xy_place_into_module("zy", n, i, 0, 0, 0, plank_thickness-corner_x_fitting_depth, plank2_width+plank_thickness-2*corner_x_fitting_depth, l_pzy_length,plank2_width,plank_thickness)
    plank_rotate_from_xy_to("zy", l_pzy_length,plank2_width,plank_thickness)
    plank_flip_according("i", l_pzy_length,plank2_width,plank_thickness)
    plank_zy_middle();
    plank_xy_place_into_module("zy", n, i, 1, 0, 0, plank_thickness-corner_x_fitting_depth, plank2_width+plank_thickness-2*corner_x_fitting_depth, l_pzy_length,plank2_width,plank_thickness)
    plank_rotate_from_xy_to("zy", l_pzy_length,plank2_width,plank_thickness)
    plank_flip_according("z", l_pzy_length,plank2_width,plank_thickness)
    plank_zy_middle();
  }
}
//wardrobe_frame_middle(3,1);

module wardrobe_frame_horizontal(n){
  l_pxy_length = n*module_width-2*pxy_sub_half_length;
  l_pyx_length = pyx_length;
  l_pyx_position_y = plank_thickness-corner_x_fitting_depth+plank_xy_width-plan2_fitting_length;
  union(){
    plank_xy_place_into_module("xy", n, 0, 0, 0, plank_thickness-corner_x_fitting_depth, plank_thickness-corner_x_fitting_depth, plank2_width-corner_x_fitting_depth, l_pxy_length,plank_xy_width,plank_thickness)
    plank_rotate_from_xy_to("xy", l_pxy_length,plank_xy_width,plank_thickness)
    plank_flip_according("x", l_pxy_length,plank_xy_width,plank_thickness)
    plank_xy_bottom(n);
    plank_xy_place_into_module("xy", n, 0, 1, 0, plank_thickness-corner_x_fitting_depth, plank_thickness-corner_x_fitting_depth, plank2_width-corner_x_fitting_depth, l_pxy_length,plank_xy_width,plank_thickness)
    plank_rotate_from_xy_to("xy", l_pxy_length,plank_xy_width,plank_thickness)
    plank_flip_according("y", l_pxy_length,plank_xy_width,plank_thickness)
    plank_xy_bottom(n);
    plank_xy_place_into_module("xy", n, 0, 1, 1, plank_thickness-corner_x_fitting_depth, plank_thickness-corner_x_fitting_depth, plank2_width-corner_x_fitting_depth, l_pxy_length,plank_xy_width,plank_thickness)
    plank_rotate_from_xy_to("xy", l_pxy_length,plank_xy_width,plank_thickness)
    plank_flip_according("i", l_pxy_length,plank_xy_width,plank_thickness)
    plank_xy_top(n);
    plank_xy_place_into_module("xy", n, 0, 0, 1, plank_thickness-corner_x_fitting_depth, plank_thickness-corner_x_fitting_depth, plank2_width-corner_x_fitting_depth, l_pxy_length,plank_xy_width,plank_thickness)
    plank_rotate_from_xy_to("xy", l_pxy_length,plank_xy_width,plank_thickness)
    plank_flip_according("z", l_pxy_length,plank_xy_width,plank_thickness)
    plank_xy_top(n);
    if(n>=2){
      for(i=[1:n-1]){
        plank_xy_place_into_module("yx", n, i, 0, 0, 0, l_pyx_position_y, corner_x_fitting_position, l_pyx_length,plank_yx_width,plank_thickness)
        plank_rotate_from_xy_to("yx", l_pyx_length,plank_yx_width,plank_thickness)
        plank_flip_according("x", l_pyx_length,plank_yx_width,plank_thickness)
        plank_yx_middle_bottom();
        plank_xy_place_into_module("yx", n, i, 0, 1, 0, l_pyx_position_y, corner_x_fitting_position, l_pyx_length,plank_yx_width,plank_thickness)
        plank_rotate_from_xy_to("yx", l_pyx_length,plank_yx_width,plank_thickness)
        plank_flip_according("i", l_pyx_length,plank_yx_width,plank_thickness)
        plank_yx_middle_top();
      }
    }
    plank_xy_place_into_module("yx", n, 0, 0, 0, plank_thickness-corner_x_fitting_depth, l_pyx_position_y, corner_x_fitting_position, l_pyx_length,plank_yx_width,plank_thickness)
    plank_rotate_from_xy_to("yx", l_pyx_length,plank_yx_width,plank_thickness)
    plank_flip_according("y", l_pyx_length,plank_yx_width,plank_thickness)
    plank_yx_side_bottom();
    plank_xy_place_into_module("yx", n, 0, 0, 1, plank_thickness-corner_x_fitting_depth, l_pyx_position_y, corner_x_fitting_position, l_pyx_length,plank_yx_width,plank_thickness)
    plank_rotate_from_xy_to("yx", l_pyx_length,plank_yx_width,plank_thickness)
    plank_flip_according("i", l_pyx_length,plank_yx_width,plank_thickness)
    plank_yx_side_top();
    plank_xy_place_into_module("yx", n, n, 0, 0, plank_thickness-corner_x_fitting_depth, l_pyx_position_y, corner_x_fitting_position, l_pyx_length,plank_yx_width,plank_thickness)
    plank_rotate_from_xy_to("yx", l_pyx_length,plank_yx_width,plank_thickness)
    plank_flip_according("x", l_pyx_length,plank_yx_width,plank_thickness)
    plank_yx_side_bottom();
    plank_xy_place_into_module("yx", n, n, 0, 1, plank_thickness-corner_x_fitting_depth, l_pyx_position_y, corner_x_fitting_position, l_pyx_length,plank_yx_width,plank_thickness)
    plank_rotate_from_xy_to("yx", l_pyx_length,plank_yx_width,plank_thickness)
    plank_flip_according("z", l_pyx_length,plank_yx_width,plank_thickness)
    plank_yx_side_top();
  }
}
//wardrobe_frame_horizontal(3);

module wardrobe_frame(n){
  //color([0.1,0.7,0.2])
  union(){
    wardrobe_frame_front(n);
    wardrobe_frame_rear(n);
    wardrobe_frame_left(n);
    wardrobe_frame_right(n);
    if(n>=2){
      for(i=[1:n-1]){
        wardrobe_frame_middle(n,i);
      }
    }
    wardrobe_frame_horizontal(n);
  }
}
//wardrobe_frame(3);

// slab

module slab_horizontal(n,i){
  l_nocut_side = slab_horizontal_sub_width1_side;
  l_nocut_middle = slab_horizontal_sub_width1_middle;
  l_w1 = module_width-(i==1?l_nocut_side:l_nocut_middle)-(i==n?l_nocut_side:l_nocut_middle)-0*2*cutting_edge;
  l_w2 = slab_horizontal_width2-0*2*cutting_edge;
  color([0.2,0.9,0.9])
  difference(){
    cube([l_w1, l_w2, slab_thickness]);
    union(){
      cut_plank_corner(l_w1, l_w2, slab_thickness,1,1,1,1);
    }
  }
}
//slab_horizontal(3,1);

module slab_side(){
  color([0.2,0.9,0.9])
  difference(){
    cube([slab_vertical_side_width1, slab_vertical_width2, slab_thickness]);
    union(){
      cut_plank_corner(slab_vertical_side_width1, slab_vertical_width2, slab_thickness,1,1,1,1);
    }
  }
}
//slab_side();

module slab_rear(n,i){
  l_nocut_side = slab_vertical_rear_side_sub_width1;
  l_nocut_middle = slab_vertical_rear_middle_sub_width1;
  l_w1 = module_width-(i==1?l_nocut_side:l_nocut_middle)-(i==n?l_nocut_side:l_nocut_middle)-0*2*cutting_edge;
  l_w2 = slab_vertical_width2-0*2*cutting_edge;
  color([0.2,0.9,0.9])
  difference(){
    cube([l_w1, l_w2, slab_thickness]);
    union(){
      cut_plank_corner(l_w1, l_w2, slab_thickness,1,1,1,1);
    }
  }
}
//slab_rear(3,1);

// wardrobe_wall

module wardrobe_wall_horizontal(n){
  l_position_z_bottom = corner_x_fitting_position+plank_thickness-slab_fitting_depth_horizontal;
  l_position_z_top = corner_x_fitting_position;
  union(){
    for(i=[1:n]){
      assign(l_w1 = module_width-(i==1?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle)-(i==n?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle)-0*2*cutting_edge){
        plank_xy_place_into_module("xy", n, i-1, 0, 0, (i==1?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle), slab_horizontal_sub_width2, l_position_z_bottom, l_w1, slab_horizontal_width2, slab_thickness)
        plank_rotate_from_xy_to("xy", l_w1,slab_horizontal_width2,slab_thickness)
        plank_flip_according("i", l_w1,slab_horizontal_width2,slab_thickness)
        slab_horizontal(n,i);
        plank_xy_place_into_module("xy", n, i-1, 0, 1, (i==1?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle), slab_horizontal_sub_width2, l_position_z_top, l_w1, slab_horizontal_width2, slab_thickness)
        plank_rotate_from_xy_to("xy", l_w1,slab_horizontal_width2,slab_thickness)
        plank_flip_according("i", l_w1,slab_horizontal_width2,slab_thickness)
        slab_horizontal(n,i);
      }
    }
  }
}
//wardrobe_wall_horizontal(3);
//wardrobe_frame_horizontal(3);

module wardrobe_wall_side(n){
  union(){
    for(i=[0:1]){
      plank_xy_place_into_module("yz", n, i*n, 0, 0, slab_fitting_depth_vertical-slab_thickness, plank1_width+remaining_plank_thickness-slab_fitting_width, slab_vertical_sub_width2, slab_vertical_side_width1, slab_vertical_width2, slab_thickness)
      plank_rotate_from_xy_to("yz", slab_vertical_side_width1, slab_vertical_width2, slab_thickness)
      plank_flip_according("i", slab_vertical_side_width1, slab_vertical_width2, slab_thickness)
      slab_side();
    }
  }
}
// wardrobe_wall_side(3);

module wardrobe_wall_rear(n){
  union(){
    for(i=[1:n]){
      assign(l_w1 = module_width-(i==1?slab_vertical_rear_side_sub_width1:slab_vertical_rear_middle_sub_width1)-(i==n?slab_vertical_rear_side_sub_width1:slab_vertical_rear_middle_sub_width1)-0*2*cutting_edge, l_px=(i==1?slab_vertical_rear_side_sub_width1:slab_vertical_rear_middle_sub_width1)){
        plank_xy_place_into_module("xz", n, (i-1), 0, 0, l_px, slab_fitting_depth_vertical-slab_thickness, slab_vertical_sub_width2, l_w1, slab_vertical_width2, slab_thickness)
        plank_rotate_from_xy_to("xz", l_w1, slab_vertical_width2, slab_thickness)
        plank_flip_according("i", l_w1, slab_vertical_width2, slab_thickness)
        slab_rear(n,i);
      }
    }
  }
}
// wardrobe_wall_rear(3);

module wardrobe_wall(n){
  union(){
    wardrobe_wall_horizontal(n);
    wardrobe_wall_side(n);
    wardrobe_wall_rear(n);
  }
}
//wardrobe_wall(3);

// opening_fastening

module opening_fastening_pivot(){
  color([0.7,0.1,0.8])
  difference(){
    union(){
      cube([opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness]);
    }
    union(){
      translate([opening_fastening_width1/2, opening_fastening_width2/2, -remove_skin])
      cylinder(r=opening_fastening_diameter/2, h=opening_fastening_thickness+2*remove_skin);
    }
  }
}
//opening_fastening_pivot();

module opening_fastening_magnet(){
  color([0.7,0.1,0.8])
  difference(){
    union(){
      cube([opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness+opening_fastening_height]);
    }
    union(){
      translate([-remove_skin, opening_fastening_width2/2, opening_fastening_thickness])
      cube([opening_fastening_width1+2*remove_skin, opening_fastening_width2/2+remove_skin, opening_fastening_height+remove_skin]);
    }
  }
}
//opening_fastening_magnet();

module opening_fastening(n){
  union(){
    for(i=[1:n]){
      assign(l_opening_fastening1=(i==1?plank1_width:plank1_width/2)+opening_fastening_space,
          l_opening_fastening2=(i==n?plank1_width:plank1_width/2)+opening_fastening_width1+opening_fastening_space){
        plank_xy_place_into_module("xy", n, (i-1), 1, 0, l_opening_fastening1, plank_thickness-opening_fastening_width2, plank1_width-opening_fastening_thickness, opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness)
        plank_rotate_from_xy_to("xy", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness)
        plank_flip_according("i", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness)
        opening_fastening_pivot();
        plank_xy_place_into_module("xy", n, (i-1), 1, 0, module_width-l_opening_fastening2, plank_thickness-opening_fastening_width2, plank1_width-opening_fastening_thickness, opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness+opening_fastening_height)
        plank_rotate_from_xy_to("xy", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness+opening_fastening_height)
        plank_flip_according("i", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness+opening_fastening_height)
        opening_fastening_magnet();
        plank_xy_place_into_module("xy", n, (i-1), 1, 1, l_opening_fastening1, plank_thickness-opening_fastening_width2, plank1_width-opening_fastening_thickness, opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness)
        plank_rotate_from_xy_to("xy", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness)
        plank_flip_according("i", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness)
        opening_fastening_pivot();
        plank_xy_place_into_module("xy", n, (i-1), 1, 1, module_width-l_opening_fastening2, plank_thickness-opening_fastening_width2, plank1_width-opening_fastening_thickness, opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness+opening_fastening_height)
        plank_rotate_from_xy_to("xy", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness+opening_fastening_height)
        plank_flip_according("y", opening_fastening_width1, opening_fastening_width2, opening_fastening_thickness+opening_fastening_height)
        opening_fastening_magnet();
      }
    }
  }
}
//opening_fastening(3);

// wardrobe_module

module wardrobe(n){
  union(){
    wardrobe_frame(n);
    wardrobe_wall(n);
    opening_fastening(n);
  }
}
//wardrobe(3);
//plank_yz_side_bottom();
//plank_xz_rear_bottom(3);

// sub function for system

module one_projection(a_direction, a_depth, a_object_size_x, a_object_size_y, a_object_size_z){
  l_marker_space = 50;
  l_marker_width = 5;
  projection(cut=true)
  translate([0,0,((a_direction=="xz")?1:-1)*a_depth])
  //plank_rotate_from_xy_to(a_direction, a_object_size_x, a_object_size_y, a_object_size_z) // what a pity that two modules using child can not call each other!
  //child(0);
  if (a_direction=="xy"){
    translate([0,0,0])
    rotate([0,0,0])
    child(0);
  } else if (a_direction=="xz"){
    translate([0,0,0])
    rotate([-90,0,0])
    child(0);
  } else if (a_direction=="yz"){
    translate([0,0,0])
    rotate([0,-90,-90])
    child(0);
  } else {
    echo("ERR451: Error, this a_direction doesn't exist!");
  }
  // marker to indicate the depth of the cut-projection
  assign(l_y=((a_direction=="xy")?a_object_size_y:0)+((a_direction=="xz")?a_object_size_z:0)+((a_direction=="yz")?a_object_size_z:0),
      l_z=((a_direction=="xy")?a_object_size_z:0)+((a_direction=="xz")?a_object_size_y:0)+((a_direction=="yz")?a_object_size_x:0)){
    difference(){
      union(){
        translate([-l_marker_space+l_marker_width, -l_marker_width, 0])
        square([3*l_marker_width,l_y+2*l_marker_width], center=false);
        translate([-l_marker_space, -l_marker_width, 0])
        square([5*l_marker_width,l_marker_width], center=false);
        translate([-l_marker_space, l_y, 0])
        square([5*l_marker_width,l_marker_width], center=false);
      }
      union(){
        translate([-l_marker_space+2*l_marker_width, 0, 0])
        square([l_marker_width,a_depth*l_y/l_z], center=false);
      }
    }
  }
}
//one_projection("xy", 200, 3*module_width, module_width, module_height) wardrobe(3);
//one_projection("xz", 200, 3*module_width, module_width, module_height) wardrobe(3);
//one_projection("yz", 200, 3*module_width, module_width, module_height) wardrobe(3);

module place_projection(a_direction, a_index, a_object_size_x, a_object_size_y, a_object_size_z){
  l_space_x = 200;
  l_space_y = 300;
  l_marker_space = 50;
  l_marker_width = 5;
  l_y = (a_direction=="xy"?2*(a_object_size_z+l_space_y):0)+(a_direction=="xz"?1*(a_object_size_z+l_space_y):0)+l_marker_width;
  l_x = ((a_direction=="xy")||(a_direction=="xz")?a_index*(a_object_size_x+l_space_x):a_index*(a_object_size_y+l_space_x))+l_marker_space;
  translate([l_x,l_y,0])
  child(0);
}

module plank_projection(a_depth_z_list, a_depth_y_list, a_depth_x_list, a_length_x, a_width_y, a_thickness_z){
  l_space_y=50;
  l_x_extrimity_margin=0.1;
  l_x_additional_step=5;
  l_plan_xy_nb = len(a_depth_z_list);
  l_plan_xz_nb = len(a_depth_y_list);
  l_plan_zy_nb = len(a_depth_x_list);
  //projection(cut=true){ // openscad crash that's way
    for(i=[0:l_plan_xy_nb-1]){
      echo("iz:",i, a_depth_z_list[i]);
      translate([0,a_width_y+l_plan_xz_nb*(a_thickness_z+l_space_y)+(i+1)*(a_width_y+l_space_y),0])
      projection(cut=true)
      translate([0,0,-a_depth_z_list[i]])
      child(0);
    }
    for(i=[0:l_plan_xz_nb-1]){
      echo("iy:",i, a_depth_y_list[i]);
      translate([0,a_width_y+(i+1)*(a_thickness_z+l_space_y),0])
      projection(cut=true)
      translate([0,a_thickness_z,-a_depth_y_list[i]])
      rotate([90,0,0])
      child(0);
    }
    //for(i=[0:l_plan_zy_nb-1]){
    for(i=[l_x_extrimity_margin:a_thickness_z+l_x_additional_step:a_length_x-l_x_extrimity_margin]){
      echo("ix:",i);
      //translate([a_depth_x_list[i],0,0])
      translate([i,0,0])
      projection(cut=true)
      //translate([0,0,a_depth_x_list[i]])
      translate([0,0,i])
      rotate([0,90,0])
      child(0);
    }
  //}
}

module count_and_place(a_nb_x, a_nb_y, a_offset_x, a_offset_y, a_length_x, a_width_y, a_thickness_z){
  l_space_x = 30;
  l_space_y = 30;
  union(){
    if((a_nb_x>0)&&(a_nb_y>0)){
      for(i=[1:a_nb_x]){
        for(j=[1:a_nb_y]){
          translate([a_offset_x+(i-1)*(a_length_x+l_space_x),a_offset_y+(j-1)*(a_width_y+l_space_y),0])
          child(0);
        }
      }
    }
  }
}


// system

wardrobe_n = 1;

//wardrobe(1);
//wardrobe(2);
//wardrobe(3);
//wardrobe(4);
//wardrobe(5);
//wardrobe(wardrobe_n);

module wardrobe_assortment(){
  l_space = 300;
  union(){
    for(i=[1:5]){
      translate([0,0,(i-1)*(module_height+l_space)])
      wardrobe(i);
    }
  }
}
//wardrobe_assortment();

module wardrobe_break_view(){
  //break_view_length = 200;
  wardrobe(wardrobe_n);
  //echo("break_view_length", break_view_length);
}
//wardrobe_break_view();
//echo("break_view_length", break_view_length);

//one_projection("xy", 200, 1*module_width, module_width, module_height) wardrobe(1);
//translate([10,10,0]) one_projection("xy", 200, 1*module_width, module_width, module_height) wardrobe(1);

module wardrobe_plan(){
  l_xy_depth_cut = [0.1,35,45,55,65,75,85,95,105,295,305,315,325,335,345,355,365,375,385,395,428];
  l_xz_depth_cut = [0.1,10,20,30,40,50,60,70,80,90,110,290,310,320,330,340,350,360,370,380,390,399];
  l_yz_depth_cut = [0.1,5,10,15,20,25,30,40,50,60,70,80,110,290,310,320,330,340,350,360,370,375,380,385,390,395,399];
  //echo("len", len(l_xy_depth_cut))
  for(i=[0:len(l_xy_depth_cut)-1]){
    echo("i",i, l_xy_depth_cut[i]);
    place_projection("xy", i, wardrobe_n*module_width, module_width, module_height)
    one_projection("xy", l_xy_depth_cut[i], wardrobe_n*module_width, module_width, module_height)
    wardrobe(wardrobe_n);
  }
  for(i=[0:len(l_xz_depth_cut)-1]){
    echo("i",i, l_xz_depth_cut[i]);
    place_projection("xz", i, wardrobe_n*module_width, module_width, module_height)
    one_projection("xz", l_xz_depth_cut[i], wardrobe_n*module_width, module_width, module_height)
    wardrobe(wardrobe_n);
  }
  for(i=[0:len(l_yz_depth_cut)-1]){
    echo("i",i, l_yz_depth_cut[i]);
    place_projection("yz", i, wardrobe_n*module_width, module_width, module_height)
    one_projection("yz", l_yz_depth_cut[i], wardrobe_n*module_width, module_width, module_height)
    wardrobe(wardrobe_n);
  }
}
//wardrobe_plan();

module plank_defintion(){
  l_z_list = [0.1,5,10,15,20,25,27];
  l_plank1_y_list = [0.1,10,20,30,40,50,60,70,80,90,97];
  l_plank2_y_list = [0.1,10,20,30,40,47];
  l_x_list_null = [1];
  // list of planks
  ////plank_projection([1,10,20,27], [1,20,40,80], [10,50,90,130,170], wardrobe_n*module_width, plank1_width, plank_thickness)
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, wardrobe_n*module_width, plank1_width, plank_thickness)
  //plank_xz_rear_bottom(wardrobe_n); // x1
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, wardrobe_n*module_width, plank1_width, plank_thickness)
  //plank_xz_rear_top(wardrobe_n); // x1
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pzx_length, plank1_width, plank_thickness)
  //plank_zx_rear_side(); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pzx_length, plank1_width, plank_thickness)
  //plank_zx_rear_middle(); // x(wardrobe_n-1)
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, wardrobe_n*module_width, plank1_width, plank_thickness)
  //plank_xz_front_bottom(wardrobe_n); // x1
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, wardrobe_n*module_width, plank1_width, plank_thickness)
  //plank_xz_front_top(wardrobe_n); // x1
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pzx_length, plank1_width, plank_thickness)
  //plank_zx_front_side(); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pzx_length, plank1_width, plank_thickness)
  //plank_zx_front_middle(); // x(wardrobe_n-1)
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyz_side_length, plank1_width, plank_thickness)
  //plank_yz_side_bottom(); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyz_side_length, plank1_width, plank_thickness)
  //plank_yz_side_top(); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pzy_side_length, plank1_width, plank_thickness)
  //plank_zy_side(); // x4
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyz_middle_length, plank1_width, plank_thickness)
  //plank_yz_middle_bottom(); // x(wardrobe_n-1)
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyz_middle_length, plank2_width, plank_thickness)
  //plank_yz_middle_top(); // x(wardrobe_n-1)
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pzy_middle_length, plank2_width, plank_thickness)
  //plank_zy_middle(); // x(2*wardrobe_n-2)
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, wardrobe_n*module_width-2*pxy_sub_half_length, plank_xy_width, plank_thickness)
  //plank_xy_bottom(wardrobe_n); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, wardrobe_n*module_width-2*pxy_sub_half_length, plank_xy_width, plank_thickness)
  //plank_xy_top(wardrobe_n); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyx_length, plank_yx_width, plank_thickness)
  //plank_yx_side_bottom(); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyx_length, plank_yx_width, plank_thickness)
  //plank_yx_side_top(); // x2
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyx_length, plank_yx_width, plank_thickness)
  //plank_yx_middle_bottom(); // x(wardrobe_n-1)
  //plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyx_length, plank_yx_width, plank_thickness)
  //plank_yx_middle_top(); // x(wardrobe_n-1)
}
//plank_defintion();

module cnc_plank_batch(){ // this module should present all the planks required for a module and placed in a plan for being mill by a cnc
  l_space_step_x = module_width+100;
  l_space_step_y = plank1_width+100;
  union(){
    count_and_place(1,1,0*l_space_step_x,0*l_space_step_y, wardrobe_n*module_width, plank1_width, plank_thickness)
    plank_xz_rear_bottom(wardrobe_n); // x1
    count_and_place(1,1,0*l_space_step_x,1*l_space_step_y, wardrobe_n*module_width, plank1_width, plank_thickness)
    plank_xz_rear_top(wardrobe_n); // x1
    count_and_place(2,1,0*l_space_step_x,2*l_space_step_y, pzx_length, plank1_width, plank_thickness)
    plank_zx_rear_side(); // x2
    count_and_place(wardrobe_n-1,1,0*l_space_step_x,3*l_space_step_y, pzx_length, plank1_width, plank_thickness)
    plank_zx_rear_middle(); // x(wardrobe_n-1)
    count_and_place(1,1,0*l_space_step_x,4*l_space_step_y, wardrobe_n*module_width, plank1_width, plank_thickness)
    plank_xz_front_bottom(wardrobe_n); // x1
    count_and_place(1,1,0*l_space_step_x,5*l_space_step_y, wardrobe_n*module_width, plank1_width, plank_thickness)
    plank_xz_front_top(wardrobe_n); // x1
    count_and_place(2,1,0*l_space_step_x,6*l_space_step_y, pzx_length, plank1_width, plank_thickness)
    plank_zx_front_side(); // x2
    count_and_place(wardrobe_n-1,1,0*l_space_step_x,7*l_space_step_y, pzx_length, plank1_width, plank_thickness)
    plank_zx_front_middle(); // x(wardrobe_n-1)
    count_and_place(2,1,0*l_space_step_x,8*l_space_step_y, pyz_side_length, plank1_width, plank_thickness)
    plank_yz_side_bottom(); // x2
    count_and_place(2,1,0*l_space_step_x,9*l_space_step_y, pyz_side_length, plank1_width, plank_thickness)
    plank_yz_side_top(); // x2
    count_and_place(4,1,0*l_space_step_x,10*l_space_step_y, pzy_side_length, plank1_width, plank_thickness)
    plank_zy_side(); // x4
    count_and_place(wardrobe_n-1,1,0*l_space_step_x,11*l_space_step_y, pyz_middle_length, plank1_width, plank_thickness)
    plank_yz_middle_bottom(); // x(wardrobe_n-1)
    count_and_place(wardrobe_n-1,1,0*l_space_step_x,12*l_space_step_y, pyz_middle_length, plank2_width, plank_thickness)
    plank_yz_middle_top(); // x(wardrobe_n-1)
    count_and_place(2*wardrobe_n-2,1,0*l_space_step_x,13*l_space_step_y, pzy_middle_length, plank2_width, plank_thickness)
    plank_zy_middle(); // x(2*wardrobe_n-2)
    count_and_place(2,1,0*l_space_step_x,14*l_space_step_y, wardrobe_n*module_width-2*pxy_sub_half_length, plank_xy_width, plank_thickness)
    plank_xy_bottom(wardrobe_n); // x2
    count_and_place(2,1,0*l_space_step_x,15*l_space_step_y, wardrobe_n*module_width-2*pxy_sub_half_length, plank_xy_width, plank_thickness)
    plank_xy_top(wardrobe_n); // x2
    count_and_place(2,1,0*l_space_step_x,16*l_space_step_y, pyx_length, plank_yx_width, plank_thickness)
    plank_yx_side_bottom(); // x2
    count_and_place(2,1,0*l_space_step_x,17*l_space_step_y, pyx_length, plank_yx_width, plank_thickness)
    plank_yx_side_top(); // x2
    count_and_place(wardrobe_n-1,1,0*l_space_step_x,18*l_space_step_y, pyx_length, plank_yx_width, plank_thickness)
    plank_yx_middle_bottom(); // x(wardrobe_n-1)
    count_and_place(wardrobe_n-1,1,0*l_space_step_x,19*l_space_step_y, pyx_length, plank_yx_width, plank_thickness)
    plank_yx_middle_top(); // x(wardrobe_n-1)
  }
}
//cnc_plank_batch();
//projection(cut=false) cnc_plank_batch();

module cnc_slab_batch(){ // this module should present all the slabs required for a module and placed in a plan for being mill by a cnc
  l_space_step_x = module_width+100;
  l_space_step_y = module_width+100;
  //l_horizontal_w1 = module_width-(i==1?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle)-(i==n?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle);
  l_horizontal_side_w1 = module_width-(wardrobe_n==1?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle)-slab_horizontal_sub_width1_side;
  l_horizontal_middle_w1 = module_width-2*slab_horizontal_sub_width1_middle;
  l_vertical_side_w1 = module_width-(wardrobe_n==1?slab_vertical_rear_side_sub_width1:slab_vertical_rear_middle_sub_width1)-slab_vertical_rear_side_sub_width1;
  l_vertical_middle_w1 = module_width-2*slab_vertical_rear_middle_sub_width1;
  union(){
    count_and_place((wardrobe_n==1?2:4),1,0*l_space_step_x,0*l_space_step_y, l_horizontal_side_w1, slab_horizontal_width2, slab_thickness)
    slab_horizontal(wardrobe_n, 1); // x2 if wardrobe_n==1 else x4
    count_and_place(2*wardrobe_n-4,1,4*l_space_step_x,0*l_space_step_y, l_horizontal_middle_w1, slab_horizontal_width2, slab_thickness)
    slab_horizontal(wardrobe_n, 2); // 2*wardrobe_n-4
    count_and_place(2,1,0*l_space_step_x,1*l_space_step_y, slab_vertical_side_width1, slab_vertical_width2, slab_thickness)
    slab_side(); // x2
    count_and_place((wardrobe_n==1?1:2),1,2*l_space_step_x,1*l_space_step_y, l_vertical_side_w1, slab_vertical_width2, slab_thickness)
    slab_rear(wardrobe_n,1); // x1 if wardrobe_n==1 else x2
    count_and_place(wardrobe_n-2,1,4*l_space_step_x,1*l_space_step_y, l_vertical_middle_w1, slab_vertical_width2, slab_thickness)
    slab_rear(wardrobe_n,2); // x(wardrobe_n-2)
  }
}
//cnc_slab_batch();
//projection(cut=false) cnc_slab_batch();

//wardrobe(wardrobe_n);
//wardrobe_assortment();
//wardrobe_break_view();
//wardrobe_plan();
//plank_defintion();
//cnc_plank_batch();
//cnc_slab_batch();



