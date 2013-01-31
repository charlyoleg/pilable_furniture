#!/usr/bin/python
# make_wardrobe.py

import argparse, sys
import os, errno
from datetime import datetime
import subprocess
import re

### local settings
# path to openscad
#openscad_path="openscad"         # default ubuntu version (OpenSCAD version 2012.05.12)
openscad_path="github_openscad"   # newest version from github

### functions

def mkdir_p(a_path): # equivalent to mkdir -p
  try:
    os.makedirs(a_path)
  except OSError as exc:
    if exc.errno == errno.EEXIST and os.path.isdir(a_path):
      pass
    else: raise

def call_openscad(a_ocf, a_f_ocf, a_options, a_f_output):
  l_cmdline="{openscad_path} -o {output_file} {openscad_options} {openscad_command_file}".format(openscad_path=openscad_path, output_file=a_f_output, openscad_options=a_options, openscad_command_file=a_f_ocf)
  print("openscad command line: %s"%l_cmdline)
  #print l_cmdline.split(' ')
  fh_ocf = open(a_f_ocf, 'w')
  fh_ocf.write(a_ocf)
  fh_ocf.write("//%s\n"%l_cmdline)
  fh_ocf.close()
  #subprocess.call(l_cmdline, stdin=None, stdout=None, stderr=None, shell=True)
  subprocess.call(l_cmdline.split(' '), stdin=None, stdout=None, stderr=None, shell=False)
  #fh_stdout_log = open("%s.stdout.log"%a_f_ocf, 'w')
  #fh_stderr_log = open("%s.stdout.log"%a_f_ocf, 'w')
  #subprocess.call(l_cmdline.split(' '), stdin=None, stdout=fh_stdout_log, stderr=fh_stderr_log, shell=False)
  #fh_stdout_log.close()
  #fh_stderr_log.close()

def call_openscad_for_info(a_ocf, a_f_ocf, a_options, a_f_output, a_plank_info_list):
  l_cmdline="{openscad_path} -o {output_file} {openscad_options} {openscad_command_file}".format(openscad_path=openscad_path, output_file=a_f_output, openscad_options=a_options, openscad_command_file=a_f_ocf)
  #l_cmdline="{openscad_path} {openscad_options} {openscad_command_file}".format(openscad_path=openscad_path, openscad_options=a_options, openscad_command_file=a_f_ocf)
  print("openscad command line: %s"%l_cmdline)
  fh_ocf = open(a_f_ocf, 'w')
  fh_ocf.write(a_ocf)
  fh_ocf.write("//%s\n"%l_cmdline)
  fh_ocf.close()
  l_f_stdout = "%s.stdout.log"%a_f_ocf
  l_f_stderr = "%s.stderr.log"%a_f_ocf
  #fh_stdout_log = open(l_f_stdout, 'w')
  fh_stderr_log = open(l_f_stderr, 'w')
  #subprocess.call(l_cmdline.split(' '), stdin=None, stdout=fh_stdout_log, stderr=None, shell=False)
  subprocess.call(l_cmdline.split(' '), stdin=None, stdout=None, stderr=fh_stderr_log, shell=False)     # it looks like openscad outputs only on stderr
  #subprocess.call(l_cmdline.split(' '), stdin=None, stdout=fh_stdout_log, stderr=fh_stderr_log, shell=False)
  #fh_stdout_log.close()
  fh_stderr_log.close()
  ll_plank_name=""
  ll_plank_length=0
  ll_plank_width=0
  ll_plank_thickness=0
  ll_plank_number=0
  fh_log = open(l_f_stderr, 'r')
  for i_line in fh_log.readlines():
    #print("dbg410:", i_line)
    if re.search("plank_name:", i_line):
      ll_plank_name=re.sub('"\n', '', re.sub("^.*plank_name: ","", i_line))
      #print("dbg414:", ll_plank_name)
    if re.search("plank_length:", i_line):
      ll_plank_length=int(re.sub("^.*plank_length:\", ","", i_line))
    if re.search("plank_width:", i_line):
      ll_plank_width=int(re.sub("^.*plank_width:\", ","", i_line))
    if re.search("plank_thickness:", i_line):
      ll_plank_thickness=int(re.sub("^.*plank_thickness:\", ","", i_line))
    if re.search("plank_number:", i_line):
      ll_plank_number=max(0,int(re.sub("^.*plank_number:\", ","", i_line)))
  fh_log.close()
  os.remove(a_f_output)
  #os.remove(l_f_stdout)
  os.remove(l_f_stderr)
  os.remove(a_f_ocf)
  a_plank_info_list.append([ll_plank_name, ll_plank_length, ll_plank_width, ll_plank_thickness, ll_plank_number])
  

