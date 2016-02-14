#!/bin/bash
mkdir -p ~/Downloads
cd ~/Downloads
rm -f sts-hb.zip
rm -f pox-hb.zip
rm -f pox-eel-hb.zip
rm -f floodlight-hb.zip
rm -f sdnracer-traces-artifact.zip
rm -f colin_scott-hassel-sts-31afb29fa667.zip
rm -f onos-hb.zip
rm -f onos-app-samples-hb.zip
rm -f reset-this-vm.sh

wget https://github.com/jmiserez/sts/archive/hb.zip -O sts-hb.zip
wget https://github.com/jmiserez/pox/archive/hb.zip -O pox-hb.zip
wget https://github.com/jmiserez/pox/archive/eel-hb.zip -O pox-eel-hb.zip
wget https://github.com/jmiserez/floodlight/archive/hb.zip -O floodlight-hb.zip
wget https://github.com/jmiserez/sdnracer-traces/archive/artifact.zip -O sdnracer-traces-artifact.zip
wget https://bitbucket.org/colin_scott/hassel-sts/get/31afb29fa667.zip -O colin_scott-hassel-sts-31afb29fa667.zip
wget https://github.com/jmiserez/onos/archive/hb.zip -O onos-hb.zip
wget https://github.com/jmiserez/onos-app-samples/archive/hb.zip -O onos-app-samples-hb.zip

cd ~/Desktop
rm -f ~/Desktop/reset-this-vm.sh
rm -f ~/Desktop/update-this-vm.sh

rm -f 01_howto_run_sdnracer_on_a_single_trace.sh
rm -f 02_howto_reproduce_all_paper_results.sh
rm -f 03_howto_generate_a_new_random_trace.sh

rm -f 01_run_sdnracer_on_a_single_trace.sh
rm -f 02_reproduce_all_paper_results.sh
rm -f 03_generate_a_new_random_trace.sh
wget http://s3.miserez.org/sdnracer-pldi/01_run_sdnracer_on_a_single_trace.sh
chmod +x 01_run_sdnracer_on_a_single_trace.sh
wget http://s3.miserez.org/sdnracer-pldi/02_reproduce_all_paper_results.sh
chmod +x 02_reproduce_all_paper_results.sh
wget http://s3.miserez.org/sdnracer-pldi/03_generate_a_new_random_trace.sh
chmod +x 03_generate_a_new_random_trace.sh

wget http://s3.miserez.org/sdnracer-pldi/update-this-vm.sh -O update-this-vm.sh
wget http://s3.miserez.org/sdnracer-pldi/reset-this-vm.sh -O reset-this-vm.sh
chmod +x update-this-vm.sh
chmod +x reset-this-vm.sh

/bin/bash reset-this-vm.sh

