#!/bin/bash - 
#===============================================================================
#
#          FILE: script6_dump_a_single_graph_of_bubble_branches_to_be_shared_later_by_parallel_processes_all.sh
# 
#         USAGE: ./script6_dump_a_single_graph_of_bubble_branches_to_be_shared_later_by_parallel_processes_all.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: X.Zhang (Shua Xu), zhangxi1014@gmail.com
#  ORGANIZATION: picb
#       CREATED: 2015年03月24日 00:30
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
process="/home/zhangxi/Document/LOG/***.txt"

mem_height=23
mem_width=100
pop="xinjiang"
kmer=31
chr=22
quality=20
T=30
pool="/picb/humpopg-bigdata/zhangxi/cortex_pool"
pool_chr_all="$pool/XJ_chr$chr/all"
ref_dir="/picb/humpopg-bigdata/zhangxi/bundle"
ref_list="${pool_chr_all}/ref_binary_list"
ref="${ref_dir}/ref_split_chromosome/human_g1k_v37_chr$chr.k$kmer.ctx"
ref_col_list="${pool_chr_all}/ref_colour_list"
echo "$ref"  > $ref_list
echo "${ref_list}" > ${ref_col_list}

cortex_dir="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/scripts"
ctx_binary1="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c1"
ctx_binary2="/picb/humpopg7/zhangxi/software/CORTEX_release_v1.0.5.21/bin/cortex_var_31_c2"
bubble_calls="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.bubbles_thresh$T"



##############################################
#command1 make the bubble-branch fasta
branches="${bubble_calls}.branches.fasta"
branches_log="${branches}.log"
echo "perl ${cortex_dir}/analyse_variants/make_branch_fasta.pl --callfile $bubble_calls --kmer 31 > $branches_log 2>&1"
perl ${cortex_dir}/analyse_variants/make_branch_fasta.pl --callfile $bubble_calls --kmer $kmer > $branches_log 2>&1 


#########################################
#dump a graph
branches_list="${branches}.list"
echo "$branches" >  ${branches_list}
bubble_graph=${bubble_calls}.branches.k$kmer.ctx
bubble_graph_log=${bubble_graph}.log
echo "$ctx_binary1 --se_list $branches_list --mem_height $mem_height --mem_width $mem_width --kmer_size 31 --dump_binary $bubble_graph > ${bubble_graph_log} 2>&1"
$ctx_binary1 --se_list $branches_list --mem_height $mem_height --mem_width $mem_width --kmer_size 31 --dump_binary $bubble_graph > ${bubble_graph_log} 2>&1


############################################
#ref intersect with bubbles

suffix="${pop}_chr${chr}_all_intersect_bubbles"
#ref_intersect_bin="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.thresh$T.ref_intersect_with_bubbles.ctx"
ref_intersect_log="${pool_chr_all}/$pop.chr$chr.k$kmer.q$quality.thresh$T.ref_intersect_with_bubbles.ctx.log"
echo "$ctx_binary2 --kmer_size 31 --multicolour_bin $bubble_graph --mem_height $mem_height --mem_width $mem_width --colour_list $ref_col_list --load_colours_only_where_overlap_clean_colour 0 --successively_dump_cleaned_colours $suffix > ${ref_intersect_log} 2>&1"
$ctx_binary2 --kmer_size 31 --multicolour_bin $bubble_graph --mem_height $mem_height --mem_width $mem_width --colour_list $ref_col_list --load_colours_only_where_overlap_clean_colour 0 --successively_dump_cleaned_colours $suffix > ${ref_intersect_log} 2>&1


