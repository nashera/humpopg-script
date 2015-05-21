#!/bin/bash - 
#===============================================================================
#
#          FILE: tmp_script2_make_uncleaned_pool_list1.sh
# 
#         USAGE: ./tmp_script2_make_uncleaned_pool_list1.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/13/2015 02:04
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
list1=/home/zhangxi/Document/script/bash_qsub/cortex_bash/XJ_chr22/list1
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"

chr=22
kmer=31
height=25
width=150
pop="xinjiang"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
bin_list="$pool/XJ_chr$chr/$pop.chr$chr.uncleaned.bin.list1"

