#! /usr/bin/perl -w
use strict;


# open F1,"/picb/humpopg2/denglian/MalaysianProject/PCA/input/test_MLY.snp";
# open F2,"/picb/humpopg2/denglian/MalaysianProject/PCA/input/test_YRI.snp";
# open F3,"/picb/humpopg2/denglian/MalaysianProject/PCA/input/test_NGO.snp";
# open F4,"/picb/humpopg2/denglian/MalaysianProject/PCA/input/test_CHB.snp";
# open OUT,">","/picb/humpopg2/denglian/MalaysianProject/PCA/input/test";
# my ($f1,$f2,$f3,$f4);
# while($f1=<F1>,$f2=<F2>,$f3=<F3>,$f4=<F4>) {
# 	chomp ($f1,$f2,$f3,$f4);
# 	if ($f1 eq $f2 and $f2 eq $f3 and $f3 eq $f4) {
# 		print OUT "OK\n";
# 	} else {
# 		print OUT "$f1,$f2,$f3,$f4\n";
# 	}
# }
# close F1;
# close F2;
# close F3,
# close F4;
# close OUT;

# open F1,"/picb/humpopg2/denglian/MalaysianProject/test/NG";
# my %snp;
# while(<F1>){
# 	chomp;
# 	my @line=split/\t/;
# 	push @{$snp{$line[0]}},join " ",@line;
# }
# close F1;
# open F1,"/picb/humpopg2/denglian/MalaysianProject/test/YRI";
# while(<F1>){
# 	chomp;
# 	my @line=split/\t/;
# 	push @{$snp{$line[0]}},join " ",@line;
# }
# close F1;
# 
# my %mismatch;
# foreach (keys %snp) {
# 	if (@{$snp{$_}} == 2) {
# 		if (@{$snp{$_}}[0] ne @{$snp{$_}}[1]) {
# 			# $mismatch{$_}=1;
# 			print "@{$snp{$_}}[0]\n";
# 		}
# 	}
# }

# open F1,"/picb/humpopg2/denglian/MalaysianProject/Data/PLINK/QC/SNP.nomaf";
# open OUT,">","/picb/humpopg2/denglian/MalaysianProject/Data/PLINK/QC/SNP.nomaf_NEW";
# while(<F1>){
# 	chomp;
# 	if (not exists $mismatch{$_}) {
# 		print OUT "$_\n";
# 	}
# }
# close F1;
# close OUT;

open INP, "/picb/humpopg6/denglian/PCA/Data/7Pops/INP/7Pops_Skin.inp" or die "Cannot open the file!";
open SNP, ">", "/picb/humpopg6/denglian/PCA/7Pops_Skin.snp" or die "Cannot open the file!";
while (<INP>) {
    chomp;
    my @line=split /\t/;
#     if ($line[0]=~/^rs/ and not exists $mismatch{$line[0]}) {
    if ($line[0]=~/^rs/) {
    	my ($a1,$a2);
    	if ($line[4] =~ /(\w)\/(\w)/) {
    		($a1,$a2)=($1,$2);
    	}
		print SNP join " ", $line[0], $line[1], "0", $line[2], $a1, $a2;
		print SNP "\n";
	}
}
close INP;
close SNP;
