#!/bin/bash

echo "Starting Test Bench Script"
echo "Cleaning project"

#clean existing
ghdl --clean

echo "Compiling modules"
#compile
ghdl -a --std=08 -fsynopsys clock.vhd
ghdl -a --std=08 -fsynopsys JKMasterSlaveFlipFlopWithClear.vhd
ghdl -a --std=08 -fsynopsys LS107.vhd
#ghdl -a --std=08 -fsynopsys LS107.vhd
ghdl -a --std=08 -fsynopsys LS107_TB.vhd

ghdl -e --std=08 -fsynopsys LS107_TB

#echo "Running Test Bench"
#run
ghdl -r --std=08 -fsynopsys LS107_TB --stop-time=1000ns --vcd=LS107_TB.vcd


