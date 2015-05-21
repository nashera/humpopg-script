#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: cnv_count_number.pl
#
#        USAGE: ./cnv_count_number.pl  
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
#      CREATED: 12/22/2014 07:37:28 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use Statistics::R;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
my $inp_dir="/picb/papgi-pgg/zhangxi/ngs_CNV_analysis/breakdancer_dir_analysis";
my $out_dir="/picb/papgi-pgg/zhangxi/ngs_CNV_analysis/breakdancer_dir_analysis";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_chr=grep{/^chr/} readdir DIRHANDLE;
my @sorted_all_chr;
for my $i(1..22){
	for my $chr(@all_chr){
	if($chr =~ /\D$i\D/){
		push @sorted_all_chr,$chr;
	}
}
}
my @cnv_del_number;
my $wrap_line=sub{return shift};
my @cnv_ins_number;
my @cnv_itx_number;
my @cnv_inv_number;
my @chr_cnv_length;
my @all_cnv_length;
my @del_array;
my @itx_array;
my @inv_array;
my @ins_array;
for my $i(0..$#sorted_all_chr){
	my $chr_del_number=0;
	my $chr_itx_number=0;
	my $chr_inv_number=0;
	my $chr_ins_number=0;
	my @single_chr_length=();
	my $line=0;
	open (my $chr_file,"<","$inp_dir/$sorted_all_chr[$i]") || die $!;
	while (<$chr_file>){
		$line++;
		chomp;
		my @entry=split;
		if ($entry[4] eq "DEL") {
			$chr_del_number++;
			push @del_array,$entry[3];
		}
		elsif($entry[4] eq "ITX"){
			$chr_itx_number++;
			push @itx_array,$entry[3];
			}
		elsif($entry[4] eq "INV"){
			$chr_inv_number++;
			push @inv_array,$entry[3];}
		elsif($entry[4] eq "INS"){
			$chr_ins_number++;
			push @ins_array,$entry[3];}
		else{print "the chr is chr($i+1),the line is $line, there is another type\n";
		}
		push @single_chr_length,$entry[3];

	}
	push @chr_cnv_length,[@single_chr_length];
	@all_cnv_length=(@all_cnv_length,@single_chr_length);
	push @cnv_del_number,$chr_del_number;
	push @cnv_itx_number,$chr_itx_number;
	push @cnv_inv_number,$chr_inv_number;
	push @cnv_ins_number,$chr_ins_number;
	print "chr $i+1 complete\n";
	
}
#my $ra_all_cnv_length=\@all_cnv_length;
#my $R = Statistics::R->new();
#$R->start();
#my $cmd="r_call_cnv_length"."<-c(".join(',',@all_cnv_length).")";
#$cmd=&$wrap_line($cmd);
#my $out=$R->run($cmd);
##$R->set('r_all_cnv_length',\@all_cnv_length);
#my $all_length_figure="all_length_figure.pdf";
#$R->run(qq`pdf("$all_length_figure",width=500,height=500)`);
#$R->run(q`barplot(r_all_cnv_length,border="NA",space=0)`);
#$R->run(q`dev.off()`);
#$R->stop();

chdir "$out_dir" or die $!;

open(my $file_all_cnv_length,">","$out_dir/all_cnv_length.txt") || die $!;
for my $i(0..$#all_cnv_length){
	print $file_all_cnv_length "$all_cnv_length[$i]\n";}


open(my $file_del_length,">","$out_dir/del_length.txt") || die $!;
	for my $i(0..$#del_array){
		print $file_del_length "$del_array[$i]\n";}
open(my $file_itx_length,">","$out_dir/itx_length.txt") || die $!;
	for my $i(0..$#itx_array){
		print $file_itx_length "$itx_array[$i]\n";}
open(my $file_inv_length,">","$out_dir/inv_length.txt") || die $!;
	for my $i(0..$#inv_array){
		print $file_inv_length "$inv_array[$i]\n";}
open(my $file_ins_length,">","$out_dir/ins_length.txt") || die $!;
	for my $i(0..$#ins_array){
		print $file_ins_length "$ins_array[$i]\n";}

open(my $cnv_number,">","$out_dir/cnv_number.txt") || die $!;
print $cnv_number "chr\tDEL\tITX\tINV\tINS\n";


for my $j(0..21){
	my $chr=$j+1;
	print $cnv_number "$chr\t$cnv_del_number[$j]\t$cnv_itx_number[$j]\t$cnv_inv_number[$j]\t$cnv_ins_number[$j]\n";
}
my $del_total_number=scalar @del_array;
my $itx_total_number=scalar @itx_array;
my $inv_total_number=scalar @inv_array;
my $ins_total_number=scalar @ins_array;
my $total = scalar @all_cnv_length;
print $cnv_number "total\t$del_total_number\t$itx_total_number\t$inv_total_number\t$ins_total_number\t$total\n";
