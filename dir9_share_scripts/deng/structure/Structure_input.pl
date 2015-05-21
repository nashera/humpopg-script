## This script is used to prepare the input file for STRUCTURE based on PED.
## Three input parameters: the number of markers, a population list (a file containing one population per row), and an INP file of any population including all the markers.

#! usr/bin/perl -w
use strict;

my ($marker_num,$poplist,$inpfile)=@ARGV;

# my $pop_num=0;
# open LIST,$poplist,or die "cannot open the file:$!";
# while(<LIST>){
# 	chomp;
# 	my $pop=$_;
# 	$pop_num++;
# 	print "$pop $pop_num\n";
# 
# ## 1> One row -> Two rows
# 	my $file1=$pop.".b37.ped";
# 	my $out1=$pop.".data1";
# 	my @line;
# 	my @a;
# 	my @b;
# 	my $i;
# 	open F1, "/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_4/Sampling/$file1" or die "cannot open the file!";
# 	open F2,">","/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_4/Input/$out1" or die "cannot open the file!";
# 	while (<F1>) {
# 		chomp;
# 		@line = split;
# 		@a="";
# 		@b="";
# 		for ($i=1;$i<=$marker_num;$i++) {
# 		   push @a, $line[2*$i];
# 		   push @b, $line[2*$i+1];
# 		   print "$line[0] $line[1] $i $line[2*$i] $line[2*$i+1]\n" if (not exists $line[2*$i]);
# 		}
# 		print F2 "$line[1] $pop_num";
# 		print F2 join " ",@a;
# 		print F2 "\n";
# 		print F2 "$line[1] $pop_num";
# 		print F2 join " ",@b;
# 		print F2 "\n";
# 	}
# 	close F1;
# 	close F2;
# 
# ## 2> Recode alleles with 0 and 1, and recode pop ID
#  	my $out2=$pop.".input_data";
# 	my (@line3,@line4,@c,@d);
# 	open F1, "gzip -dc $inpfile|" or die "cannot open the file!";
# 	while (<F1>) {
# 		@line3=split /\s|\t/;
# 		my ($a1,$a2);
# 		if ($line3[0] !~ /^db/) {
# 			if ($line3[4] =~ /(\w)\/(\w)/) {
# 				($a1,$a2)=($1,$2);
# 			}
# 			push @c, $a1;
# 			push @d, $a2;
# 		}
# 	}
# 	close F1;
# 	open F2, "/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_4/Input/$out1" or die "cannot open the file!";
# 	open F3,">","/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_4/Input/$out2" or die "cannot open the file!";
# 	while (<F2>) {
# 		@line4=split;
# 		$line4[1]=$pop_num;
# 		for ($i=2;$i<=$marker_num+1;$i++) {
# 			if ($line4[$i] eq $c[$i-2]) {
# 				$line4[$i] = 1;
# 			}
# 			elsif ($line4[$i] eq $d[$i-2]) {
# 				$line4[$i] = 2;
# 			}
# 			else {
# 				$line4[$i] = 0;
# 			}
# 		}
# 		print F3 "@line4","\n";
# 	}
# 	close F2;
# 	close F3;
# 	
# 	`rm /picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_4/Input/$out1`;
# 	
# }
# close LIST;

# my @pop;
# open LIST,$poplist,or die "cannot open the file:$!";
# while(<LIST>){
# 	chomp;
# 	push @pop, "/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_4/Input/$_.input_data";
# } 
# close LIST;
# 
# my $combine_pop = join " ",@pop;
# `cat $combine_pop > /picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_4/Input/Dataset3.input`;

my @pop;
open LIST,$poplist,or die "cannot open the file:$!";
while(<LIST>){
	chomp;
	my $pop;
	if ($_ =~ /^(\w+)_(\w+)-(\w+).inp/) {$pop = $1."_".$2."-".$3;}
	elsif ($_ =~ /^(\w+).(\w+).b37/) {$pop = "$1.$2";}
	push @pop, "/picb/humpopg6/denglian/Malay/ADMIXTURE/Dataset7/Data/Sampling/$pop.b37.ped";
} 
close LIST;

my $combine_pop = join " ",@pop;
`cat $combine_pop > /picb/humpopg6/denglian/Malay/ADMIXTURE/Dataset9/Dataset9.ped`;

