#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script2_build_uncleaned_sample_graph_PAR_version2.pl
#
#        USAGE: ./script2_build_uncleaned_sample_graph_PAR_version2.pl  
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
#      CREATED: 02/01/2015 05:56:55 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;


use Getopt::Long;

my $inp_root   = "/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling";
my $out_root   = "/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling";
my $cortex_dir = "/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21";
my $kmer       = 31;

#### 0. Check args
if ($cortex_dir !~ /\/$/)
{
    $cortex_dir=$cortex_dir.'/';
}

my $ctx_binary = check_cortex_compiled($cortex_dir, $kmer);

opendir(INP,"$inp_root") || die $!;
my @all_ind=grep{/1997|1998|1999|2000|2001/} readdir INP;
for my $i(0..$#all_ind){

	## Assumes fastq are downloaded (they do NOT need to be unzipped any more), 
	##  and filelists are made and valid (contain only files that exists on the filelsystem)

	my $sample = "$all_ind[$i]";
	my $pe1_list = "$inp_root/$sample/$sample\_pe1";
	my $pe2_list = "$inp_root/$sample/$sample\_pe2";
	my $out_dir  = "$out_root/$sample/";

	if (!(-e $pe1_list))
	{
		die("Abort mission. The filelist $pe1_list does not exist - have you reun the rpevious script??");
	}
	if (!(-e $pe2_list))
	{
		die("Abort mission. The filelist $pe2_list does not exist - have you reun the rpevious script??");
	}


	my $binname = $out_dir.$sample.".uncleaned.q10.k31.ctx";
	my $log     = $binname.".log";

	my $cmd = $ctx_binary." --kmer_size $kmer --sample_id $sample --mem_height 25 --mem_width 15  --pe_list $pe1_list,$pe2_list  --quality_score_threshold 10  --dump_binary $binname --remove_pcr_duplicates > $log 2>&1";
	print "$cmd\n\n";
	my $ret = qx{$cmd};
	print "$ret\n";
	print "Finished building uncleaned graph pf $sample\n";
}



sub check_cortex_compiled
{
    my ($dir, $k) = @_;

    my $maxk=31;
    if (($k>32) && ($k<64) )
    {
	$maxk=63;
    }
    elsif ($k<32)
    {
	#maxk is already 31
    }
    else
    {
	die("This script expects you to use a k<64");
    }
	
    if (-e $dir."bin/cortex_var_".$maxk."_c1")
    {
	return $dir."bin/cortex_var_".$maxk."_c1";
    }
    else
    {
	die("Please go and compile Cortex in $cortex_dir for k=$kmer");
    }
}

