#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: get_same_snp.pl
#
#        USAGE: ./get_same_snp.pl  
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
#      CREATED: 07/10/2014 03:55:18 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

my $dir= "/picb/humpopg7/zhangxi/test";
my @snp_index;
my @snp_matrix;
opendir(DIRNAME, $dir) || die $!;
open(OUT,">","$dir/match.txt") || die $!;
open(ERROR,">","$dir/error.txt") || die $!;
open (NU,">","$dir/number.txt")  || die $!;
my @snp_inp = grep{/^snp/} readdir DIRNAME;
for my $i(0..$#snp_inp){
	open (SNP_FH,"<","$dir/$snp_inp[$i]") || die $!;
	if ($i == 0){
		@snp_index = <SNP_FH>;
		chomp(@snp_index);
		next;
	}
	my @inp_snp= <SNP_FH>;
	chomp(@inp_snp);
	push @snp_matrix,[@inp_snp];
	close SNP_FH;
}
print ERROR "@{$snp_matrix[0]}";
my $nu_match ;
my @snp_match;
foreach my $snp(@snp_index){
	$nu_match = 0;
	for my $j(0..$#snp_matrix){
		my @row = @{$snp_matrix[$j]};
		my %hash = map {$row[$_],$_+1}0..$#row;
			if (exists $hash{$snp}){
				$nu_match ++;}
		}
		print NU "$nu_match\n";
		if ($nu_match == $#snp_matrix+1){
			print OUT "$snp\n";}
	}

close OUT;
	
		
