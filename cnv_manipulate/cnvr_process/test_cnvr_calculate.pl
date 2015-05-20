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

my $inp="/picb/papgi-pgg/zhangxi/xinjiang_ngs_analysis/ngs_CNV_analysis/breakdancer_dir_analysis/cnvr_analysis/classify_type";
my $out="/picb/humpopg-bigdata/zhangxi/breakdancer_cnvr_result";

opendir(CLASS,"$inp") || die $!;
my @all_chr_dir=grep{/^chr/} readdir CLASS;
for my $i(0..$#all_chr_dir){
	my $chr_dir="$inp/$all_chr_dir[$i]";
	my $out_chr_dir="$out/$all_chr_dir[$i]";
	if (! -e $out_chr_dir){
		mkdir("$out_chr_dir",0777) || die $!;}
	opendir(INP_CHR,"$chr_dir") || die $!;
	my @all_sv_dir=grep{/\w+/} readdir INP_CHR;
	for my $j(0..$#all_sv_dir){
		print "$i\t$all_sv_dir[$j]\n";
		my $sv_inp_dir="$chr_dir/$all_sv_dir[$j]";
		my $ra_chr_sv_type_cnvr_array=&calculate_cnvr($sv_inp_dir);
		open (CNVR_FILE,">","$out_chr_dir/$all_chr_dir[$i]\_$all_sv_dir[$j]\_sv.txt") || die $!;
		my $length = scalar(@$ra_chr_sv_type_cnvr_array)-1;
		for my $h(0..$length){
			print CNVR_FILE "$ra_chr_sv_type_cnvr_array->[$h][0]\t$ra_chr_sv_type_cnvr_array->[$h][1]\n";
		}
	}
}

sub calculate_cnvr{
	my $inp_dir=shift;
	print "$inp_dir\t";
	opendir(DIRHANDLE,"$inp_dir") || die $!;
	my @all_ind_chr_type_file=grep{/^WGC/} readdir DIRHANDLE;
	my $ra_cnv_reference_breakpoint;
	for my $i(0..$#all_ind_chr_type_file){
		print "$all_ind_chr_type_file[$i]\t";
		open(my $cnv_file,"<","$inp_dir/$all_ind_chr_type_file[$i]") || die $!;
		my $ra_ind_breakpoint_array=&abstract_breakpoint($cnv_file);
		if($i == 0){
			$ra_cnv_reference_breakpoint = $ra_ind_breakpoint_array;}
		else{
			$ra_cnv_reference_breakpoint = &merge_two_reference_breakpoint($ra_cnv_reference_breakpoint,$ra_ind_breakpoint_array);
		}
	}
	return $ra_cnv_reference_breakpoint;
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
	print "arrya_two\t$#breakpoint_array2\t";
	print "array_one\t$#breakpoint_array1";
	print "\t";
	my @cnv_breakpoint;
	my $index=0;
	for my $i(0..$#breakpoint_array1){
		if ($index > $#breakpoint_array2){
			push @cnv_breakpoint, @breakpoint_array1[$i..$#breakpoint_array1];
			last;
		}
		my @sub_breakpoint_array2=@breakpoint_array2[$index..$#breakpoint_array2];
		my $ra_sub_breakpoint_array2=\@sub_breakpoint_array2;
		my $output_point_to_array=&merge_one_to_array($breakpoint_array1[$i],$ra_sub_breakpoint_array2);
		push @cnv_breakpoint, @{$output_point_to_array->[0]};
		$index=$index + $output_point_to_array->[1];
	}
	my $ra_cnv_breakpoint=\@cnv_breakpoint;
	return $ra_cnv_breakpoint;
}
	



sub merge_one_to_array{
	my ($ra_one,$ra_breakpoint_array)=@_;
	my $l = scalar(@$ra_breakpoint_array);	
	print "$ra_one->[0]\t$ra_one->[1]\t$l\t";
	my @output_breakpoint_array=();
	my @breakpoint_array=@$ra_breakpoint_array;
	my $n=0;
	for my $i(0..$#breakpoint_array){
		my $signal=&one_to_one($ra_one,$ra_breakpoint_array->[$i]);
		$n++;
		if($signal == 0)
		{
			if(($#output_breakpoint_array == -1) or (one_to_one($ra_one,$ra_breakpoint_array->[$i-1])== 5))
			{
				print "done\t";
				push @output_breakpoint_array, $ra_one;
			}
			$n--;
			last;}
		elsif($signal == 1){
				push @output_breakpoint_array, [$ra_one->[0],$ra_breakpoint_array->[$i][1]];
				}
		elsif($signal == 2){
				push @output_breakpoint_array,$ra_one;
				}
		elsif($signal == 3){
				push @output_breakpoint_array,$ra_breakpoint_array->[$i];
				}
		elsif($signal == 4){
				push @output_breakpoint_array,[$ra_breakpoint_array->[$i][0],$ra_one->[1]];
				}
		elsif($signal == 5){
				push @output_breakpoint_array, $ra_breakpoint_array->[$i];
				}
	}
	if ($#output_breakpoint_array == -1){
		die(print "what's wrong");
	}
	my $ra_output_breakpoint_array=\@output_breakpoint_array;
	print "$n\t$#output_breakpoint_array\n";
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
	else{print "there is a mistake";}
	return $t;
}
