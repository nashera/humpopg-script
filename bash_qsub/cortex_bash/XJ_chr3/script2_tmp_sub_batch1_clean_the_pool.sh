#!/bin/bash - 
#===============================================================================
#
#          FILE: script3_tmp_sub_batch1_clean_the_pool.sh
# 
#         USAGE: ./script3_tmp_sub_batch1_clean_the_pool.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 04/04/2015 17:12
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"

pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
chr=3
kmer=31
height=25
width=200
pop="xinjiang"
T=30
quality=20
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
for((i=1;i<=2;i++));do
	sub_batch_list="$pool/XJ_chr$chr/sub_batch$i/xinjiang.chr$chr.uncleaned.bin.sub_batch$i.q$quality.list"
	sub_batch_colorlist="$pool/XJ_chr$chr/sub_batch$i/xinjiang.chr$chr.uncleaned_bin.sub_batch$i.q$quality.colorlist"
	sub_batch_merged_pool_bin="$pool/XJ_chr$chr/sub_batch$i/$pop.chr$chr.merged.uncleaned.k$kmer.sub_batch$i.q$quality.ctx"
	sub_batch_cleaned_pool_bin="$pool/XJ_chr$chr/sub_batch$i/$pop.chr$chr.merged.cleaned_pool.k$kmer.sub_batch$i.q$quality.thresh$T.ctx"
	sub_batch_log="${sub_batch_cleaned_pool_bin}.log"
	$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --health_check --multicolour_bin $sub_batch_merged_pool_bin --remove_low_coverage_supernodes $T --dump_binary  $sub_batch_cleaned_pool_bin  >$sub_batch_log 2>&1
done


