#!/bin/bash

# Get the traces we're interested in
source scripts/traces.sh


for trace in ${ALL_TRACES[@]}
do
  for i in {1..20};
  do
    export INRUN=${i}
    echo "In run ${i} for trace: ${trace}"
    cd ../jsts
    ./gen.sh ../sdnracer-traces/"${trace}" #2>&1 1>/dev/null
    cd ../sdnracer-traces
  done
done