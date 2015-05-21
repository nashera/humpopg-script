#!/bin/bash - 
#===============================================================================
#
#          FILE: script9_genotyping.sh
# 
#         USAGE: ./script9_genotyping.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/24/2015 20:39
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"

chr=5
kmer=31
height=20
width=250
pop="xinjiang"
quality=20
T=30
ctx_binary="/home/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c121"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
pool_chr_dir="$pool/XJ_chr$chr"
pool_chr_all="${pool_chr_dir}/all"
multicol_ref_samples_overlap_bubbles="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.thresh$T.multicol_ref_samples_overlap_bubbles.ctx"
bubbles_input="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T"
bubbles_output="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T.genotyped"
log="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T.genotyped.log"

$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --multicolour_bin ${multicol_ref_samples_overlap_bubbles} --max_read_len 15000 --gt ${bubbles_input},${bubbles_output},BC --genome_size 51304566 --experiment_type EachColourADiploidSampleExceptTheRefColour  --print_colour_coverages  --estimated_error_rate 0.01 --ref_colour 0 > $log 2>&1
