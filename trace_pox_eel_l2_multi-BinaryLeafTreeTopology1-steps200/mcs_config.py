
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.mcs_finder import EfficientMCSFinder
from sts.invariant_checker import InvariantChecker
from sts.simulation_state import SimulationConfig

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd=' ./pox.py --verbose openflow.of_01 --address=__address__ --port=__port__  openflow.discovery forwarding.l2_multi_orig', label='c1', address='127.0.0.1', cwd='/home/ahassany/repos/pox/')],
                 topology_class=BinaryLeafTreeTopology,
                 topology_params="num_levels=1",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = EfficientMCSFinder(simulation_config, "traces/trace_pox_eel_l2_multi-BinaryLeafTreeTopology1-steps200/events.trace",
                                  wait_on_deterministic_values=False,
                                  default_dp_permit=False,
                                  pass_through_whitelisted_messages=False,
                                  delay_flow_mods=False,
                                  invariant_check_name='InvariantChecker.check_liveness',
                                  bug_signature="")
