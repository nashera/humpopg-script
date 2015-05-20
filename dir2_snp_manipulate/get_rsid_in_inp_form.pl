#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: split_rsid.pl
#
#        USAGE: ./split_rsid.pl  
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
#      CREATED: 07/09/2014 05:09:24 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

my $dir= "/picb/humpopg7/zhangxi/Austronesian";
opendir(DIRNAME,$dir) || dir $!;
my @dir_inp = grep{/inp$/} readdir DIRNAME;
foreach my $file(@dir_inp){
	open(SNP_OUT,">"."$dir/snp_$file");
	open(INP_FH,"<","$dir/$file");
	while(<INP_FH>){
		chomp;
		if (/^dbSNP/){
			next;}
		if (/^\d+$/){
			next;}
		if (/^\s*$/){
			next;}
		my @entry = split;
		print SNP_OUT "$entry[0]\n";
	}
	close SNP_OUT;
	close INP_FH;
}

