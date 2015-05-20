#!/bin/bash - 
#===============================================================================
#
#          FILE: script4_clean_the_pool.sh
# 
#         USAGE: ./script4_clean_the_pool.sh 
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
height=50
width=300
pop="xinjiang"
ctx_binary="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"

$ctx_binary --mer_size $kmer --mem_height $height --mem_width $width --multicolor_bin 
