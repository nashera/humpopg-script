#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: breakdancer_analysis.pl
#
#        USAGE: ./breakdancer_analysis.pl
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
# ORGANIZATION: picb
#      VERSION: 1.0
#      CREATED: 11/18/2014 08:00:38 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir="/picb/papgi-pgg/zhangxi/xinjiang_ngs";
my $out_dir="/picb/papgi-pgg/zhangxi/xinjiang_ngs_breakdancer";

opendir(DIRHANDLE,"$inp_dir")  || die $!;
my @all_inp=grep{/^WGC021937/} readdir DIRHANDLE;
for my $i(0..$#all_inp){
	my $x="$out_dir/$all_inp[$i]";  
	if(! -e $x){
	mkdir("$out_dir/$all_inp[$i]",0777) || die $!;  
	}
	my $ind_dir="$inp_dir/$all_inp[$i]";
	opendir(INDDIR,"$ind_dir") || die $!;
	my @all_chr_bam=grep{/bam$/} readdir INDDIR;
	for my $j(0..$#all_chr_bam){
		my $chr=substr($all_chr_bam[$j],11,5);
		my $y="$out_dir/$all_inp[$i]/$chr";
		if(! -e $y){
			mkdir("$out_dir/$all_inp[$i]/$chr",0777) || die $!;  
			}
		chdir "$out_dir/$all_inp[$i]/$chr" or die $!;
		my $command1="perl /picb/humpopg5/zhangxi/breakdancer_ouput/bam2cfg.pl  -f /picb/papgi-pgg/zhangxi/xinjiang_ngs_breakdancer/list $ind_dir/$all_chr_bam[$j] >$all_chr_bam[$j].cfg";
		system("$command1");
		my $command2="breakdancer-max -h $all_chr_bam[$j].cfg > $all_chr_bam[$j].sv";
		system("$command2");
		}

	}



	

