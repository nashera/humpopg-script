#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script8_genotyping.pl
#
#        USAGE: ./script8_genotyping.pl  
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
#      CREATED: 05/07/2015 04:37:47 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $cnvr_file=""
my @cnvr_breakpoint;
my $ind_cnv_root="";


open(CNVR, "<","$cnvr_file") || die $!;
while(<CNVR>){
	if(/\D/){
		next;
	}
	chomp;
	my @entry=split;
	my $breakpoint=[$entry[0],$entry[1]];
	push @cnvr_breakpoint, $breakpoint;
}

opendir (INP, "$ind_cnv_root") || die $!;
my @all_sv_dir=grep{/INV/}readdir INP;
for my $i(0..$#sv_dir){
	my $sv_dir="$ind_cnv_root/$all_sv_dir[$i]";
	opendir(SV_DIR,"$sv_dir") || die $!;
	my @ind_sv=grep{^WGC} readdir SV_DIR;
	for my $j(0..$#sv_dir){
		open(my $sv_file, "<","$ind_sv/$sv_dir[$i]") || die $!;
		my $ra_ind_sv_output=abstract_breakdancer($sv_file);
		my $y="$out_dir/$all_ind[$i]/chr_$chr";
		my $genotype_cnv_call=cnv_call($ra_ind_sv_output, \@cnvr_breakpoint);
		print }
	




sub abstract_breakdancer{
	my ($file)=@_;
	my @ind_chr_cnv;
	while(<$file>){
		if(/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my @length=($entry[4]-$entry[1]);
		my $all=[$entry[0];$ent]
	}
}

sub cnv_call{
	my ($ind_sv, $cnvr)=@_;
	my $ra_cnvr_call_array;
	my $lengh = scalar(@$cnvr)-1;
	for my $i(0..$lengh){
		$n++;
		my $g=$one_to_array($cnvr->$i, $ind_sv);
		push @$ra_cnvr_call_array. $g;
		}
		return $ra_cnvr_array;
	}

sub one_to_array{
	my ($ra_one,$ra_array)=@_;
	my $t;
	my $l=scalar(@$ra_array)-1
	for my $i(0..$l){
		$signal = one_to_one($ra_array->$i, $ra_one);
		if($signal == 3){
			$t=1;
		}
		else(next;)
	}
		return $t;
}

sub one_to_one{   # compare two breakpoint to output the CNVR
	my ($ra_one,$ra_two)=@_;
	my @one=@$ra_one;
	my @two=@$ra_two;
	my $t;
	if($one[1] <= $two[0]){
		$t=0;}
	elsif($one[0] <= $two[0] and $two[0] <= $one[1] and $one[1] <= $two[1]){
		$t=1;}
	elsif($one[0] <= $two[0] and $two[1] <= $one[1]){
		$t=2;}
	elsif($two[0] <= $one[0] and $one[1] <= $two[1]){
		$t=3;}
	elsif($two[0] <= $one[1] and $one[0] <= $two[1] and $two[1] <= $one[1]){
		$t=4;}
	elsif($two[1] <= $one[0]){
		$t=5;}
	else{print "there is a mistake";}
	return $t;
}





