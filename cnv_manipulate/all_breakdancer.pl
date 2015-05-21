#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: all_breakdancer.pl
#
#        USAGE: ./all_breakdancer.pl  
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
#      CREATED: 12/16/2014 08:33:52 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
my $inp_dir="/picb/papgi-pgg/zhangxi/xinjiang_ngs_breakdancer";
my $out_dir="/picb/papgi-pgg/zhangxi/ngs_CNV_analysis/breakdancer_dir_analysis";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_ind=grep{/^WGC/} readdir DIRHANDLE;
my %hash;

for my $i(0..$#all_ind){
	my $ind_dir="$inp_dir/$all_ind[$i]";
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


for my $h(1..22){
	open(my $chr_file,">","$out_dir/chr$h\_sv\_file.txt");
	for my $k(0..$#sorted_samples){
		my @sv_array=@{${$hash{$sorted_samples[$k]}}[$h]};
		for my $l(0..$#sv_array){
			print $chr_file "${$sv_array[$l]}[0]\t${$sv_array[$l]}[1]\t${$sv_array[$l]}[2]\t${$sv_array[$l]}[3]\t${$sv_array[$l]}[4]\n";
		}
	}
	close $chr_file;
}


for my $k(0..$#sorted_samples){
	open (my $single_sample_cnv_file,">","$out_dir/single_cnv_dir/$sorted_samples[$k]\_cnv.txt");
	for my $h(1..22){
		my @sv_array=@{${$hash{$sorted_samples[$k]}}[$h]};
		for my $l(0..$#sv_array){
			print $single_sample_cnv_file "${$sv_array[$l]}[0]\t${$sv_array[$l]}[1]\t${$sv_array[$l]}[2]\t${$sv_array[$l]}[3]\t${$sv_array[$l]}[4]\n";
		}
	}
	close $single_sample_cnv_file;
}

###########################################################


sub abstract_breakdancer{
	my ($file)=@_;
	my @ind_chr_cnv;
	while(<$file>){
		if (/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my $length=($entry[4]-$entry[1]);
		my $all=[$entry[0],$entry[1],$entry[4],$length,$entry[6]]; # [chromosome,pos1,pos2,length,type]
		push @ind_chr_cnv,$all;
	}
	my $ra_ind_chr_cnv=\@ind_chr_cnv;
return $ra_ind_chr_cnv;
}
