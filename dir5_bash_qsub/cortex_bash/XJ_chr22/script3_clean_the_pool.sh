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

chr=22
kmer=31
height=25
width=300
pop="xinjiang"
T=30
quality=20
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool/XJ_chr$chr"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
merged_pool_bin="$pool/$pop.chr$chr.merged.uncleaned.k$kmer.q$quality.ctx"
cleaned_pool_bin="$pool/$pop.chr$chr.merged.cleaned_pool.k$kmer.q$quality.thresh$T.ctx"
log="${cleaned_pool_bin}.log"

$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --health_check --multicolour_bin $merged_pool_bin --remove_low_coverage_supernodes $T --dump_binary  $cleaned_pool_bin  >$log 2>&1
