#!/bin/bash

echo "Starting Test Bench Script"
echo "Cleaning project"

#clean existing
ghdl --clean

echo "Compiling modules"
#compile

ghdl -a --std=08 -fsynopsys tristatebuffer.vhd
ghdl -a --std=08 -fsynopsys JKMasterSlaveFlipFlopWithClear.vhd
ghdl -a --std=08 -fsynopsys LS107.vhd
ghdl -a --std=08 -fsynopsys LS126.vhd
ghdl -a --std=08 -fsynopsys program_counter.vhd
ghdl -a --std=08 -fsynopsys program_counter_tb.vhd

ghdl -e --std=08 -fsynopsys program_counter_tb

#echo "Running Test Bench"
#run
ghdl -r --std=08 -fsynopsys program_counter_tb --stop-time=10000ns --vcd=program_counter_tb.vcd
