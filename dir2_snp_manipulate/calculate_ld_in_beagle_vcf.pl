#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: ld_for_vcf.pl
#
#        USAGE: ./ld_for_vcf.pl  
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
#      CREATED: 09/12/2014 09:13:31 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir="";
open(INP,">","$inp_dir/file.vcf") || die $!;
my $row=0;
my @all_loci;
while(<INP>){
	if (/^\#/){
		next;}
	$row++;
	chomp;
	my @entry=split;
	my  @pat;
	my	@mat;
	for my $i(10..$#entry){
		push @pat, substr($entry[$i],0,1);
		push @mat, substr($entry[$i],2,1);
		}
	my $single_locus_site=[[@pat],[@mat]];
	push @all_loci,$single_locus_site;
	
}
 
for my $i(1..$row){
	my @first_locus_pat=  @{$all_loci[$i-1] -> [0]};
	my @first_locus_mat=  @{$all_loci[$i-1] -> [1]};
	my $first_ref_frequency=&frequency(\@first_locus_pat,\@first_locus_mat);
	my $first_alt_frequency=1-$first_ref_frequency;
	my $p_A=$first_ref_frequency;
	my $p_a=$first_alt_frequency;
	for my $j(1..$row){
		my @second_locus_pat= @{$all_loci[$i-1] -> [0]};
		my @second_locus_mat= @{$all_loci[$i-1] -> [1]};
		my $second_ref_frequency=&frequecy(\@second_locus_pat,\@second_locus_mat);
		my $second_alt_frequency=1-$second_ref_frequency;
		my $p_B=$second_ref_frequency;
		my $p_b=$second_ref_frequency;
		my $p_AB=&frequency_of_AB(\@first_locus_pat,\@first_locus_mat,\@second_locus_pat,\@second_locus_mat);
		my $ld=(($p_AB-$p_A*$p_B)**2)/($p_A*$p_B*$p_a*$p_b);
		print OUT "$ld\t"

	}
	print OUT "\n";
}


############################################################
sub calculate {
	my @array=@_;
	my $count=0;
	for my $number(@array){
		if ($number == 0){
			$count++;
		}else{next;}
	}
	return $count;
}
sub frequency(\@\@){
	my($ra_locus_pat,$ra_locus_mat)=@_;
	my $n1=&calculate(@$ra_locus_pat);
	my $n2=&calculate(@$ra_locus_mat);
	my $frequency=($n1+$n2)/(2*(scalar(@$ra_locus_pat)));
	return $frequency;
}

sub frequency_of_AB(\@\@\@\@){
	my($ra_first_locus_pat,$ra_first_locus_mat,$ra_second_locus_pat,$ra_second_locus_mat)=@_;
	my $number_of_AB=0;
	my $human_num=scalar(@$ra_first_locus_pat);
	for my $i(1..$human_num) {
		my @t=($$ra_first_locus_pat[$i-1], $$ra_second_locus_pat[$i-1], $$ra_first_locus_pat[$i-1], $$ra_second_locus_mat[$i-1]);
		my $t_number= &calculate(\@t);
		if ( $t_number == 4){
			$number_of_AB=$number_of_AB+2;}
		elsif ( $t_number == 3 ){
			$number_of_AB=$number_of_AB+1;}
		elsif ( $t_number == 2 and $t[0] == 0 and $t[1] == 0){
			$number_of_AB=$number_of_AB+1;}
		elsif ( $t_number == 2 and $t[2] == 0 and $t[3] == 0){
			$number_of_AB=$number_of_AB+1;}
		else{next;}
		}
}

