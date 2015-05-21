#! /usr/bin/perl -w
use strict;

#chdir "/picb/humpopg2/denglian/MalaysianProject/Data/INP";
#my @files = glob "*.b37.inp.gz";
my @files = ("SGVP.MAS.inp.gz","Srilanka.Malay.inp.gz","Srilanka.Burger.inp.gz");

foreach my $file (@files) {
	my $pop;
	if ($file =~ /^(\w+).(\w+).inp.gz/) {
		$pop = $1.".".$2;
	} elsif ($file =~ /^(\w+).filter.inp.gz/) {
		$pop = $1;
	}
#	if ($pop !~ /^(\w+)-(\w+)$/) {
		print "$pop\n";
		`perl /picb/humpopg6/denglian/Malay/script/OverlappingSNP.pl /picb/humpopg6/denglian/Malay/Admixture/STRUCTURE/$file /picb/humpopg6/denglian/Malay/Admixture/STRUCTURE/SharedSNPs_MAS_SLB_SLM.independent.ld0.3.txt /picb/humpopg6/denglian/Malay/Admixture/STRUCTURE/Data/$pop.inp`;
#	}
}

