#!/bin/bash


# Get the traces we're interested in
source scripts/traces.sh

export RESET_FILEs=1
for trace in ${ALL_TRACES[@]}
do
  ./scripts/cross_summary.sh $trace
  RESET_FILEs=0
done


rm -rf data/*.csv
./scripts/extract_data.sh

rm -rf table.csv

SETHEADER=1


for app in "${APPS[@]}"
do
  for topo in "${TOPOS[@]}"
  do
    for ctrl in "${CTRLS[@]}"
    do
      f=data/"${app}_${topo}_${ctrl}.csv"
      if [ ! -f "${f}" ];
      then
        echo "File ${f} doesn't exist"
        continue
      fi
      echo "In file $f"
      if [ $SETHEADER == 1 ];
      then
        python scripts/gen_tables.py -p "${f}" > races_table.csv
        python scripts/gen_tables.py -c -p "${f}" > consistency_table.csv
        python scripts/gen_tables.py -s -p "${f}" > races_table_sum.csv
        python scripts/gen_tables.py -s -c -p "${f}" > consistency_table_sum.csv
        SETHEADER=0
      else
        python scripts/gen_tables.py "${f}" >> races_table.csv
        python scripts/gen_tables.py -c "${f}" >> consistency_table.csv
        python scripts/gen_tables.py -s "${f}" >> races_table_sum.csv
        python scripts/gen_tables.py -s -c "${f}" >> consistency_table_sum.csv
      fi
    done
  done
done

exit 0;
