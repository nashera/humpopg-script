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

my $inp="/picb/papgi-pgg/zhangxi/xinjiang_ngs_analysis/ngs_CNV_analysis/breakdancer_dir_analysis/cnvr_analysis/classify_type";
my $out="/picb/humpopg-bigdata/zhangxi/breakdancer_cnvr_result";

opendir(CLASS,"$inp") || die $!;
my @all_chr_dir=grep{/^chr/} readdir CLASS;
for my $i(0..$#all_chr_dir){
	my $chr_dir="$inp/$all_chr_dir[$i]";
	opendir(INP_CHR,"$chr_dir") || die $!;
	my @all_sv_dir=grep{/INS/} readdir INP_CHR;
	print "$i\n";	
	for my $j(0..$#all_sv_dir){
		my $sv_inp_dir="$chr_dir/$all_sv_dir[$j]";
		opendir (SV_DIR,"$sv_inp_dir") || die $!;
		my @all_ind_chr_type_file=grep{/^WGC/} readdir SV_DIR;
		for my $k(0..$#all_ind_chr_type_file){
			my $ind_sv_file="$sv_inp_dir/$all_ind_chr_type_file[$k]";
			if (!-e $ind_sv_file){
				die  "no such file\t"}
			my $command="perl /home/zhangxi/Document/script/cnv_manipulate/cnvr_process/script4_scan_overlapping_for_ind.pl $ind_sv_file";
			my $ret=qx{$command};
			print "$ret";
		}
	}
}


