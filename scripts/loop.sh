#! /usr/bin/env bash

# Run something n times
#
# Params:
#     n - Number of iterations
#     args - Command and arguments to loop
#
# Usage: loop n args
function loop() {
  for (( n=0; n<$1; n++ ))
    do ${*:2}
  done
}

loop $@
