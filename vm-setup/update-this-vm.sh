#!/bin/bash

cd /tmp
rm -f /tmp/update-sdnracer-vm-latest.sh
# download latest update script
wget https://raw.githubusercontent.com/jmiserez/sdnracer-traces/artifact/vm-setup/update-sdnracer-vm-latest.sh -O update-sdnracer-vm-latest.sh
# execute update
/bin/bash /tmp/update-sdnracer-vm-latest.sh
rm -f /tmp/update-sdnracer-vm-latest.sh

