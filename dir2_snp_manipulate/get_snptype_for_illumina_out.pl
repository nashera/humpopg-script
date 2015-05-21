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
my @map_matrix;
while($aa=<MAP>){
	$map_line++;
	if ($map_line == 1){next;}

	chomp $aa;
	my @map_entry=split(/\s+/, $aa);
	my @four=($map_entry[1], $map_entry[2], $map_entry[3],substr($map_entry[4],1,3));
	map{$map_matrix[$map_line-1][$_+1]=$four[$_]}0..3;
}
close MAP;
my $bb;
my $line=0;
my @human_id;
my $col;
my $snp_number=$map_line-1;
my $sample_number;
while($bb=<FULLTYPE>){
	$line++;
	my @entry;
	if ($line == 1){
		chomp $bb;
		my @entry=split(/\s+/, $bb);
		$sample_number=$#entry-4;
		map{$human_id[$_-5]=$entry[$_]}5..$#entry;
		print OUT "$snp_number\n$sample_number\n\n";
		print OUT "dbSNP_ID\tChromosome\tposition\tRef/Alt";
		for my $human_id(@human_id){
			print OUT "\t$human_id";
		}
		print OUT "\n";
	next;
	}
	chomp $bb;
	@entry=split(/\s+/, $bb);
	print OUT "$entry[1]\t$map_matrix[$line-1][2]\t$map_matrix[$line-1][3]\t$map_matrix[$line-1][4]";
	my @copy;
	map{$copy[$_-4]=&tran_allele($entry[$_])}5..$#entry;
	for my $i(1..$#copy){
		print OUT "\t$copy[$i]";
	}
	print OUT "\n";
	}


close FULLTYPE;
close OUT;
close ERROR;

##################################################################################################################


	sub tran_allele{
	my ($snp)=@_;
	my $s;
	if ($snp eq "AA") {
		$s = "A";}
	if ($snp eq "BB") {
		$s = "B";}
	if ($snp eq "AB") {
		$s = "H";}
	if ($snp eq "NC") {
		$s = "U";}
	return $s;
		}


