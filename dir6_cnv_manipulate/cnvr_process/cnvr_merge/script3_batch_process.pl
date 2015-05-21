#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script5_batch_process.pl
#
#        USAGE: ./script5_batch_process.pl  
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
#      CREATED: 02/03/2015 07:59:11 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp="/picb/humpopg-bigdata/zhangxi/after_filter_cnvr_result";
my $out="/picb/humpopg-bigdata/zhangxi/breakdancer_cnvr_result";

opendir(CLASS,"$inp") || die $!;
my @all_sv_dir=grep{/INV/} readdir CLASS;
for my $i(0..$#all_sv_dir){
	my $sv_dir="$inp/$all_sv_dir[$i]";
	opendir(INP_SV,"$sv_dir") || die $!;
	my @all_chr_dir=grep{/chr/} readdir INP_SV;
	print "$i\n";	
	for my $j(0..$#all_chr_dir){
		my $sv_chr_dir="$sv_dir/$all_chr_dir[$j]";
		opendir (CHR_DIR,"$sv_chr_dir") || die $!;
		my @all_sv_chr_ind_type_file=grep{/^filtered\.filtered\.WGC/} readdir CHR_DIR;
		for my $k(0..$#all_sv_chr_ind_type_file){
			my $ind_sv_file="$sv_chr_dir/$all_sv_chr_ind_type_file[$k]";
			my $ind_sv_filtered_file="$sv_chr_dir/filtered2.$all_sv_chr_ind_type_file[$k]";
			if (!-e $ind_sv_file){
				die  "no such file\t";}
			chdir ("$sv_chr_dir");
			my $command="perl /home/zhangxi/Document/script/cnv_manipulate/cnvr_process/haiyi_cnvr_merge/script2_scan_overlapping_for_ind.pl $ind_sv_file $ind_sv_filtered_file";
			my $ret=qx{$command};
			print "$ret";
		}
	}
}


