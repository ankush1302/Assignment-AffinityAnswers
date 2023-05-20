#!/bin/bash

url="https://www.amfiindia.com/spages/NAVAll.txt"
output_file="scheme_data2.csv"

# Download the data file
curl -s "$url" -o myData.txt

# Extract Scheme Name and Asset Value using awk
# here we use awk to traverse through file , and we need to move in the line which is staring with a number, and then we have splitted the line by ';'.
awk -F ';' '/^[0-9]+/ { print $4 "," $5 }' myData.txt > "$output_file"

rm myData.txt

echo "Scheme Name and Asset Value fields have been extracted."
