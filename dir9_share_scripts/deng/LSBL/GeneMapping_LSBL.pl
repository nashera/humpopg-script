#! /usr/bin/perl -w
use strict;

my ($file,$out,$out2) = @ARGV;

my %pos;
open INF,"/picb/humpopg2/denglian/GeneAnnotation/GeneAnnotation_Summary.txt" or die "Cannot open the file:$!";
while(<INF>){
	chomp;
	my @line=split;
	push @{$pos{$line[1]}}, \@line;
}
close INF;

my $i=1;
my (@rs1,@rs2,@rs3);
my (%rs1,%rs2,%rs3,%rs4);
open FILE,$file or die "Cannot open the file:$!";
open OUT,">",$out or die "Can't open the file: $!";
while(<FILE>){
	s/^\s+//;
     if ($i<=1000) {
        chomp;
		my @line=split/\s+/;
		$rs1{"line[0] $line[1]"}=1;
		if ($pos{$line[0]}) { 
			my @l = @{$pos{$line[0]}};
			foreach (@l) {
				   my @p=@{$_};
				   foreach (@p) {
						 if ($p[4] >= $line[1] && $p[3] <= $line[1]) {						 
							 print OUT "@line"," ",$p[0],"\n";
							 $rs2{"line[0] $line[1]"}=1;
						 } 
				   }
			}    
		}
	}
    $i++;
}
close FILE;

foreach (keys %rs1) {
	if (not exists $rs2{$_}) {
		push @rs1,$_;
	}
}

$i=1;
open FILE,$file or die "Cannot open the file:$!";
while(<FILE>){
	s/^\s+//;
     if ($i<=1000) {
		chomp;
		my @line=split/\s+/;
		foreach (@rs1) {
			if ($_ eq "line[0] $line[1]") {
				if ($pos{$line[0]}) { 
					my @l = @{$pos{$line[0]}};
					foreach (@l) {
						   my @p=@{$_};
						   foreach (@p) {
								 if (($p[4]+10000) >= $line[1] && ($p[3]-10000) <= $line[1]) {						 
									 print OUT "@line"," ",$p[0],"\n";
									 $rs3{"line[0] $line[1]"}=1;
								 } 
						   }
					}    
				}
			}
		}
	}
	$i++;
}
close FILE;

foreach (keys %rs1) {
	if (not exists $rs2{$_} and not exists $rs3{$_}) {
		push @rs2,$_;
	}
}

$i=1;
open FILE,$file or die "Cannot open the file:$!";
while(<FILE>){
	s/^\s+//;
     if ($i<=1000) {
		chomp;
		my @line=split/\s+/;
		foreach (@rs2) {
			if ($_ eq "line[0] $line[1]") {
				if ($pos{$line[0]}) { 
					my @l = @{$pos{$line[0]}};
					foreach (@l) {
						   my @p=@{$_};
						   foreach (@p) {
								 if (($p[4]+20000) >= $line[1] && ($p[3]-20000) <= $line[1]) {						 
									 print OUT "@line"," ",$p[0],"\n";
									 $rs4{"line[0] $line[1]"}=1;
								 } 
						   }
					}    
				}
			}
		}
	}
	$i++;
}
close FILE;

foreach (keys %rs1) {
	if (not exists $rs2{$_} and not exists $rs3{$_} and not exists $rs4{$_}) {
		push @rs3,$_;
	}
}

$i=1;
open FILE,$file or die "Cannot open the file:$!";
while(<FILE>){
	s/^\s+//;
     if ($i<=1000) {
		chomp;
		my @line=split/\s+/;
		foreach (@rs3) {
			if ($_ eq "line[0] $line[1]") {
				if ($pos{$line[0]}) { 
					my @l = @{$pos{$line[0]}};
					foreach (@l) {
						   my @p=@{$_};
						   foreach (@p) {
								 if (($p[4]+30000) >= $line[1] && ($p[3]-30000) <= $line[1]) {						 
									 print OUT "@line"," ",$p[0],"\n";
								 } 
						   }
					}    
				}
			}
		}
	}
	$i++;
}
close FILE;

close OUT;

 `sort -k3gr $out|uniq| column -t > $out2`; 

my $n1=@rs1;
my $n2=@rs2;
my $n3=@rs3;

print "$n1\n";
print "$n2\n";
print "$n3\n";

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
