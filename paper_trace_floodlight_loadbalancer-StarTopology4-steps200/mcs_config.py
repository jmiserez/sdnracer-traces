
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.mcs_finder import EfficientMCSFinder
from sts.invariant_checker import InvariantChecker
from sts.simulation_state import SimulationConfig

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd='java -ea -Dlogback.configurationFile=./src/main/resources/logback-test-trace.xml -jar ./target/floodlight.jar -cf ./src/main/resources/trace_loadbalancer.properties', label='c1', address='127.0.0.1', cwd='../floodlight')],
                 topology_class=StarTopology,
                 topology_params="num_hosts=4",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = EfficientMCSFinder(simulation_config, "paper/trace_floodlight_loadbalancer-fixed-StarTopology4-steps200/events.trace",
                                  wait_on_deterministic_values=False,
                                  default_dp_permit=False,
                                  pass_through_whitelisted_messages=False,
                                  delay_flow_mods=False,
                                  invariant_check_name='InvariantChecker.check_liveness',
                                  bug_signature="")
