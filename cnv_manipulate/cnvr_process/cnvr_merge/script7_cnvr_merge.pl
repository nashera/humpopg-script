#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script7_cnvr_merge.pl
#
#        USAGE: ./script7_cnvr_merge.pl  
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
#      CREATED: 02/05/2015 10:13:04 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_root="";
my $out_root="";
opendir (INP,"$inp_root") || die $!;
my @all_sv_dir=grep{/INV/} readdir INP;
for my $i(0..$#all_sv_dir) {
	my $sv_dir="$inp_root/$all_sv_dir[$i]";
	my $out_sv_dir="$out_root/$sv_dir[$i]";
	opendir(INP_SV,"$sv_dir") || die $!;
	my @cnvr_file=grep{/INV_chr/}  readdir INP_SV;
	for my $j(0..$#cnvr_file){
		my $cnvr="$out_sv_file/$cnvr_file[$j]";
		open(my $filehand,"$cnvr") || die $!;
		my $ra_cnvrs=abstract($filehand);
		my @$ra_cnvrs=(sort{a->[0]<=>b->[0]}@$ra_cnvrs); #  sort the cnvr
		my $ra_cnvrs_merged=merge_cnvr($ra_cnvrs);
		open(MERGE,">","$out_root/$all_chr_")
		my $len=scalar(@$ra_cnvrs)-1;
		for my $k(0..$len){
			print MERGE ""}
		
	}
}
		
sub abstract{
	my ($file)=@_;
	my $ra_breakpoint_array;
	while(<$file>){
		if(/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my $breakpoint=[$entry[0],$entry[1]];
		push @$ra_breakpoint_array,$breakpoint;
		}
	return $ra_breakpoint_array;
}

sub merge_cnvr{
	my ($ra_cnvr)=@_;
	my $l=scalar(@$ra_cnvr)-1;
	my @cnvr=@$ra_cnvr;
	my @merged_cnvr;
	my $i=0;
	while($i <= $l){
		my @sub_cnvr=@cnvr[$i..$l];
		my $breakpoint=shift @sub_cnvr;
		my $output_point_to_array=&merge_one_to_array($breakpoint,\@sub_cnvr);
		push @merged_cnvr, $output_point_to_array->[0];
		$i=$i+$output_point_to_array->[1]-1 ;
	}
	my $ra_merged_cnvr=\@merged_cnvr;
	return $ra_merged_cnvr;
}
	
sub merge_one_to_array{
	my ($ra_one,$ra_breakpoint_array)=@_;
	my @tmp_breakpoint_array;
	my @breakpoint_array=@$ra_breakpoint_array;
	my $n=0;
	for my $i(0..$#breakpoint_array){
		$n++;
		my $signal=&one_to_one($ra_one,$ra_breakpoint_array->[$i]);
		if($signal == 1){
			push @tmp_breakpoint_array, [$ra_one->[0],$ra_breakpoint_array->[$i][1]];}
		elsif($signal == 2){
			push @tmp_breakpoint_array,$ra_one;}
		elsif($signal == 0){
			last;}
		else{print "There is mistake";}
	}
	push @tmp_breakpoint_array, $ra_one;
	@tmp_breakpoint_array=(sort{a->[1]<=>b->[1]}@tmp_breakpoint_array);
	$ra_output_breakpoint=[$ra_one->[0],@tmp_breakpoint_array[$#tmp_breakpoint_array]];
	my $output=[$ra_output_breakpoint,$n];
	return $output;
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
	else{print "there is a mistake";}
	return $t;
}
