ehe file order is inputfile(inp) .outfile(hapmap)
#!/usr/bin/perl
use strict;

my ($file1,$file2) = @ARGV;

open PHA, ">$file2";
open INP, "$file1";
if(! open INP, "$file1"){
	die "cannot open INP\n";
}
my $line;
my $col;
my @matrix;
while(<INP>){
	$line++;
	my(@a, @b);
	my @entry = split ;
	my @allele = split /\//, $entry[5];
	for my $i(6..$#entry){
		if($entry[$i] eq "A"){
			push @a, $allele[0];
			push @b, $allele[0];
		}
		elseif ($entry[$i] eq "B"){
			push @a, $allele[1];
			push @b, $allele[1];
		}
		elseif ($entry[$i] eq "H"){
			push @a, $allele[0];
			push @b, $allele[1];
		}
		else{print "hey,there is a mistake\t the line is $line \t the factor is $entry[$i]\n"}
	}
	map{matrx[$line][$_]}=$a[$_]0..$#a;
	map{matix[$line][$_]}=$b[$_]0..$#b;
	$line = $line + 1;
}
print "the line is $line\n";
print "the col is $col\n";
close INP;
for my $i(1..$col){
	print PHA "$rsid ";
	for my $j(1..$line){
		print PHA "$matrix[$j][$i]");
	}
	print PHA "\n";
}
close PHA;

