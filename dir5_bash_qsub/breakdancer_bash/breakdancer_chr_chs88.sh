#!/bin/sh
output="/picb/papgi-pgg/zhangxi/han_breakdancer"
root="/picb/humpopg-bigdata/AAGC/data/bqsr"
perl_cfg="/home/zhangxi/Document/script/bam2cfg.pl"
list_file="/picb/papgi-pgg/zhangxi/han_breakdancer/han.lib.list"
breakdancer="/home/zhangxi/local/bin/breakdancer-max"
for ind in `ls $root | grep -E '(^AAGC02215(1|2|3|4|5|6|7|8))'`
do 
			echo $ind
	if [ ! -d "$output/$ind" ];then
		mkdir $output/$ind
	fi
	for chr_bam in `ls $root/$ind | grep 'bam$'`
	do
		chr_dir=`expr substr "$chr_bam" 13 5`
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
			 perl $perl_cfg -f $list_file $bam_file > $cfg_file
			 $breakdancer -h -r 5 -c 7 $cfg_file > $sv_file
		fi
	done
done;


