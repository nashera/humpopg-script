#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
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
#my $file4;
($file1, $file2, $file3) = @ARGV;

open MAP, "$file1" || die $!;
open PED, "$file2" || die $!;
open OUT, ">$file3";
#open ERROR,">$file4";
my $aa;
my $map_line=0;
my @map_matrix;
while($aa=<MAP>){
	$map_line++;
	chomp $aa;
	my @map_entry=split (/\s+/, $aa);
	my @three=($map_entry[1], $map_entry[0], $map_entry[3]);
	map{$map_matrix[$map_line][$_+1]=$three[$_]}0..2;
}
close MAP;
my $bb;
my $ped_line=0;
my @ped_matrix;
my @human_id;
while($bb=<PED>){
	chomp $bb;
	my @ref;
	my @alt;
	$ped_line++;
	my @ped_entry=split (/\s+/, $bb);
	push @human_id, $ped_entry[1];
	@ref=@ped_entry[grep{!($_ % 2)}6..$#ped_entry];
	@alt=@ped_entry[grep{$_ % 2}6..$#ped_entry];
	map{$ped_matrix[$ped_line][$_ +1]=$ref[$_]."/".$alt[$_]}0..$#ref;
}
close PED;
my $i;
my $j;
my @refalt;
my @matrix_out;
my @copy;
for $i(1..$map_line){
	map{$copy[$_-1]=$ped_matrix[$_][$i]}1..$ped_line;
	$refalt[$i]=&select_allele(\@copy);

			map{$matrix_out[$_][$i]=&tran_allele($ped_matrix[$_][$i],$refalt[$i] )}1..$ped_line;
}


print OUT "$ped_line\n$map_line\n\n";
print OUT "dbSNP_ID\tChromosome\tPosition\tStrand\tRef/Alt";
for $i(0..$#human_id){
	print OUT "\t$human_id[$i]";
}
print OUT "\n";
for $i(1..$map_line){
	print OUT "$map_matrix[$i][1]\t$map_matrix[$i][2]\t$map_matrix[$i][3]";
	print OUT "\t+\t$refalt[$i]";
	for $j(1..$ped_line){
			if (! defined $matrix_out[$j][$i]){
				#print ERROR "$j\t$i\n";
			print OUT "\t ";
			next;}
		print OUT "\t$matrix_out[$j][$i]";
	}
	print OUT "\n";
}
close OUT;
#close ERROR;






########################################


sub tran_allele{
	 my($snp,$allele)=@_;
	 my $t;
	 my @p=split (/\//, $snp);
	 my @q=split (/\//, $allele);
	if ($p[0] ne $p[1] ){
		$t = "H";}
	else {if ($p[0] eq $q[0])
			{$t = "A";}
		if ($p[0] eq $q[1])
			{$t = "B";}
		if ($p[0] eq "0")
			{$t = "U";}
	}
	return $t;
	}
sub select_allele{
	my ($ra_snp)=@_;
	my $a=$$ra_snp[1];
	my $b;
	my @c;
	my $d;
	my $rf;
	foreach (@$ra_snp){

		$b=$_;
		if ( $a ne $b ){
			last;
		}
	}
	@c=(split(/\//,$a),split(/\//,$b));
	foreach (@c){
		$d=$_;
		if($d ne $c[0]){
			last;
		}
	}
	$rf=$c[0]."/".$d;
	return $rf;
}
