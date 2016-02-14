#!/bin/bash

# cd to STS/SDNRacer root directory:
cd ~/Desktop/sdnracer/sts

# Invoke SDNRacer to analyze a single trace:
./sts/happensbefore/hb_graph.py ../sdnracer-traces/trace_pox_eel_l2_multi-MeshTopology2-steps200/hb.json

# Browse the results folder:
cd ../sdnracer-traces/trace_pox_eel_l2_multi-MeshTopology2-steps200
nautilus .

# If desired, open one of the graphs showing a packet coherence violation in XDot:

# xdot /home/sdnracer/Desktop/sdnracer/sdnracer-traces/trace_pox_eel_l2_multi-MeshTopology2-steps200/incoherent_12:34:56:78:01:02_12:34:56:78:02:02_315.dot 
