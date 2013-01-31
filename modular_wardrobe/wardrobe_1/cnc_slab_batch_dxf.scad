
include <../src/wardrobe.scad>;
projection(cut=false) cnc_slab_batch();
//github_openscad -o wardrobe_1/cnc_slab_batch.dxf -D wardrobe_n=1 -D cutting_edge=0 -D break_view_length=0 wardrobe_1/cnc_slab_batch_dxf.scad
