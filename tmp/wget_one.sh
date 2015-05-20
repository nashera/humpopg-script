#!/bin/bash - 
#===============================================================================
#
#          FILE: wget_one.sh
# 
#         USAGE: ./wget_one.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/10/2015 15:56
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"

rm -rf /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/262N/110311_I235_FC81EB3ABXX_L6_HUMohgRFXDMAAPEI-10_2.clean.fq.gz
wget -c -b -P /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/262N  ftp://climb.genomics.cn/pub/10.5524/100001_101000/100034/RawData/262N/110311_I235_FC81EB3ABXX_L6_HUMohgRFXDMAAPEI-10_2.clean.fq.gz

rm -rf /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/26N/101221_I245_FC810MUABXX_L4_HUMohgRELDMAAPEI-8_1.clean.fq.gz
wget -c -b -P /picb/humpopg-bigdata/archive/20120527_NG_Chinese88/Fastqgz/26N  ftp://climb.genomics.cn/pub/10.5524/100001_101000/100034/RawData/26N/101221_I245_FC810MUABXX_L4_HUMohgRELDMAAPEI-8_1.clean.fq.gz
