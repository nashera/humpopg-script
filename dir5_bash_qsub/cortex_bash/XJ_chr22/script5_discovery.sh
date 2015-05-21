#!/bin/bash - 
#===============================================================================
#
#          FILE: script5_discovery.sh
# 
#         USAGE: ./script5_discovery.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/20/2015 20:04
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
T=30
quality=20
cleaned_pool=""
outdir=
pool_dir="/picb/humpopg-bigdata/zhangxi/cortex_pool/XJ_chr$chr"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c2"
ref="/picb/humpopg-bigdata/zhangxi/bundle/human_g1k_v37.proper_chroms.k31.ctx"
colour_list=
ref_list="${pool_dir}/"
pool_list=

