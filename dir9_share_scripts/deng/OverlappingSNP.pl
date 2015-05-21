#! /usr/bin/perl -w
use strict;

my ($in,$file,$out)=@ARGV;
# my @pop=("YRI","CEU","CHB","JPT");
# foreach my $pop (@pop) {
# print "$pop\n";

# my $in="/picb/humpopg7/denglian/MalaysianProject/HaplotypeDiversity/Data/Sampling_17Inds/$pop";
# my $out="/picb/humpopg2/denglian/MalaysianProject/Data/20130717/FinalData/WithHM/Sampling_83inds/BiasCorrected/$pop";

#chdir "/picb/humpopg2/denglian/AsianDiversityProject/Pops";
#my @files = glob "Srilanka*inp.gz";
#my $file = "/picb/humpopg6/denglian/Malay/Data/Sampling20inds_IndependentSNPs/AFFY.MLY.inp.gz";

my %snp;
open F1,"$file" or die "cannot open the file:$!";
#my $head=<F1>;
while (<F1>) {
        chomp;
        my @line=split /\s+/;
        if (exists $line[1]) {
 		   my $key="$line[0] $line[3]";
#       my $key = $_;
			$snp{$key}++;
         }
}
close F1;

#foreach my $in (@files) {
#print "$in\n";

#my $out;
#if ($in =~ /^(\w+).(\w+).b37.inp.gz/) {
#       $out = "$1.$2.inp"; 
#}
#$out = "/picb/humpopg6/denglian/Malay/$out";

# open F1,"gzip -dc $in|";
open F1,$in;
open OUT,">",$out;
while(<F1>){
        chomp;
        my @line=split /\s+/;
         if ($line[0] =~ /^db/ or $line[0] =~ /^Chr/ or $line[0] =~ /^Pos/ or $line[0] =~ /^Str/ or $line[0] =~ /^All/) {
#         if ($line[0] =~ /#CHROM/) {
                print OUT join "\t",@line;
                print OUT "\n";
        } else {
                my $key="$line[0] $line[3]";
#               if (exists $snp{$key}) {
                 if (exists $snp{$key} and $snp{$key}==1) {
#                         print OUT join "\t",@line;
#                         print OUT "\n";
						print OUT "$line[1]\n";
                }
        }
}
close F1;
close OUT;

