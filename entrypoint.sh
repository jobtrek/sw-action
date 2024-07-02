#!/bin/sh -l

# Add " -e " before each languages
EXTENSIONS=$(echo $INPUT_LANG | sed 's/ / -e /g')

# Run sw
sw $INPUT_PATH -e $EXTENSIONS

# Test if the command was successful
echo "Test: $(diff -rq test/test test/expected)"
tree .

exit 0
