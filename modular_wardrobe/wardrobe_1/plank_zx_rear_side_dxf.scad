
include <../src/wardrobe.scad>;
l_z_list = [0.1,5,10,15,20,25,27];
l_plank1_y_list = [0.1,10,20,30,40,50,60,70,80,90,97];
l_plank2_y_list = [0.1,10,20,30,40,47];
l_x_list_null = [1];
plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pzx_length, plank1_width, plank_thickness)
plank_zx_rear_side();
echo("plank_length:", pzx_length);
echo("plank_width:", plank1_width);
echo("plank_thickness:", plank_thickness);
echo("plank_number:", 2);
//github_openscad -o wardrobe_1/plank_zx_rear_side.dxf -D wardrobe_n=1 -D cutting_edge=0 -D break_view_length=0 wardrobe_1/plank_zx_rear_side_dxf.scad
