#!/bin/bash - 
#===============================================================================
#
#          FILE: pbs.sh
# 
#         USAGE: ./pbs.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/28/2015 14:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#PBS -l nodes=1:ppn=16,walltime=0:00:59
#PBS -l mem=62000mb
#PBS -m abe
#PBS -v foo='qux'
process="/home/zhangxi/Document/LOG/test.txt"
bar="${PATH}"
bkk=`which cp`
echo "${PATH}" > $process
echo  "$bkk" >> $process

