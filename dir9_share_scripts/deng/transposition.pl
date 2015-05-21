#!/usr/bin/perl
####################################################################################################
##### this script is used to transposition the input matrix ########################################
##### Uage: .pl matrix_file ########################################################################
##### Leading annotation lines beginning with '#' are tolerable and skipped ########################
##### Note that the entire file (except the annotation lines) are transpositioned, including the####
#####header ########################################################################################
######2012.05.22####################################################################################

my $file = shift @ARGV or die("file to be transpositioned!\n");
open INFILE,"$file";
#my $head=<INFILE>;
#$head=<INFILE>;
#$head=<INFILE>;
my @column_array;
my $anno_line;
while(($anno_line = <INFILE>) =~ /^#+/){}			#skipping the annotation lines
my $firstline = $anno_line;					#the first line, maybe the header
#print "$firstline";
@column_array = split /\s+/, $firstline;
my $columns = @column_array;
#print "$columns\n";
while($line = <INFILE>){
	my @line = split /\s+/, $line;
	if(@line == $columns){
		$column_array[$_] .= " $line[$_]" foreach (0..($columns - 1));
	}else{
		die("$line[0] line has unfilled columns!\n");	#unregular matrix
	}
}
close INFILE;
$_ .= "\n" foreach (@column_array);
my $convert_file = $file."_TP";
open OUTFILE,">$convert_file";
print OUTFILE @column_array;
close OUTFILE;
print "OK!\n";

