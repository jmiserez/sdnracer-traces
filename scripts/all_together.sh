#!/bin/bash

export RESET_FILEs=1
./scripts/cross_summary.sh *l2_multi*steps200
export RESET_FILEs=0
./scripts/cross_summary.sh *forwarding*steps200
./scripts/cross_summary.sh *onos*steps200
#./scripts/cross_summary.sh *learning*steps200
./scripts/cross_summary.sh *learningswitch-StarTopology2-steps200
./scripts/cross_summary.sh *learningswitch-MeshTopology2-steps200
./scripts/cross_summary.sh *learningswitch-BinaryLeafTreeTopology1-steps200
./scripts/cross_summary.sh *learningswitch-BinaryLeafTreeTopology2-steps200
./scripts/cross_summary.sh trace_floodlight_circuitpusher-BinaryLeafTreeTopology1-steps200


rm -rf data/*.csv
./scripts/extract_data.sh

rm -rf table.csv

SETHEADER=1


apps=('LearningSwitch' 'Forwarding' 'CircuitPusher')
ctrls=('POX Angler' 'POX EEL' 'POX EEL Fixed' 'ONOS' 'Floodlight')
topos=('Star' 'Linear' 'BinTree')


for app in "${apps[@]}"
do
  for topo in "${topos[@]}"
  do
    for ctrl in "${ctrls[@]}"
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
        SETHEADER=0
      else
        python scripts/gen_tables.py "${f}" >> races_table.csv
        python scripts/gen_tables.py -c "${f}" >> consistency_table.csv
      fi
    done
  done
done

exit 0;
