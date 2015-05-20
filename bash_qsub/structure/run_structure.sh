#!/bin/bash - 
#===============================================================================
#
#          FILE: run_structure.sh
# 
#         USAGE: ./run_structure.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/29/2015 22:22
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
maparam="/picb/humpopg7/zhangxi/Austronesian/structure/mainparam_k14"
exparam=" /home/zhangxi/software/structure_kernel_src/extraparams"
stru_binary=" /home/zhangxi/software/structure_kernel_src/structure"
run_dir="/home/zhangxi/Document/run"

name=`basename $maparam`
struc_dir=$run_dir/Austro/struc/$name
if [ ! -e $struc_dir ];then
	mkdir -p $struc_dir
fi


ln -sf $stru_binary $struc_dir/structure
ln -sf $maparam $struc_dir/mainparams
ln -sf $exparam $struc_dir/extraparams
cd $struc_dir

$struc_dir/structure

