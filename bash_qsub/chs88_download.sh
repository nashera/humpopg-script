#!/bin/bash - 
#===============================================================================
#
#          FILE: chs88_download.sh
# 
#         USAGE: ./chs88_download.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/10/2015 09:38
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
root="/picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz"
collection=("34N" "32N" "30N" "29N" "276N" "274N" "273N" "272N" "26N" "268N" "267N" "266N" "262N" "261N" "260N") 
link="ftp://climb.genomics.cn/pub/10.5524/100001_101000/100034/RawData"
for ind in ${collection[@]}
do
	echo $ind
	value="$root/$ind/check_value.txt"
	cat ${value} | while read line
	do
		if  echo "$line" | egrep -q 'fq.gz' ;then
			if echo "$line" | egrep -q 'OK$' ;then
				continue
			fi
			unf=`awk -F ':' '{print $1}'`
			echo $unf
			if [ -e "$root/$ind/$unf"];then
				rm -rf $unf
			fi
			wget -c -b -P $root/$ind  $link/$ind/$unf
		else
			continue
		fi
	done
done




