#!/bin/bash

# Check if R is installed
if ! command -v Rscript &> /dev/null; then
    echo "Rscript is not installed. Please install it before running this script."
    exit 1
fi

# Run the R script
Rscript Q2_preprocess.R

echo "R script executed successfully."