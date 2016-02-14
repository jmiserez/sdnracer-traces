#!/bin/bash

# cd to STS/SDNRacer root directory
cd ~/Desktop/sdnracer/sts

# run STS (the network simulator) with the configuration in pldi_floodlight_loadbalancer.py, using the Floodlight controller. The topology used is BinTree, 200 rounds will be simulated; these settings can easily be changed in this config file.
./simulator.py -L logging.cfg -c config/pldi_floodlight_loadbalancer.py

# invoke SDNRacer
./sts/happensbefore/hb_graph.py plditraces/trace_floodlight_loadbalancer-StarTopology4-steps200/hb.json

# browse the results folder
cd plditraces/trace_floodlight_loadbalancer-StarTopology4-steps200
nautilus .

