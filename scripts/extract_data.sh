#!/bin/bash


apps=('LearningSwitch' 'Forwarding' 'CircuitPusher')
ctrls=('POX Angler' 'POX EEL' 'POX EEL Fixed' 'ONOS' 'Floodlight')
topos=('Star2' 'Mesh2' 'BinTree1' 'BinTree2')
steps=200
alt='False'
#reg="${app},${ctrl},${topo},${steps},*,*,${alt}"
#egrep "forwarding,POX,Star2,200,([0-9]+|inf),([0-9]+|inf),True" cross_summary.csv

for app in "${apps[@]}"
do
  for ctrl in "${ctrls[@]}"
  do
    for topo in "${topos[@]}"
    do
      reg="${app},${ctrl},${topo},${steps},([0-9]+|inf),([0-9]+|inf),${alt}"
      
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
