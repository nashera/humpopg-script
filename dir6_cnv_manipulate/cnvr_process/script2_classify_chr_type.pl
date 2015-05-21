#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: classify_chr_type.pl
#
#        USAGE: ./classify_chr_type.pl  
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
#      CREATED: 01/23/2015 11:36:57
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
use File::Copy qw(copy);
my @all_cnv_types=("DEL","ITX","INV","INS");



my $inp_dir="/picb/papgi-pgg/zhangxi/xinjiang_ngs_analysis/ngs_CNV_analysis/breakdancer_dir_analysis/cnvr_analysis";
my $out_dir="/picb/papgi-pgg/zhangxi/xinjiang_ngs_analysis/ngs_CNV_analysis/breakdancer_dir_analysis/cnvr_analysis/classify_type";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_ind=grep{/^WGC/} readdir DIRHANDLE;

for my $i(0..$#all_ind){
	my $ind_dir="$inp_dir/$all_ind[$i]";
	my @ind_cnv;
	opendir(INDDIR,"$ind_dir") || die $!;
	my @all_chr=grep{/^chr/} readdir INDDIR;
	for my $j(0..$#all_chr){
		my ($chr) = ($all_chr[$j]=~/chr_(\d+)/);
		my $out_chr_dir="$out_dir/chr$chr";
		if(! -e $out_chr_dir) {
			mkdir("$out_chr_dir",0777) || die $!;
		}
		opendir(CHRHANDLE,"$ind_dir/$all_chr[$j]") || die $!;
		my @all_sv_file=grep{/^WGC/} readdir CHRHANDLE;
			for my $h(0..$#all_sv_file){
				if($all_sv_file[$h] =~ /DEL/){
					my $out_chr_cnvtype_dir="$out_chr_dir/DEL";
					if(! -e $out_chr_cnvtype_dir){
						mkdir("$out_chr_cnvtype_dir",0777) || die $!;
					}
				copy("$ind_dir/$all_chr[$j]/$all_sv_file[$h]","$out_chr_dir/DEL/$all_sv_file[$h]")  || die $!;
			}
				if($all_sv_file[$h] =~ /ITX/){
					my $out_chr_cnvtype_dir="$out_chr_dir/ITX";
					if(! -e $out_chr_cnvtype_dir){
						mkdir("$out_chr_cnvtype_dir",0777) || die $!;
					}
				copy("$ind_dir/$all_chr[$j]/$all_sv_file[$h]","$out_chr_dir/ITX/$all_sv_file[$h]")  || die $!;
			}
				if($all_sv_file[$h] =~ /INV/){
					my $out_chr_cnvtype_dir="$out_chr_dir/INV";
					if(! -e $out_chr_cnvtype_dir){
						mkdir("$out_chr_cnvtype_dir",0777) || die $!;
					}
				copy("$ind_dir/$all_chr[$j]/$all_sv_file[$h]","$out_chr_dir/INV/$all_sv_file[$h]")  || die $!;
			}
				if($all_sv_file[$h] =~ /INS/){
					my $out_chr_cnvtype_dir="$out_chr_dir/INS";
					if(! -e $out_chr_cnvtype_dir){
						mkdir("$out_chr_cnvtype_dir",0777) || die $!;
					}
				copy("$ind_dir/$all_chr[$j]/$all_sv_file[$h]","$out_chr_dir/INS/$all_sv_file[$h]")  || die $!;
			}
		}
	}
}

