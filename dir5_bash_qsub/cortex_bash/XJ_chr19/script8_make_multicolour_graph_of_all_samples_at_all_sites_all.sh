#!/bin/bash - 
#===============================================================================
#
#          FILE: script8_make_multicolour_graph_of_all_samples_at_all_sites.sh
# 
#         USAGE: ./script8_make_multicolour_graph_of_all_samples_at_all_sites.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/24/2015 10:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
pop="xinjiang"
chr=22
kmer=31
height=50
width=200
quality=20
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
pool_chr_dir="$pool/XJ_chr$chr"
pool_chr_all="${pool_chr_dir}/all"
ref_dir="/picb/humpopg-bigdata/zhangxi/bundle"
ref_overlap_bubble="${pool_chr_all}/ref_binary_list_${pop}_chr${chr}_all_intersect_bubbles.ctx"
list_ref_overlap_bubble="${pool_chr_all}/ref_binary_list_${pop}_chr${chr}_all_intersect_bubbles.ctx.list"
echo "${ref_overlap_bubble}"  > ${list_ref_overlap_bubble}
pop="xinjiang"
T=30
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c121"
ref_and_sample_overlapping_bubbles="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.thresh$T.ref_then_samples_overlapping_bubbles.colourlist"
if [ -e "${ref_and_sample_overlapping_bubbles}" ];then
	rm ${ref_and_sample_overlapping_bubbles}
fi
echo "${list_ref_overlap_bubble}" > ${ref_and_sample_overlapping_bubbles}

for ind in `ls ${pool_chr_all} | grep "^WGC"`
do
	sample_overlap_bubble="${pool_chr_all}/$ind/$ind.chr$chr.k$kmer.q$quality.bin_cleaned.thresh$T.ctx.list_intersect_bubbles_thresh$T.ctx"
	echo "${sample_overlap_bubble}"
	if [ ! -e "${sample_overlap_bubble}" ];then
		echo "the overlap bubble of $ind did't exist"
	fi
	list_sample_overlap_bubbles="${pool_chr_all}/$ind/$ind.chr$chr.q$quality.thresh$T.sample_overlap_bubbles.list"
	
	echo "${sample_overlap_bubble}" >  ${list_sample_overlap_bubbles}
	echo "${list_sample_overlap_bubbles}" >>  ${ref_and_sample_overlapping_bubbles}
done
multicol_ref_samples_overlap_bubbles="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.thresh$T.multicol_ref_samples_overlap_bubbles.ctx"
log="${multicol_ref_samples_overlap_bubbles}.log"
$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list ${ref_and_sample_overlapping_bubbles} --dump_binary ${multicol_ref_samples_overlap_bubbles} > $log 2>&1
