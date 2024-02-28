#!/bin/bash

echo "Starting Test Bench Script"
echo "Cleaning project"

#clean existing
ghdl --clean

echo "Compiling modules"
#compile
ghdl -a --std=08 -fsynopsys LS20.vhd
#ghdl -a --std=08 -fsynopsys LS107.vhd
ghdl -a --std=08 -fsynopsys ls20_tb.vhd

ghdl -e --std=08 -fsynopsys ls20_tb

#echo "Running Test Bench"
#run
ghdl -r --std=08 -fsynopsys ls20_tb --stop-time=1000ns --vcd=ls_tb.vcd


