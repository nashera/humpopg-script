#!/usr/bin/perl
use strict;
use warnings;

my ( $file1, $file2, $fst_out ) = @ARGV;

#chdir "/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_5/FST/Data";
#my @files = glob "*.inp.gz";

#my $num_files = @files;

#for (my $num_file1=0;$num_file1<=$num_files-2;$num_file1++) {
#	for (my $num_file2=$num_file1+1;$num_file2<=$num_files-1;$num_file2++) {
#		my ($file1, $file2) = ($files[$num_file1], $files[$num_file2]);
#		if (($file1 =~ /AFFY/ and $file1 ne "AFFY.MLY.b37.inp.gz") or ($file2 =~ /AFFY/ and $file2 ne "AFFY.MLY.b37.inp.gz")) {
#		my ($out1,$out2);
#		if ($file1 =~ /^(\w+)_(\w+)-(\w+).b37.inp/) {
#			$out1 = $1."_".$2."-".$3;
#		} elsif ($file1 =~ /^(\w+).(\w+).b37.inp/) {
#			$out1 = "$1.$2";
#		}
#		if ($file2 =~ /^(\w+)_(\w+)-(\w+).b37.inp/) {
#                        $out2 = $1."_".$2."-".$3;
#                } elsif ($file2 =~ /^(\w+).(\w+).b37.inp/) {
#                        $out2 = "$1.$2";
#                }
#		my $fst_out = "/picb/humpopg6/denglian/Malay/STRUCTURE/Analysis_5/FST/$out1"."2".$out2.".fst";
		print "$file1 $file2 $fst_out\n";
		
		my %snpfreq1 = &freq_get( $file1 );
		my %snpfreq2 = &freq_get( $file2 );
		my %ovrlapsnp;
		my %print_out;
		
		# open OUT,">","/picb/humpopg2/denglian/GeneFlow/f_test/1_Fst/$fst_out" or die "cannot open the file:$!";
		# open OUT,">","/picb/humpopg2/denglian/Negritos/$fst_out" or die "cannot open the file:$!";
		
		foreach my $chr ( keys %snpfreq1 ){
			foreach my $pos ( keys %{$snpfreq1{$chr}} ){
				next unless ( defined $snpfreq2{$chr}->{$pos} );
				my ( $miss_1, $ni_1, $pi_1, $a0_1, $a1_1, $rsid_1 ) = split ",", $snpfreq1{$chr}->{$pos};
		#		print OUT "$chr $pos $miss_1 $ni_1 $pi_1 $a0_1 $a1_1 $rsid_1\n";
		
				my ( $miss_2, $ni_2, $pi_2, $a0_2, $a1_2, $rsid_2 ) = split ",", $snpfreq2{$chr}->{$pos};
				$ni_1 = $ni_1*2;
				$ni_2 = $ni_2*2;
		#  		next if ( (($pi_1 < $pi_2) and ($pi_1 < 0.01)) or (($pi_1 > $pi_2) and ($pi_2 < 0.01))); ## QC: Allele frequency 
#				if ( $rsid_1 ne $rsid_2 ){
#					print "Not unique rsid for $chr $pos\n";
#					next;
#				}
				my ( $p_pa, $n_sum, $n_sqr_sum, $nc );
                                my ( $MSG, $MSP, $fst );
                                my ( $fst_nume, $fst_deno );
				
				if ( ($a0_1 ne $a0_2) or ($a1_1 ne $a1_2) ){
					if ($a0_1 eq $a0_2) {
						if (($a1_1 eq "Z") or ($a1_2 eq "Z")) {
							$p_pa = ( $ni_1*$pi_1 + $ni_2*$pi_2 )/( $ni_1 + $ni_2 );
							$n_sum = $ni_1 + $ni_2;
                                        		$n_sqr_sum = $ni_1**2 + $ni_2**2;
                                        		$MSG = ( $ni_1*$pi_1*(1-$pi_1) + $ni_2*$pi_2*(1-$pi_2) )/( $ni_1 -1 + $ni_2 -1 );
                                        		$MSP = ( $ni_1*($pi_1-$p_pa)**2 + $ni_2*($pi_2-$p_pa)**2 );
                                        		$nc = ( $ni_1 + $ni_2 - $n_sqr_sum/$n_sum );
                                        		$fst_nume = ( $MSP - $MSG );
                                        		$fst_deno = ( $MSP + ($nc-1)*$MSG );
                                        		$fst = ( $fst_nume == 0 ) ? 0 : $fst_nume/$fst_deno;
                                        		$fst = 0 if ( $fst < 0 );
                                        		$print_out{$chr}->{$pos} = sprintf("%s\t%s/%s\t%d\t%d\t%.8f\t%.8f\t%.8f\n", $rsid_1, $a0_1, $a1_1, $chr, $pos, $fst_nume, $fst_deno, $fst);
							delete $snpfreq1{$chr}->{$pos};
							delete $snpfreq2{$chr}->{$pos};
						} else {
							print "Not unique SNP $a0_1($pi_1)/$a1_1 V.S. $a0_2($pi_2)/$a1_2 for $rsid_1\n" ;
                                       			next;
						}
					} else {
						if ((($a1_1 eq $a1_2) and ($a1_2 eq "Z")) or (($a1_1 eq "Z") and ($a0_1 eq $a1_2)) or (($a1_2 eq "Z") and ($a1_1 eq $a0_2))) {
							$pi_2 = 1 - $pi_2;
							$p_pa = ( $ni_1*$pi_1 + $ni_2*$pi_2 )/( $ni_1 + $ni_2 );
                                        		$n_sum = $ni_1 + $ni_2;
                                        		$n_sqr_sum = $ni_1**2 + $ni_2**2;
                                        		$MSG = ( $ni_1*$pi_1*(1-$pi_1) + $ni_2*$pi_2*(1-$pi_2) )/( $ni_1 -1 + $ni_2 -1 );
                                        		$MSP = ( $ni_1*($pi_1-$p_pa)**2 + $ni_2*($pi_2-$p_pa)**2 );
                                        		$nc = ( $ni_1 + $ni_2 - $n_sqr_sum/$n_sum );
                                        		$fst_nume = ( $MSP - $MSG );
                                        		$fst_deno = ( $MSP + ($nc-1)*$MSG );
                                        		$fst = ( $fst_nume == 0 ) ? 0 : $fst_nume/$fst_deno;
                                        		$fst = 0 if ( $fst < 0 );
                                        		$print_out{$chr}->{$pos} = sprintf("%s\t%s/%s\t%d\t%d\t%.8f\t%.8f\t%.8f\n", $rsid_1, $a0_1, $a1_1, $chr, $pos, $fst_nume, $fst_deno, $fst);
                                        		delete $snpfreq1{$chr}->{$pos};
                                        		delete $snpfreq2{$chr}->{$pos};		
						} else {
							print "Not unique SNP $a0_1($pi_1)/$a1_1 V.S. $a0_2($pi_2)/$a1_2 for $rsid_1\n" ;
							next;
						}
					} 
				} else {
					$p_pa = ( $ni_1*$pi_1 + $ni_2*$pi_2 )/( $ni_1 + $ni_2 );
					$n_sum = $ni_1 + $ni_2;
					$n_sqr_sum = $ni_1**2 + $ni_2**2;
					$MSG = ( $ni_1*$pi_1*(1-$pi_1) + $ni_2*$pi_2*(1-$pi_2) )/( $ni_1 -1 + $ni_2 -1 );
					$MSP = ( $ni_1*($pi_1-$p_pa)**2 + $ni_2*($pi_2-$p_pa)**2 );
					$nc = ( $ni_1 + $ni_2 - $n_sqr_sum/$n_sum );
					$fst_nume = ( $MSP - $MSG );
					$fst_deno = ( $MSP + ($nc-1)*$MSG );
					$fst = ( $fst_nume == 0 ) ? 0 : $fst_nume/$fst_deno;
					$fst = 0 if ( $fst < 0 );
					$print_out{$chr}->{$pos} = sprintf("%s\t%s/%s\t%d\t%d\t%.8f\t%.8f\t%.8f\n", $rsid_1, $a0_1, $a1_1, $chr, $pos, $fst_nume, $fst_deno, $fst);
					delete $snpfreq1{$chr}->{$pos};
					delete $snpfreq2{$chr}->{$pos};
				}
			}
		}
		
		open OUT, ">", $fst_out;
		foreach my $chr ( sort { $a <=> $b } keys %print_out ){
			foreach my $pos ( sort { $a <=> $b } keys %{$print_out{$chr}} ){
				print OUT $print_out{$chr}->{$pos};
			}
		}
		close OUT;
