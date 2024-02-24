library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_controller is
    Port(
        clk_in : IN STD_LOGIC;
        mode : in STD_LOGIC;
        pulse : IN STD_LOGIC;
        hlt : in STD_LOGIC;
        clk_out : out STD_LOGIC;
        clk_out_bar : out STD_LOGIC
    );
end clock_controller;

architecture behavioral of clock_controller is
    signal clock_pulse : STD_LOGIC;
    signal or_out : STD_LOGIC;
    signal and1_out : STD_LOGIC;
    signal and2_out : STD_LOGIC;
begin
    single_pulse_generator : entity work.single_pulse_generator
        port map(
            clk => clk_in,
            start => pulse,
            pulse_out => clock_pulse
        );
    
    clk_out <= or_out and not hlt;
    clk_out_bar <= not clk_out;
    or_out <= and1_out or and2_out;
    and2_out <= not mode and clock_pulse;
    and1_out <= clk_in and mode;
    
    
end architecture behavioral;
