#!/bin/bash

#####################################################################
# This file contains a list of network traces used in the PLDI '15  #
# Paper.                                                            #
# ALL_TRACES: list of traces                                        #
# CTRL: list of controllers                                         #
# TOPOS: list of topologies                                         #
# STEPS: number of STS simulation steps used in producing the trace #
#####################################################################


export ALL_TRACES=(
  trace_pox_eel_learningswitch-StarTopology2-steps200
  trace_pox_eel_learningswitch-MeshTopology2-steps200
  trace_pox_eel_learningswitch-BinaryLeafTreeTopology2-steps200

  trace_floodlight_learningswitch-StarTopology2-steps200
  trace_floodlight_learningswitch-MeshTopology2-steps200
  trace_floodlight_learningswitch-BinaryLeafTreeTopology2-steps200


  trace_pox_l2_multi-StarTopology2-steps200
  trace_pox_l2_multi-MeshTopology2-steps200
  trace_pox_l2_multi-BinaryLeafTreeTopology2-steps200

  trace_pox_eel_l2_multi-StarTopology2-steps200
  trace_pox_eel_l2_multi-MeshTopology2-steps200
  trace_pox_eel_l2_multi-BinaryLeafTreeTopology2-steps200

  trace_pox_eel_l2_multi_fixed-StarTopology2-steps200
  trace_pox_eel_l2_multi_fixed-MeshTopology2-steps200
  trace_pox_eel_l2_multi_fixed-BinaryLeafTreeTopology2-steps200

  trace_floodlight_forwarding-StarTopology2-steps200
  trace_floodlight_forwarding-MeshTopology2-steps200
  trace_floodlight_forwarding-BinaryLeafTreeTopology2-steps200

  trace_onos_ifwd-StarTopology2-steps200
  trace_onos_ifwd-MeshTopology2-steps200
  trace_onos_ifwd-BinaryLeafTreeTopology2-steps200


  trace_floodlight_circuitpusher-StarTopology2-steps200
  trace_floodlight_circuitpusher-MeshTopology2-steps200
  trace_floodlight_circuitpusher-BinaryLeafTreeTopology2-steps200


  trace_floodlight_firewall-StarTopology2-steps200
  trace_floodlight_firewall-MeshTopology2-steps200
  trace_floodlight_firewall-BinaryLeafTreeTopology2-steps200


  trace_floodlight_loadbalancer-StarTopology4-steps200/
  trace_floodlight_loadbalancer-MeshTopology4-steps200/
  trace_floodlight_loadbalancer-BinaryLeafTreeTopology2-steps200/
)


export APPS=('LearningSwitch' 'Forwarding' 'CircuitPusher' 'Firewall' 'LoadBalancer')
export CTRLS=('POX Angler' 'POX EEL' 'POX EEL Fixed' 'ONOS' 'Floodlight')
export TOPOS=('Single' 'Single4' 'Linear' 'Linear4' 'BinTree')
export STEPS=200

