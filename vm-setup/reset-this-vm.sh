#!/bin/bash
# remove everything
mkdir -p ~/Desktop/sdnracer
cd ~/Desktop/sdnracer
rm -rf ~/Desktop/sdnracer/*
# install STS/SDNRacer/POX/Hassel
unzip ~/Downloads/sts-hb.zip -d .
unzip ~/Downloads/pox-hb.zip -d .
mv sts-hb sts
rmdir sts/pox
mv pox-hb sts/pox
rmdir sts/sts/hassel
cd sts
# git clone https://bitbucket.org/colin_scott/hassel-sts.git sts/hassel
# alternatively, unzip and mv this zip:
unzip ~/Downloads/colin_scott-hassel-sts-31afb29fa667.zip -d .
mv colin_scott-hassel-sts-31afb29fa667 sts/hassel
export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future
(cd sts/hassel/hsa-python && source setup.sh)
# install Floodlight
cd ~/Desktop/sdnracer
unzip ~/Downloads/floodlight-hb.zip -d .
mv floodlight-hb floodlight
cd floodlight
ant
# install POX EEL
cd ~/Desktop/sdnracer
unzip ~/Downloads/pox-eel-hb.zip -d .
mv pox-eel-hb pox-eel
# install traces scripts
cd ~/Desktop/sdnracer
unzip ~/Downloads/sdnracer-traces-artifact.zip -d .
mv sdnracer-traces-artifact sdnracer-traces
# install ONOS
cd ~/Desktop/sdnracer
unzip ~/Downloads/onos-hb.zip -d .
mv onos-hb onos
unzip ~/Downloads/onos-app-samples-hb.zip -d .
mv onos-app-samples-hb onos-app-samples
# build ONOS
/bin/bash -c 'export ONOS_ROOT=~/Desktop/sdnracer/onos;
export KARAF_ROOT=~/Applications/apache-karaf-3.0.5;
export MAVEN=~/Applications/apache-maven-3.3.9 && source $ONOS_ROOT/tools/dev/bash_profile;
cd ~/Desktop/sdnracer/onos;
$MAVEN/bin/mvn clean install -nsu -DskipIT -DskipTests -Dcheckstyle.skip=true;
cd ~/Desktop/sdnracer/onos-app-samples;
$MAVEN/bin/mvn clean install -nsu -DskipIT -DskipTests -Dcheckstyle.skip=true;'