### main

mw_parser = argparse.ArgumentParser(description='This script generates STL and DXF files related to the modular wardrobe.')
mw_parser.add_argument('--module_length_number', '--mln', action='store', type=int, default=0, dest='sw_module_length_number',
  help='It defines the number of module_width the module_length must be.')
mw_parser.add_argument('--draw_assembly', '--da', action='store_true', dest='sw_draw_assembly',
  help='Draw the assembled wardrobe module in three STL variants (normal, exagerated cut, break view) and in DXF.')
mw_parser.add_argument('--draw_planks', '--dp', action='store_true', dest='sw_draw_planks',
  help='Draw each plank in STL and DXF.')
mw_parser.add_argument('--draw_cnc_batch', '--dc', action='store_true', dest='sw_draw_cnc_batch',
  help='Draw the cnc plank batch and slab batch in STL and DXF.')
mw_parser.add_argument('--draw_all', '--all', action='store_true', dest='sw_draw_all',
  help='Draw all STL and DXF (assembly, planks and cnc batchs) related to the wardrobe module.')
mw_parser.add_argument('--plank_info', '--pi', action='store_true', dest='sw_plank_info',
  help='Display information about required planks (number, size, ...)')
mw_args = mw_parser.parse_args()

if mw_args.sw_module_length_number<1:
  print("ERR101: Error, the module_length_number is smaller than 1!")
  sys.exit(2)
print("module_length_number: %d" % (mw_args.sw_module_length_number))

output_dir="wardrobe_%d" % (mw_args.sw_module_length_number)
print("output_dir: %s"%(output_dir))
mkdir_p(output_dir)

# plank and slab list
plank_list=[
["plank_xz_rear_bottom(wardrobe_n)",  "1",                "wardrobe_n*module_width","plank1_width","plank_thickness"],
["plank_xz_rear_top(wardrobe_n)",     "1",                "wardrobe_n*module_width","plank1_width","plank_thickness"], # crash with OpenSCAD version 2012.05.12
["plank_zx_rear_side()",              "2",                "pzx_length","plank1_width","plank_thickness"],
["plank_zx_rear_middle()",            "(wardrobe_n-1)",   "pzx_length","plank1_width","plank_thickness"],
["plank_xz_front_bottom(wardrobe_n)", "1",                "wardrobe_n*module_width", "plank1_width", "plank_thickness"],
["plank_xz_front_top(wardrobe_n)",    "1",                "wardrobe_n*module_width", "plank1_width", "plank_thickness"], # crash with OpenSCAD version 2012.05.12
["plank_zx_front_side()",             "2",                "pzx_length", "plank1_width", "plank_thickness"],
["plank_zx_front_middle()",           "(wardrobe_n-1)",   "pzx_length", "plank1_width", "plank_thickness"],
["plank_yz_side_bottom()",            "2",                "pyz_side_length", "plank1_width", "plank_thickness"],
["plank_yz_side_top()",               "2",                "pyz_side_length", "plank1_width", "plank_thickness"],  # crash with OpenSCAD version 2012.05.12
["plank_zy_side()",                   "4",                "pzy_side_length", "plank1_width", "plank_thickness"],
["plank_yz_middle_bottom()",          "(wardrobe_n-1)",   "pyz_middle_length", "plank1_width", "plank_thickness"],
["plank_yz_middle_top()",             "(wardrobe_n-1)",   "pyz_middle_length", "plank2_width", "plank_thickness"],
["plank_zy_middle()",                 "(2*wardrobe_n-2)", "pzy_middle_length", "plank2_width", "plank_thickness"],
["plank_xy_bottom(wardrobe_n)",       "2",                "wardrobe_n*module_width-2*pxy_sub_half_length", "plank_xy_width", "plank_thickness"],
["plank_xy_top(wardrobe_n)",          "2",                "wardrobe_n*module_width-2*pxy_sub_half_length", "plank_xy_width", "plank_thickness"],
["plank_yx_side_bottom()",            "2",                "pyx_length", "plank_yx_width", "plank_thickness"],
["plank_yx_side_top()",               "2",                "pyx_length", "plank_yx_width", "plank_thickness"],
["plank_yx_middle_bottom()",          "(wardrobe_n-1)",   "pyx_length", "plank_yx_width", "plank_thickness"],
["plank_yx_middle_top()",             "(wardrobe_n-1)",   "pyx_length", "plank_yx_width", "plank_thickness"]]
slab_list=[
["slab_horizontal(wardrobe_n, 1)",    "(wardrobe_n==1?2:4)",    "prepare_horizontal_side_w1",       "slab_horizontal_width2",   "slab_thickness"],
["slab_horizontal(wardrobe_n, 2)",    "(2*wardrobe_n-4)",       "prepare_horizontal_middle_w1",     "slab_horizontal_width2",   "slab_thickness"],
["slab_side()",                       "2",                      "slab_vertical_side_width1",        "slab_vertical_width2",     "slab_thickness"],
["slab_rear(wardrobe_n,1)",           "(wardrobe_n==1?1:2)",    "prepare_vertical_side_w1",         "slab_vertical_width2",     "slab_thickness"],
["slab_rear(wardrobe_n,2)",           "(wardrobe_n-2)",         "prepare_vertical_middle_w1",       "slab_vertical_width2",     "slab_thickness"]]



