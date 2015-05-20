#!/bin/bash - 
#===============================================================================
#
#          FILE: tmp_script3_remove_q10_ctx_log.sh
# 
#         USAGE: ./tmp_script3_remove_q10_ctx_log.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/28/2015 00:44
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
for ind in `ls $root | grep '^WGC'` 
do
	trash=`ls $root/$ind/ | grep 'q2.k31'`
	for file in ${trash[@]}
	do
		rm  $root/$ind/$file
	done
done


