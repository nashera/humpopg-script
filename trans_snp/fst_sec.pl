#!/use/bin/perl

# input file:  two population with the same loci ;  output file: fst in all loci  and fst in this area , frequence in all loci
use strict;
use warnings;
my($file1,$file2,$file3,$file4)=@ARGV;
open INP1, "$file1";
open INP2, "$file2";
sh
if (!open "$file1"){
	die "cannot open INP1\n"};
if (!open "$file2"){
	die "cannot open INP1\n"};
open FREQ, ">$file3";
open FST , ">$file4";

sub locus_fst{
	my (@humpop_genotype1,@humpop_genotype2)=@_;
	

	
