#!/bin/bash - 
#===============================================================================
#
#          FILE: script7_intersect_cleaned_sample_with_bubbles_PAR_all.sh
# 
#         USAGE: ./script7_intersect_cleaned_sample_with_bubbles_PAR_all.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/24/2015 10:09
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c2"
mem_height=23
mem_width=100
pop="xinjiang"
kmer=31
chr=22
quality=20
T=30
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
pool_chr_dir="$pool/XJ_chr$chr"
pool_chr_all="${pool_chr_dir}/all"
cleaned_graph_colourlist="${pool_chr_all}/$pop.chr$chr.$kmer.q$quality.cleaned_bin.for_samples_intersection.colourlist"
if [ -e "${cleaned_graph_colourlist}" ];then
	rm ${cleaned_graph_colourlist}
fi

for ind in `ls ${pool_chr_all} | grep "^WGC"`
do
	sample_cleaned_graph="${pool_chr_all}/$ind/${ind}.chr$chr.k$kmer.q$quality.bin_cleaned.thresh$T.ctx"
	if [ ! -e "$sample_cleaned_graph" ];then
		echo "the cleaned graph of $ind did't exist"
	fi
	list_this_binary="${pool_chr_all}/${ind}/${ind}.chr$chr.k$kmer.q$quality.bin_cleaned.thresh$T.ctx.list"
	echo "${sample_cleaned_graph}" > ${list_this_binary}
	echo "${list_this_binary}" >> ${cleaned_graph_colourlist}
done

bubble_graph="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.bubbles_thresh$T.branches.k$kmer.ctx"



suffix="intersect_bubbles_thresh$T"
log="${cleaned_graph_colourlist}.log"

$ctx_binary --kmer_size $kmer --mem_height $mem_height --mem_width $mem_width --multicolour $bubble_graph --colour_list ${cleaned_graph_colourlist} --load_colours_only_where_overlap_clean_colour 0 --successively_dump_cleaned_colours $suffix > $log 2>&1

