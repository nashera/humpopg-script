#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: inp_to_plink.pl
#
#        USAGE: ./inp_to_plink.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: zhangxi,zhangxi1014@gmail.com
# ORGANIZATION: picb
#      VERSION: 1.0
#      CREATED: 09/15/2014 09:14:01 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $file1;
my $file2;
my $file3;
my $pop_name;
my @matrix_a;
my @matrix_b;
my @inf;
my @ind_id;

($file1,$file2,$file3,$pop_name)=@ARGV;

open(INP,"$file1")||die $!; 
open( MAP,">","$file2");
open(PED,">","$file3");
my $line=0;

while(<INP>){
	chomp;
	my (@a,@b);
	my $long=length($_);
	if($long<30){next;}
	if(/^dbSNP/){
		my @head_entry=split; 
		@ind_id=@head_entry[5..$#head_entry];
		next;
		}
		if(! /\//){
			next;}
		$line++;
		my @entry=split;
		my @allele=split( /\//,$entry[4]);
		my $three=[$entry[1],$entry[0],$entry[2]];
		push @inf,$three;
		for my $i(5..$#entry){
			if($entry[$i] eq "A"){
				push @a,$allele[0];
				push @b,$allele[0];
			}
			elsif($entry[$i] eq "B"){
				push @a,$allele[1];
				push @b,$allele[1];
			}
			elsif($entry[$i] eq "H"){
				push @a, $allele[0];
				push @b,$allele[1];
			}
			elsif($entry[$i] eq "U" or $entry[$i] eq "N"){
				push @a,"0";
				push @b,"0";
			}
			else{print "there is a mistake the line is $line the snp is $i"}
			
			}	
			map{$matrix_a[$line][$_] = $a[$_]} 0..$#a;
			map{$matrix_b[$line][$_] = $b[$_]} 0..$#b;
			}

print "line is $line\n";
print "sample_num is $#ind_id\n";

close INP;
foreach  my  $i(0..$#inf){
	print MAP "$inf[$i]->[0]\t$inf[$i]->[1]\t0\t$inf[$i]->[2]\n";
}
for my $i(0..$#ind_id){
	print PED "$pop_name\t$ind_id[$i]\t0\t0\t0\t-9";
	for my $j(1..$line){
		print PED"\t$matrix_a[$j][$i]\t$matrix_b[$j][$i]";
	}
		print PED"\n";
	}


close MAP;
close PED;

	
	
