#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script4_scan_overlapping_for_ind.pl
#
#        USAGE: ./script4_scan_overlapping_for_ind.pl  
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
#      CREATED: 02/03/2015 07:05:41 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
#
my ($sv_ind)=@ARGV;
open(my $ind_sv_file,"<","$sv_ind") || die $!;
my $ra_ind_sv_output=abstract_breakdancer($ind_sv_file);
my $length = scalar(@$ra_ind_sv_output)-1;
my @s;
my $n=0;
for my $i(0..$length){
	my $judge;
	if($i == 0){
		$judge = 0;
	}
	elsif($i >= 1){
		my $ra_forward=[$ra_ind_sv_output->[$i-1][1],$ra_ind_sv_output->[$i-1][2]];
		my $ra_current=[$ra_ind_sv_output->[$i][1],$ra_ind_sv_output->[$i][2]];
		$judge=one_to_one($ra_forward,$ra_current);
		if ($judge == 1){
			print "$sv_ind\t$i+1\toverlapping site\t$ra_forward->[0]\t$ra_forward->[1]\t$ra_current->[0]\t$ra_current->[1]\t";
			$n++;
		}
		elsif ($judge ==2){
		print "$sv_ind\t$i+1\tlocation\t$ra_forward->[0]\t$ra_forward->[1]\t$ra_current->[0]\t$ra_current->[1]\t";;}
	}
	push @s, $judge;
}

if ($#s != $length) {
	die("the length is note equal\n");
}

if ($n >=1){
	print "$sv_ind\t$n\toverlapping exist!\n";

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
		my $length=($entry[2]-$entry[1]);
		my $all=[$entry[0],$entry[1],$entry[2],$length,$entry[4]]; #[chromosome,pos1,pos2,type,$length,num_reads
		push @ind_chr_cnv,$all;
		}
	my $ra_ind_chr_cnv=\@ind_chr_cnv;
	return $ra_ind_chr_cnv;
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
		$t=1;}
	elsif($two[0] <= $one[0] and $one[1] <= $two[1]){
		$t=1;}
	elsif($two[0] <= $one[1] and $one[0] <= $two[1] and $two[1] <= $one[1]){
		$t=1;}
	elsif($two[1] <= $one[0]){
		$t=2;}
	else{print "there is a mistake";}
	return $t;
}
