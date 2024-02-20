#!/bin/bash

echo "Starting Test Bench Script"
echo "Cleaning project"

#clean existing
ghdl --clean

echo "Compiling modules"
#compile
ghdl -a --std=08 -fsynopsys mytypes.vhd
#ghdl -a --std=08 -fsynopsys d_flip_flop.vhd 
#ghdl -a --std=08 -fsynopsys ring_counter_6bit.vhd
ghdl -a --std=08 -fsynopsys proc_top.vhd
ghdl -a --std=08 -fsynopsys proc_top_tb.vhd
#

ghdl -e --std=08 -fsynopsys proc_top_tb

echo "Running Test Bench"
#run
ghdl -r --std=08 -fsynopsys proc_top_tb --stop-time=10000ns --vcd=proc_top_tb.vcd


