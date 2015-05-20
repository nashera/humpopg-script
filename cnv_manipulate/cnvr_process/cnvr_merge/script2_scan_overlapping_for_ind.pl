#!/picb/extprog/biopipeline/Linux-x86_64_exports/bin/perl
#===============================================================================
#
#         FILE: script2_scan_overlapping_for_ind.pl
#
#        USAGE: ./script2_scan_overlapping_for_ind.pl  
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
#      CREATED: 02/03/2015 07:05:41 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
#open(ERROR,">","/picb/humpopg7/zhangxi/test/error") || die $!;
#
my ($sv_ind,$sv_ind_filtered)=@ARGV;
open(my $ind_sv_file,"<","$sv_ind") || die $!;
open(my $filtered,">","$sv_ind_filtered") || die $!;
my $ra_ind_sv_output=abstract_breakdancer($ind_sv_file);
my @ind_sv_output_modefied=@$ra_ind_sv_output;
my $ra_ind_sv_output_modefied=\@ind_sv_output_modefied;
my $length = scalar(@$ra_ind_sv_output)-1;
=head
my @s;
my @null=();
my $ra_null=\@null;
my $n=0;
=cut
my $ra_cnv_array_filtered;
my $length = scalar(@$ra_ind_sv_output)-1;

my @cnv_array_filtered;
my $ra_cnv_array_filtered = \@cnv_array_filtered;
while(my $m <= $length){
	my @cnv_array_splie = @$ra_ind_sv_output[$m..$length];
	my $ra_cnv_array_splice = \@cnv_array_splice;
	my $ra_output = &one_to_cnv_array_self($cnv_array_splice -> $m, $ra_cnv_array_splice);
	$m = $m + $ra_output -> [0];
	push @$ra_cnv_array_filtered, $ra_output->[1];
}
=head

=for comment
>>>>>>> 98706a71c456e50d8f6ac969d10996e119cea6db
for my $i(0..$length){
	my $judge;
	if($i == 0){
		$judge = 0;
	}
	elsif($i >= 1){
		my $ra_forward=$ra_ind_sv_output->[$i-1];
		my $ra_current=$ra_ind_sv_output->[$i];
		my $ra_first=[$ra_forward->[1],$ra_forward->[2]];
		my $ra_second=[$ra_current->[1],$ra_current->[2]];
		$judge=one_to_one($ra_first,$ra_second);
		if ($judge == 1){
			if($ra_forward->[5] >= $ra_current->[5]){
				$ra_ind_sv_output_modefied->[$i]=$ra_null;}
			else{$ra_ind_sv_output_modefied->[$i-1]=$ra_null;}
			$n++;
		}
		elsif ($judge ==2){
		my $t=$ra_ind_sv_output->[$i-1];
		$ra_ind_sv_output_modefied->[$i-1]=$ra_ind_sv_output->[$i];
		$ra_ind_sv_output_modefied->[$i]=$t;
		print "print The line\n";
		print "$sv_ind\t$i+1\tlocation has been tranlocated\t$ra_forward->[1]\t$ra_forward->[2]\t$ra_current->[1]\t$ra_current->[2]\n";
		print "after tranlocate\t$ra_ind_sv_output_modefied->[$i-1][1]\t$ra_ind_sv_output_modefied->[$i-1][2]\t$ra_ind_sv_output_modefied->[$i][1]\t$ra_ind_sv_output_modefied->[$i][2]\n";}
	}
	push @s, $judge;
}
close $ind_sv_file;
=cut

if ($#s != $length) {
	die("the length is note equal\n");
}

for my $i(0..$length){
	if ( @{$ra_ind_sv_output_modefied->[$i]})
		{print $filtered "$ra_ind_sv_output_modefied->[$i][0]\t$ra_ind_sv_output_modefied->[$i][1]\t$ra_ind_sv_output_modefied->[$i][2]\t$ra_ind_sv_output_modefied->[$i][3]\t$ra_ind_sv_output_modefied->[$i][4]\t$ra_ind_sv_output_modefied->[$i][5]\n";}
		else{next;}
	}
	close $filtered;





for my $i(0..$length){
	if ( @{$ra_cnv_array_filtered->[$i]}){
		print $filtered  "$ra_cnv_array_filtered->[$i][0]\t$ra_cnv_array_filtered->[$i][1]\t$ra_cnv_array_filtered->[$i][2]\t$ra_cnv_array_filtered->[$i][3]\t$ra_cnv_array_filtered->[$i][4]\t$ra_cnv_array_filtered->[$i][5]\n";	}	
		else{next;}
}
	close $filtered;

sub abstract_breakdancer{
	my ($file)=@_;
	my @ind_chr_cnv;
	while(<$file>){
		if(/^\D/){
			next;
		}
		chomp;
		my @entry=split;
		my $length=($entry[2]-$entry[1]);
		my $all=[$entry[0],$entry[1],$entry[2],$length,$entry[4],$entry[5]]; #[chromosome,pos1,pos2,type,$length,num_reads
		push @ind_chr_cnv,$all;
		}
	my $ra_ind_chr_cnv=\@ind_chr_cnv;
	return $ra_ind_chr_cnv;
}


sub one_to_cnv_array_self{
	my ($ra_breakpoint, $ra_array_self)=@_;
	my $l = scalar(@$ra_array_self)-1;
	my $output;
	my @compare_array;
	my @output_breakpoint;
	my $n = 0;
	push @compare_array, $ra_breakpoint;
	for my $i(0..$l){
		my $signal = $one_to_one($ra_breakpoint, $ra_array_self -> [$i]);
		use switch;
			switch($signal){
				case 0 {$n++; next;}
				case 1 {last;}
				case 2 {$n++; push @compare_array, $ra_array_self -> [$i];}
				}
			}
	@compare_array=(sort {$a->[5] <=> $b->[5]}@compare_array);
	$output_breakpoint=$compare_array[$#compare_array];
	push @$output, $n;
	push @$output, $output_breakpoint;
	return $output;
	
	push @$output, $n;
	push @$output, []
}



sub one_to_one{
	my ($ra_one, $ra_two) = @_;
	my @one = @$ra_one;
	my @two = @$ra_two;
	my $t;
	if($one[1] = $two[1] and $one[2] = $two[2]){
		$t = 0;}
	elsif($two[2] < $one[1]){
		$t = 1;}
	else{$t = 2;}
	return 0;
}
	
=head
=for comment
sub one_to_one{   # compare two breakpoint to output the CNVR
	my ($ra_one,$ra_two)=@_;
	my @one=@$ra_one;
	my @two=@$ra_two;
	my $t;
	if($one[1] <= $two[0]){
		$t=0;}
	elsif($one[0] <= $two[0] and $two[0] <= $one[1] and $one[1] <= $two[1]){
		$t=1;}
	elsif($one[0] <= $two[0] and $two[1] <= $one[1]){
		$t=1;}
	elsif($two[0] <= $one[0] and $one[1] <= $two[1]){
		$t=1;}
	elsif($two[0] <= $one[1] and $one[0] <= $two[1] and $two[1] <= $one[1]){
		$t=1;}
	elsif($two[1] <= $one[0]){
		$t=2;}
	else{print "there is a mistake";}
	return $t;
}
=cut
