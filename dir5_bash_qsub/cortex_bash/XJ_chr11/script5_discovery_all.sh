#!/bin/bash - 
#===============================================================================
#
#          FILE: script5_discovery_all.sh
# 
#         USAGE: ./script5_discovery_all.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 02/09/2015 16:06
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"


pool_dir="/picb/humpopg-bigdata/zhangxi/cortex_pool"


kmer=31
chr=22
pop="xinjiang"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c2"
mem_height=25
mem_width=120
T=30
pop="xinjiang"
quality=20
outdir="${pool_dir}/XJ_chr$chr/all"
bubbles="$outdir/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T"

ref_dir="/picb/humpopg-bigdata/zhangxi/bundle/ref_split_chromosome"
ref="${ref_dir}/human_g1k_v37_chr$chr.k31.ctx"
ref_list="${outdir}/ref_bianry_list"
echo "$ref" > ${ref_list}

cleaned_pool="${pool_dir}/XJ_chr$chr/$pop.chr$chr.merged_clean_subpools_bin.k$kmer.q$quality.ctx"
pool_list="${pool_dir}/XJ_chr$chr/$pop.chr$chr.merged_clean_subpools_bin.k$kmer.q$quality.list"
colour_list="${pool_dir}/XJ_chr$chr/all/$pop.chr$chr.k$kmer.q$quality.thresh$T.for_discovery.colourlist"
echo "${cleaned_pool}" > ${pool_list}
echo "${ref_list}" > ${colour_list}
echo "${pool_list}" >> ${colour_list}
log="${bubbles}.log"

$ctx_binary --kmer_size $kmer --mem_height $mem_height --mem_width $mem_width --colour_list $colour_list --detect_bubbles1 1/1 --output_bubbles1 $bubbles --exclude_ref_bubbles --ref_colour 0 > $log 2>&1


