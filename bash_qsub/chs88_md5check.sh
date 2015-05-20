#!/bin/bash - 
#===============================================================================
#
#          FILE: chs88_md5check.sh
# 
#         USAGE: ./chs88_md5check.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/09/2015 19:58
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
root="/picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz"
collection=("35N" "34N" "32N" "30N" "29N" "276N" "274N" "273N" "272N" "26N" "268N" "267N" "266N" "262N" "261N" "260N") 
for ind in ${collection[@]}
do
	list=`ls $root/$ind | grep '^md5check'`
	value="$root/$ind/check_value.txt"
	if [ -e "$value" ];then
		rm -rf $value
	fi
	cd $root/$ind
	md5sum -c $list > $value 2>&1 
done
	

