#! perl -w
use strict;

## 1 ??

open INF,"/picb/humpopg2/denglian/PanAsian_SEA/OrigData/snp_inf_positive_all.txt" or die "Cannot open the file!";
my $i=1;
my %line;
while (<INF>) {
    my @line=split /\s|\t/;
    push @{$line{$i}},$line[0];
    push @{$line{$i}},$line[2];
    $i++;
}
close INF;
open PED,"/picb/humpopg2/denglian/PanAsian_SEA/OrigData/PSEA_QC_MalayAll_4pops.ped" or die "Cannot open the file!";
open GENO,">","/picb/humpopg2/denglian/PSEA_Affy6/ThirdAnalysis/PCA/PSEA_14pops.geno" or die "Cannot open the file!";
my $j;
my $k=1;
my %line2;
my %sample;
while (<PED>) {
    my @line=split;
    $sample{$k}=$line[1];
    $k++;
    for ($j=1;$j<=17388;$j++) {
        my ($a,$b,$c);
        if ($line[4+2*$j] =~ /[a-zA-Z]/ && $line[5+2*$j] =~ /[a-zA-Z]/) {
			if ($line[4+2*$j] eq $line{$j} -> [1]) {
				$a=1;
			}
			else {
				$a=0;
			}
			if ($line[5+2*$j] eq $line{$j} -> [1]) {
				$b=1;
			}
			else {
				$b=0;
			}
			$c=$a+$b;
		}
		else {
		    $c=9
		}
        push @{$line2{$line{$j}->[0]}},$c;
    }
}
my ($m,$n);
for ($m=1;$m<=17388;$m++) {
    for ($n=1;$n<=77;$n++) {
		print GENO join " ",$line{$m} -> [0],$sample{$n},$line2{$line{$m}->[0]}->[$n-1];
		print GENO "\n";
	}
}
close PED;
close GENO;

## 2

# open F1,"/picb/humpopg2/denglian/Malaysian/PCA/pop_index.txt";
# while (<F1>) {
# chomp;
# print "$_\n";
# 
# chdir "/picb/humpopg7/denglian/MalaysianProject/PCA/Data";
# my @files= glob"*";
# 
# foreach my $file (@files) {
# 	
# 	my $pop;
# 	if ($file =~ /^(\w+)_(\w+)-(\w+).inp/) {$pop = "$1.$2"."-$3";}
# 	elsif ($file =~ /^(\w+).(\w+).inp/) {$pop = "$1.$2";}
# 	my $geno = "$pop.geno";
# 	
# 	open INF, "$file" or die "Cannot open the file!";
# 	open GENO,">","/picb/humpopg7/denglian/MalaysianProject/PCA/PCA_input/$geno" or die "Cannot open the file!";
# 	while (<INF>) {
# 		chomp;
# 		my $i;
# 		my @line=split /\t|\s/;
# 		my @geno;
# 		if ($line[0]=~/^rs/) {
# 			for ($i=5;$i<=$#line;$i++) {
# 				if ($line[$i] eq "A") {
# 					push @geno,2;
# 				} elsif ($line[$i] eq "H") {
# 					push @geno,1;
# 				} elsif ($line[$i] eq "B") {
# 					push @geno,0;
# 				} else {
# 					push @geno,9;
# 				}
# 			} 
# 		print GENO @geno;
# 		print GENO "\n";
# 		}
# 	}
# 	print "$pop\n";
# }

# while (<INF>) {
#     chomp;
#     my $i;
#     my @line=split /\t|\s/;
#     my @geno;
#     if ($line[0]=~/^rs/) {
# 		for ($i=5;$i<=$#line;$i++) {
# 			if ($line[$i] eq "A") {
# 				push @geno,2;
# 			} elsif ($line[$i] eq "H") {
# 				push @geno,1;
# 			} elsif ($line[$i] eq "B") {
# 				push @geno,0;
# 			} else {
# 				push @geno,9;
# 			}
# 		} 
#     print GENO @geno;
#     print GENO "\n";
#     }
# }
# close INF;
# close GENO;
# 
# # }
# # 
