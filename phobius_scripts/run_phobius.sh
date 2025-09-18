#!/bin/bash
input_fasta="/scratch/user/jbard/repos/membrane_prediction/example/Sec61A_P61619.fasta"
output_dir="/scratch/user/jbard/repos/membrane_prediction/example/phobius_results"
github_repo="/scratch/user/jbard/repos/membrane_prediction"

# Extract basename without .fasta extension
mkdir -p "$output_dir"
fasta_basename=$(basename "$input_fasta" .fasta)

perl ${github_repo}/phobius/phobius.pl "$input_fasta" > "${output_dir}/${fasta_basename}~phobius_results.txt"