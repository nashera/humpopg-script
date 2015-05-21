#!/bin/bash - 
#===============================================================================
#
#          FILE: script2_tmp_merge_sub_pools.sh
# 
#         USAGE: ./script2_tmp_merge_sub_pools.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 04/04/2015 18:08
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"

chr=3
kmer=31
height=25
width=180
pop="xinjiang"
T=30
quality=20

ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
list_for_merging_sub_batch_pools="$pool/XJ_chr$chr/$pop.chr$chr.k$kmer.q$quality.for_merging_sub_batch_pools.list"
if [ -e "${list_for_merging_pools}" ];then
	rm ${list_for_merging_pools}
fi

for((i=1;i<=4;i++));do
	sub_batch_cleaned_pool_bin="$pool/XJ_chr$chr/sub_batch$i/$pop.chr$chr.merged.cleaned_pool.k$kmer.sub_batch$i.q$quality.thresh$T.ctx"
	echo "${sub_batch_cleaned_pool_bin}" >>  ${list_for_merging_pools}
done
colourlist_for_merging_pools="$pool/XJ_chr$chr/$pop.chr$chr.k$kmer.q$quality.for_merging_pools.colourlist"
echo "${list_for_merging_sub_batch_pools}" > ${colourlist_for_merging_pools}
merged_all_subpools_bin="$pool/XJ_chr$chr/$pop.chr$chr.merged_clean_subpools_bin.k$kmer.q$quality.ctx"
merging_dump_covg="${merged_all_subpools_bin}.covg"
merging_dump_log="${merged_all_subpools_bin}.log"
$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list ${colourlist_for_merging_pools}  --dump_binary  ${merged_all_subpools_bin} --dump_covg_distribution ${merging_dump_covg}  --remove_low_coverage_supernodes 1 >${merging_dump_log} 2>&1

