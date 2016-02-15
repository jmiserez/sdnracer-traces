#!/bin/bash

# cd to traces root directory
cd ~/Desktop/sdnracer/sdnracer-traces

# run the script reproducing all results from table 2
./scripts/run_paper_results.sh --sts ../sts/

# view the results in LibreOffice
xdg-open ~/Desktop/sdnracer/sdnracer-traces/data/total_table.csv
