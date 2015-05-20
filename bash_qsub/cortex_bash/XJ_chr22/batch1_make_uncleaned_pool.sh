#!/bin/bash - 
#===============================================================================
#
#          FILE: batch1_make_uncleaned_pool.sh
# 
#         USAGE: ./batch1_make_uncleaned_pool.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/20/2015 11:33
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool/XJ_chr22"
chr=22
pop="xinjiang"
kmer=31
height=25
width=150
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
colorlist="/picb/humpopg-bigdata/zhangxi/cortex_pool/XJ_chr22/xinjiang.chr22.batch1.colorlist"
merged_pool_bin="$pool/$pop.chr$chr.batch1.merged.uncleaned.k$kmer.q10.ctx"
merged_pool_cov_distrib="${merged_pool_bin}.covg"
log="${merged_pool_bin}.log"

$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list $colorlist --dump_binary $merged_pool_bin --dump_covg_distribution $merged_pool_cov_distrib > $log 2>&1



