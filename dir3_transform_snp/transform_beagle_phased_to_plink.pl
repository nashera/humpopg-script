#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: transform_beagle_phased_to_plink.pl
#
#        USAGE: ./transform_beagle_phased_to_plink.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
# ORGANIZATION: picb
#      VERSION: 1.0
#      CREATED: 09/22/2014 11:52:21 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
use File::Basename qw(basename dirname);

my ($file1,$file2,$file3) =@ARGV;
my @inf;

open(INP,"<","$file1") || die $!;
open(MAP ,">","$file2");
open(PED,">","$file3") ;
my @matrix_a;
my @matrix_b;
my $base=basename($file1);
my $pop_name=substr($base,0,3);
my $line;

my @ind_id;
while(<INP>){
	my (@a,@b);
	if(/^\#\#/){
		next}
	if(/^\#CHROM/){
		chomp;
		my @head=split;
		@ind_id=@head[9..$#head];
		next;
	}
	$line++;
	my @entry=split;
	my $three=[$entry[0],$entry[2],$entry[1]];
	push @inf,$three;
	for my $i(9..$#entry){
		my $allele=$entry[$i];
		my $m=substr($allele,0,1);
		my $n=substr($allele,2,1);
		if ($m ==0 ){
			push @a,$entry[3];
		}
		elsif($m==1){
			push @b,$entry[4];
		}
		else{print "mistake,the line is $line!";}
		if ($n == 0){
			push @b,$entry[3];
		}
		elsif($m == 1){
			push @b,$entry[4];
		}
		else {print "mistake,the line is $line!";
		}
	}

	map{$matrix_a[$line][$_]} 0..$#a;
	map{$matrix_b[$line][$_]} 0..$#b;
	}

print "line is $line\n";
print "sample_num is $#ind_id\n";


close INP;
foreach my $i(0..$#inf){
	print MAP "$inf[$i] ->[0] \t$inf[$i] -> [1]\t0\t$inf[$i]\n";
}
for my $i(0..$#ind_id){
	print PED "$pop_name\t$ind_id[$i]\t0\t0\t0\t-9";
	for my $j(1..$line){
		print PED "\t$matrix_a[$j][$j]\t$matrix_b[$j][$i]";
	}
}
close MAP;
close PED;
