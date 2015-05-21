#!/usr/bin/perl -w
use strict;

my $pop = shift;
my $snpfile = shift;
# my $chr=shift;

# mkdir "/picb/humpopg6/denglian/SwedishProject/Haploview/GeneticMap/$pop";
my $map="$pop.gd";
open MY,">","/picb/humpopg6/denglian/Malay/Admixture/STRUCTURE/Data/$map" or die "Can't open the file: $!";

for (my $chr=1;$chr<=22;$chr++) {

my $gd_file="genetic_map_GRCh37_chr$chr.txt.gz";
print "$chr $gd_file\n";
# my $map="$pop.chr$chr.gd";
# open MY,">","/picb/humpopg6/denglian/Malay/Admixture/ALDER/Data/GD/$map" or die "Can't open the file: $!";

my %sdata;
my @index;
open F1,"gzip -dc /picb/humpopg2/denglian/GD/b37/$gd_file|" or die "Can't open the file: $!";
while(<F1>){
    chomp;
    my @line=split /\t/,$_;
    if ($line[0] !~ /Chromosome/) {
		$sdata{$line[1]}=[];
		push @{$sdata{$line[1]}},$line[2];
		push @{$sdata{$line[1]}},$line[3];
		push @index,$line[1];
    }
}
# shift @index;
close F1;
# print "$index[0]\n";

## INP
# open F2,"/picb/humpopg2/denglian/MalaysianProject/AdmixTime/20131212-ALDER/test.inp" or die "cannot open the file:$!";
# while(<F2>){
#     my @line=split/\t/;
#     if ($line[0] !~ /^db/ and $line[1] == $chr) {
#     	my ($a1,$a2);
#     	if ($line[4] =~ /(\w)\/(\w)/) {
#     		($a1,$a2)=($1,$2);
#     	}
# 		if(exists $sdata{$line[2]}){
# 			my $value=($sdata{$line[2]}->[1]);
# 			print MY $line[0]." ".$line[1]." ".$value." ".$line[2]." ".$a1." ".$a2."\n";
# 		}else{
# 			my $new_value=&new_value($line[2]);
# 			print MY $line[0]." ".$line[1]." ".$new_value." ".$line[2]." ".$a1." ".$a2."\n";
# 		}
#     }
# }
# close F2;

## MAP
# print MY "pposition rrate gposition\n";
open F2,"$snpfile" or die "cannot open the file:$!";
while(<F2>){
	chomp;
    my @line=split/\s/;
    if ($line[0] == $chr) {
		if(exists $sdata{$line[3]}){
#  			my $rrate=($sdata{$line[3]}->[0]);
			my $gposition=($sdata{$line[3]}->[1]);
			print MY "$line[3] $gposition\n";
		}else{
			my $result=&new_value($line[3]);
			print MY "$line[3] $result\n";
		}
    }
}
close F2;

# close MY;
sub new_value{
    my $test=$_[0];
    my ($new_gposition,$new_rrate,$new_value);
    for(my $i=0;$i<=@index-1;$i++){
        if ($test<=$index[$i]){
            $new_gposition=int((($test-$index[$i-1])*$sdata{$index[$i-1]}->[0]/1000000+$sdata{$index[$i-1]}->[1])*1000000000)/1000000000;
#             $new_rrate=(($sdata{$index[$i]}->[1]-$new_gposition)*1000000/($index[$i]-$test));
# 		    $new_value="$new_rrate = (( $sdata{$index[$i]}->[1] - $new_gposition ) * 1000000/( $index[$i] - $test ));";
#   			$new_value=((( $test - $index[$i-1] )* $sdata{$index[$i-1]}->[0] )/1000000+ $sdata{$index[$i-1]}->[1] );
#           splice @index,0,$i;
		    $new_value="$new_gposition";
            goto OUT;
        }
    }
OUT:return $new_value;
}

}
close MY;

# open OUT,">/picb/humpopg6/denglian/Malay/Admixture/ALDER/Data/MAS-SL.snp";
# open F1,"/picb/humpopg6/denglian/Malay/Admixture/ALDER/Data/GD/MAS-SL.snp";
# while (<F1>) {
# 	chomp;
# 	my @line = split;
# 	$line[2] = $line[2] / 100;
# 	print OUT join " ", @line;
# 	print OUT "\n";
# }
# close F1;
# close OUT;

# my $pos = 0;
# my $dis = 0;
# my $chr = shift;
# open F1,"/picb/humpopg6/denglian/Malay/Admixture/ALDER/Data/GD/MAS-SL.chr$chr.gd";
# open OUT,">/picb/humpopg6/denglian/Malay/Admixture/ALDER/Data/GD2/MAS-SL.chr$chr.gd";
# while (<F1>) {
# 	chomp;
# 	my @line = split;
# # 	if ($line[1] == $chr) {
# 		if ($line[1] > $dis) {$dis = $line[1];print OUT join " ",@line;print OUT "\n";} else {$line[1]=$dis+0.00000000001;$dis = $line[1];print OUT join " ",@line;print OUT "\n";}
# # 	} elsif ($line[1] > $chr) {last;}
# }
# close F1;
# 
