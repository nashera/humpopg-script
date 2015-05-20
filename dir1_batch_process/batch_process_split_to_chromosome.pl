#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: batch_process_split_to_chromosome.pl
#
#        USAGE: ./batch_process_split_to_chromosome.pl  
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
#      CREATED: 09/21/2014 05:56:35 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir="/picb/humpopg7/zhangxi/affymetrix/snp_data_inp";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_inp=grep{/filter/} readdir  DIRHANDLE;
for my $i(1..$#all_inp){
	my $parameter="$inp_dir"."/$all_inp[$i]";
	my $split_in_chr="perl /picb/humpopg7/zhangxi/perl_script/split_to_chromosome_for_calculate_ld.pl $parameter";
	print ("$split_in_chr\n");
	system("$split_in_chr");
}

