#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: Austronesian_merge.2.pl
#
#        USAGE: ./Austronesian_merge.2.pl  
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
#      CREATED: 07/11/2014 12:01:36 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
my $dir = "/picb/humpopg7/zhangxi/affymetrix/out";
my $dir_out= "/picb/humpopg7/zhangxi/merge";
open(SNP_INDEX,"<","/picb/humpopg7/zhangxi/merge_CHD.inp") || die $!;
my @index_list;
while(my $aa= <SNP_INDEX>){
	if ($aa =~ m/^daSNP/){
		next;}
	if($aa =~ m/^\d+$/){
		next;}
	if($aa =~ m/^\s+$/){
		next;}
	my $index_line ++;
	my @index_entry = split;
my @dir_inp = grep {/inp$/} readdir DIRNAME;
foreach my $file(@dir_inp){
	open(OUT,">","$dir_out/merge_$file");
	open(INP,"<","$dir/$file");
	my %inp_string=();
	while(my $bb =<INP>){
		if ($bb =~ m/^dbSNP/){
			print OUT "$bb";
			next;}
		if ($bb =~ m/^\d+$/){
			next;}
		if($bb =~ m/^\s+$/){
			next;}
	my @entry=split /\s+/, $bb;
	$inp_string{$entry[0]} = $bb;
}
	foreach my $rsid(@index_list){
	if(exists $inp_string{$rsid}){
		print OUT "$inp_string{$rsid}";
		}
	}
	close OUT;
	close INP;
}

