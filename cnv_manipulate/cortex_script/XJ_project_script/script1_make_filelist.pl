#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script1_make_filelist.pl
#
#        USAGE: ./script1_make_filelist.pl  
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
#      CREATED: 02/01/2015 04:28:07 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;


my $inp_root="/picb/humpopg-bigdata/AAGC/data/sequence";
my $out_root="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling";

opendir(INP,"$inp_root") || die $!;
my @all_ind=grep{/1997|1998|1999|2000|2001/} readdir INP;
for my $i(0..$#all_ind){
	print "$all_ind[$i]\n";
	my $x="$out_root/$all_ind[$i]";
	if(! -e $x){
		mkdir("$out_root/$all_ind[$i]",0777) || die $!;
	}
	my $ind_fq_dir="$inp_root/$all_ind[$i]";
	opendir(FQ,"$ind_fq_dir")|| die $!;

	my $pout1 = "$x/$all_ind[$i]_pe1";
	my $pout2 = "$x/$all_ind[$i]_pe2";

	open(POUT1,">",$pout1) || die $!;
	open(POUT2,">",$pout2) || die $!;
	my @pe_files=grep{/^\w.+gz$/} readdir FQ;
	print "@pe_files";
	my $pe1;
	my $pe2;
	if ($#pe_files != 1)
	{
		die("Abort mission.the paired end files does not complete")
	}	
	if (($pe_files[0] =~ /R1\.fastq\.gz$/) && ($pe_files[1] =~ /R2\.fastq\.gz$/)) 
	{
	$pe1="$ind_fq_dir/$pe_files[0]";
	$pe2="$ind_fq_dir/$pe_files[1]";
	}
	elsif (($pe_files[0] =~ /R2\.fastq\.gz$/) && ($pe_files[1] =~ /R1\.fastq\.gz$/)) 
	{
	$pe1="$ind_fq_dir/$pe_files[1]";
	$pe2="$ind_fq_dir/$pe_files[0]";
	}
	print POUT1 "$pe1\n";
	print POUT2 "$pe2\n";

}
print "\n\n\n\n*********\nFinished!\n\n";
