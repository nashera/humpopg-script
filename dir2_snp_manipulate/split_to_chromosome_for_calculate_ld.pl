#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: split_to_chromosome.pl
#
#        USAGE: ./split_to_chromosome.pl  
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
#      CREATED: 09/12/2014 04:08:36 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use File::Basename qw(basename dirname);
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my ($file) = @ARGV;
my $base=basename($file);
my $pop=substr($base,0,3);
my $dir= dirname($file);
my $head;


open (INP,"<",$file) || die $!;
my $row=0;
while(<INP>){
	chomp;
	if(/^dbSNP/){
		$head=$_;
		next;}
	if(length($_)<20){
	next;}
	$row++;
	my $i;
	my @entry=split;
	if($entry[1]=~/\d+/){
		$i =$entry[1] + 0;}
	elsif ($entry[1] eq "X"){
		$i=23;}
	elsif ($entry[1] eq "Y"){
		$i=24;}
	else{print STDERR "there is a mistake in row $row";}
	my $outfile="$dir/$pop\_chr$i";
	if(-e  $outfile){
	open (OUT,">>","$outfile") || die $!;
	}
	else{
		open (OUT,">","$dir/$pop\_chr$i") || die $!;
		print OUT "$head\n";
	}
	print OUT "$_\n";
	close OUT;
	
}



	

