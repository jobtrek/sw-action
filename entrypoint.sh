#!/bin/sh -l

# Add " -e " before each languages (not the first)
EXTENSIONS=$(echo "$INPUT_LANG" | sed 's/,/ -e /g')

# Run sw
eval "sw $INPUT_PATH -e $EXTENSIONS"

exit 0
