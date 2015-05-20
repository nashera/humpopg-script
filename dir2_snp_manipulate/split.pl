#!/usr/bin/perl -w
use strict;
my($file1,$file2)=@ARGV;
my $chr=1;
my $x=1;
my (@map,$z,@num,@ped,@head,$ind,);
open PED,"$file1"||die $!;
open MAP,"$file2"||die $!;
while(my $w=<MAP>){
chomp($w);
my $i = (split /\s+/,$w)[0];
if ($i==$chr){
  push @map,$w;
  $z++;}
else{
  my $q=join "\n",@map;
  #my $handle_fh = $file2.$i;
  open OUT,">>","$file2.$chr.map" or die $!; 
  print OUT $q; 
  close OUT;
  push @num,$z;
  ($z,@map)=();
  $chr++; 
  redo;}
 }
close MAP;
while (<PED>){
chomp;
my @line = split;
push @ped,[@line[6..$#line]];
push @head,[@line[0,1]];
$ind++;
}
close PED;
foreach my $a(@num){
foreach my $r(0..($ind - 1)){
  open OUT,">>", "$file1.$x.ped" or die $!;
  print OUT "$head[$r][0]\t$head[$r][1]\t0\t0\t0\t-9\t";
  my @piece = splice @{$ped[$r]},0,$a*2;
  my $b=join "\t",@piece;
  print OUT "$b\n";
  }
close OUT;
$x++;
 }
