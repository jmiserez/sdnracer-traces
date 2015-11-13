#!/bin/bash


TRACES="$@"
SUMMARY_FILE=summary_tbl.csv
TIMINGS_FILE=summary_timings_tbl.csv
CROSS_FILE=cross_summary.csv
CROSS_TIMINGS_FILE=cross_summary_timings.csv
HEADER=


# Clear previous files
if [ $RESET_FILEs == 1 ];
then
  >&2 echo "Resetting cross summary file"
  rm ${CROSS_FILE}
  rm ${CROSS_TIMINGS_FILE}
  touch ${CROSS_FILE}
  touch ${CROSS_TIMINGS_FILE}
fi

function read_files {
 folder=$1
 file=$2
 outfile=$3

 >&2 echo "Reading ${folder}/${file}"
 >&2 echo "Saving to ${outfile}"

  header=`head -n1 "${folder}/${file}"`
  if [ $HEADER ];
  then
    if [ $HEADER != $header ];
    then
      >&2 echo "Found unexpected HEADER: ${header}"
      >&2 echo "While expecting: ${HEADER}"
      return -1
    fi
  else
    HEADER=$header
    if [ $RESET_FILEs == 1 ];
    then
      echo "App,Controller,Topology,Steps,${header}" > ${outfile}
    fi
  fi

  app=$(basename "${folder}")
  app="${app/trace_/}"
  controller="UNKNOWN"
  topology="UNKOWN"
  case $app in
   *"pox_eel_l2_multi_fixed"*)
     controller='POX EEL Fixed'
     app="${app/pox_eel_l2_multi_fixed/l2_multi}"
     ;;
   *"pox_eel"*)
    controller='POX EEL'
    app="${app/pox_eel_/}"
   ;;
   *"pox"*)
    controller='POX Angler'
    app="${app/pox_/}"
   ;;
   *"floodlight"*)
    controller='Floodlight'
    app="${app/floodlight_/}"
   ;;
   *"onos"*)
    controller='ONOS'
    app="${app/onos_/}"
   ;;
  esac

  case $app in
   *"StarTopology2"*)
    topology="Star"
    app="${app/StarTopology2-/}"
    ;;
   *"StarTopology4"*)
     topology="Star4"
     app="${app/StarTopology4-/}"
     ;;
  *"StarTopology8"*)
       topology="Star8"
       app="${app/StarTopology4-/}"
       ;;
   *"MeshTopology2"*)
    topology="Linear"
    app="${app/MeshTopology2-/}"
    ;;
   *"MeshTopology4"*)
     topology="Linear2"
     app="${app/MeshTopology4-/}"
     ;;
   *"BinaryLeafTreeTopology1"*)
    topology="Linear3"
    app="${app/BinaryLeafTreeTopology1-/}"
    ;;
   *"BinaryLeafTreeTopology2"*)
    topology="BinTree"
    app="${app/BinaryLeafTreeTopology2-/}"
    ;;
   esac

 steps="${app/*-steps/}"
 app="${app/-steps[[:digit:]]*/}"
 app="${app/l2_multi/Forwarding}"
 app="${app/ifwdnoinstr/Forwarding Noinst}"
 app="${app/ifwd/Forwarding}"
 app="${app/l2_learning/LearningSwitch}"
 app="${app/learningswitch/LearningSwitch}"
 app="${app/circuitpusher/CircuitPusher}"
 app="${app/forwarding/Forwarding}"
 app="${app/firewall/Firewall}"
 app="${app/loadbalancer/LoadBalancer}"
 

 # Actually read the file
  while read -r line
  do
    if [ $line == $HEADER ]; then
      # Skip header
      continue;
    fi
    echo "${app},${controller},${topology},${steps},${line}" >> ${outfile}
  done < ${folder}/${file}
}


for trace in $TRACES;
do
  if [ ! -e ${trace}/${SUMMARY_FILE} ];
  then
    >&2 echo "no summary in ${trace}"
    continue
  fi

  read_files $trace $SUMMARY_FILE $CROSS_FILE
done;

HEADER=

for trace in $TRACES;
do
  if [ ! -e ${trace}/${TIMINGS_FILE} ];
  then
    >&2 echo "no timing summary in ${trace}"
    continue
  fi

  read_files $trace $TIMINGS_FILE $CROSS_TIMINGS_FILE
done;
