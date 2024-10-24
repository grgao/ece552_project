#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <replacement_word>"
  exit 1
fi

# Assign the replacement word to a variable
REPLACEMENT_WORD=$1

# The original command with 'simple'
ORIGINAL_COMMAND="wsrun.pl -list simple.txt proc_hier_bench verilog/proc_hier_bench.v verilog/*.v"

# Replace 'simple' with the user's replacement word in the command
MODIFIED_COMMAND=$(echo "$ORIGINAL_COMMAND" | sed "s/simple.txt/${REPLACEMENT_WORD}/g")

# Execute the modified command
eval "$MODIFIED_COMMAND"

# Notify the user
echo "Executed command: $MODIFIED_COMMAND"