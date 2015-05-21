#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: test.pl
#
#        USAGE: ./test.pl  
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
#      CREATED: 05/19/2015 01:11:58 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;

my $ra_array=[1,2,3,4,5];
<<<<<<< HEAD
my $t=scalar(@$ra_array);
=======
my $splice = $ra_array->[1..4];
my $t=scalar(@$ra_array);
print "@$splice\n";
>>>>>>> 98706a71c456e50d8f6ac969d10996e119cea6db
print "$t\n@$ra_array\n";

