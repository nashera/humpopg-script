#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script5_cnv_genotyping.pl
#
#        USAGE: ./script5_cnv_genotyping.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
# ORGANIZATION: picb
#      VERSION: 1.0
#      CREATED: 02/05/2015 06:12:05 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $cnvr_dir="";
my $inp_root="";
my $out_root="";



my $cnv_type="";
opendir(CNVR,"$cnvr_dir") || die $!;
my $cnvr_file=grep{/$cnv_type/} readdir $



