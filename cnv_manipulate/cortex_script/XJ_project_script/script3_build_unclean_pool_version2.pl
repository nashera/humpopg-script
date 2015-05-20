#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script3_build_unclean_pool_version2.pl
#
#        USAGE: ./script3_build_unclean_pool_version2.pl  
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
#      CREATED: 02/01/2015 06:03:11 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

use Getopt::Long;
use File::Spec;

## Pass in a list of uncleaned binaries - all the uncleaned per-sample binaries, in one list

my $pop="UIG";
my $list_sample_uncleaned_bins="";
my $inpdir="/humpopg";
my $outdir="";
my $mem_height = 27;
my $mem_width = 110;
my $cortex_dir = "/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.12";
my $kmer= 31;

&GetOptions(
        'pop:s'                                  => \$pop, #population identifier, eg LWK
         'mem_height:i'                          =>\$mem_height,
         'mem_width:i'                           =>\$mem_width,
#        'kmer|k:i'                               => \$kmer,
);

opendir(INP,"$inpdir") || die $!;
my @all_ind=grep{/1997|1998|1999|2000|2001/} readdir INP;
my $list_sample_uncleaded_bins="$outdir/sample_uncleaned_bins_list1.txt";
open (LIST,">","$outdir/sample_uncleaned_bins_list1") || die $!;
for my $i(0..$#all_ind){
	my $x="$inpdir/$all_ind[$i]";
	opendir(BIN_DIR,"$x") || die $!;
	my @binary_bins=grep{/ctx$/} readdir BIN_DIR;
	my $bin=shift @binary_bins;
	my $sample_bin="$x/$bin";
	print LIST "$sample_bin\n";
}

close LIST;

check_args($pop, $list_sample_uncleaned_bins,$outdir, $mem_height, $mem_width);

if ($cortex_dir !~ /\/$/)
{
    $cortex_dir=$cortex_dir.'/';
}

my $ctx_binary = check_cortex_compiled($cortex_dir, $kmer);
my $colour_list = make_colourlist($list_sample_uncleaned_bins, $pop, $outdir);

my $merged_pool_bin = $outdir.$pop.".merged_uncleaned_samples.k".$kmer.".q10.ctx";
my $merged_pool_cov_distrib = $merged_pool_bin.".covg";
my $log = $merged_pool_bin.".log";
my $cmd= $ctx_binary." --kmer_size $kmer --mem_height $mem_height --mem_width $mem_width  --colour_list $colour_list  --dump_binary $merged_pool_bin  --dump_covg_distribution $merged_pool_cov_distrib > $log 2>&1";
print "$cmd\n";
my $ret = qx{$cmd};
print "$ret\n";
print "Finished building pool\n";

sub check_args
{
    my ($p, $l, $o, $h, $w) = @_;
    if ($p eq "")
    {
	die("You must specify --pop");
    }
    if ($o eq "")
    {
	die("You must specify --outdir");
    }
    elsif (!(-d $o))
    {
	die("You have specified an outdir that does not exist, $o");
    }
    if ($l eq "")
    {
	die("You must specify a list of uncleaned binaries (one per sample), using --list");
    }
    else
    {
      if (!(File::Spec->file_name_is_absolute($l)))
      {
	  die("You must give an absolute path to $l\n");
      }
    }
    open(L, $l)||die("Cannot open your list of uncleaned binaries, $l");
    while (<L>)
    {
	my $f = $_;
	chomp $f;
	if (!(-e $f))
	{
	    die("Your list $l, contains a file $f that we cannot find on the filesystem - some kind of typo? Or a network.disk issue?");
	}
	elsif ($f !~ /uncleaned.q10.k31.ctx/)
	{
	    die("This list of uncleaned binaries contains this file $f, which does not match this text: uncleaned.q10.k31.ctx - is it really an uncleaned binary?");
	}
    }
    close(L);


    my $num_kmers = (2**$h) * $w;
    if ($num_kmers > 14000000000)
    {
	print "You have specified mem height $h and mem_width $w, which will support $num_kmers kmers\n";
	print "This will require ";
	print 16 * $num_kmers/1000000000;
	print "  Gb\n";
	print "Ideally I would want to support over 25 billion to be safe\n";
    }
    else
    {
	print "You have specified mem height $h and mem_width $w, which will support $num_kmers kmers\n";
	die("This is too few - you are going to need at least 14 billion - was that a typo?");
	
    }

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


sub make_colourlist
{
    my ($list, $pop, $odir) = @_;
    if ($odir !~ /\/$/)
    {
	$odir = $odir.'/';
    }
    my $col_list = $odir.$pop.".colourlist_for_merging_uncleaned_samples";
    open(COL, ">".$col_list)||die("Cannot open $col_list");
    my $pool_id = $pop."_pool";
    print COL "$list\t$pool_id\n";
    close(COL);
    return $col_list;
}

