#!/bin/bash - 
#===============================================================================
#
#          FILE: script2_merge_batch_pool.sh
# 
#         USAGE: ./script2_merge_batch_pool.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/25/2015 22:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
chr=22
kmer=31
height=25
width=180
pop="xinjiang"
T=30
quality=30

ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"

for((i=1;i<=4;i++));do
	batch_cleaned_pool_bin="$pool/XJ_chr$chr/batch$i/$pop.chr$chr.merged.cleaned_pool.k$kmer.batch$i.q$quality.thresh$T.ctx"
	$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --health_check --multicolour_bin $batch_merged_pool_bin --remove_low_coverage_supernodes $T --dump_binary  $batch_cleaned_pool_bin  >$batch_log 2>&1
done
