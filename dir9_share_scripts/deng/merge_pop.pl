#! /usr/bin/perl -w
use strict;

# my @pop;
# open F1,"/picb/humpopg2/denglian/Malaysian/PCA/pop_index.txt";
# while (<F1>) {
# 	chomp;
# # 	my @l = split /\s/;
# # 	print "$l[1]\n";
# 	my $name = $_.".ind";
# 	push @pop, "/picb/humpopg2/denglian/Malaysian/PCA/ind/$name";
# }
# close F1;
# 
# my $pops = join " ", @pop;
# `cat $pops > /picb/humpopg2/denglian/Malaysian/PCA/M2_NoYRICEUGIH.ind`;
# 
# @pop = ();
# open F1,"/picb/humpopg2/denglian/Malaysian/PCA/pop_index.txt";
# while (<F1>) {
# 	chomp;
# # 	my @l = split /\s/;
# # 	print "$l[1]\n";
# 	my $name = $_.".geno";
# 	push @pop, "/picb/humpopg2/denglian/Malaysian/PCA/geno/$name";
# }
# close F1;
# 
# $pops = join " ", @pop;
# `paste -d '' $pops > /picb/humpopg2/denglian/Malaysian/PCA/M2_NoYRICEUGIH.geno`;

# chdir "/picb/humpopg2/denglian/AsianDiversityProject/Pops_ShareSNPs/Sampling_20inds/test";
# my @files = glob "*.inp_TP";
# 
# foreach (@files) {
# my $command = "perl /picb/humpopg2/denglian/script/transposition.pl $_";
# print "$_\n";
# `$command`;
# }

my @test = (1 .. 10);
my $test = join "",@test[0 .. 3];
print $test,"\n";