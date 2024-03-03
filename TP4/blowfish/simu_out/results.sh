#!/bin/bash

# Create an array to store the keywords to search for
keywords=("sim_IPC" "bpred_2lev.bpred_addr_rate" "bpred_bimod.bpred_addr_rate" "il1.miss_rate" "dl1.miss_rate" "ul2.miss_rate")

# List all files in the current directory with the .out extension
out_files=$(ls *.out)

# Iterate through each .out file
for out_file in $out_files; do
    archive_name=$(basename "$out_file" .out)
    output_file="${archive_name}_extracted.out"

    # Create an empty output file for this archive
    touch "$output_file"

    # Iterate through each keyword
    for keyword in "${keywords[@]}"; do
        # Search for lines containing the keyword in the .out file
        grep "$keyword" "$out_file" >> "$output_file"
    done
done
