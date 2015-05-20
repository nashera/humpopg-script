#!/bin/bash - 
#===============================================================================
#
#          FILE: script3_make_cleaned_pool.sh
# 
#         USAGE: ./script3_make_cleaned_pool.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 02/09/2015 15:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"

pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
chr=22
kmer=31
height=25
width=150
pop="xinjiang"
T=6

merged_pool_uncleaned_bin="$pool/$pop.chr$chr.merged.uncleaned.k$kmer.q10.ctx"
merged_pool_cleaned_bin="$pool/$pop.chr$chr.merged.cleaned.k$kmer.thresh$T.ctx"
$log="$pool/$pop.chr$chr.thresh$T.output.clean.pool.log"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --multicolour_bin $merged_pool_uncleaned_bin --remove_low_coverage_supernodes $T --dump_binary $merged_cleaned_pool_bin > $log 2>&1