# openscad command line options
openscad_options_for_assembly="-D wardrobe_n=%d -D cutting_edge=-1 -D break_view_length=0"%(mw_args.sw_module_length_number)
openscad_options_for_assembly_with_exagerated_cut="-D wardrobe_n=%d -D cutting_edge=2 -D break_view_length=0"%(mw_args.sw_module_length_number)
openscad_options_for_break_view="-D wardrobe_n=%d -D cutting_edge=2 -D break_view_length=200"%(mw_args.sw_module_length_number)
openscad_options_for_planks="-D wardrobe_n=%d -D cutting_edge=0 -D break_view_length=0"%(mw_args.sw_module_length_number)

# openscad command files
ocf_assembly="""
// ocf_assembly.scad
// generated on %s by %s
//use <../src/wardrobe.scad>;
include <../src/wardrobe.scad>;
echo("break_view_length", break_view_length);
wardrobe(wardrobe_n);
""" % (datetime.now(),sys.argv[0])

ocf_assembly_plan="""
// ocf_assembly_plan.scad
// generated on %s by %s
//use <../src/wardrobe.scad>;
include <../src/wardrobe.scad>;
wardrobe_plan();
""" % (datetime.now(),sys.argv[0])

ocf_plank_definition="""
include <../src/wardrobe.scad>;
{plank_name};
"""

ocf_plank_definition_dxf="""
include <../src/wardrobe.scad>;
l_z_list = [0.1,5,10,15,20,25,27];
l_plank1_y_list = [0.1,10,20,30,40,50,60,70,80,90,97];
l_plank2_y_list = [0.1,10,20,30,40,47];
l_x_list_null = [1];
plank_projection(l_z_list, l_plank1_y_list, l_x_list_null, {plank_length}, {plank_width}, {plank_thickness})
{plank_name};
echo("plank_length:", {plank_length});
echo("plank_width:", {plank_width});
echo("plank_thickness:", {plank_thickness});
echo("plank_number:", {plank_number});
"""

ocf_cnc_plank_batch="""
include <../src/wardrobe.scad>;
cnc_plank_batch();
"""

ocf_cnc_plank_batch_dxf="""
include <../src/wardrobe.scad>;
projection(cut=false) cnc_plank_batch();
"""

ocf_cnc_slab_batch="""
include <../src/wardrobe.scad>;
cnc_slab_batch();
"""

ocf_cnc_slab_batch_dxf="""
include <../src/wardrobe.scad>;
projection(cut=false) cnc_slab_batch();
"""

ocf_plank_info="""
include <../src/wardrobe.scad>;
prepare_horizontal_side_w1 = module_width-(wardrobe_n==1?slab_horizontal_sub_width1_side:slab_horizontal_sub_width1_middle)-slab_horizontal_sub_width1_side;
prepare_horizontal_middle_w1 = module_width-2*slab_horizontal_sub_width1_middle;
prepare_vertical_side_w1 = module_width-(wardrobe_n==1?slab_vertical_rear_side_sub_width1:slab_vertical_rear_middle_sub_width1)-slab_vertical_rear_side_sub_width1;
prepare_vertical_middle_w1 = module_width-2*slab_vertical_rear_middle_sub_width1;
echo("plank_name: {plank_short_name}");
echo("plank_length:", {plank_length});
echo("plank_width:", {plank_width});
echo("plank_thickness:", {plank_thickness});
echo("plank_number:", {plank_number});
{plank_name};
"""

