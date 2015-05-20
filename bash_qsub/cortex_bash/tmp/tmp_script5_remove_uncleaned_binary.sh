#!/bin/bash - 
#===============================================================================
#
#          FILE: tmp_script5_remove_uncleaned_binary.sh
# 
#         USAGE: ./tmp_script5_remove_uncleaned_binary.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/28/2015 14:05
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
process="/home/zhangxi/Document/LOG/***.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
chr=22
for ind in `ls $root | grep '^WGC'` 
do
	binname="$root/$ind/$ind.chr$chr.uncleaned.q20.k31.ctx"
	log="$root/$ind/$ind.chr$chr.uncleaned.q20.k31.ctx.log"
	if [ -e "$binname" ] ;then
		rm -rf $binname
		rm -rf $log
	fi
done




