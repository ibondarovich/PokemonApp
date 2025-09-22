#!/bin/bash

# Set the base path (adjust as necessary)
BASE_PATH="/Users/user/projects/PokemonApp/domain/lib"
OUTPUT_FILE="coverage/lcov_merged.info"

# Merge all lcov.info files into one
find . -name "lcov.info" -exec cat {} + > "$OUTPUT_FILE"

# Replace the base path in the merged lcov.info file
sed -i "" "s|$BASE_PATH|lib|" "$OUTPUT_FILE"

# Generate the HTML report
#genhtml "$OUTPUT_FILE" --output-directory coverage

#echo "Coverage report generated at coverage/index.html"