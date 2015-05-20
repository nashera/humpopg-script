#!/bin/bash - 
#===============================================================================
#
#          FILE: tmp_script2_re_bam_to_fastq.sh
# 
#         USAGE: ./tmp_script2_re_bam_to_fastq.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/28/2015 00:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
chr=$1
remain="/home/zhangxi/Document/LOG/chr$chr.ind.txt"

all_remain=`cat $remain`
for ind in ${all_remain[@]}
do
	echo "$ind"
	pe1_fastq="$root/$ind/$ind.chr$chr.pe1.fastq.gz"
	binname="$root/$ind/$ind.chr$chr.uncleaned.q20.k31.ctx"
	if [ -e "$binname" ];then
	rm $binname
	fi
	if [ -e "$pe1_fastq" ];then
	rm $pe1_fastq
	fi
	pe2_fastq="$root/$ind/$ind.chr$chr.pe2.fastq.gz"
	if [ -e "$pe2_fastq" ];then
	rm $pe2_fastq
	fi
done
