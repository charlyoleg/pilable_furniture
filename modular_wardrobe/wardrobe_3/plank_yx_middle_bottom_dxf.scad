
include <../src/wardrobe.scad>;
l_z_list = [0.1,5,10,15,20,25,27];
l_plank1_y_list = [0.1,10,20,30,40,50,60,70,80,90,97];
l_plank2_y_list = [0.1,10,20,30,40,47];
l_x_list_null = [1];
plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, pyx_length, plank_yx_width, plank_thickness)
plank_yx_middle_bottom();
echo("plank_length:", pyx_length);
echo("plank_width:", plank_yx_width);
echo("plank_thickness:", plank_thickness);
echo("plank_number:", (wardrobe_n-1));
//github_openscad -o wardrobe_3/plank_yx_middle_bottom.dxf -D wardrobe_n=3 -D cutting_edge=0 -D break_view_length=0 wardrobe_3/plank_yx_middle_bottom_dxf.scad
