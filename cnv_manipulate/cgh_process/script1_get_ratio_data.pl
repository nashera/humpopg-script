#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script1_get_ratio_data.pl
#
#        USAGE: ./script1_get_ratio_data.pl  
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
#      CREATED: 05/18/2015 18:49:52
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $data_root = "";

opendir(DIR, "$data_root") || die $!;
my @all_ind_dir=grep{/area/} readdir DIR;

for my $i(0..$#all_ind_dir){
	my $ind_cgh_dir =  }
