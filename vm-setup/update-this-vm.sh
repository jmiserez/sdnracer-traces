#!/bin/bash

cd /tmp
rm -f /tmp/update-sdnracer-vm-latest.sh
# download latest update script
wget http://s3.miserez.org/sdnracer-pldi/update-sdnracer-vm-latest.sh -O update-sdnracer-vm-latest.sh
# execute update
/bin/bash /tmp/update-sdnracer-vm-latest.sh
rm -f /tmp/update-sdnracer-vm-latest.sh

