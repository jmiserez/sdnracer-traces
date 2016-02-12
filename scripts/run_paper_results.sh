#!/bin/bash

# Get the traces we're interested in
source ./scripts/traces.sh


#####################################################################
# Run HB graph analysis on a given trace                            #
# Takes an input result_dir, which should contain hb.json generated #
# by the instrumented version of STS                                #
#####################################################################
generate_results(){
  if [ -z "$result_dir" ];
  then
    echo "No result dir is set";
    exit 1;
  fi

  if [ -z "${STS_HOME}" ];
  then
    echo "STS HOME is not set";
    exit 1;
  fi

  rm -f "${result_dir}"/*.dat

  teefile="${result_dir}/gen_sh_generate_results.out"
  rm -f "$teefile"

  echo "==============================================="
  echo "Running HB Graph with delta=inf for trace: ${result_dir}"
  echo "==============================================="
  ${STS_HOME}/sts/happensbefore/hb_graph.py ${result_dir}/hb.json  --no-dot-files --pkt --no-hbt  --data-dep 2>&1 | tee -a "$teefile"

  #for x in {0..10};
  for x in {0..10};
  do
    echo "=============================================="
    echo "Running HB Graph with delta=$x for trace: ${result_dir}"
    echo "=============================================="
    ${STS_HOME}/sts/happensbefore/hb_graph.py ${result_dir}/hb.json  --no-dot-files --pkt --data-dep  --time-delta=$x 2>&1 | tee -a "$teefile"
  done

}



#####################################################################
# Extract the important information from the output of SDNRacer,    #
# then put them in four different CSV files (two for data and two   #
# for timing information.                                           #
# Takes an input result_dir,  after running  hb_graph.py            #
#####################################################################
format_results(){
  if [ -z "$result_dir" ]; then exit 1; fi

  teefile="${result_dir}/gen_sh_format_results.out"
  rm -f "$teefile"

  echo "Formatting results"

  rm -f "${result_dir}/summary.csv"
  rm -f "${result_dir}/summary_timings.csv"
  rm -f "${result_dir}/summary_tbl.csv"
  rm -f "${result_dir}/summary_timings_tbl.csv"

  ./format_results.py ${result_dir} 2>&1 | tee -a "$teefile"

  if [[ ${INRUN} ]];
  then
    echo "Backing up"
    mv "${result_dir}/summary_timings_tbl.csv" "${result_dir}/summary_timings_tbl_run_${INRUN}.csv"
  fi
}


#####################################################################
# Main                                                              #
#####################################################################

# Read command line arguments
while [[ $# > 1 ]]
do
key="$1"

  case $key in
    --sts)
    STS_HOME="${2}"
    shift
    ;;
  esac
done


# Check if sts path is set
if [ -z "${STS_HOME}" ];
then
  echo "Please specify the STS home dir using --sts argument."
  exit -1
fi

# Check if STS_HOME is actually the rigth path
if [ ! -f ${STS_HOME}"/sts/happensbefore/hb_graph.py" ];
then
  echo "Possibly wrong folder for STS, ${STS_HOME}/sts/happensbefore/hb_graph.py doesn't exist."
  exit -1
fi


for trace in ${ALL_TRACES[@]}
do
  echo ../${trace};
  result_dir=./${trace}
  generate_results
  format_results
done


# Now produce the tables and plots
./scripts/produce_tbl_plots.sh