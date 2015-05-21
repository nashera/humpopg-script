#! /usr/bin/perl -w
use strict;

my $pop=shift @ARGV;

# chdir "/picb/humpopg2/denglian/GeneAnnotation" or die "cannot change directory:$!";
# my @files=glob"$pop\_chr*";
# my $file=join " ",@files;
# my $command="cat $file > /picb/humpopg6/share/denglian/Processed_Malay/iHS/$pop";
# `$command`;

# chdir "/picb/humpopg6/share/denglian/Processed_Malay/f4test/Freq/" or die "cannot change directory:$!";
# my @files=glob"*";
# foreach my $file (@files) {
# 	my $command="sort -k1g -k3g $file > /picb/humpopg6/share/denglian/Processed_Malay/f4test/Freq2/$file";
# 	`$command`;
# }

# chdir "/picb/humpopg6/share/denglian/Processed_Malay/f3test/Uyghur/" or die "cannot change directory:$!";
# my @files=glob"*.inp";
# foreach my $file (@files) {
# 	my ($command,$n);
# 	if ($file !~ /chr1.inp$/) {
# 		open F1,$file or die "cannot open the file:$!";
# 		my $i=0;
# 		while(<F1>){
# 			$i++;
# 			chomp;
# 			if ($i==2) {
# 				$n=$_;
# 				last;
# 			}
# 		}
# 		close F1;
# 		$command="tail -$n $file > /picb/humpopg6/share/denglian/Processed_Malay/f3test/Uyghur2/$file";
# 		`$command`;
# 	}
# }

# chdir "/picb/humpopg2/denglian/PSEA_Affy6/1_Analysis/Fst/Annotation/GeneMapping/top1000/Geneline" or die "cannot change directory:$!";
# my @files=glob"*.txt";
# foreach (@files) {
# 	print "$_\n";
# 	my $command="sort -k4gr $_ > /picb/humpopg2/denglian/PSEA_Affy6/1_Analysis/Fst/Annotation/GeneMapping/top1000/Geneline/Geneline/$_";
# 	`$command`;
# }

chdir "/picb/humpopg2/denglian/Data/yx/IRN" or die "cannot change directory:$!";
my $i;
my @files;
for ($i=1;$i<=22;$i++) {
	my $file="chr".$i.".markers";
	print "$file\n";
	push @files,$file;
}
my $f=join " ",@files;
#my $out=$pop;
my $out="Markers.txt";
my $command="cat $f > /picb/humpopg2/denglian/Data/yx/IRN/$out";
`$command`;
