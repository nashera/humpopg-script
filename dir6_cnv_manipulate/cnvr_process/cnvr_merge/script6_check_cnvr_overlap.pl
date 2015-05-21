#===============================================================================
#
#         FILE: script6_check_cnvr_overlap.pl
#
#        USAGE: ./script6_check_cnvr_overlap.pl  
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
#      CREATED: 02/05/2015 08:58:27 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $cnvr_root="/picb/humpopg-bigdata/zhangxi/cnvr_filtered";
my $sv_type="INV";
opendir (CNVR,"$cnvr_root") || die $!;
my @all_sv_dirs=  grep{/$sv_type/}  readdir CNVR;

for my $i(0..$#all_sv_dirs){
	my $sv_dir="$cnvr_root/$all_sv_dirs[$i]";
	opendir(SV,"$sv_dir") || die $!;
	my @sv_chr_cnvr_files=grep{/chr_10/} readdir SV;
	for my $j(0..$#sv_chr_cnvr_files){
		print "$sv_chr_cnvr_files[$j]\n";
		my $sv_file="$sv_dir/$sv_chr_cnvr_files[$i]";
		open(my $filehand,"<","$sv_file") || die $!;
		my $ra_all_cnvr=abstract_data($filehand);
		my $length= scalar(@$ra_all_cnvr)-1;
		my $n=0;
		my @s;
		for my $k(0..$length) {
			my $jud;
			if ($k==0){
				$jud=0;}
			elsif($k >= 1){
				my $jud=one_to_one($ra_all_cnvr->[$k-1],$ra_all_cnvr->[$k]);
				if ($jud == 1){
					print "$k\toverlapping\t";
					$n++;}
				elsif($jud == 2){
					print "localtion trans!";
				}
			}
				push @s,$jud; 
		}
		my @merged_cnvr;
		foreach my $m(0..$length){
			}
		close $filehand;

	}
}


	
sub abstract_data{
	my ($file)=@_;
	my @ind_chr_cnv;
	while(<$file>){
		if(/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my $length=($entry[1]-$entry[0]);
		my $all=[$entry[0],$entry[1]];
		push @ind_chr_cnv,$all;
		}
	my $ra_ind_chr_cnv=\@ind_chr_cnv;
	return $ra_ind_chr_cnv; #[chromosome,pos1,pos2,type,$length,num_reas
}

sub one_to_one{   # compare two breakpoint to output the CNVR
	my ($ra_one,$ra_two)=@_;
	my @one=@$ra_one;
	my @two=@$ra_two;
	my $t;
	if($one[1] <= $two[0]){
		$t=0;}
	elsif($one[0] <= $two[0] and $two[0] <= $one[1] and $one[1] <= $two[1]){
		$t=1;}
	elsif($one[0] <= $two[0] and $two[1] <= $one[1]){
		$t=1;}
	elsif($two[0] <= $one[0] and $one[1] <= $two[1]){
		$t=1;}
	elsif($two[0] <= $one[1] and $one[0] <= $two[1] and $two[1] <= $one[1]){
		$t=1;}
	elsif($two[1] <= $one[0]){
		$t=2;}
	else{print "there is a mistake";}
	return $t;
}
