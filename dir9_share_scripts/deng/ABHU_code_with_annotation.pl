#!/usr/bin/perl -w
use strict;
no strict 'refs';
my $paramfile=shift @ARGV;
$paramfile="paramfile.txt" unless defined $paramfile;
my ($ind_num,$snp_num);
my $title;
my ($ori_file,$group_file,$coding_file,$ref_file,$chr_ref_dir,$POP_file);
sub read_paramfile{
	my $paramfile=shift @_;
	print"Reading parameter...\n";
	my %name_var;
	my @variable_name=qw(ori_file  group_file  coding_file  ref_file  chr_ref_dir  POP_file);
	my @all_variable=($ori_file,$group_file,$coding_file,$ref_file,$chr_ref_dir,$POP_file);
	
	@name_var{@variable_name}=@all_variable;
	open PARAM,$paramfile or die"Can't open $paramfile:$!";
	while(<PARAM>){
		chomp;
		if(/^(\S+)\s+(\S+)(\s*|#)$/){
			my $var_name="$1";
			my $value=$2;
			$name_var{$var_name}=$value;
		}	
	}
	@all_variable=@name_var{@variable_name};
	($ori_file,$group_file,$coding_file,$ref_file,$chr_ref_dir,$POP_file)= @all_variable;
	@all_variable=@name_var{@variable_name};
	foreach (@variable_name){
		print"$_ $name_var{$_}\n" if defined $name_var{$_};
	}
}
#"48inds_3pops.inp";
sub read_group_sample_file{
	my $file=shift @_;
	open FILE,"$file" or die"can't open $file";
	my $samp_num;
	my @pops=map {$_="POP".$_} (0..100);
	while(<FILE>){
		s/\r//;
		chomp;
		if(/^\S+\s+(\S+)\s+(\S+)$/){
			push @{$pops[$2]},$1;
		}
	}
	close FILE;
	my @samples;
	foreach my $p(@pops){
		my $num=@{$p};
		if($num>0){
			push @samples,[@{$p}];
		}
	}
	foreach my $i(0..$#samples){
		print"@{$samples[$i]}\n";
	}
	return @samples;
	
}

sub create_relationship{
	my $ori_file=shift @_;
	my @samp=@_;
	$ori_file.=".inp";
	my ($all_samp_num,@all_samp);
	print"Creating relationship using $ori_file......\n";
	open ORI,$ori_file or die"can't open$ori_file";
	while(<ORI>){
		chomp;
		if(/^(prob|affy)/i){
			@all_samp=split(/\s+/);
			@all_samp=@all_samp[6..$#all_samp];
			last;
		}
	}
	$all_samp_num=@all_samp;
	my $samp_num=@samp;
	my %r;
	pop @all_samp if $all_samp[-1]=~/^\s+$/;
	my %sample_name;
	@sample_name{@samp}=@samp;
	for(my $i=0;$i<$all_samp_num;$i++){
		if(defined $sample_name{$all_samp[$i]}){
			$r{$all_samp[$i]}=$i+6;
		}
	}
	foreach(@samp){
		unless(defined $r{$_}){
			$r{$_}=0;
			print"There maybe something wrong\n";
		}
	}
	print"samp:@samp\n";
	return %r;
}

sub create_sample_matrix{
	my $ori_file=${$_[0]};
	my @samp=@{$_[1]};
	my %relation=%{$_[2]};
	my @chrs=map{$_="chrom".$_} (0..25);
	map{@{$_}=()} @chrs;
	$ori_file.=".inp";
	
	open ORI,$ori_file or die"can't open$ori_file";
	while(<ORI>){
		chomp;
		if(/^(pro|affy)/i){
			my @ele=(split/\s+/)[0..5,@relation{@samp}];
			$title=join"\t",@ele;
		}
		elsif(/^\S+\s+\S/){
			my @ele=(split/\s+/,$_)[0..5,@relation{@samp}];
			my $chr=$ele[2];
			my $one_snp=join"\t",@ele;
			push @{$chrs[$chr]},$one_snp;
		}
	}
	close ORI;
	print "have read\n";
	
	my @samp_geno;
	foreach(@chrs){
		push @samp_geno,[@{$_}];
	}
	return @samp_geno;
}

sub read_ref_file{
	my $file=shift @_;
	print"Try to read reference file...\n";	
	open FILE,"$file" or die"can't open $file";
	my %id;
	while(<FILE>){
		s/\r//;
		chomp;
		if(/^([\w\-]+)\s+(\w.*\w)\s+[\w\-]+$/){
			$id{$1}=$2;
#			print "$1 $2" if $1 eq "affy_id";
		}
		
	}
	close FILE;
	return %id;

}

sub read_coding_file{
	my $file=shift @_;
	print"Try to read coding file...\n";
	open FILE,"$file" or die"can't open $file";
	my %coding;
	while(<FILE>){
		chomp;
		if(/^([\w\-]+)\s+(\S+)\s+(\S+)\s*$/){
			$coding{$1}=$3; 
		}
	}
	close FILE;
	print keys %coding;
	print"\n";
	return %coding;
}

sub read_geno_file{
	my $ori_file=${$_[0]};
	my %coding=%{$_[1]};
	my %id=%{$_[2]};
	$snp_num=0;
	my @chrs=map{$_="chrom".$_} (0..25);
	map{@{$_}=()} @chrs;
	
	print"Trying reading genotype of $ori_file...\n";
	my @geno;
	open FILE,"$ori_file" or die"can't open $ori_file";
	while(<FILE>){
		s/\r//g;
		chomp;
		if(/^((?:affy|prob)\S+)\s+(\w+)/i){
			my @samples=(split/\s+/);
			@samples=@samples[1..$#samples];
			$ind_num=@samples;
			$title=$id{"affy_id"};
			my @t_inf=split(/\s+/,$title);
			my @title=("affy_id",@t_inf,@samples);
			$title=join"\t",@title;
			
		}
		elsif(/^([\w\-]+)\s+(\S+\s+.*)$/){
			my $id=$1;
			next unless defined $id{$id};
			my @var_ele=split(/\s+/,$2);
			my @inf=split/\s+/,$id{$id};
			if($inf[-2] eq "-"){
				$inf[-2]="+";
				$inf[-1]=~tr/ATCG/TAGC/;
			}
#			print"@inf\n";
			foreach my $ele (@var_ele){
				$ele=$coding{$ele};
			}
			my @all_inf=($id,@inf,@var_ele);
			$snp_num++;
			my $chr=$all_inf[2];
			my $one_snp=join"\t",@all_inf;
			push @{$chrs[$chr]},$one_snp;
		}
	}
	close FILE;
	foreach(@chrs){
		push @geno,[@{$_}];
	}
	return @geno;
}

sub print_geno{
	my $file=${$_[0]};
	my @geno=@{$_[1]};
	print"writing into $file...\n";
	my $one_file=$file.".inp";
	open ONE,">$one_file" or die"can't open $one_file";
	print ONE "$ind_num\n$snp_num\n\n";
	print ONE "$title\n";
	for(my $i=0;$i<26;$i++){
		my @chr=@{$geno[$i]};
		my $chr_file=$file."/chr$i".".inp";
		open FILE,">$chr_file" or die"can't open $chr_file";
		my $snp_num=@chr;
		if($i==0){
			print FILE "$ind_num\n$snp_num\n\n";
			print FILE "$title\n";
			map {print FILE "$_\n"} @chr;
			map {print ONE "$_\n"} @chr;
			
			next;
		}
		my %position;
		foreach(@chr){
			my @site=split(/\s+/,$_);
			$position{$_}=$site[3];
		}
		my @snps=keys %position;
		@snps=sort{$position{$a}<=>$position{$b}} @snps;
		print FILE "$ind_num\n$snp_num\n\n";
		print FILE "$title\n";
		map {print FILE "$_\n"} @snps;
		map {print ONE "$_\n"} @snps;
		close FILE;
	}
	close ONE;
	return 0;
}
sub print_sample_geno{
	my $file=${$_[0]};
	my @geno=@{$_[1]};
	my $n=@geno;
	print "geno_num:$n\n";
	print"writing into $file...\n";
	my $one_file=$file.".inp";
	open ONE,">$one_file" or die"can't open $one_file";
	print ONE "$ind_num\n$snp_num\n\n";
	print ONE "$title\n";
	for(my $i=0;$i<26;$i++){
		my @chr=@{$geno[$i]};
#		print join "\n",@chr;
		my $chr_file=$file."/chr$i".".inp";
		open FILE,">$chr_file" or die"can't open $chr_file";
		my $snp_num=@chr;
		if($i==0){
			print FILE "$ind_num\n$snp_num\n\n";
			print FILE "$title\n";
			map {print FILE "$_\n"} @chr;
			map {print ONE "$_\n"} @chr;
			
			next;
		}
		my %position;
		foreach(@chr){
			my @site=split(/\s+/,$_);
			$position{$_}=$site[3];
		}
		my @snps=keys %position;
		@snps=sort{$position{$a}<=>$position{$b}} @snps;
		print FILE "$ind_num\n$snp_num\n\n";
		print FILE "$title\n";
		map {print FILE "$_\n"} @snps;
		map {print ONE "$_\n"} @snps;
		close FILE;
	}
	close ONE;
	return 0;
}
sub read_list{
	my $file=shift @_;
	open FILE,"$file" or die"can't open $file";
	my @files;
	while(<FILE>){
		chomp;
		if(/^([A-Z]\S+)(\s|$)/i){
			push @files,$1;
		}
	}
	close FILE;
	return @files;
}

read_paramfile($paramfile);
my %coding=read_coding_file($coding_file);
my %snp_inf=read_ref_file($ref_file);
my @geno=read_geno_file(\$ori_file,\%coding,\%snp_inf);
my $out_file=$ori_file;
$out_file=~s/\..*$//;
mkdir "data",0770 unless -e "data";
$out_file="data/".$out_file;
mkdir $out_file,0770 or die unless -e $out_file;
print_geno(\$out_file,\@geno);
@geno=();

my @samples=read_group_sample_file($group_file);
my @pop_file=read_list($POP_file);
foreach my $i(0..$#samples){
	my @sample_names=@{$samples[$i]};
	
	$ind_num=@sample_names;
	my %relation=create_relationship($out_file,@sample_names);
	my @par=(\$out_file,\@sample_names,\%relation);
	print"Creating genotype matrix ...\n";
	my @geno_matrix=create_sample_matrix(@par);
	my $pop_file="data/".$pop_file[$i];
	mkdir $pop_file,0770 or die unless -e $pop_file;
	print_sample_geno(\$pop_file,\@geno_matrix);
#	exit;
}

