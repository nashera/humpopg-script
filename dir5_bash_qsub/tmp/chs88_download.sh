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
down="/home/zhangxi/Document/script/tmp/ref.txt"
root="/picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz"
collection=("35N" "34N" "32N" "30N" "29N" "276N" "274N" "273N" "272N" "26N" "268N" "267N" "266N" "262N" "261N" "260N") 
link="ftp://climb.genomics.cn/pub/10.5524/100001_101000/100034/RawData"
for ind in ${collection[@]}
do
	echo $ind >> $down
	value="$root/$ind/check_value.txt"
	cat ${value} | while read line
	do
			if echo "$line" | egrep -q '^md5sum' ;then
				continue
			fi
			if echo "$line" | egrep -q 'OK$' ;then
				continue
			fi
			echo $line
			unf=`echo $line | awk -F ':' '{print $1}' `
			echo $unf
			#if [ -e "$root/$ind/$unf"];then
			echo "rm -rf $root/$ind/$unf" >> $down
			#fi
			echo "wget -c -b -P $root/$ind  $link/$ind/$unf" >> $down
	done
done




