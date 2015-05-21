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
chr=5
kmer=31
height=20
width=200
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
ref_chromos="${ref_dir}/ref_split_chromosome/human_g1k_v37_chr$chr.fasta"
genome_size=`sed -n '1p' ${ref_chromos} | awk -F ':' '{print $6}'`
vcftools="/home/zhangxi/software/vcftools_0.1.12b/"
stampy="/home/zhangxi/software/stampy-1.0.23/stampy.py"

cortex_dir="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/scripts"
perl ${cortex_dir}/analyse_variants/make_read_len_and_total_seq_table.pl $log> $table 2>&1
ref_stampy_dir="${ref_dir}/stampy"
stampy_hash="${ref_stampy_dir}/human_g1k_v37_chr$chr"
col_sample_list="${pool}/xinjiang_col_sample_list"
perl ${cortex_dir}/analyse_variants/make_covg_file.pl $bubbles_output 121 0
number_of_variant=`wc -l ${covg_for_classifier} | awk '{print $1}'`
echo "$number_of_variant"

echo "cat ${cortex_dir}/analyse_variants/classifier.parallel.ploidy_aware.R | R --vanilla --args 1 ${number_of_variant} ${covg_for_classifier} ${number_of_variant} 121 1 $table ${genome_size} $kmer 2 ${classified} "  | sh

perl ${cortex_dir}/analyse_variants/process_calls.pl -callfile ${bubbles_output} -callfile_log $log -outvcf xinjiang.bubbles.chr$chr -outdir ${pool_chr_all} -samplename_list ${col_sample_list} -num_cols 121 -stampy_hash ${stampy_hash} -vcftools_dir $vcftools -caller BC -kmer $kmer -stampy_bin ${stampy} -refcol 0 -pop_classifier $classified -ploidy 2 -ref_fasta ${ref_chromos}




