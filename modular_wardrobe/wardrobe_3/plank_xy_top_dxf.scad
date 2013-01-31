
include <../src/wardrobe.scad>;
l_z_list = [0.1,5,10,15,20,25,27];
l_plank1_y_list = [0.1,10,20,30,40,50,60,70,80,90,97];
l_plank2_y_list = [0.1,10,20,30,40,47];
l_x_list_null = [1];
plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, wardrobe_n*module_width-2*pxy_sub_half_length, plank_xy_width, plank_thickness)
plank_xy_top(wardrobe_n);
echo("plank_length:", wardrobe_n*module_width-2*pxy_sub_half_length);
echo("plank_width:", plank_xy_width);
echo("plank_thickness:", plank_thickness);
echo("plank_number:", 2);
//github_openscad -o wardrobe_3/plank_xy_top.dxf -D wardrobe_n=3 -D cutting_edge=0 -D break_view_length=0 wardrobe_3/plank_xy_top_dxf.scad
