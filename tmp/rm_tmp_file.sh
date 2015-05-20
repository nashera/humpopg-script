#!/bin/bash - 
#===============================================================================
#
#          FILE: rm_tmp_file.sh
# 
#         USAGE: ./rm_tmp_file.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/30/2015 10:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"

rm -rf /picb/humpopg2/zhangxi/tmp/*
rm -rf /picb/humpopg5/zhangxi/tmp/*
rm -rf /picb/humpopg6/zhangxi/tmp/*
rm -rf /picb/humpopg7/zhangxi/tmp/*
rm -rf /picb/humpopg-bigdata/zhangxi/tmp/*
rm -rf /picb/papgi-pgg/zhangxi/tmp/*
rm -rf /picb/share/zhangxi/tmp
rm -rf /home/zhangxi/tmp


