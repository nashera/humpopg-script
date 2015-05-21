#!/bin/bash - 
#===============================================================================
#
#          FILE: script1_make_list.sh
# 
#         USAGE: ./script1_make_list.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 02/08/2015 20:47
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
chr=19
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
kmer=31
height=25
width=150
quality=20
process="/home/zhangxi/Document/LOG/cortex.make.uncleaned.bin.chr${chr}_process.txt"
for ind in `ls $root | grep '^WGC'` 
do 
	echo $ind
	pe1_fastq="$root/$ind/$ind.chr$chr.pe1.fastq.gz"
	pe2_fastq="$root/$ind/$ind.chr$chr.pe2.fastq.gz"
	pe1_list="$root/$ind/$ind.chr$chr.pe1.list"
	pe2_list="$root/$ind/$ind.chr$chr.pe2.list"

	binname="$root/$ind/$ind.chr$chr.uncleaned.q$quality.k31.ctx"
	log="$binname.log"
	if [ -e "$binname" ];then
	continue
	fi
	if [ -e "$log" ];then
	rm $log
	fi
	if [ -e "$pe1_fastq" ] && [ -e "$pe2_fastq" ];then
		echo $pe1_fastq > $pe1_list
		echo $pe2_fastq > $pe2_list
	fi
	$ctx_binary --kmer_size $kmer --sample_id $ind --mem_height $height --mem_width $width --pe_list $pe1_list,$pe2_list --quality_score_threshold $quality --dump_binary $binname --remove_pcr_duplicates >$log 2>&1
	if [ -e "$process" ];then
		echo "$binname finished" >> $process
	else
		echo "$binname finished" > $process
	fi
done

