#!/bin/bash - 
#===============================================================================
#
#          FILE: wget4.sh
# 
#         USAGE: ./wget4.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/12/2015 14:35
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
rm -rf /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/32N/101230_I116_FC810N4ABXX_L3_HUMohgRERDMAAPEI-10_1.clean.fq.gz
wget -c -b -P /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/32N  ftp://climb.genomics.cn/pub/10.5524/100001_101000/100034/RawData/32N/101230_I116_FC810N4ABXX_L3_HUMohgRERDMAAPEI-10_1.clean.fq.gz
rm -rf /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/32N/101230_I116_FC810N4ABXX_L3_HUMohgRERDMAAPEI-10_2.clean.fq.gz
wget -c -b -P /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/32N  ftp://climb.genomics.cn/pub/10.5524/100001_101000/100034/RawData/32N/101230_I116_FC810N4ABXX_L3_HUMohgRERDMAAPEI-10_2.clean.fq.gz


