
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.openflow_replayer import OpenFlowReplayer
from sts.simulation_state import SimulationConfig
from sts.input_traces.input_logger import InputLogger

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd='./pox.py --verbose openflow.discovery forwarding.l2_multi openflow.of_01 --address=__address__ --port=__port__ ', label='c1', address='127.0.0.1', cwd='pox/')],
                 topology_class=GridTopology,
                 topology_params="num_rows=3, num_columns=3",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = OpenFlowReplayer(simulation_config, "traces/pox_l2_multi-grid33-traffic-failures/events.trace")
# wait_on_deterministic_values=False
# delay_flow_mods=False
# Invariant check: 'InvariantChecker.check_liveness'
# Bug signature: ""
