#!/bin/bash - 
#===============================================================================
#
#          FILE: tmp_script4_get_ctx_miss.sh
# 
#         USAGE: ./tmp_script4_get_ctx_miss.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/28/2015 13:57
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
process="/home/zhangxi/Document/LOG/ctx_miss.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
chr=1
for ind in `ls $root | grep '^WGC'` 
do
	pe1_fastq="$root/$ind/$ind.chr$chr.pe1.fastq.gz"
	pe2_fastq="$root/$ind/$ind.chr$chr.pe2.fastq.gz"
	binname="$root/$ind/$ind.chr$chr.uncleaned.q20.k31.ctx"
	if [ ! -e "$binname" ] ;then
		echo "$ind chr$chr ctx didn't exist" >> $process
	fi
done
	




