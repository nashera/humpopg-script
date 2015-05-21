#!/usr/bin/perl
use strict;
use warnings;

my ( $popidx, $poporder, $input, $sizeout, $output ) = @ARGV;
my %info;
my %average;
my %index;
my @order;
my %indiidx;
my %size;
my ( $maxK, $minK ) = ( 0, 100 );

open IDX, $popidx;
while ( <IDX> ){
	my ( $pop, $idx ) = split;
	$index{$idx} = $pop;
}
close IDX;

open ORDER, $poporder;
while ( <ORDER> ){
	my $pop = (split)[0];
	push @order, $pop;
}
close ORDER;

foreach my $K ( 2 .. 14 ){
	my $file = $input;
	$file =~ s/K\d+/K$K/;
	next unless ( -f $file );
	$maxK = $K if ( $K > $maxK );
	$minK = $K if ( $K < $minK );

	###### Store the original structure result to %info ######
	open FILE, $file;
	my $tag = 0;
	while ( <FILE> ){
		if ( /Label/ ){
			$tag =1;
			next;
		}
		if ( $tag == 1 and /^\s*$/ ){
			$tag = 0;
		}
		if ( $tag == 1 ){
			s/^\s+//;
			my @entry = split;
			my $pop = $index{$entry[3]};
			$size{$K}->{$pop} ++;
			$indiidx{$K}->{$entry[0]} = $entry[1];
			$info{$K}->{$pop}->{$entry[0]} = [ @entry[5 .. $#entry] ];
		}
	}
	close FILE;

	##### Calculate the mean value of each K for each population #####
	foreach my $pop ( @order ){
		my $indinum = 0;
		foreach my $indi ( keys %{$info{$K}->{$pop}} ){
			$indinum ++;
			foreach my $i ( 0 .. $K - 1 ){
				$average{$K}->{$pop}->[$i] += $info{$K}->{$pop}->{$indi}->[$i];
			}
		}
		map { $average{$K}->{$pop}->[$_] /= $indinum } ( 0 .. $K - 1 );
	}
}

open SIZE, ">", $sizeout;
foreach my $pop ( @order ){
	my $sizeOfPop = $size{$minK}->{$pop};
	foreach my $K ( keys %size ){
		print "Error\n" if ( $sizeOfPop != $size{$K}->{$pop} );
	}
	print SIZE "$pop\t$size{$maxK}->{$pop}\n";
}
close SIZE;

my @Kpop;
my %isaKpop;
foreach my $K ( sort {$a <=> $b} keys %info ){
	###### Sort K according to the maximum, the second maximum ... mean value ######
	#### %average
	my @Ksort;
	my %isaKsort;
	my %maxavgpop;
	foreach my $i ( 0 .. $K - 1 ){
		my $maxpop = $order[0];
		my $maxval = 0;
		foreach my $pop ( keys %{$average{$K}} ){
			my $value = $average{$K}->{$pop}->[$i];
			if ( $value > $maxval ){
				$maxpop = $pop;
				$maxval = $value;
			}
		}
		$maxavgpop{$i} = $maxpop;
	}
	foreach my $pop ( @Kpop ){
		my $maxidx = &whichIsMax( @{$average{$K}->{$pop}} );
		next if ( defined $isaKsort{$maxidx} );
		push @Ksort, $maxidx;
		$isaKsort{$maxidx} = 1;
	}
	foreach my $i ( 0 .. $K - 1 ){
		next if ( defined $isaKsort{$i} );
		my $maxpop = $maxavgpop{$i};
		push @Ksort, $i;
		$isaKsort{$i} = 1;
		push @Kpop, $maxpop;
		$isaKpop{$maxpop} = 1;
	}

	my $out = $output;
	$out =~ s/K\d+/K$K/;
	open OUT, ">", $out;
	foreach my $pop ( @order ){
		my $maxidx = &whichIsMax( @{$average{$pop}} );
		my @sortIndi = sort { $info{$K}->{$pop}->{$a}->[$maxidx] <=> $info{$K}->{$pop}->{$b}->[$maxidx] } keys %{$info{$K}->{$pop}};
		foreach my $indi ( @sortIndi ){
			my $line = join "\t", $indi, $indiidx{$K}->{$indi}, $pop, @{$info{$K}->{$pop}->{$indi}}[@Ksort];
			print OUT "$line\n";
		}
	}
	close OUT;
}

sub whichIsMax{
	my @digit = @_;
	my $max = 0;
	foreach my $i ( 0 .. $#digit ){
		$max = $i if ( $digit[$max] < $digit[$i] );
	}
	return $max;
}
