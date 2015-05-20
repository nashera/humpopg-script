#!/usr/bin/env perl 
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
use utf8;
my ($file1, $file2, $file3, $file4) = @ARGV;
open FILTER1 ">file3";
open FILTER2 ">file4"
open INP1, "$file1";
if(!open INP1,"$file1"){
	die "cannot open INP1\n";
}
open INP2, "$file2";
if(!open INP2,"$file2"){
	die "cannot open INP2\n"
}

my(@a,@b)
$aa=0;
$bb=0;
$line1 =  0;
$col1 = 0 ;
$line2 = 0;
$col2 =0;
while (<INP1>=$aa){
	$line++;
	my @entry1 = split /\t+/ $aa;
	push @a, $entry1(0);
	while (<INP2>=$bb)
		$line2 ++;
		my @entry2=split /\t+/ $bb;
		push @b, $entry2(0);
		if (grep { $entry1(0) eq $_ } @b ){
			print FILTER1 "$line1\t $_\n";
		}else {
			print FILTER1 "0\n";
		}
}
close INP1;
close INP2;
close FILTER1;


for my $i(1.$#b){
	if (grep {$b($i) eq $_ } @a){
		print FILTER2 "$i \t $_\n";
	}else {
	print FILTER2 "0\n";
}

close FILTER2;

