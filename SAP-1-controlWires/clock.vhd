library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock is
    Generic (
        HighDuration : time := 100 ns;
        LowDuration : time := 100 ns
    );
    Port (
        clk : out STD_LOGIC
    );
end clock;

architecture behavioral of clock is
begin
    clk_process :
    process
    begin
        clk <= '0';
        wait for HighDuration;
        clk <= '1';
        wait for LowDuration;
    end process;
end behavioral;