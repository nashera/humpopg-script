#! usr/bin/perl -w
use strict;

my ($marker_num,$poplist,$inpfile)=@ARGV;

my $pop_num=0;
open LIST,$poplist,or die "cannot open the file:$!";
while(<LIST>){
	chomp;
	my $pop=$_;
	$pop_num++;
	print "$pop $pop_num\n";
	
## 1> One line -> Two lines
	my $file1=$pop.".ped";
	my $out1=$pop.".data1";
	my @line;
	my @a;
	my @b;
	my $i;
	open F1, "/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_8/SupervisedSTRUCTURE/PASNP-SLMLY-SL/$file1" or die "cannot open the file!";
	open F2,">","/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_8/SupervisedSTRUCTURE/PASNP-SLMLY-SL/$out1" or die "cannot open the file!";
	while (<F1>) {
		chomp;
		@line = split;
		@a="";
		@b="";
		for ($i=1;$i<=$marker_num;$i++) {
		   push @a, $line[2*$i+4];
		   push @b, $line[2*$i+5];
		   print "$line[0] $line[1] $i $line[2*$i+4] $line[2*$i+5]\n" if (not exists $line[2*$i]);
		}
		print F2 "$line[1] $pop_num";
		print F2 join " ",@a;
		print F2 "\n";
		print F2 "$line[1] $pop_num";
		print F2 join " ",@b;
		print F2 "\n";
	}
	close F1;
	close F2;

## 3> Recode alleles with 0 and 1, and recode pop ID
 	my $out2=$pop.".input_data";
	my (@line3,@line4,@c,@d);
	open F1, "gzip -dc $inpfile|" or die "cannot open the file!";
	while (<F1>) {
		@line3=split /\s|\t/;
		my ($a1,$a2);
		if ($line3[0] !~ /^db/) {
			if ($line3[4] =~ /(\w)\/(\w)/) {
				($a1,$a2)=($1,$2);
			}
			push @c, $a1;
			push @d, $a2;
		}
	}
	close F1;
	open F2, "/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_8/SupervisedSTRUCTURE/PASNP-SLMLY-SL/$out1" or die "cannot open the file!";
	open F3,">","/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_8/SupervisedSTRUCTURE/PASNP-SLMLY-SL/$out2" or die "cannot open the file!";
	while (<F2>) {
		@line4=split;
		$line4[1]=$pop_num;
		my $anc;
		if ($pop_num == 3) {$anc = 0;} else {$anc = 1;}
		for ($i=2;$i<=$marker_num+1;$i++) {
			if ($line4[$i] eq $c[$i-2]) {
				$line4[$i] = 1;
			}
			elsif ($line4[$i] eq $d[$i-2]) {
				$line4[$i] = 2;
			}
			else {
				$line4[$i] = 0;
			}
		}
		print F3 join " ", @line4[0 .. 1],$anc,@line4[2 .. $#line4],"\n";
	}
	close F2;
	close F3;
}
close LIST;

## 5> 筛选位点
# my (@line6,@line7,@line8,@site,@site2,@num);
# my $k=1;
# my $j=1;
# open F1,"/picb/humpopg2/denglian/MalaysianProject/STRUCTURE/SNPindex.txt" or die "cannot open the file!";
# while (<F1>) {
#     chomp;
#     push @site, $_;
# }
# close F1;
# print "1\n";
# open F2,"/picb/humpopg2/denglian/MalaysianProject/Data/QC/Maf0.02/AFFY.NGO.b37.inp" or die "cannot open the file!";
# while (<F2>) {
#     chomp;
#     @line7=split /\t|\s/;
#     if ($line7[0] !~ /^db/) {
# 	    push @site2, $line7[0];
# 	}
# }
# foreach my $s (@site2) {
# 	map { if ( $s eq $_ ) { push @num, $k } } @site;
# 	$k++;
# }
# close F2;
# print "2\n";
# 
# open F3,"/picb/humpopg2/denglian/MalaysianProject/STRUCTURE/YRI.CEU.JPT.CHB.MLY.NGO.NGO.NGO/input_data" or die "cannot open the file!";
# open F4,">","/picb/humpopg2/denglian/MalaysianProject/STRUCTURE/YRI.CEU.JPT.CHB.MLY.NGO.NGO.NGO/filtered_input_data" or die "cannot open the file!";
# while (<F3>) {
#     chomp;
#     @line8=split;
#     my @out_line;
#     push @out_line, $line8[0], $line8[1];
#    foreach (@num) {
# # 	foreach $h ( 2 .. $#line7 ){
# #     	map { $j ++ if ( $h == $_ ) } @num;
# 		push @out_line, $line8[$_+1];
#     }
#     print F4 join " ",@out_line;
#     print F4 "\n";
# }
# close F3;
# close F4;
# 
# 
# 












