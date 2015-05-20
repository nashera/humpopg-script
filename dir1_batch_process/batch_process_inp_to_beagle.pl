#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: batch_process_transform_inp_to_beagle.pl
#
#        USAGE: ./batch_process_transform_inp_to_beagle.pl  
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
#      CREATED: 09/21/2014 11:29:24 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir="/picb/humpopg7/zhangxi/affymetrix/snp_data_inp";
my $out_dir="/picb/humpopg7/zhangxi/affymetrix/phasing";


opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_inp=grep{/chr/} readdir DIRHANDLE;
for my $i(0..$#all_inp){
	my $inp_to_beagle_command="perl /picb/humpopg7/zhangxi/perl_script/transform_inp_to_beagle.pl $inp_dir/$all_inp[$i]  $out_dir/$all_inp[$i].vcf";
	print ("$inp_to_beagle_command\n");
	system("$inp_to_beagle_command");
}

close DIRHANDLE;
