#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: batch_process_beagle_phase.pl
#
#        USAGE: ./batch_process_beagle_phase.pl  
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
#      CREATED: 09/22/2014 11:14:08 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $beagle ="/picb/humpopg7/zhangxi/software/b4.r1274.jar";
my $inp_dir= "/picb/humpopg7/zhangxi/affymetrix/vcf";
my $out_dir="/picb/humpopg7/zhangxi/affymetrix/phased";
opendir(DIRHANDLE,"$inp_dir") || die $!;
my @all_inp=grep{/vcf.gz$/} readdir DIRHANDLE;

for my $i(0..$#all_inp){
	my $beagle_phase_command = "java -Xmx2000m -jar $beagle  gt=$inp_dir/$all_inp[$i] out=$out_dir/phased_$all_inp[$i]";
	print "$beagle_phase_command\n";
	system("$beagle_phase_command");
}
	
