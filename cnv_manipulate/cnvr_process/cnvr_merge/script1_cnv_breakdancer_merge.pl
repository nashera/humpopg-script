#
#/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: cnv_breakdancer_merge.pl
#
#        USAGE: ./cnv_breakdancer_merge.pl  
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
#      CREATED: 01/21/2015 03:08:59 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir="/picb/humpopg-geno/louhaiyi/xinjiang_sequencing/merged_phase1/sv_by_ind";
my $out_dir="/picb/humpopg-bigdata/zhangxi/after_filter_cnvr_result";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_sv=grep{/INV/} readdir DIRHANDLE;
my $sv_dir=shift @all_sv;
my $out_sv_dir="$out_dir/$sv_dir";
if (! -e $out_sv_dir){
	mkdir("$out_sv_dir",0777) || die $!;
}
my $x="$inp_dir/$sv_dir";
opendir(SV,"$x") || die $!;
my @all_ind=grep{/^WGC/} readdir SV;
for my $i(0..$#all_ind){
	my $sv_ind_file="$x/$all_ind[$i]";
	open(my $sv_file,"<","$sv_ind_file") || die $!;
	my $ra_sv_ind_output= abstract_breakdancer($sv_file);
	@$ra_sv_ind_output=( sort{$a->[1] <=> $b->[1] }@$ra_sv_ind_output); # sort the cnvr
	my $length=scalar(@$ra_sv_ind_output)-1;
	for my $k(0..$length){
		my $chr=$ra_sv_ind_output->[$k][0]+0;
		my $y="$out_sv_dir/chr_$chr";
		if(! -e $y){
			mkdir("$out_sv_dir/chr_$chr",0777) || die $!;
			}
		chdir "$y" || die $!;
		my $out_cnv_type_file="$y/$all_ind[$i]";
		if (-e $out_cnv_type_file){
			open (OUT,">>","$out_cnv_type_file") || die $!;}
			else{
				open (OUT,">","$out_cnv_type_file") || die $!;}
			print OUT "$ra_sv_ind_output->[$k][0]\t$ra_sv_ind_output->[$k][1]\t$ra_sv_ind_output->[$k][2]\t$ra_sv_ind_output->[$k][3]\t$ra_sv_ind_output->[$k][4]\t$ra_sv_ind_output->[$k][5]\n";
		}
}
sub abstract_breakdancer{
	my ($file)=@_;
	my @ind_chr_cnv;
	while(<$file>){
		if(/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my $length=($entry[4]-$entry[1]);
		my $all=[$entry[0],$entry[1],$entry[4],$length,$entry[6],$entry[9]]; #[chromosome,pos1,pos2,type]
		push @ind_chr_cnv,$all;
		}
	my $ra_ind_chr_cnv=\@ind_chr_cnv;
	return $ra_ind_chr_cnv;
}

