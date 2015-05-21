#the file order is inputfile, outfile1(map file), outfile2(ped file); population_name.

# transform inp file to ped and map file.
#!usr/bin/perl
use strict;
my $file1;
my $file2;
my $file3;
my $pop_name;
($file1, $file2, $file3, $pop_name) = @ARGV;

open MAP, ">$file2";
open PED, ">$file3";

open UNIQ, "$file1";
if(! open UNIQ, "$file1"){
    die "cannot open UNIQ\n";
}

my $title = <UNIQ>;
chomp($title);
my @title = split/\t/,$title;
my @ind_ID = @title[6..$#title];
print "ind_ID is $#ind_ID+1\n";

my $line = 0;
my $col = 0;
my @matrix;
while(<UNIQ>){
    $line++;
    my (@a, @b);
    my @entry = split/\s+/, $_;
    print MAP "$entry[1]\t$entry[0]\t0\t$entry[2]\n";    
    my @allele = split/\//, $entry[4];
    for my $i(5..$#entry){
		if($entry[$i] eq "A"){
            push @a, $allele[0];
           push @b, $allele[0]; 
        }
        elsif($entry[$i] eq "B"){
            push @a, $allele[1];
            push @b, $allele[1];      
        }
        elsif($entry[$i] eq "H"){
            push @a, $allele[0];
            push @b, $allele[1];       
        }
        elsif(($entry[$i] eq "N")or($entry[$i] eq "U")){
            push @a, "0";
            push @b, "0";
        }
        else{print "hey, there is a mistake\tthe line is $line\tthe factor is $entry[$i]\n";}
    }
    $col = $#a +1 if($col == 0);
    map{$matrix[$line][$_+1] = $a[$_]}0..$#a;
    map{$matrix[$line+1][$_+1] = $b[$_]}0..$#b;
    $line=$line+1;
}
print "line is $line\n";
print "col is $col\n";
close MAP;
close UNIQ;

for my $i(1..$col){
    print PED "$pop_name\t$ind_ID[$i-1]\t0\t0\t0\t-9\t";
    for my $j(1..$line){
        print PED "$matrix[$j][$i]\t";
    
    }
    print PED "\n";
}
close PED;

