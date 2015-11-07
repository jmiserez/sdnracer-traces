
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.interactive_replayer import InteractiveReplayer
from sts.simulation_state import SimulationConfig
from sts.input_traces.input_logger import InputLogger

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd=' ./pox.py --verbose openflow.of_01 --address=__address__ --port=__port__  openflow.discovery forwarding.l2_multi_orig ', label='c1', address='127.0.0.1', cwd='/home/ahassany/repos/pox/')],
                 topology_class=StarTopology,
                 topology_params="num_hosts=2",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = InteractiveReplayer(simulation_config, "traces/trace_pox_eel_l2_multi-StarTopology2-steps200/events.trace")
# wait_on_deterministic_values=False
# delay_flow_mods=False
# Invariant check: 'InvariantChecker.check_liveness'
# Bug signature: ""
