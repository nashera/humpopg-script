#! /usr/bin/perl -w
## perl -I /picb/home50/denglian/Perl/lib/perl5/ /picb/humpopg2/denglian/PSEA_Affy6/Processed_Malay/scripts/GlobalFst.pl
use strict;
#use Statistics::Descriptive;

# my $file=shift (@ARGV);

chdir "/picb/humpopg6/denglian/Negrito_Pygmy_Selection/f4";
my @files=glob "*fst.gz";

open OUT,">>","/picb/humpopg6/denglian/Negrito_Pygmy_Selection/f4/Global.fst" or die "cannot open the file:$!";
# print join "\n",@files;
foreach my $file (@files) {
	print "Dealing with $file...\n";
	open F1,"gzip -dc $file|" or die "cannot open the file:$!";
	my ($a,$b)=(0,0);
#  	my $c=0;
	my %ab;
# 	my $k=0;
	while (<F1>) {
		chomp;
# 		$k++;
		my @line=split/\t/;
		$a += $line[4];
		$b += $line[5];
#  		$c += $line[6];
# 		push @{$ab{$k}},$line[4];
# 		push @{$ab{$k}},$line[5];
	}
	close F1;
	my $fst=$a/$b;
#  	my $fst=$c/31031;
	
	## Bootstrapping for IC
# 	my $i;
# 	my @fst;
# 	for ($i=1;$i<=1000;$i++) {
# 		print "$i\n";
# 		my (@index_new,@a_new,@b_new);
# 		my @index = keys %ab;
# 		push @index_new,$index[rand @index] for (1 .. 289998);
# 		foreach (@index_new) {
# 			push @a_new, @{$ab{$_}}[0];
# 			push @b_new, @{$ab{$_}}[1];
# 		}
# 		my ($a_new,$b_new)=(0,0);
# 		foreach (@a_new) {
# 			$a_new+=$_;
# 		}
# 		foreach (@b_new) {
# 			$b_new+=$_;
# 		}
# 		my $fst_new=$a_new/$b_new;
# 		push @fst,$fst_new;
# 	}
# 	my $stat = Statistics::Descriptive::Full->new();
# 	$stat->add_data(@fst);
# 	my $mean = $stat->mean();
# 	my $variance = $stat->variance();
# 	my $num = $stat->count();
# 	my $CI1=$mean-$variance/sqrt($num)*1.96;
# 	my $CI2=$mean+$variance/sqrt($num)*1.96;
# 	my $sd=sqrt($variance);
  	print OUT "$file\t$fst\n";
#   	print OUT "$file\t$mean\t$CI1\t$CI2\t$sd\n";
}
close OUT;

