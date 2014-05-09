#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: fst.pl
#
#        USAGE: ./fst.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: ZHANG XI (student), zhangxi1014@gmail.com
# ORGANIZATION: sibs
#      VERSION: 1.0
#      CREATED: 03/13/2014 14:29:17
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
my ($file1, $file2, $file3, $file4)=@ARGV
open INP1, "$file1";
open INP2, "$file2";
if (!open "$file1" ){
	die "cannot open INP1\n";
}
if (!open "$file2"){
	die "cannot open INP2\n";
}
open FREQ, ">$file3";
open FST, ">$file4";

$inp1_line = 0;
$col = 0 ;
 while (<INP>){
	$line++;
	my ($a = 0 , $b = 0,$freq=0);
	my @entry =split;
	my @allele = split /\/,  $entry[5];
	for my $i(6..$#entry){
		if ($entry[$i] eq "A"){
		a=a+2;
		}
		elseif (
		b=b+2;
		}
		elseif ($entry[$i] eq "H"){
		a=a+1;
		b=b+1;
		}
		else {print "there is a mistake \t the line is $line  \t the  factor is  $entry[$i]\n";}
		$freq = $a / ($a + $b);
	}

		print FREQ , "@entry[1]\t@entry[2]\t@entry[3]\t $p\n"
	

	print "inp1_line1 is $inp1_line1 \n";
	print "inp1_col1 is $in1_col1\n";

	close INP1;

my $inp2_line =0;
my $inp2_line= 0;
	while (<INP2>){
	}

	my $freq_averge; 

	$freq_averge = ($freq1 + $freq2 ) / 2;
	 
my  $fst_msg_nume ;
my $fst_msg_demo;
my $fst_msg

$fst_msg_nume  =(($inp1_col-5)*$inp1_freq*(1-$inp1_freq))+( ($inp2_col-5)*$inp2_freq*(1-$inp2_freq));
$fst_msg_demo = 1;
$fst_msg =$fst_msg_nume / $fst_msg_demo ;

###########################
my $fst_msp;
 q
$ft_msp  = ($inp1_col - 5)* ($inp1_freq-$freq_averge)*($inp1_freq_averge)+($inp2_col - 5)* ($inp2_freq -$freq_averge)* ($inp2_freq - $freq_averge)

my $nc;
$nc= $inp1_col- 5 + $inp2_col -5 -(($inp1_col-5)*($inp1_col-5)+($inp2_col-5)*($inp2_col-5))/($inp1_col-5 + $inp2_col-5);

my $fst;
$fst = ($fst_msp-$fst_msg)/($fst_msp+($nc-1)*$fst_msg)

print fst_output "$fst\n";




