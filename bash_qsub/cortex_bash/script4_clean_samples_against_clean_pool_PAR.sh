#!/bin/bash - 
#===============================================================================
#
#          FILE: script4_clean_samples_against_clean_pool_PAR.sh
# 
#         USAGE: ./script4_clean_samples_against_clean_pool_PAR.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/20/2015 18:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"

chr=22
pop="xinjiang"
kmer=31
height=25
width=150
batch=1
quality=20
T=30

pool="/picb/humpopg-bigdata/zhangxi/cortex_pool/XJ_chr$chr"
cleaned_pool="$pool/xinjiang.chr$chr.merged.cleaned_pool.k$kmer.batch$batch.q$quality.thresh$T.ctx"

batch_list="$pool/$pop.chr$chr.uncleaned.bin.batch$batch.q$quality.list"
col_list="$pool/batch$batch/$pop.chr$chr.batch$batch.colourlist_for_clean"
if [ -e "$col_list" ];then
	rm $col_list
fi
if [ ! -e "$pool/batch$batch" ];then
	mkdir $pool/batch$batch
fi
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c2"
cat ${batch_list} | while read line
do
	ind=`echo $line | awk -F '/' '{print $6}'`
	if [ ! -e "$pool/batch$batch/$ind" ];then
		mkdir $pool/batch$batch/$ind
	fi
	list_this_binary="$pool/batch$batch/$ind/$ind.chr$chr.filelist"
	echo $line > $list_this_binary
	echo $list_this_binary >> $col_list
done

thresh=20  
log="${col_list}.log"
suffix="clean".$T
$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width  --multicolour_bin $cleaned_pool --colour_list $col_list --load_colours_only_where_overlap_clean_colour 0 --successively_dump_cleaned_colours $suffix > $log 2>&1

