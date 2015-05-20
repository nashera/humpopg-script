#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: get_snptype.pl
#
#        USAGE: ./get_snptype.pl  
#
#  DESCRIPTION: illumina trans map
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: zhangxi,zhangxi1014@gmail.com
# ORGANIZATION: picb
#      VERSION: 1.0
#      CREATED: 05/08/2014 09:09:32 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
my $file1;
my $file2;
my $file3;
my $file4;
($file1, $file2, $file3, $file4)= @ARGV;
open MAP, "$file1"||die $!;
open FULLTYPE, "$file2"||die $!;
open OUT, ">$file3" || dile $!;
open ERROR, ">$file4" || die $!;

my $aa;
my $map_line=0;
my $map_matrix;
while($aa=<MAP>){
	$map_line++;
	if ($map_line == 1){next;}

	chomp $aa;
	my @map_entry=split(/\s+/, $aa);
	my @four=($map_entry[1], $map_entry[2], $map_entry[3],substr($map_entry[5],1,3));
	map{$map_matrix[$map_line-1][$_+1]=$four[$_]}0..3;
}
close MAP;
my $bb;
my $line=0;
my @human_id;
my $col;
my $snp_number;
my $sample_number;
while($bb=<FULLTYPE>){
	$line++;
	if ($line == 1){next;}
	if ($line == 2){next;}
	if ($line == 3){next;}
	if ($line == 4){next;}
	if ($line == 5){
		$snp_number=split(/\s+/, $_)->[2];
		next;
	}
	
	if ($line == 6){next;}
	if ($line == 7){
		$sample_number=split(/\s+/, $_)->[2];
		next;
	}

	if ($line == 8){next;}
	if ($line == 9){next;}
	if ($line == 10){
		chomp $bb;
		@human_id=split(/\s+/, $bb);
		print OUT "$snp_number\n$sample_number\n\n";
		print OUT "dbSNP_ID\tChromosome\tposition\tRef/Alt";
		for my $human_id(@human_id){
			print OUT "\t$human_id";
		}
		print OUT "\n";
	next;
	}
	chomp $bb;
	my @entry=split(/\s+/, $bb);
	print OUT "@entry[0]\t$map_matrix[$map_line-10][2]\t$map_matrix[$map_line-10][3]\t$map_matrix[$map_line-10][4]";
	my @copy;
	map{$copy[$_]=&tran_allele(substr($entry[$_],0,2),$map_matrix[$map_line-10][4])}1..$#entry
	for my $i(1..$#copy){
		print OUT "$copy[$i]";}
	}



##################################################################################################################


	sub tran_allele{
	my ($snp,  $allele)=@_;
	my $s;
	my @p=split(/\//,$allele);
	my @q=(substr($snp,0,1), substr($snp,1,1));
	if ($q[0] ne $q[1]) {
		$s = "H";}
	if ($q[0] eq $p[1]){
		if ($q[0] eq $p[0])
			{$s = "A";}
		if ($q[0] eq $p[1])
			{$s = "B";}
		if ($q[0] eq "-")
			{$s = "U";}
			}


