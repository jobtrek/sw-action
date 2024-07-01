#!/bin/sh -l

# Add " -e " before each languages
EXTENSIONS=$(echo $INPUT_LANG | sed 's/ / -e /g')

# Run sw
sw $INPUT_PATH -e $EXTENSIONS

exit 0
