
from config.experiment_config_lib import ControllerConfig
from sts.topology import *
from sts.control_flow.replayer import Replayer
from sts.simulation_state import SimulationConfig
from sts.input_traces.input_logger import InputLogger

simulation_config = SimulationConfig(controller_configs=[ControllerConfig(start_cmd='./pox.py --verbose  forwarding.consistency --consistent=False --deny=False  --update_wait=10 --update_once=True --consistent_sleep=10 --barriers=True  openflow.of_01 --address=__address__ --port=__port__ ', label='c1', address='127.0.0.1', cwd='pox/')],
                 topology_class=ConsistencyTopology,
                 topology_params="",
                 patch_panel_class=BufferedPatchPanel,
                 multiplex_sockets=False,
                 ignore_interposition=False,
                 kill_controllers_on_exit=True)

control_flow = Replayer(simulation_config, "traces/trace_pox_ConsistencyTopology-False-True-steps200/events.trace",
                        input_logger=InputLogger(),
                        wait_on_deterministic_values=False,
                        allow_unexpected_messages=False,
                        delay_flow_mods=False,
                        default_dp_permit=False,
                        pass_through_whitelisted_messages=False,
                        invariant_check_name='InvariantChecker.check_liveness',
                        bug_signature="")
