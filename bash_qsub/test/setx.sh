#!/bin/bash - 
#===============================================================================
#
#          FILE: setx.sh
# 
#         USAGE: ./setx.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 05/15/2015 11:19
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
set -x
dir=$(ls /picb/humpopg2)
echo ${dir[@]}


