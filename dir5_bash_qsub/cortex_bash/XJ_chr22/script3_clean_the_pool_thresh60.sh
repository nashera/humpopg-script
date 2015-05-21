#!/bin/bash - 
#===============================================================================
#
#          FILE: script3_clean_the_pool.sh
# 
#         USAGE: ./script3_clean_the_pool.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/20/2015 16:51
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
T=60
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
merged_pool_bin="$pool/XJ_chr$chr/$pop.chr$chr.batch1.merged.uncleaned.k$kmer.q10.ctx"
cleaned_pool_bin="$pool/XJ_chr$chr/$pop.chr$chr.batch1.merged.cleaned_pool.thresh$T.k$kmer.q10.ctx"
log="${cleaned_pool_bin}.log"

$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --health_check --multicolour_bin $merged_pool_bin --remove_low_coverage_supernodes $T --dump_binary  $cleaned_pool_bin  >$log 2>&1
