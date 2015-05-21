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
open INP, "<$file1";
open FREQ, ">$file2";

$line = 0;
$col = 0 ;
 while (<INP>){
	$line++;
	my ($a = 0 , $b = 0,$p=0);
	my @entry =split;
	my @allele = split /\/,  $entry[5];
	for my $i(6..$#entry){
		if ($entry[$i] eq "A"){
		a=a+2;
		}
		elseif ($entry[$i] eq "B"){
		b=b+2;
		}
		elseif ($entry[$i] eq "H"){
		a=a+1;
		b=b+1;
		}
		else {print "there is a mistake \t the line is $line  \t the  factor is  $entry[$i]\n";}
		$p = $a / ($a + $b)
		print FREQ , "@entry[1]\t@entry[2]\t@entry[3]\t $p\n"
	
