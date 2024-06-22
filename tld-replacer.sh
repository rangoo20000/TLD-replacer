#!/bin/bash

# Function to get user input
get_input() {
    read -p "$1" input
    echo $input
}

# Get the input file containing the list of domains
input_file=$(get_input "Enter the path to the input file containing the domain list: ")

# Get the new TLD from the user
new_tld=$(get_input "Enter the new TLD (e.g., .tel): ")

# Get the output file name from the user
output_file=$(get_input "Enter the output file name (e.g., output.txt): ")

# Check if input file exists
if [[ ! -f $input_file ]]; then
    echo "The input file does not exist."
    exit 1
fi

# Process the domains
processed_domains=""
while IFS= read -r domain; do
    # Remove the existing TLD
    base_domain=$(echo $domain | sed 's/\.[^.]*$//')
    # Add the new TLD
    new_domain="${base_domain}${new_tld}"
    # Append to the processed domains list
    processed_domains="${processed_domains}${new_domain}\n"
done < "$input_file"

# Save the processed domains to the output file
echo -e $processed_domains > $output_file

# Inform the user of completion
echo "The processed domains have been saved to $output_file"

