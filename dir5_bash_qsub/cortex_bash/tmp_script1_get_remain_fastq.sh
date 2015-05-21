#!/bin/bash - 
#===============================================================================
#
#          FILE: tmp_script1_get_remain_fastq.sh
# 
#         USAGE: ./tmp_script1_get_remain_fastq.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/11/2015 20:36
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/remain_fastq.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
chr=22
for ind in `ls $root | grep '^WGC'` 
do
	binname="$root/$ind/$ind.chr$chr.uncleaned.q10.k31.ctx"
	if [ ! -e "$binname" ];then
		echo "$ind chr$chr ctx didn't exist" >> $process
	fi
done
	


