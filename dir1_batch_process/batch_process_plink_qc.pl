#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: batch_process_plink_qc.pl
#
#        USAGE: ./batch_process_plink_qc.pl  
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
#      CREATED: 09/18/2014 03:25:33 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
my $inp_dir="/picb/humpopg7/zhangxi/affymetrix/plink";
my $dirhandle;
opendir($dirhandle,"$inp_dir") || die $!;
my @all=readdir $dirhandle;
my @all_map=grep{/map$/} @all;
my @all_ped=grep{/ped$/} @all;
print STDERR "@all_map\n";
print STDERR "@all_ped\n";

my @all_map_ordered=@all_map;
my @all_ped_ordered;
my @pop= map{substr($_,0,3)}@all_map;
for my $i(0..$#pop){
	for my $j(0..$#all_ped){
		if ($all_ped[$j] =~ m/^$pop[$i]/){
			push @all_ped_ordered,$all_ped[$j];
		}
	}
}
if($#all_map_ordered == $#all_ped_ordered){
	print STDERR "map and ped are equal.\n";}
else{print STDERR "map and ped are not equal!";}
#my $plink="./home/zhangxi/software/plink-1.07/plink";
for my $k(0..$#all_map_ordered){
	print STDERR "$k\t$pop[$k]\n";
	print STDERR "$k\t$all_map_ordered[$k]\n";
	print STDERR "$k\t$all_ped_ordered[$k]\n";
	my $qc_command="plink --noweb";
	$qc_command .=" --ped $inp_dir/$all_ped_ordered[$k]";
	$qc_command .=" --map $inp_dir/$all_map_ordered[$k]";
	$qc_command .=" --mind 0.1";
	$qc_command .=" --geno 0.1";
	$qc_command .=" --maf 0.05";
	$qc_command .=" --recode";
	$qc_command .=" --out $pop[$k]_cleaned";
	print("$qc_command");
	system("$qc_command");
}
