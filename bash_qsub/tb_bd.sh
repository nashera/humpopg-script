#!/bin/bash - 
#===============================================================================
#
#          FILE: tb_bd.sh
# 
#         USAGE: ./tb_bd.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/04/2015 16:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
#process="/home/zhangxi/Document/LOG/***.txt"
export PATH=$HOME/local/bin:/picb/extprog/biopipeline/Linux-x86_64_exports/bin:/bin:/sbin:/usr/local/sbin:/usr/sbin:/usr/bin:$PATH
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib) 
perl /picb/humpopg-bigdata/zhangxi/tb_breakdancer_output_chr/breakdancer_analysis.pl


