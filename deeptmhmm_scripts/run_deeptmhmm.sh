#!/bin/bash
container="/scratch/group/jbardlab/containers/deeptmhmm_latest.sif"
input_fasta_dir="/scratch/user/jbard/repos/membrane_prediction/example"
input_fasta="Sec61A_P61619.fasta"
output_dir="/scratch/user/jbard/repos/membrane_prediction/example/deeptmhmm_results"
github_repo="/scratch/user/jbard/repos/membrane_prediction"

# Extract basename without .fasta extension
fasta_basename=$(basename "$input_fasta" .fasta)

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Create a unique temporary directory
tmp_dir=$(mktemp -d "$output_dir/tmp.XXXXXX")

singularity exec \
    -B "${input_fasta_dir}:/input" \
    -B "${output_dir}:/outdir" \
    -B "${tmp_dir}:/tmpdir" \
    -B "${github_repo}/deeptmhmm_scripts/predict_modified.py:/openprotein/predict.py" \
    "$container" \
    bash -c "cd /tmpdir && \
             ln -sf /openprotein/* . && \
             cp /input/$input_fasta . && \
             /bin/python3 predict.py --fasta $input_fasta && \
             cp TMRs.gff3 /outdir/${fasta_basename}~TMRs.gff3 && \
             cp deeptmhmm_results.md /outdir/${fasta_basename}~deeptmhmm_results.md && \
             cp predicted_topologies.3line /outdir/${fasta_basename}~predicted_topologies.3line"

# Remove the tmp directory
rm -rf "$tmp_dir"