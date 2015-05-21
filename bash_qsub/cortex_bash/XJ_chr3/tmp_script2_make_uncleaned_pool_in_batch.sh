#!/bin/bash - 
#===============================================================================
#
#          FILE: script2_tmp_tmp_batch1_make_uncleaned_pool.sh
# 
#         USAGE: ./script2_tmp_tmp_batch1_make_uncleaned_pool.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 04/04/2015 16:37
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"


root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
kmer=31
height=25
width=150
pop="xinjiang"
quality=20
chr=3
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
bin_list="$pool/XJ_chr$chr/$pop.chr$chr.uncleaned.bin.q$quality.list"
colorlist="$pool/XJ_chr$chr/$pop.chr$chr.q$quality.colorlist"
for((i=1;i<=2;i++));do
	tmp_batch_dir="$pool/XJ_chr$chr/tmp_batch$i"
	if [ ! -e "${tmp_batch_dir}" ];then
		mkdir ${tmp_batch_dir}
	fi
	tmp_batch_list="${tmp_batch_dir}/xinjiang.chr$chr.uncleaned.bin.tmp_batch$i.q$quality.list"
	tmp_batch_colorlist="${tmp_batch_dir}/xinjiang.chr$chr.uncleaned_bin.tmp_batch$i.q$quality.colorlist"
	m=`expr 7 \* $i - 6`
	n=`expr 7 \* $i `
	#sed_command="sed -n "$m,$n""
	echo "cat $bin_list | sed -n -e '$m,$[n]p' > $tmp_batch_list" | sh 
	echo $tmp_batch_list > $tmp_batch_colorlist
	tmp_batch_merged_pool_bin="${tmp_batch_dir}/$pop.chr$chr.merged.uncleaned.k$kmer.tmp_batch$i.q$quality.ctx"
	if [ -e "${tmp_batch_merged_pool_bin}" ];then
		continue
	fi
	tmp_batch_merged_pool_cov_distrib="${tmp_batch_merged_pool_bin}.covg"
	tmp_batch_log="${tmp_batch_merged_pool_bin}.log"
	echo "$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list $tmp_batch_colorlist --dump_binary $tmp_batch_merged_pool_bin --dump_covg_distribution $tmp_batch_merged_pool_cov_distrib > $tmp_batch_log 2>&1" 
	$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --colour_list $tmp_batch_colorlist --dump_binary $tmp_batch_merged_pool_bin --dump_covg_distribution $tmp_batch_merged_pool_cov_distrib > $tmp_batch_log 2>&1
done



