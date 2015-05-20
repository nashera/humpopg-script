#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: convenge.pl
#
#        USAGE: ./convenge.pl  
#
#  DESCRIPTION: convenge 2 inp 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: ZHANG XI (student), zhangxi1014@gmail.com
# ORGANIZATION: sibs
#      VERSION: 1.0
#      CREATED: 03/13/2014 15:56:34
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

my ($file1, $file2, $file3, $file4) = @ARGV;
open FILTER1, ">$file3";
open FILTER2, ">$file4";
open INP1, "$file1";
if(!open INP1,"$file1"){
	die "cannot open INP1\n";
}
open INP2, "$file2";
if(!open INP2,"$file2"){
	die "cannot open INP2\n";
}

my(@a,@inp2_list,%inp2_string);

my $line1 = 0;
my $line2 = 0;
my $bb;
while ($bb=<INP2>){
	if ($bb =~ m/^dbSNP/){
		next;}
	if($bb =~ m/^\d+$/){
		next;}
	if($bb =~ m/^\s+$/){
		next;}
	$line2 ++;
	my @entry2 = split /\s+/, $bb; 
	$inp2_string{$entry2[0]}=$bb;
}
close INP2;

my $aa;
while ($aa=<INP1>){
	if ($aa =~ m/^dbSNP/){
		next;}
	if($aa =~ m/^\d+$/){
		next;}
	if($aa =~ m/^\s+$/){
		next;}
	$line1++;
	my @entry1 = split /\t+/, $aa;
	if (exists $inp2_string{$entry1[0]}){
			print FILTER1 "$aa";
			print FILTER2 "$inp2_string{$entry1[0]}";
		}
		else {
		next;
		}
}
close INP1;
close FILTER1;
close FILTER2;

