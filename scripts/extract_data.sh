#!/bin/bash

#####################################################################
# Split data into smaller files, that are easier to read            #
#####################################################################

# Get the traces we're interested in
source scripts/traces.sh


for app in "${APPS[@]}"
do
  for ctrl in "${CTRLS[@]}"
  do
    for topo in "${TOPOS[@]}"
    do
      reg="${app},${ctrl},${topo},${STEPS},([0-9]+|inf),([0-9]+|inf),${ALTBARR}"
      
      if egrep "${reg}" cross_summary.csv > /dev/null ;
      then
        head -n1 cross_summary.csv > data/"${app}_${topo}_${ctrl}.csv"
        egrep "${reg}" cross_summary.csv >> data/"${app}_${topo}_${ctrl}.csv"
      else
        echo "${reg}"
      fi      
    done
  done
done
