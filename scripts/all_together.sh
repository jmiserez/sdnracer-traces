#!/bin/bash

export RESET_FILEs=1
./scripts/cross_summary.sh *l2_multi*steps200
export RESET_FILEs=0
./scripts/cross_summary.sh *forwarding*steps200
./scripts/cross_summary.sh *onos*steps200
./scripts/cross_summary.sh *learning*steps200
./scripts/cross_summary.sh trace_floodlight_circuitpusher-BinaryLeafTreeTopology1-steps200


rm -rf data/*.csv
./scripts/extract_data.sh

rm -rf table.csv

SETHEADER=1
for f in data/*.csv
do
  echo "In file $f"
  if [ $SETHEADER == 1 ];
  then
    python scripts/gen_tables.py -p "${f}" > races_table.csv
    python scripts/gen_tables.py -c -p "${f}" > consistency_table.csv
    SETHEADER=0
  else
    python scripts/gen_tables.py "${f}" >> races_table.csv
    python scripts/gen_tables.py -c "${f}" >> consistency_table.csv
  fi
done

