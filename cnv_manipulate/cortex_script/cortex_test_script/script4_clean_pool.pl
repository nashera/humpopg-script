#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script4_clean_pool.pl
#
#        USAGE: ./script4_clean_pool.pl  
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
#      CREATED: 02/06/2015 08:51:11 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $pop="UIG";
my $mem_height = 26;
my $mem_width = 450;
my $t="6";
my $root="/picb/humpopg-bigdata/zhangxi/cortex_test/";
my $cortex_dir = "/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/";
my $kmer= 31;


my $ctx_binary = check_cortex_compiled($cortex_dir, $kmer);

my $uncleaned_pool_bin = $root.$pop.".merged_uncleaned_samples.list1.chr22.k".$kmer.".q10.ctx";
if (! -e $uncleaned_pool_bin) {
	die ("pool didn't exist");
}
my $cleaned_pool_bin = $root.$pop.".merged_uncleaned_samples.list1.chr22.k".$kmer.".thresh$t.ctx";
my $output_clean_pool_log=$root."output_clean_pool.log";
my $cmd= $ctx_binary." --kmer_size $kmer --mem_height $mem_height --mem_width $mem_width --multicolor_bin $uncleaned_pool_bin --remove_low_coverage_supernodes $t --dump_binary  $cleaned_pool_bin> $output_clean_pool_log 2>&1";
print "$cmd\n";
my $ret = qx{$cmd};
print "$ret\n";
print "Finished building pool\n";
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

