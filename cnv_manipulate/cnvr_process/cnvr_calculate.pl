#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: cnvr_calculate.pl
#
#        USAGE: ./cnvr_calculate.pl  
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
#      CREATED: 01/23/2015 16:13:22
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir="";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_ind_chr_type_file=grep{/^WGC/} readdir DIRHANDLE;


my $ra_cnv_reference_breakpoint;

for my $i(0..$#all_ind_chr_type_file){
	open(my $cnv_file,"<","$inp_dir/$all_ind_chr_type_file[$i]") || die $!;
	my $ra_ind_breakpoint_array=&abstract_breakpoint($cnv_file);
	if($i == 0){
		$ra_cnv_reference_breakpoint = $ra_ind_breakpoint_array;}
	else{$ra_cnv_reference_breakpoint = &merge_two_reference_breakpoint($ra_cnv_reference_breakpoint,$ra_ind_breakpoint_array);}
	}

sub abstract_breakpoint{
	my ($file)=@_;
	my $ra_breakpoint_array;
	while(<$file>){
		if(/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my $breakpoint=[$entry[1],$entry[2]];
		push @$ra_breakpoint_array,$breakpoint;
		}
	return $ra_breakpoint_array;
	}


sub merge_two_reference_breakpoint{
	my ($ra_breakpoint_array1,$ra_breakpoint_array2)=@_;
	my @breakpoint_array1=@$ra_breakpoint_array1;
	my @breakpoint_array2=@$ra_breakpoint_array2;
	my $ra_cnv_breakpoint;
	my $index=0;
	for my $i(0..$#breakpoint_array1){
		my $sub_breakpoint_array2=[@breakpoint_array2[$index..$#breakpoint_array2]];
		my $output_point_to_array=&merge_one_to_array($breakpoint_array1[$i],$sub_breakpoint_array2);
		push $ra_cnv_breakpoint, @{$output_point_to_array->[0]};
		$index=$index + $output_point_to_array->[1];
		}
	return $ra_cnv_breakpoint;
	}
	



sub merge_one_to_array{
	my ($ra_one,$ra_breakpoint_array)=@_;
	my $ra_output_breakpoint_array;
	my @breakpoint_array=@$ra_breakpoint_array;
	my $n=0;
	for my $i(0..$#breakpoint_array){
		$n++;
		my $signal=&one_to_one($ra_one,$ra_breakpoint_array->[$i]);
		if($signal == 5){
			push @$ra_output_breakpoint_array,$breakpoint_array[$i]; }
		elsif($signal == 1){
			push @$ra_output_breakpoint_array, [$ra_one->[0],$ra_breakpoint_array->[$i][1]];}
		elsif($signal == 2){
			push @$ra_output_breakpoint_array,$ra_one;}
		elsif($signal == 3){
			push @$ra_output_breakpoint_array,$ra_output_breakpoint_array->[$i];}
		elsif($signal == 4){
			push @$ra_output_breakpoint_array,[$ra_output_breakpoint_array->[$i][0],$ra_one->[1]];}
		elsif($signal == 0){
			last;}
	}
	my $output=[$ra_output_breakpoint_array,$n];
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
	elsif($two[0] <= $one[0] and $one[1] <= $two[1]){
		$t=3;}
	elsif($two[0] <= $one[1] and $one[0] <= $two[1] and $two[1] <= $one[1]){
		$t=4;}
	elsif($two[1] <= $one[0]){
		$t=5;}
	return $t;
	}
