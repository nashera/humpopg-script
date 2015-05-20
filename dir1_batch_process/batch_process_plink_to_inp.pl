#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: batch_process_plink_to_inp.pl
#
#        USAGE: ./batch_process_plink_to_inp.pl  
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
#      CREATED: 09/18/2014 07:42:02 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $plink_dir="/picb/humpopg7/zhangxi/affymetrix/plink";
my $inp_dir="/picb/humpopg7/zhangxi/affymetrix/snp_data_inp";
opendir(DIRHANDLE,"$plink_dir") || die $!;
my @all=readdir DIRHANDLE;
my @all_map=grep{/cleaned.map$/} @all;
my @all_ped=grep{/cleaned.ped$/} @all;
my @all_map_ordered=@all_map;
my @all_ped_ordered;
my @pop=map {substr($_,0,3)} @all_map;
for my $i(0..$#pop){
	for my $j(0..$#all_ped){
		if($all_ped[$j] =~ m/^$pop[$i]/){
			push @all_ped_ordered,$all_ped[$j];
		}
	}
}
for my $k(0..$#all_map_ordered){
	print STDERR "$k\t$pop[$k]\n";
	my $plink_to_inp_command="perl /picb/humpopg7/zhangxi/perl_script/transform_plink_to_inp.pl $plink_dir/$all_map_ordered[$k] $plink_dir/$all_ped_ordered[$k] $inp_dir/$pop[$k]\_filtered.inp";
	print("$plink_to_inp_command");
	system("$plink_to_inp_command");
	}

	
