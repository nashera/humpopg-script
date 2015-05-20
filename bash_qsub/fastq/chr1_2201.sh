#!/bin/sh
root="/picb/humpopg-ngs2/XJAnalysis/sortedBAM"
tmp="/picb/share/zhangxi/tmp"
out="/picb/humpopg-bigdata/zhangxi/XJ_cortex_calling"
chr=1
samtools_binary="/home/zhangxi/local/bin/samtools"
picard_package="/home/zhangxi/software/picard-tools-1.126/picard.jar"
process="/home/zhangxi/Document/LOG/bam_to_fastq_chr$chr.txt"
for ind  in `ls $root | grep '^WGC02201'`
do
	pe1_fastq="$tmp/$ind/$ind.chr$chr.pe1.fastq"
	pe2_fastq="$tmp/$ind/$ind.chr$chr.pe2.fastq"
	if [ -e "$out/$ind/$ind.chr$chr.pe1.fastq.gz" ];then
		continue
	fi
	bam_file="$root/$ind/$ind.bam"
	if [ ! -d "$tmp/$ind" ];then
		mkdir $tmp/$ind
	fi
	if [ ! -d "$out/$ind" ];then
		mkdir $out/$ind
	fi
	tmp_sam_file="$tmp/$ind/$ind.chr$chr.sam"
	tmp_bam_file="$tmp/$ind/$ind.chr$chr.bam"
	$samtools_binary view -h $bam_file $chr > $tmp_sam_file 
	$samtools_binary view -f4 $bam_file >> $tmp_sam_file
	$samtools_binary view -bS $tmp_sam_file > $tmp_bam_file
	java -Xmx2g -jar $picard_package  SamToFastq INPUT=$tmp_bam_file FASTQ=$pe1_fastq SECOND_END_FASTQ=$pe2_fastq
	rm $tmp_sam_file
	rm $tmp_bam_file
	gzip $pe1_fastq
	gzip $pe2_fastq
	mv  $pe1_fastq.gz $out/$ind/
	mv  $pe2_fastq.gz $out/$ind/
	if [ -e "$process" ];then
		echo "$ind chr$chr complete" >> $process
	else
		echo "$ind chr$chr complete" > $process
	fi
done
