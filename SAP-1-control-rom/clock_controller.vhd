library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity clock_controller is
    generic (
        SIMULATION_MODE : boolean := false
    );
    Port(
        clk_in : IN STD_LOGIC;
        rst : in STD_LOGIC;          
        run_mode : in STD_LOGIC;
        pulse : IN STD_LOGIC;
        hltbar : in STD_LOGIC;
        clk_out_1HZ : out STD_LOGIC;
        clk_out_1HZ_bar : out STD_LOGIC;
        clk_out_1KHZ : out STD_LOGIC
    );
end clock_controller;

architecture behavioral of clock_controller is
    signal clock_pulse : STD_LOGIC;
    signal or_out : STD_LOGIC;
    signal and1_out : STD_LOGIC;
    signal and2_out : STD_LOGIC;
    signal clk_out_raw_1HZ : STD_LOGIC;
    --signal clk_out_1HZ : STD_LOGIC;
    --signal clk_out_1KHZ : STD_LOGIC;
begin

    GENERATING_CLOCK_CONVERTER:
        if SIMULATION_MODE
        generate
            passthrough_clock_converter : entity work.passthrough_clock_converter
            port map (
                clk_in => clk_in,   -- simulation test bench should generate a 1HZ clock
                clk_out => clk_out_raw_1HZ
            );
        else generate
            FPGA_clock_converter : entity work.clock_converter
            port map (
                clk_in_100MHZ => clk_in,
                rst => rst,
                clk_out_1HZ => clk_out_raw_1HZ,
                clk_out_1KHZ => clk_out_1KHZ
            );
        end generate;

    single_pulse_generator : entity work.single_pulse_generator
        port map(
            clk => clk_out_1HZ,
            start => pulse,
            pulse_out => clock_pulse
        );
    
    clk_out_1HZ <= or_out and hltbar;
    clk_out_1HZ_bar <= not clk_out_1HZ;
    or_out <= and1_out or and2_out;
    and2_out <= not run_mode and clock_pulse;
    and1_out <= clk_out_raw_1HZ and run_mode;
    
    
end architecture behavioral;
