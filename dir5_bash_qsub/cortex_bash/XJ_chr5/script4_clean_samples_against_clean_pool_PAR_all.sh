#!/bin/bash - 
#===============================================================================
#
#          FILE: script4_clean_samples_against_clean_pool_PAR_all.sh
# 
#         USAGE: ./script4_clean_samples_against_clean_pool_PAR_all.sh 
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

chr=5
pop="xinjiang"
kmer=31
height=25
width=150
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
T=30  
quality=20
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c2"
all_list="$pool/XJ_chr$chr/$pop.chr$chr.uncleaned.bin.q$quality.list"
cleaned_pool_bin="$pool/XJ_chr$chr/$pop.chr$chr.merged_clean_subpools_bin.k$kmer.q$quality.ctx"
all_col_list="$pool/XJ_chr$chr/$pop.chr$chr.q$quality.for_clean_samples.colourlist"
if [ -e "$all_col_list" ];then
	rm $all_col_list
fi
cat ${all_list} |  while read line
do
	ind=`echo $line | awk -F '/' '{print $6}'`
	if [ ! -e "$pool/XJ_chr$chr/all/$ind" ];then
		mkdir $pool/XJ_chr$chr/all/$ind
	fi
	list_this_binary="$pool/XJ_chr$chr/all/$ind/$ind.chr$chr.k$kmer.q$quality.bin"
	echo $line > $list_this_binary
	echo $list_this_binary >> $all_col_list
done
log="${all_col_list}.log"
suffix="cleaned".thresh$T
$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width  --multicolour_bin $cleaned_pool_bin --colour_list $all_col_list --load_colours_only_where_overlap_clean_colour 0 --successively_dump_cleaned_colours $suffix > $log 2>&1



