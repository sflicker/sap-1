----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2024 10:12:11 PM
-- Design Name: 
-- Module Name: proc_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Tests
-- PowerOn    - just initiallize but don't run
-- Execute    - initialize then run

entity proc_top_tb is
    generic (
        Test_Name : String := "PowerOn"
    );
end proc_top_tb;

architecture Behavioral of proc_top_tb is
signal s7_anodes_out : STD_LOGIC_VECTOR(3 downto 0);
signal s7_cathodes_out : STD_LOGIC_VECTOR(6 downto 0);
signal rst : STD_LOGIC;
signal clk : STD_LOGIC;
signal run_mode : STD_LOGIC;
signal run_toggle : STD_LOGIC;
signal pulse : STD_LOGIC;
signal hltbar_signal : STD_LOGIC;
begin
    proc_top : entity work.proc_top
        generic map (
            SIMULATION_MODE => true
        )
        port map(
            clk_in => clk,
            run_mode => run_mode,
            run_toggle => run_toggle,
            pulse => pulse,
            rst => rst,
            hltbar_external => hltbar_signal,
            s7_anodes_out => s7_anodes_out,
            s7_cathodes_out => s7_cathodes_out
        );

    -- generate a 1HZ clock

    clock : entity work.clock
        port map(
            clk => clk
        );

    test: process
    begin

        if Test_Name = "PowerOn" then
            Report "Starting SAP-1 PowerOn Test";
            hltbar_signal <= '1';
            rst <= '0';
            run_mode <= '0';
            wait for 200 ns;
        elsif Test_Name = "Execute" then

            Report "Starting SAP-1 Execute Test";
            hltbar_signal <= '1';
            rst <= '0';
            run_mode <= '0';
            run_toggle <= '0';
            wait for 200 ns;

            wait for 300 ns;
            run_mode <= '1';
            wait for 200 ns;
            rst <= '1';
            wait for 200 ns;
            rst <= '0';
            run_toggle <= '1';
            wait for 200 ns;
            run_toggle <= '0';
            wait for 500 ns;
        end if; 

        wait;
    end process;

end Behavioral;