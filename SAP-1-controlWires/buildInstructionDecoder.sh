#!/bin/bash

echo "Starting Test Bench Script"
echo "Cleaning project"

#clean existing
ghdl --clean

echo "Compiling modules"
#compile

ghdl -a --std=08 -fsynopsys LS04.vhd
ghdl -a --std=08 -fsynopsys LS20.vhd
ghdl -a --std=08 -fsynopsys instruction_decoder.vhd
#ghdl -a --std=08 -fsynopsys instruction_decoder_tb.vhd

#ghdl -e --std=08 -fsynopsys instruction_decoder_tb

#echo "Running Test Bench"
#run
#ghdl -r --std=08 -fsynopsys instruction_decoder_tb --stop-time=10000ns --vcd=instruction_decoder_tb.vcd
