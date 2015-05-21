#!/bin/bash - 
#===============================================================================
#
#          FILE: script2_make_uncleaned_pool.sh
# 
#         USAGE: ./script2_make_uncleaned_pool.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 02/09/2015 14:04
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/cortex_chr22.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
chr=22
kmer=31
height=25
width=150
pop="xinjiang"
quality=20
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool/XJ_chr$chr"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
bin_list="$pool/$pop.chr$chr.all_uncleaned_bin.q$quality.list"
colorlist="$pool/$pop.chr$chr.all_uncleaned_bin.q$quality.colorlist"
rm $bin_list



for ind in `ls $root | grep '^WGC'` 
do
	binname="$root/$ind/$ind.chr$chr.uncleaned.q$quality.k31.ctx"
	if [ ! -e "$binname" ];then
		echo "$ind chr$chr ctx didn't exist" >> $process
	exit 0
	fi
	if [ -e "$bin_list" ];then
		echo "$binname" >> $bin_list
	else
		echo "$binname" > $bin_list
	fi
done

echo "$bin_list" >  $colorlist
merged_pool_bin="$pool/$pop.chr$chr.merged.uncleaned.k$kmer.q$quality.ctx"
merged_pool_cov_distrib="${merged_pool_bin}.covg"
log="${merged_pool_bin}.log"

$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list $colorlist --dump_binary $merged_pool_bin --dump_covg_distribution $merged_pool_cov_distrib > $log 2>&1