## check openscad_command_file
#print ocf_assembly
#print ocf_plank_definition.format(plank_name=plank_list[0][0])
#print ocf_plank_definition_dxf.format(plank_name=plank_list[0][0], plank_number=plank_list[0][1],  plank_length=plank_list[0][2],  plank_width=plank_list[0][3],  plank_thickness=plank_list[0][4])

# run openscad

if mw_args.sw_draw_all:
  mw_args.sw_draw_assembly=True
  mw_args.sw_draw_planks=True
  mw_args.sw_draw_cnc_batch=True
  mw_args.sw_plank_info=True

if mw_args.sw_draw_assembly:
  print "Draw assembly"
  # wardrobe assembly
  l_drawing_name="wardrobe_%d_assembly"%(mw_args.sw_module_length_number)
  l_f_ocf_stl="%s/%s_stl.scad"%(output_dir,l_drawing_name)
  l_ocf_stl=ocf_assembly
  l_openscad_options=openscad_options_for_assembly
  l_f_output_stl="%s/%s.stl"%(output_dir,l_drawing_name)
  call_openscad(l_ocf_stl, l_f_ocf_stl, l_openscad_options, l_f_output_stl)
  # wardrobe assembly with exagerated cut
  l_drawing_name="wardrobe_%d_assembly_with_exagerated_cut"%(mw_args.sw_module_length_number)
  l_f_ocf_stl="%s/%s_stl.scad"%(output_dir,l_drawing_name)
  l_ocf_stl=ocf_assembly
  l_openscad_options=openscad_options_for_assembly_with_exagerated_cut
  l_f_output_stl="%s/%s.stl"%(output_dir,l_drawing_name)
  call_openscad(l_ocf_stl, l_f_ocf_stl, l_openscad_options, l_f_output_stl)
  # wardrobe assembly break view
  l_drawing_name="wardrobe_%d_assembly_break_view"%(mw_args.sw_module_length_number)
  l_f_ocf_stl="%s/%s_stl.scad"%(output_dir,l_drawing_name)
  l_ocf_stl=ocf_assembly
  l_openscad_options=openscad_options_for_break_view
  l_f_output_stl="%s/%s.stl"%(output_dir,l_drawing_name)
  call_openscad(l_ocf_stl, l_f_ocf_stl, l_openscad_options, l_f_output_stl)
  # wardrobe assembly dxf plan # crash with OpenSCAD version 2012.05.12
  l_drawing_name="wardrobe_%d_assembly_plan"%(mw_args.sw_module_length_number)
  l_f_ocf_dxf="%s/%s_dxf.scad"%(output_dir,l_drawing_name)
  l_ocf_dxf=ocf_assembly_plan
  l_openscad_options=openscad_options_for_assembly_with_exagerated_cut
  l_f_output_dxf="%s/%s.dxf"%(output_dir,l_drawing_name)
  call_openscad(l_ocf_dxf, l_f_ocf_dxf, l_openscad_options, l_f_output_dxf)
  print "End of draw assembly"

if mw_args.sw_draw_planks:
  print "Draw planks"
  for i in range(len(plank_list)):
  #for i in range(2):
    l_plank_name=re.sub("\(.*$","",plank_list[i][0])
    l_f_ocf_stl="%s/%s_stl.scad"%(output_dir,l_plank_name)
    l_ocf_stl=ocf_plank_definition.format(plank_name=plank_list[i][0])
    l_openscad_options=openscad_options_for_planks
    l_f_output_stl="%s/%s.stl"%(output_dir,l_plank_name)
    call_openscad(l_ocf_stl, l_f_ocf_stl, l_openscad_options, l_f_output_stl)
    l_f_ocf_dxf="%s/%s_dxf.scad"%(output_dir,l_plank_name)
    l_ocf_dxf=ocf_plank_definition_dxf.format(plank_name=plank_list[i][0], plank_number=plank_list[i][1],  plank_length=plank_list[i][2],  plank_width=plank_list[i][3],  plank_thickness=plank_list[i][4])
    l_f_output_dxf="%s/%s.dxf"%(output_dir,l_plank_name)
    call_openscad(l_ocf_dxf, l_f_ocf_dxf, l_openscad_options, l_f_output_dxf)
  print "End of draw planks"

