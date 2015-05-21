#! /usr/bin/perl -w
use strict;

my ($input,$chr,$bgldir,$snp,$outdir)=@ARGV;

my %anc; ## rs ID -> ancestral allele
open ANC,"/picb/humpopg2/denglian/PSEA_Affy6/2_Analysis/DAF/Affy6_na27_anc_anno.inp" or die "cannot open the file:$!";
while(<ANC>){
    chomp;
    my @line=split/\t/;
    if ($line[6] ne "?") {
        $anc{$line[1]}=$line[6];
    }
}
close ANC;

my %pop; ## pop -> start_col, ... , end_col
@{$pop{"MLY"}}=(1 .. 34);
@{$pop{"NGO"}}=(35 .. 124);
@{$pop{"PML"}}=(125 .. 132);
@{$pop{"SNI"}}=(133 .. 166);
# @{$pop{"CEU"}}=(167 .. 390);
# @{$pop{"CHB"}}=(391 .. 664);
# @{$pop{"JPT"}}=(665 .. 890);
# @{$pop{"YRI"}}=(891 .. 1122);

open F1,$snp or die "cannot open the file:$!";
my %marker; 
while (<F1>) {
	chomp;
	my @line=split;
	$marker{$line[0]}=1;
}
close F1;

my %rs; ## index (number) -> rs ID 
chdir $bgldir or die "cannot change the directory:$!";
my $bgl="Chr$chr"."_phased.Chr$chr".".bgl.phased";
my $j=0;
print "$bgl\n";
open F1,$bgl or die "cannot open the file:$!";
my $head=<F1>;
while (<F1>) {
	$j++;
	my @line=split;
	if (exists $marker{$line[1]}) {
		$rs{$j}=$line[1];
	}
}
close F1;

foreach my $p (keys %pop) {
	print "$p $chr\n";
	if (-e "$outdir/$p") {} else {
		mkdir "$outdir/$p" or die "cannot make the directory:$!"; ## Make output directory for each pop.
	}
	my $out="$outdir/$p/$p"."_Chr$chr";
	open OUT,">$out" or die "cannot open the file:$!";
	
	my ($start_col,$end_col)=(@{$pop{$p}}[0],@{$pop{$p}}[-1]);
	for (my $j=$start_col;$j<=$end_col;$j++) {
		my $col='$'.($j+2);
		my @hap=split/\n/,`awk '{print $col}' $input`; ## One haplotype, with the first one being the individual ID.
		my @new_hap;
		for (my $k=1;$k<=$#hap+1;$k++) {
			if (exists $rs{$k}) {
				if ($hap[$k] =~ /\w+/) {
					if ($hap[$k] eq $anc{$rs{$k}}) {push @new_hap, 1;}
					else {push @new_hap, 2;}
				} else {
					push @new_hap, 0;
				}
			}
		}
		print OUT join " ",$j,@new_hap;
		print OUT "\n";
	}
	close OUT;
}
