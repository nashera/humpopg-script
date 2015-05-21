#! /usr/bin/perl -w 
use strict;

my ($indir, $pop1, $pop2, $pop3, $outdir) = @ARGV;
# my @all=("PML","NGO","SNI","MLY","CEU","CHB","YRI");
# my ($j,$k);


chdir "$indir" or die "cannot change directory:$!";
my @files = glob "*.fst.gz";
my @file;
foreach my $file (@files) {
	if (($file =~ /^$pop1/ or $file =~ /-$pop1/) and ($file =~ /^$pop2/ or $file =~ /-$pop2/)) {$file[0] = $file;}
	if (($file =~ /^$pop1/ or $file =~ /-$pop1/) and ($file =~ /^$pop3/ or $file =~ /-$pop3/)) {$file[1] = $file;}
	if (($file =~ /^$pop2/ or $file =~ /-$pop2/) and ($file =~ /^$pop3/ or $file =~ /-$pop3/)) {$file[2] = $file;}
}

#my @file=("$pop1"."-$pop2.fst.gz","$pop1"."-$pop3.fst.gz","$pop2"."-$pop3.fst.gz");

###单个处理

my %snp;
foreach my $file (@file) {
	open F1,"gzip -dc $file|" or die "cannot open the file:$!";
	print "$file\n";
	while(<F1>){
		chomp;
		my @line=split /\s+/;
		my $k="$line[2]\t$line[3]";
		push @{$snp{$k}},$line[6];
	}
	close F1;
}

my ($lsbl1,$lsbl2,$lsbl3);
my $out = "$outdir/$pop1"."-".$pop2."-".$pop3.".lsbl";
open OUT,">",$out or die "cannot open the file:$!";
foreach (keys %snp) {
	my $n=@{$snp{$_}};
	if ($n==3) {
		$lsbl1=(@{$snp{$_}}[0]+@{$snp{$_}}[1]-@{$snp{$_}}[2])/2;
		$lsbl2=(@{$snp{$_}}[0]+@{$snp{$_}}[2]-@{$snp{$_}}[1])/2;
		$lsbl3=(@{$snp{$_}}[1]+@{$snp{$_}}[2]-@{$snp{$_}}[0])/2;
		$lsbl1=0 if ($lsbl1<0);
		$lsbl2=0 if ($lsbl2<0);
		$lsbl3=0 if ($lsbl3<0);
		print OUT "$_\t$lsbl1\t$lsbl2\t$lsbl3\n";
	}
}
close OUT;



###批量处理

# for ($j=0;$j<=$#all-1;$j++) {
# 	my $pop1=$all[$j];		
# 	next if ($pop1 eq $pop);
# 	for ($k=$j+1;$k<=$#all;$k++) {
# 		my $pop2=$all[$k];		
# 		next if ($pop2 eq $pop1 or $pop2 eq $pop);
# 		
# 		my ($fst1,$fst2,$fst3);
# 		foreach my $file (@file) {
# 			$fst1=$file if ($file =~ /$pop/ and $file =~ /$pop1/);
# 			$fst2=$file if ($file =~ /$pop/ and $file =~ /$pop2/);
# 			$fst3=$file if ($file =~ /$pop1/ and $file =~ /$pop2/);
# 		}
# 		print "$pop $pop1 $pop2 $fst1 $fst2 $fst3\n";
# 		
# 		my (%fst1,%fst2,%fst3);
# 		open F1,$fst1 or die "cannot open the file:$!";
# 		while(<F1>){
# 			chomp;
# 			my @line=split/\t/;
# # 			print "@line","\n";
# 			push @{$fst1{$line[0]}}, $line[1]; # Alleles
# 			push @{$fst1{$line[0]}}, $line[2]; # Chromosome
# 			push @{$fst1{$line[0]}}, $line[3]; # Position
# 			push @{$fst1{$line[0]}}, $line[6]; # Fst
# 		}
# 		close F1;
# 		
# 		open F2,$fst2 or die "cannot open the file:$!";
# 		while(<F2>){
# 			chomp;
# 			my @line=split/\t/;
# 			$fst2{$line[0]}=$line[6];
# 		}
# 		close F2;
# 		
# 		open F3,$fst3 or die "cannot open the file:$!";
# 		while(<F3>){
# 			chomp;
# 			my @line=split/\t/;
# 			$fst3{$line[0]}=$line[6];
# 		}
# 		close F3;
# 		
# 		my $out=$pop.".".$pop1.".".$pop2;
# 		open OUT,">","/picb/humpopg2/denglian/MalaysianProject/LSBL/$out" or die "cannot open the file:$!";
# 		foreach my $snp (keys %fst1) {
# 			if (exists $fst2{$snp} and exists $fst3{$snp}) {
# 				my $lsbl=($fst1{$snp}->[3]+$fst2{$snp}-$fst3{$snp})/2;
# 				$lsbl=0 if ($lsbl<0);
# 				print OUT "$fst1{$snp}->[1] $snp $fst1{$snp}->[0] $fst1{$snp}->[2] $lsbl\n";
# 			}
# 		}
# 		close OUT;
# 		`sort -k1g -k4g /picb/humpopg2/denglian/MalaysianProject/LSBL/$out > /picb/humpopg2/denglian/MalaysianProject/LSBL/results/$out`;
# 		`sort -k5gr /picb/humpopg2/denglian/MalaysianProject/LSBL/$out > /picb/humpopg2/denglian/MalaysianProject/LSBL/results_sorted/$out`;
# 	}
# }
# 