if mw_args.sw_draw_cnc_batch:
  print "Draw cnc batch"
  # cnc plank batch
  l_cnc_batch_name="cnc_plank_batch"
  l_f_ocf_stl="%s/%s_stl.scad"%(output_dir,l_cnc_batch_name)
  l_ocf_stl=ocf_cnc_plank_batch
  l_openscad_options=openscad_options_for_planks
  l_f_output_stl="%s/%s.stl"%(output_dir,l_cnc_batch_name)
  call_openscad(l_ocf_stl, l_f_ocf_stl, l_openscad_options, l_f_output_stl)
  l_f_ocf_dxf="%s/%s_dxf.scad"%(output_dir,l_cnc_batch_name)
  l_ocf_dxf=ocf_cnc_plank_batch_dxf
  l_f_output_dxf="%s/%s.dxf"%(output_dir,l_cnc_batch_name)
  call_openscad(l_ocf_dxf, l_f_ocf_dxf, l_openscad_options, l_f_output_dxf)
  l_cnc_batch_name="cnc_plank_batch"
  # cnc slab batch
  l_cnc_batch_name="cnc_slab_batch"
  l_f_ocf_stl="%s/%s_stl.scad"%(output_dir,l_cnc_batch_name)
  l_ocf_stl=ocf_cnc_slab_batch
  l_openscad_options=openscad_options_for_planks
  l_f_output_stl="%s/%s.stl"%(output_dir,l_cnc_batch_name)
  call_openscad(l_ocf_stl, l_f_ocf_stl, l_openscad_options, l_f_output_stl)
  l_f_ocf_dxf="%s/%s_dxf.scad"%(output_dir,l_cnc_batch_name)
  l_ocf_dxf=ocf_cnc_slab_batch_dxf
  l_f_output_dxf="%s/%s.dxf"%(output_dir,l_cnc_batch_name)
  call_openscad(l_ocf_dxf, l_f_ocf_dxf, l_openscad_options, l_f_output_dxf)
  print "End of draw cnc batch"

def extract_plank_info(a_plank_list):
  l_plank_info=[]
  for i in range(len(a_plank_list)):
  #for i in range(2):
    l_plank_name=re.sub("\(.*$","",a_plank_list[i][0])
    l_f_ocf_info="%s/%s_info.scad"%(output_dir,l_plank_name)
    l_f_output="%s/%s_info.stl"%(output_dir,l_plank_name)
    l_ocf_info=ocf_plank_info.format(plank_name=a_plank_list[i][0], plank_short_name=l_plank_name, plank_number=a_plank_list[i][1],  plank_length=a_plank_list[i][2],  plank_width=a_plank_list[i][3],  plank_thickness=a_plank_list[i][4])
    l_openscad_options=openscad_options_for_planks
    call_openscad_for_info(l_ocf_info, l_f_ocf_info, l_openscad_options, l_f_output, l_plank_info)
  l_plank_type_nb=0
  l_plank_nb=0
  l_linear={}
  a_output_txt=""
  for i in range(len(l_plank_info)):
    #print "dbg225:", l_plank_info[i]
    l_one_plank_info="%5d %5d %5d \t%2d \t%s"%(l_plank_info[i][1], l_plank_info[i][2], l_plank_info[i][3], l_plank_info[i][4], l_plank_info[i][0])
    a_output_txt+="plank_info_%02d: %s\n"%(i+1, l_one_plank_info)
    if l_plank_info[i][4]>0:
      l_plank_type_nb+=1
    l_plank_nb+=l_plank_info[i][4]
    #print "dbg412:", i, l_plank_nb
    if l_linear.has_key(l_plank_info[i][2]):
      l_linear[l_plank_info[i][2]]+=l_plank_info[i][1]
    else:
      l_linear[l_plank_info[i][2]]=l_plank_info[i][1]
  #a_output_txt+="\nNumber of types of planks: %d\n"%(len(a_plank_list))
  a_output_txt+="\nNumber of types of planks: %d\n"%(l_plank_type_nb)
  a_output_txt+="Number of planks: %d\n"%(l_plank_nb)
  a_output_txt+="linear per width:\n"
  for i in l_linear.keys():
    a_output_txt+=" %6d : %6d\n"%(i, l_linear[i])
  return(a_output_txt)

if mw_args.sw_plank_info:
  print "Information on required planks and plywood slabs:"
  l_plank_and_slab_count=""
  l_plank_and_slab_count+="solid plank info:\n"
  l_plank_and_slab_count+=extract_plank_info(plank_list)
  l_plank_and_slab_count+="plywood slab info:\n"
  l_plank_and_slab_count+=extract_plank_info(slab_list)
  print l_plank_and_slab_count
  fh_plank_info = open("%s/plank_info.txt"%output_dir, 'w')
  fh_plank_info.write(l_plank_and_slab_count)
  fh_plank_info.close()
  print "End of plank information"

print("End of the script %s"%(sys.argv[0]))



