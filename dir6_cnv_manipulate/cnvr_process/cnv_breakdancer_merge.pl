#
#/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: cnv_breakdancer_merge.pl
#
#        USAGE: ./cnv_breakdancer_merge.pl  
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
#      CREATED: 01/21/2015 03:08:59 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $inp_dir="/picb/papgi-paa/zhangxi/xinjiang_ngs_sortedBAM_chr";
my $out_dir="/picb/papgi-pgg/zhangxi/ngs_CNV_analysis/breakdancer_dir_analysis/cnvr_analysis";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_ind=grep{/^WGC/} readdir DIRHANDLE;
my %hash;
my @all_cnv_types=("DEL","ITX","INV","INS");

for my $i(0..$#all_ind){
	my $ind_dir="$inp_dir/$all_ind[$i]";
	my $x="$out_dir/$all_ind[$i]";
	if (! -e $x){
		mkdir("$out_dir/$all_ind[$i]",0777) || die $!;
	}
	my @ind_cnv;
	opendir(INDDIR,"$ind_dir") || die $!;
	my @all_chr=grep{/^chr\d/} readdir INDDIR;
	for my $j(0..$#all_chr){
		my ($chr)=($all_chr[$j]=~/chr(\d+)/);
		opendir(CHRHANDLE,"$ind_dir/$all_chr[$j]") || die $!;
		my @sv_files=grep{/sv$/} readdir CHRHANDLE;
		my $sv=shift @sv_files;
		open(my $sv_file,"<","$ind_dir/$all_chr[$j]/$sv") || die $!;
		my $ra_ind_chr_sv_output= abstract_breakdancer($sv_file);
		my $y="$out_dir/$all_ind[$i]/chr_$chr";
		if(! -e $y){
		mkdir("$out_dir/$all_ind[$i]/chr_$chr",0777) || die $!;
	}
		chdir "$out_dir/$all_ind[$i]/chr_$chr" || die $!;
		my $out_cnv_type_file="$y/$all_ind[$i]\_chr$chr\_@$ra_ind_chr_sv_output[4]";
		if (-e $out_cnv_type_file){
		open (OUT,">>","$out_cnv_type_file") || die $!;
	}
	else{
		open (OUT,">","$out_cnv_type_file") || die $!;
	}
	print OUT "@$ra_ind_chr_sv_output[0]\t@$ra_ind_chr_sv_output[1]\t@$ra_ind_chr_sv_output[2]\t@$ra_ind_chr_sv_output[3]\t@$ra_ind_chr_sv_output[4]\n";

	$ind_cnv[$chr]=$ra_ind_chr_sv_output;


		}
		my ($key,$value)= ($all_ind[$i],[@ind_cnv]);
		$hash{$key}=$value;
}
my %paired_sample;
my @samples= keys %hash;
my @samples_number=map{substr($samples[$_],4,5)}0..$#samples;
for my $i(0..$#samples_number){
	$paired_sample{$samples_number[$i]}=$samples[$i];
}
my @sorted_samples_number=sort{$a <=> $b} @samples_number;
my @sorted_samples;
for my $number(@sorted_samples_number){
	push @sorted_samples,$paired_sample{$number};
}




sub abstract_breakdancer{
	my ($file)=@_;
	my @ind_chr_cnv;
	while(<$file>){
		if(/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my $length=($entry[4]-$entry[1]);
		my $all=[$entry[0],$entry[1],$entry[4],$length,$entry[6]]; #[chromosome,pos1,pos2,type]
		push @ind_chr_cnv,$all;
		}
	my $ra_ind_chr_cnv=\@ind_chr_cnv;
	return $ra_ind_chr_cnv;
}
