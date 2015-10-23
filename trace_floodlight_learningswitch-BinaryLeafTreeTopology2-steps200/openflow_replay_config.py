
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.openflow_replayer import OpenFlowReplayer
from sts.simulation_state import SimulationConfig
from sts.input_traces.input_logger import InputLogger

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd='java -ea -Dlogback.configurationFile=./src/main/resources/logback-trace.xml -jar ./target/floodlight.jar -cf ./src/main/resources/trace_learningswitch.properties', label='c1', address='127.0.0.1', cwd='../floodlight')],
                 topology_class=BinaryLeafTreeTopology,
                 topology_params="num_levels=2",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = OpenFlowReplayer(simulation_config, "traces/trace_floodlight_learningswitch-BinaryLeafTreeTopology2-steps200/events.trace")
# wait_on_deterministic_values=False
# delay_flow_mods=False
# Invariant check: 'InvariantChecker.check_liveness'
# Bug signature: ""
