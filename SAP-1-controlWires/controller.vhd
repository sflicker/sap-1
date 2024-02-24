library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controller is
    clk : STD_LOGIC;
    rst : STD_LOGIC;
end controller;

architecture behavioral of controller is
signal pc_enable_read : STD_LOGIC;
signal pc_enable_write : STD_LOGIC;
signal address_bus : STD_LOGIC_VECTOR(3 downto 0);
signal data_bus : STD_LOGIC_VECTOR(7 downto 0);
begin
    pc : entity work.register_4bit is
        Generic (
            ID => "PC"
        )
        port map (
            clk => clk, rst => rst, data_out => data_bus
        )