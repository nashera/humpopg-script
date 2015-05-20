#!/bin/bash - 
#===============================================================================
#
#          FILE: script10_population_filter_and_dump_vcf.sh
# 
#         USAGE: ./script10_population_filter_and_dump_vcf.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 03/26/2015 17:47
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"
chr=22
kmer=31
height=20
width=150
pop="xinjiang"
quality=20
T=30
ctx_binary="/home/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c121"
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
ref_dir="/picb/humpopg-bigdata/zhangxi/bundle"
pool_chr_dir="$pool/XJ_chr$chr"
pool_chr_all="${pool_chr_dir}/all"
multicol_ref_samples_overlap_bubbles="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.thresh$T.multicol_ref_samples_overlap_bubbles.ctx"
bubbles_input="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T"
bubbles_output="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T.genotyped"
log="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T.genotyped.log"
covg_for_classifier="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T.genotyped.covg_for_classifier"
classified="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T.genotyped.classified"
table="${pool_chr_all}/${pop}.chr$chr.k$kmer.q$quality.bubbles_thresh$T.genotyped.table"
vcftools="/home/zhangxi/software/vcftools_0.1.12b/"
stampy="/home/zhangxi/software/stampy-1.0.23/stampy.py"

$ctx_binary --kmer_size $kmer --mem_height $height --mem_width $width --multicolour_bin ${multicol_ref_samples_overlap_bubbles} --max_read_len 15000 --gt ${bubbles_input},${bubbles_output},BC --genome_size 51304566 --experiment_type EachColourADiploidSampleExceptTheRefColour  --print_colour_coverages  --estimated_error_rate 0.01 --ref_colour 0 > $log 2>&1
cortex_dir="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/scripts"
perl ${cortex_dir}/analyse_variants/make_read_len_and_total_seq_table.pl $log> $table 2>&1
ref_stampy_dir="${ref_dir}/stampy"
stampy_hash="${ref_stampy_dir}/human_g1k_v37_chr$chr"
ref_chromos="${ref_dir}/ref_split_chromosome/human_g1k_v37_chr$chr.fasta"
col_sample_list="${pool_chr_all}/xinjiang_col_sample_list"
#perl ${cortex_dir}/analyse_variants/make_covg_file.pl $bubbles_output 121 0

echo "cat ${cortex_dir}/analyse_variants/classifier.parallel.ploidy_aware.R | R --vanilla --args 1 64735 ${covg_for_classifier} 64735 121 1 $table 51304566 31 2 ${classified} "  | sh

perl ${cortex_dir}/analyse_variants/process_calls.pl -callfile ${bubbles_output} -callfile_log $log -outvcf xinjiang.bubbles.chr$chr -outdir ${pool_chr_all} -samplename_list ${col_sample_list} -num_cols 121 -stampy_hash ${stampy_hash} -vcftools_dir $vcftools -caller BC -kmer 31 -stampy_bin ${stampy} -refcol 0 -pop_classifier $classified -ploidy 2 -ref_fasta ${ref_chromos}




