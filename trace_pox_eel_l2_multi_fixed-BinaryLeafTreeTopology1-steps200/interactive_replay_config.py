
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.interactive_replayer import InteractiveReplayer
from sts.simulation_state import SimulationConfig
from sts.input_traces.input_logger import InputLogger

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd='echo "no-op"', label='c1', address='192.168.56.1', cwd='pox/', controller_type='dummy')],
                 topology_class=BinaryLeafTreeTopology,
                 topology_params="num_levels=1",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = InteractiveReplayer(simulation_config, "traces/trace_pox_eel_l2_multi_fixed-BinaryLeafTreeTopology1-steps200/events.trace")
# wait_on_deterministic_values=False
# delay_flow_mods=False
# Invariant check: 'InvariantChecker.check_liveness'
# Bug signature: ""
