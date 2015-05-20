#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: batch_process_inp_to_plink.pl
#
#        USAGE: ./batch_process_inp_to_plink.pl  
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
#      CREATED: 09/18/2014 01:23:24 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir= "/picb/humpopg7/zhangxi/affymetrix/out";
my $out_dir="/picb/humpopg7/zhangxi/affymetrix/plink";
opendir(DIRHANDLE,"$inp_dir") || die  $!;
my @all_inp= grep{/inp$/} readdir DIRHANDLE;
for my $j(0..$#all_inp){
	my $pop=substr($all_inp[$j],0,3);
	my $inp_to_plink_command="perl /picb/humpopg7/zhangxi/perl/inp_to_plink.pl $inp_dir/$all_inp[$j] $out_dir/$pop.map $out_dir/$pop.ped $pop";
	print ("$inp_to_plink_command\n");
	system("$inp_to_plink_command");
	}


close DIRHANDLE;
