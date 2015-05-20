#!/bin/bash - 
#===============================================================================
#
#          FILE: script4_clean_samples_against_clean_pool_PAR_in_batch.sh
# 
#         USAGE: ./script4_clean_samples_against_clean_pool_PAR_in_batch.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/23/2015 17:49
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"

chr=22
pop="xinjiang"
kmer=31
height=25
width=150
batch=1
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
thresh=20  
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c2"
for((i=1;i<=4;i++));do
	batch_list="$pool/XJ_chr$chr/xinjiang.chr$chr.uncleaned.bin.batch$i.q$quality.list"
	batch_colorlist="$pool/XJ_chr$chr/xinjiang.chr$chr.uncleaned_bin.batch$i.q$quality.colorlist"
	batch_merged_pool_bin="$pool/XJ_chr$chr/$pop.chr$chr.merged.uncleaned.k$kmer.batch$i.q$quality.ctx"
	batch_cleaned_pool_bin="$pool/XJ_chr$chr/$pop.chr$chr.merged.cleaned_pool.k$kmer.batch$i.q$quality.thresh$T.ctx"
	batch_col_list="$pool/$pop.chr$chr.batch$i.q$quality.colourlist_for_clean"
	if [ -e "$batch_col_list" ];then
		rm $batch_col_list
	fi
	cat ${$batch_list} while read line
	do
		ind=`echo $line | awk -F '/' '{print $6}'`
		list_this_binary="$root/$ind/$ind.chr$chr.filelist"
		echo $line > $list_this_binary
		echo $list_this_binary > $batch_col_list
	done
	log="${batch_col_list}.log"
	suffix="clean".$thresh
	$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width  --multicolour_bin $batch_cleaned_pool_bin --colour_list $batch_col_list --load_colours_only_where_overlap_clean_colour 0 --successively_dump_cleaned_clours $suffix > $log 2>&1
done



