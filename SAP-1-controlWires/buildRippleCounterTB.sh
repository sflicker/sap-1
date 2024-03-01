#!/bin/bash

echo "Starting Test Bench Script"
echo "Cleaning project"

#clean existing
ghdl --clean

echo "Compiling modules"
#compile

ghdl -a --std=08 -fsynopsys JKMasterSlaveFlipFlopWithClear.vhd
ghdl -a --std=08 -fsynopsys LS107.vhd
ghdl -a --std=08 -fsynopsys six_stage_ripple_counter_with_107s.vhd
ghdl -a --std=08 -fsynopsys six_stage_ripple_counter_with_107s_tb.vhd

ghdl -e --std=08 -fsynopsys six_stage_ripple_counter_with_107s_tb

#echo "Running Test Bench"
#run
ghdl -r --std=08 -fsynopsys six_stage_ripple_counter_with_107s_tb --stop-time=10000ns --vcd=six_stage_ripple_counter_with_107s_tb.vcd
