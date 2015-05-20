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
chr=$1
remain="/home/zhangxi/Document/LOG/chr$chr.ind.txt"
if [ -e "$remain" ];then
	rm $remain
fi
if [ -e "$process" ];then
	rm $process
fi
for ind in `ls $root | grep '^WGC'` 
do
	pe1_fastq="$root/$ind/$ind.chr$chr.pe1.fastq.gz"
	pe2_fastq="$root/$ind/$ind.chr$chr.pe2.fastq.gz"
	binname="$root/$ind/$ind.chr$chr.uncleaned.q20.k31.ctx"
	if [ ! -e "$pe1_fastq" ];then
		echo "$ind chr$chr fastq didn't exist" >> $process
	fi
	if [ ! -e "$binname" ] && [ -e $pe1_fastq ];then
		echo "$ind chr$chr fastq exist but $ind chr$chr ctx didn't" >> $process
		echo "$ind" >> $remain
	fi
done
	


