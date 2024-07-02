#!/bin/sh -l

# Add " -e " before each languages
EXTENSIONS=$(echo $INPUT_LANG | sed 's/,/ -e /g')

# Run sw
eval "sw $INPUT_PATH -e $EXTENSIONS"

# Test if the command was successful
echo "INPUT_LANG: $INPUT_LANG"
echo "sw $INPUT_PATH -e $EXTENSIONS"
echo "Test: $(diff -rq test/test test/expected)"
tree .
pwd

exit 0
