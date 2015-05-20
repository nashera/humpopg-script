#!/bin/bash - 
#===============================================================================
#
#          FILE: run_admixture.sh
# 
#         USAGE: ./run_admixture.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/30/2015 00:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
admix_run_dir="/home/zhangxi/Documnt"
admix_binary="/home/zhangxi/software/admixture_linux-1.23/admixture"
k=
input="/picb/papgi-ppg"

$admix_bianry $input $k