#		}
#	}
#}




sub freq_get{
	my $file = shift @_;
	my %snpfreq;
	
# 	$f="PanAsia_".$file.".inp";
	
	my ( $rsid_col, $chr_col, $pos_col, $alel_col, $first_col, $indi_no );
	open FILE, "gzip -dc $file|";
# 	my $head=<FILE>;
# 	$head=<FILE>;
# 	$head=<FILE>;
	while ( <FILE> ){
		chomp;
		next if /^[\d\s]*$/;
 		print "Processing line $. in $file ...\n" if ( $. % 100000 == 0 );
		my @entry = split/\t|\s+/;
		if (  /chrom/i ){
			map {
				$chr_col = $_ if ( $entry[$_] =~ m/chromosome/i );
			} ( 0 .. 2 );
			$rsid_col = $chr_col - 1;
			$pos_col = $chr_col + 1;
			$alel_col = $chr_col + 3;
			$first_col = $chr_col + 4;
			$indi_no = $#entry - $first_col + 1;
# 			print "$chr_col $rsid_col $pos_col $alel_col $first_col $#entry $indi_no\n";
			next;
		}
		if ( $#entry != $first_col + $indi_no - 1 ){
			print "$entry[0] $entry[1] $entry[2] $entry[3] $entry[4] $entry[5] $entry[6] $entry[7] $entry[$#entry]\n";
 			print "Broken line infor for line $. of $file, skip this line\n";
			next;
		}
		my ( $rsid, $chr, $pos, $allele ) = @entry[$rsid_col, $chr_col, $pos_col, $alel_col];
		$chr = $chr eq 'X' ? 23 :
			   $chr eq 'Y' ? 24 :
			   $chr eq 'MT' ? 25 :
			   $chr;
		my @genotypes = @entry[$first_col .. $#entry];
		my ( $a0, $a1 ) = split '/', $allele;
		if ( $a0 gt $a1 ){
			( $a0, $a1 ) = ( $a1, $a0 );
			map { tr/AB/BA/ } @genotypes;
		}
		my ( $ni, $pi, $miss );
		my ( $no_a, $no_b, $no_h, $no_u ) = ( 0, 0, 0, 0 );
		map {
			if ( $_ eq 'A' ){
				$no_a ++;
			}
			elsif ( $_ eq 'B' ){
				$no_b ++;
			}
			elsif ( $_ eq 'H' ){
				$no_h ++;
			}
			elsif ( $_ eq 'U' ){
				$no_u ++;
			}
			elsif ( $_ eq 'N' ){
				$no_u ++;
			}
			else {
				print "Unknown genotype $_ at line $. of $file\n";
			}
		} @genotypes;
		$ni = $indi_no - $no_u;
		next if ( $ni == 0 );
		$miss = $no_u/$indi_no;
  		next if ( $miss > 0.05 ); ## QC: Missing rate perl SNP
		$pi = ( $no_a + $no_h/2 )/$ni;
		if ( defined $snpfreq{$chr}->{$pos} ){
			my $fmiss = ( split ",", $snpfreq{$chr}->{$pos} )[0];
# 			next if ( $miss > $fmiss );
		}
		$snpfreq{$chr}->{$pos} = join ",", $miss, $ni, $pi, $a0, $a1, $rsid;
	}
	close FILE;
	return %snpfreq;
}

# open F1,"/picb/humpopg2/share_denglian/PanAsian_geno/HapMap_code_MY-KN.inp" or die "cannot open the file:$!";
# open OUT,">","/picb/humpopg2/denglian/PanAsian_LocalAdaptation/Data/MY-KN.inp" or die "cannot open the file:$!";
# while (<F1>) {
# 	chomp;
# 	my @line=split /\s+/;
# 	print OUT join "\t", @line;
# 	print OUT "\n";
# }
# close F1;
# close OUT;
