#! perl -w
use strict;

my $pop=shift (@ARGV);
my $ped=$pop.".ped";
my $ind=$pop.".ind";
my @line;
open PED, "/picb/humpopg6/denglian/PCA/Data/3Pops/$ped" or die "Cannot open the file!";
open IND,">","/picb/humpopg6/denglian/PCA/$ind" or die "Cannot open the file!";
while (<PED>) {
    @line=split/\t|\s/;
    my $id=$line[0];
#     if ($line[0] =~ /(\w+)/) {
#     	$id=$1;
#     }
    print IND $line[1]," U ",$id,"\n";
}
close PED;
close IND;
