
include <../src/wardrobe.scad>;
l_z_list = [0.1,5,10,15,20,25,27];
l_plank1_y_list = [0.1,10,20,30,40,50,60,70,80,90,97];
l_plank2_y_list = [0.1,10,20,30,40,47];
l_x_list_null = [1];
plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyz_middle_length, plank2_width, plank_thickness)
plank_yz_middle_top();
echo("plank_length:", pyz_middle_length);
echo("plank_width:", plank2_width);
echo("plank_thickness:", plank_thickness);
echo("plank_number:", (wardrobe_n-1));
//github_openscad -o wardrobe_1/plank_yz_middle_top.dxf -D wardrobe_n=1 -D cutting_edge=0 -D break_view_length=0 wardrobe_1/plank_yz_middle_top_dxf.scad
