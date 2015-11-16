
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.replayer import Replayer
from sts.simulation_state import SimulationConfig
from sts.input_traces.input_logger import InputLogger

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd='java -ea -Dlogback.configurationFile=./src/main/resources/logback-trace.xml -jar ./target/floodlight.jar -cf ./src/main/resources/trace_circuitpusher.properties', label='c1', address='127.0.0.1', cwd='../floodlight')],
                 topology_class=StarTopology,
                 topology_params="num_hosts=4",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = Replayer(simulation_config, "paper/trace_floodlight_circuitpusher-StarTopology4-steps200/events.trace",
                        input_logger=InputLogger(),
                        wait_on_deterministic_values=False,
                        allow_unexpected_messages=False,
                        delay_flow_mods=False,
                        default_dp_permit=False,
                        pass_through_whitelisted_messages=False,
                        invariant_check_name='InvariantChecker.check_liveness',
                        bug_signature="")
