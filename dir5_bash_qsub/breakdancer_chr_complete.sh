#!/bin/sh
output="/picb/papgi-pgg/zhangxi/xinjiang_ngs_analysis/xinjiang_ngs_sortedBAM_chr_breakdancer_update"
root="/picb/papgi-pgg/zhangxi/xinjiang_ngs_analysis/xinjiang_ngs_sortedBAM_chr"
perl_cfg="/picb/humpopg5/zhangxi/breakdancer_ouput/bam2cfg.pl"
list_file="/picb/papgi-pgg/zhangxi/xinjiang_ngs_analysis/xinjiang_ngs_sortedBAM_chr_breakdancer/list"
breakdancer="/home/zhangxi/local/bin/breakdancer-max"
for ind in `ls $root | grep '^WGC'`
do 
	if [ ! -d "$output/$ind" ];then
		mkdir $output/$ind
	fi
	for chr_bam in `ls $root/$ind | grep 'bam$'`
	do
		chr_dir=`expr substr "$chr_bam" 12 5`
		if [ ! -d "$output/$ind/$chr_dir" ];then
			mkdir $output/$ind/$chr_dir
		fi
		sv_file="$output/$ind/$chr_dir/$chr_bam.sv"
	if [ ! -e "$sv_file" ];then
		touch $sv_file
	fi
		size=`stat -c%s $sv_file`
		cfg_file="$output/$ind/$chr_dir/$chr_bam.cfg"
		bam_file="$root/$ind/$chr_bam"
		if [ $size -lt 400 ];then
			echo $ind
			echo $chr_bam
			perl $perl_cfg -f $list_file $bam_file > $cfg_file
			$breakdancer -h -r 5 -c 7 $cfg_file > $sv_file
		fi
	done
done;


