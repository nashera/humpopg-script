#! /usr/bin/perl -w
use strict;

my $file = shift @ARGV;

chdir "/picb/humpopg6/denglian/Negrito_Pygmy/GeneMapping/Fst" or die "cannot change directory:$!";
# my @file=glob "*.fst.d.gz";

my %pos;
open INF,"gzip -dc /picb/humpopg6/Share_NegPyg_LD_DL/resource/RefSeq.gene.ucsc.hg19.gz|" or die "Cannot open the file:$!";
my $head=<INF>;
while(<INF>){
	chomp;
	my @line=split /\s+/;
	my $chr;
	if ($line[2] =~ /chr(\d+)/) {
		$chr = $1;
#	 	$chr = $line[0];
		push @{$pos{$chr}}, \@line;
# 		if ($chr>=1 and $chr<=22) {} else {print "$chr\n";}
	}
}
close INF;

# foreach my $file (@file) {
	
	print "$file\n";

	open FILE,"gzip -dc $file|" or die "Cannot open the file:$!";
	my @f = <FILE>;
	my $count = @f;
	my $i_max=0.05*$count;
	close FILE;
	my $out=$file."-".int($i_max);
	open OUT,">/picb/humpopg6/denglian/Negrito_Pygmy/GeneMapping/Fst/SinglePopulation/Similar/2$out" or die "Can't open the file: $!";

	my $i=0;	
	my %snp;
	open FILE,"gzip -dc $file|" or die "Cannot open the file:$!";
	while(<FILE>){
		s/^\s+//;
 	    if ($i<=$i_max) {
			chomp;
			my @line = split /\s+/;
			$snp{$line[0]} = \@line;
		}
	    $i++;
	}
	close FILE;
	
	
	foreach my $snp (keys %snp) {
		my @line = @{$snp{$snp}};
		if ($pos{$line[2]}) { 
			my @l = @{$pos{$line[2]}};
			foreach (@l) {
			 	  my @p=@{$_};
				 if ($p[5] >= $line[3] && $p[4] <= $line[3]) {						 
					 print OUT join "\t",@line,$p[12];
					 print OUT "\n";
					delete $snp{$snp};
				 } 
			}    
		}			
	}
	
	foreach my $snp (keys %snp) {
		my @line = @{$snp{$snp}};
		if ($pos{$line[2]}) { 
			my @l = @{$pos{$line[2]}};
			foreach (@l) {
			   my @p=@{$_};
				 if ($p[5]+10000 >= $line[3] && $p[4]-10000 <= $line[3]) {						 
					 print OUT join "\t",@line,$p[12];
					 print OUT "\n";
					delete $snp{$snp};
				 } 
			}    
		}			
	}

	foreach my $snp (keys %snp) {
		my @line = @{$snp{$snp}};
		if ($pos{$line[2]}) { 
			my @l = @{$pos{$line[2]}};
			foreach (@l) {
			   my @p=@{$_};
				 if ($p[5]+30000 >= $line[3] && $p[4]-30000 <= $line[3]) {						 
					 print OUT join "\t",@line,$p[12];
					 print OUT "\n";
					delete $snp{$snp};
				 } 
			}    
		}			
	}

	foreach my $snp (keys %snp) {
		my @line = @{$snp{$snp}};
		if ($pos{$line[2]}) { 
			my @l = @{$pos{$line[2]}};
			foreach (@l) {
			   my @p=@{$_};
				 if ($p[5]+50000 >= $line[3] && $p[4]-50000 <= $line[3]) {						 
					 print OUT join "\t",@line,$p[12];
					 print OUT "\n";
				 } 
			}    
		}			
	}

	close OUT;


# 	`uniq /picb/humpopg6/Share_NegPyg_LD_DL/GeneMapping/Fst/2$out > /picb/humpopg6/Share_NegPyg_LD_DL/GeneMapping/Fst/$out`;

 `sort -k1 /picb/humpopg6/denglian/Negrito_Pygmy/GeneMapping/Fst/SinglePopulation/Similar/2$out | uniq | sort -k7g > /picb/humpopg6/denglian/Negrito_Pygmy/GeneMapping/Fst/SinglePopulation/Similar/$out`; 

# }


# my ($file1,$file2,$out) = @ARGV;
# 
# my %gene;
# open FILE2, $file2 or die "Cannot open the file:$!";
# while(<FILE2>){
# 	chomp;
# 	my @line=split/\t/;
# 	$gene{$line[0]}=\@line;
# }
# close FILE2;
# 
# open FILE1, $file1 or die "Cannot open the file:$!";
# open OUT,">", $out or die "Cannot open the file:$!";
# while(<FILE1>){
# 	chomp;
# 	my @line=split;
# 	if (exists $gene{$line[5]}) {
# 		print OUT "@line"," ",@{$gene{$line[5]}},"\n";
# 	}
# }
# close FILE1;
# close OUT;
