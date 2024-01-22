#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <math_classes_file> <input_file>"
    exit 1
fi

# Assign arguments to variables
math_classes_file="$1"
input_file="$2"

# Check if the math classes file exists
if [ ! -f "$math_classes_file" ]; then
    echo "Error: File '$math_classes_file' not found."
    exit 1
fi

# Function to run a Math class and check sum
run_math_and_check() {
    math_class="$1"
    m="$2"
    n="$3"
    k="$4"

    # Run the specified Math class with m and n as arguments and capture the output
    output=$(java -cp "$math_class" Math "$m" "$n" 2>&1)

    # Check if the output is equal to k
    if [ "$output" -eq "$k" ]; then
        echo "Success"
    else
        echo "Fail"
    fi
}

# Process each line in the math classes file
while IFS= read -r math_class || [ -n "$math_class" ]; do
    # Process each line in the input file
    while IFS= read -r line || [ -n "$line" ]; do
        # Extract values from the line
        read -r m n k <<< "$line"

        # Call the function with extracted values
        run_math_and_check "$math_class" "$m" "$n" "$k"
    done < "$input_file"
done < "$math_classes_file"
