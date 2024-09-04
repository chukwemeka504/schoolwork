#!/bin/bash

# Corrected ETL Script for CoreDataEngineers

# Set environment variables for the file path
CSV_FILE_PATH="/home/neboemeka96/assignment/raw.csv"  # Corrected path to your local CSV file

# Directories
RAW_DIR="raw"
TRANSFORMED_DIR="Transformed"
GOLD_DIR="Gold"

# Create directories if they do not exist
mkdir -p "$RAW_DIR"
mkdir -p "$TRANSFORMED_DIR"
mkdir -p "$GOLD_DIR"

# Extract: Copy CSV file to the raw directory
echo "Starting the ETL process..."
echo "Copying the CSV file from $CSV_FILE_PATH to the raw directory..."

cp "$CSV_FILE_PATH" "$RAW_DIR/raw.csv"

# Check if the file was successfully copied
if [[ -f "$RAW_DIR/raw.csv" ]]; then
    echo "File copied successfully and saved in $RAW_DIR."
else
    echo "Failed to copy the file."
    exit 1
fi

# Transform: Rename column and select specific columns
echo "Transforming data..."

# Using awk to rename column and select columns
awk 'BEGIN {FS=OFS=","} NR==1 {gsub(/Variable_code/, "variable_code", $0); print "year,Value,Units,variable_code"} NR>1 {print $1, $2, $3, $4}' "$RAW_DIR/raw.csv" > "$TRANSFORMED_DIR/2023_year_finance.csv"

# Check if the transformation file was created
if [[ -f "$TRANSFORMED_DIR/2023_year_finance.csv" ]]; then
    echo "Transformation successful and saved in $TRANSFORMED_DIR."
else
    echo "Transformation failed."
    exit 1
fi

# Load: Move the transformed file to the Gold directory
echo "Loading data to the Gold directory..."

mv "$TRANSFORMED_DIR/2023_year_finance.csv" "$GOLD_DIR/"

# Confirm if the file is in the Gold directory
if [[ -f "$GOLD_DIR/2023_year_finance.csv" ]]; then
    echo "Data successfully loaded into the Gold directory."
else
    echo "Failed to load data into the Gold directory."
    exit 1
fi

echo "ETL process completed successfully."

