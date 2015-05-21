#! /usr/bin/perl -w
use strict;
my ($bgldir,$inp,$out)=@ARGV;

my %anc; ## SNPs with clear ancestral allele.
open ANC,"/picb/humpopg2/denglian/PSEA_Affy6/2_Analysis/DAF/Affy6_na27_anc_anno.inp" or die "cannot open the file:$!";
while(<ANC>){
    chomp;
    my @line=split/\t/;
    if ($line[6] ne "?") {
        $anc{$line[1]}=$line[6];
    }
}
close ANC;

my %snp; ## SNPs involved in phasing.
chdir $bgldir or die "cannot change the directory:$!";
my @bgl=glob "*";
foreach my $bgl (@bgl) {
	print "$bgl\n";
	open F1,$bgl or die "cannot open the file:$!";
	my $head=<F1>;
	while (<F1>) {
		my @line=split;
		$snp{$line[1]}=0;
	}
	close F1;
}

open OUT,">",$out or die "cannot open the file:$!";
open INF,$inp or die "cannot open the file:$!";
while(<INF>){
	chomp;
	my @line=split/\t/;
	if (exists $snp{$line[0]} and exists $anc{$line[0]}) {
		print OUT join " ",$line[0],$line[1],$line[2],1,2;
		print OUT "\n";
	}
}
close INF;
close INF;

