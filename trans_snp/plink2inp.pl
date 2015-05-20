#!/usr/bin/perl 
#===============================================================================
#
#         FILE: plink2inp.pl
#
#        USAGE: ./plink2inp.pl  
#
#  DESCRIPTION: transform plink to inp
#
#      OPTIONS: ---
# REQUIREMENTS:
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: ZHANG XI (student), zhangxi1014@gmail.com
# ORGANIZATION: sibs
#      VERSION: 1.0
#      CREATED: 12/22/2013 16:13:11
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
my $file1;
my $file2;
my $file3;
my $pop_name;
($file1, $file2, $file3, $pop_name) = @ARGV;

open MAP, "$file1" || die "cannot open $file1";
open PED, "$file2" || die  "cannot open $file2";
open OUT, ">$file3";
my $aa;
my $map_line=0;
my @map_matrix;
while($aa= <MAP>){
	$map_line++;
	chomp $aa;
	my @map_entry=split /\s+/, $aa;
	my @three=($map_entry[1], $map_entry[0], $map_entry[3]);
	map{$map_matrix[$map_line][$_+1]=$three[$_]}0..2;
}
close MAP;
my $bb;
my $ped_line=0;
my @ped_matrix;
my @human_id;
my $col;
while($bb=<PED>){
	my @ref;
	my @alt;
	$ped_line++;
	my @ped_entry=split /\s+/, $bb;
	push @human_id, $ped_entry[1];
	@ref=@ped_entry[grep{$_ % 2}6..$#ped_entry];
	@alt=@ped_entry[grep{!($_ % 2)}6..$#ped_entry];
	map{$ped_matrix[$ped_line][$_ +1]=$ref[$_]."/".$alt[$_]}0..$#ref;
	$col = $#ref;
}
close PED;
my $i;
my $j;
my @refalt;
my @matrix_out;
my @m;
if ($col == $map_line){
	for $i(1..$map_line){
		for $j(1..$ped_line){
			@m=split(/\//, $ped_matrix[$j][$i]);
			if ($m[0] ne $m[1]){
				last;
				$refalt[$i] = $ped_matrix[$j][$i];
			}
			else {next;}
			}
			map{$matrix_out[$_][$i]=&tran_allele($ped_matrix[$_][$i],$refalt[$i] )}1..$ped_line;
}
}
else {print "there is a mistake\n";}

print OUT "$ped_line\n$map_line\n\n";
print OUT "dbSNP_ID\tChromosome\tPosition\tStrand\tRef/Alt";
for $i(0..$#human_id){
	print OUT "\t$human_id[$i]";
}
print OUT "\n";
for $i(1..$map_line){
	print OUT "$map_matrix[$i][0]\t$map_matrix[$i][1]\t$map_matrix[$i][1]";
	print OUT "\t+\t$refalt[$i]";
	for $j(1..$ped_line){
		print OUT "\t$matrix_out[$j][$i]";
	}
	print OUT "\n";
}
close OUT;







########################################


sub tran_allele{
	 my($snp,$allele)=@_;
	 my @p=split (/\//, $snp);
	 my @q=split (/\//, $allele);
	if ($p[0] ne $p[1] ){
		return "H";}
	if ($p[0] eq $p[1]){
		if ($p[0] eq $q[0])
			{return "A";}
		if ($p[0] eq $q[1])
			{return "B";}
			}
		}
