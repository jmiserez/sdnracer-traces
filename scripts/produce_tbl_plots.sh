#!/bin/bash

#####################################################################
# Generate the final tables and figures in used in the paper        #
#####################################################################


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
        python scripts/gen_tables.py -p "${f}" > ./data/races_table.csv
        python scripts/gen_tables.py -c -p "${f}" > ./data/consistency_table.csv
        python scripts/gen_tables.py -s -p "${f}" > ./data/races_table_sum.csv
        python scripts/gen_tables.py -s -c -p "${f}" > ./data/consistency_table_sum.csv
        python scripts/gen_tables.py -s -t -p "${f}" > ./data/total_table.csv
        SETHEADER=0
      else
        python scripts/gen_tables.py "${f}" >> ./data/races_table.csv
        python scripts/gen_tables.py -c "${f}" >> ./data/consistency_table.csv
        python scripts/gen_tables.py -s "${f}" >> ./data/races_table_sum.csv
        python scripts/gen_tables.py -s -c "${f}" >> ./data/consistency_table_sum.csv
        python scripts/gen_tables.py -s -t "${f}" >> ./data/total_table.csv
      fi
    done
  done
done


# Produce CDFs
./scripts/cdfs.py  ./data/races_table.csv > ./data/races_cdf.csv

# Plot graphs
cat plot/fig4_filter_cmp_cdf.gnuplot | gnuplot
cat plot/fig5_time_cdf.gnuplot | gnuplot
cat plot/fig5_time_cdf.gnuplot | gnuplot

exit 0;
