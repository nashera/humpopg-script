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

chr=22
kmer=31
height=25
width=150
pop="xinjiang"
quality=20
T=30
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_63_c31"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
pool_chr_dir="$pool/XJ_chr$chr"
pool_chr_batch_dir="${pool_chr_dir}/batch$batch"

multicol_ref_samples_overlap_bubbles="${pool_chr_batch_dir}/$pop.chr$chr.batch$batch.k$kmer.q$quality.thresh$T.multicol_ref_samples_overlap_bubbles.ctx"


$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --multicolour_bin ${multi_ref_samples_overlap_bubbles} --max_read_len 15000 --gt --genome_size  --experiment_type EachColourADiploidExceptTheRefColour  --print_colour_coverages  --estimated_error_rate 0.01  -ref_colour 0 > $log 2>&1"
