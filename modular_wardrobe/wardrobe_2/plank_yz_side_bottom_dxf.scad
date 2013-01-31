
include <../src/wardrobe.scad>;
l_z_list = [0.1,5,10,15,20,25,27];
l_plank1_y_list = [0.1,10,20,30,40,50,60,70,80,90,97];
l_plank2_y_list = [0.1,10,20,30,40,47];
l_x_list_null = [1];
plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyz_side_length, plank1_width, plank_thickness)
plank_yz_side_bottom();
echo("plank_length:", pyz_side_length);
echo("plank_width:", plank1_width);
echo("plank_thickness:", plank_thickness);
echo("plank_number:", 2);
//github_openscad -o wardrobe_2/plank_yz_side_bottom.dxf -D wardrobe_n=2 -D cutting_edge=0 -D break_view_length=0 wardrobe_2/plank_yz_side_bottom_dxf.scad
