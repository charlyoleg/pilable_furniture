
include <../src/wardrobe.scad>;
projection(cut=false) cnc_plank_batch();
//github_openscad -o wardrobe_2/cnc_plank_batch.dxf -D wardrobe_n=2 -D cutting_edge=0 -D break_view_length=0 wardrobe_2/cnc_plank_batch_dxf.scad
