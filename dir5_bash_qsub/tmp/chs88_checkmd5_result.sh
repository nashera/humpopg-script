#!/bin/bash - 
#===============================================================================
#
#          FILE: chs88_checkmd5_result.sh
# 
#         USAGE: ./chs88_checkmd5_result.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/10/2015 14:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
result="/home/zhangxi/Document/result/md5_check.txt"

root="/picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz"
collection=("32N" "30N" "29N" "276N" "274N" "273N" "272N" "26N" "268N" "267N" "266N" "262N" "261N" "260N") 
for ind in ${collection[@]}
do 
	value="$root/$ind/check_value.txt"
	echo $ind >> $result
	cat $value >> $result
done



