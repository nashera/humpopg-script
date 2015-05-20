#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: inp_to_beagle.pl
#
#        USAGE: ./inp_to_beagle.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: zhangxi,zhangxi1014@gmail.com
# ORGANIZATION: picb
#      VERSION: 1.0
#      CREATED: 09/11/2014 08:45:32 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
my ($file1,$file2)=@ARGV;

open(INP,"<","$file1") || die $!;
open(OUT,">","$file2")  ;
print OUT "##fileformat=VCFv4.1\n";
while(<INP>){
	if (length($_)<20){
		next;}
	if (/^dbSNP/){
		chomp;
		my @head_entry= split;
		print OUT "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT";
		for my $i(5..$#head_entry){
			print OUT "\t$head_entry[$i]"};
		print OUT "\n";
		next;
	}
	chomp;
	my @entry=split;
	my $ref=substr($entry[4],0,1);
	my $alt=substr($entry[4],2,1);
	print OUT "$entry[1]\t$entry[2]\t$entry[0]\t$ref\t$alt\t100\tpass\tVT=SNP;+;\tGT";
	for my $i(5..$#entry){
		if ($entry[$i] eq "A"){
			print OUT "\t0/0";
		}
		elsif ($entry[$i] eq "B"){
			print OUT "\t1/1";
		}
		elsif ($entry[$i] eq "U"){
			print OUT "\t./.";
		}
		elsif ($entry[$i] eq "H"){
			print OUT "\t1/0";
		}
		else{print "there is a mistake\n";}
	}
	print OUT "\n";

}
close INP;
close OUT;
