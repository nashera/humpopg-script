#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: get_valid_snp.pl
#
#        USAGE: ./get_valid_snp.pl  
#
#  DESCRIPTION: 从20万个SNP中随机挑选万个SNP,按照染色体进行排列
#
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: zhangxi,zhangxi1014@gmail.com
# ORGANIZATION: picb
#      VERSION: 1.0
#      CREATED: 07/22/2014 03:30:01 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

my ($file1,$file2) = @ARGV;
open(INP,"<",$file1) || die $!;
open(OUT,">",$file2);
my $row=0;
my @chr;
while(<INP>){
	if(/^dbSNP/){
	next;}
	$row++;
	chomp;
	my @entry= split;
	my %rec = ();
	my $i=0;
	my ($key,$value) = ($entry[2],$entry[0]);
	$rec{$key} = $value;
	if ($entry[1] =~ /\d+/){
		$i= $entry[1] +0;}
	elsif ($entry[1] eq "X"){
		$i = 23;}
	elsif ($entry[1] eq "Y"){
		$i = 24;}
	else{print STDERR "the row is $row\n";}
	if (!defined $chr[$i]){
		$chr[$i] ={};}
	%{$chr[$i]}=(%{$chr[$i]},%rec);
	if($row%100 == 0){
		print STDERR "print $row\n";}
	}
	print STDERR "the number of chr is  $#chr\n";
for my $h(1..$#chr){
	my @positions = keys(%{$chr[$h]});
	my @sorted_positions=sort{$a <=> $b} @positions;
	my $get_snp_num= int(($#positions)/10);
	my @rand_position_num=&creat_rand_num($#positions,$get_snp_num);
	my @rand_positions=map{$sorted_positions[$rand_position_num[$_]]}0..$#rand_position_num;
	for my $k(0..$#rand_positions){
		print OUT "$chr[$h]->{$rand_positions[$k]}\t$h\n";}
	print STDERR "chr $h complete\n";
}






####################################################################################
sub creat_rand_num{
	my ($max_num,$max_count)=@_;
	my $i = 0;
	my %rand=();
	while(1){
		my $no=int(rand($max_num));
		if(! exists($rand{$no})){
			$rand{$no}=1;
			$i++;}
		if($i >= $max_count){
			last;}
	}
	my @rand_num=keys(%rand);
	return @rand_num;
}

