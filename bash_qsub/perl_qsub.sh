#!/bin/bash - 
#===============================================================================
#
#          FILE: perl_qsub.sh
# 
#         USAGE: ./perl_qsub.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/28/2015 15:18
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
perl /home/zhangxi/Document/script/break.pl 

