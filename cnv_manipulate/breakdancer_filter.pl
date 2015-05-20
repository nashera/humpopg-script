#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: all_breakdancer.pl
#
#        USAGE: ./all_breakdancer.pl  
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
#      CREATED: 12/16/2014 08:33:52 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
my $inp_dir="/picb/papgi-pgg/zhangxi/xinjiang_ngs_breakdancer";
my $out_dir="/picb/humpopg-bigdata/zhangxi/breakdancer_output_filter";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_ind=grep{/^WGC/} readdir DIRHANDLE;

for my $i(0..$#all_ind){
	my $ind_dir="$inp_dir/$all_ind[$i]";
	my $out_ind_dir="$out_dir/$all_ind[$i]";
	if(! -e $out_ind_dir){
		mkdir("out_ind_dir",0777) || die $!;
	}
	opendir(INDDIR,"$ind_dir") || die $!;
	my @all_chr=grep{/^chr\d/} readdir INDDIR;
	for my $j(0..$#all_chr){
		my ($chr)=($all_chr[$j]=~/chr(\d+)/);
		opendir(CHRHANDLE,"$ind_dir/$all_chr[$j]") || die $!;
		my @sv_files=grep{/sv$/} readdir CHRHANDLE;
		my $sv=shift @sv_files;
		open(my $sv_file,"<","$ind_dir/$all_chr[$j]/$sv") || die $!;
		open(my $sv_filter_file,">","$out_ind_dir/$sv") || die $!;
		while(my $aa=<$sv_file>){
			chomp;
			if ($aa =~ /^\#/){
				print $sv_filter_file $_;}
			else{
				my @entry=split($aa,/\t+/);
				if($entry[8] >= 50 and $entry[9]  >=5){
					print $sv_filter_file "$aa\t";}
					elsef{next;}
			}
		}
	}
}

