#!/bin/bash - 
#===============================================================================
#
#          FILE: script2_make_uncleaned_pool_list_in_batch.q20.sh
# 
#         USAGE: ./script2_make_uncleaned_pool_list_in_batch.q20.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/23/2015 15:00
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/chr22_batch_cortex_make_unclean_bin_q20.txt"
if [ -e "$process" ];then
	rm $process
fi

root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
chr=22
kmer=31
height=25
width=150
pop="xinjiang"
quality=20
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
bin_list="$pool/XJ_chr$chr/$pop.chr$chr.all_uncleaned_bin.q$quality.list"
colorlist="$pool/XJ_chr$chr/$pop.chr$chr.all_uncleaned_bin.q$quality.colorlist"
if [ -e "$bin_list" ];then
	rm $bin_list
	rm $colorlist
fi

for ind in `ls $root | grep '^WGC'` 
do
	binname="$root/$ind/$ind.chr$chr.uncleaned.q$quality.k31.ctx"
	if [ ! -e "$binname" ];then
		echo "$ind chr$chr ctx didn't exist" >> $process
	#exit 0
	fi
	if [ -e "$bin_list" ];then
		echo "$binname" >> $bin_list
	else
		echo "$binname" > $bin_list
	fi
done
echo $bin_list > $colorlist
for((i=1;i<=4;i++));do
	batch_dir="$pool/XJ_chr$chr/batch$i"
	if [ ! -e "${batch_dir}" ];then
		mkdir ${batch_dir}
	fi
	batch_list="${batch_dir}/xinjiang.chr$chr.uncleaned.bin.batch$i.q$quality.list"
	batch_colorlist="${batch_dir}/xinjiang.chr$chr.uncleaned_bin.batch$i.q$quality.colorlist"
	m=`expr 30 \* $i - 29`
	n=`expr 30 \* $i `
	sed_command="sed -n "$m,$n""
	#echo "cat $bin_list | sed -n -e '$m,$[n]p' > $batch_list" | sh 
	#echo $batch_list > $batch_colorlist
	batch_merged_pool_bin="${batch_dir}/$pop.chr$chr.merged.uncleaned.k$kmer.batch$i.q$quality.ctx"
	batch_merged_pool_cov_distrib="${batch_merged_pool_bin}.covg"
	batch_log="${batch_merged_pool_bin}.log"
	echo "$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list $batch_colorlist --dump_binary $batch_merged_pool_bin --dump_covg_distribution $batch_merged_pool_cov_distrib > $batch_log 2>&1" 
	#$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list $batch_colorlist --dump_binary $batch_merged_pool_bin --dump_covg_distribution $batch_merged_pool_cov_distrib > $batch_log 2>&1
done



