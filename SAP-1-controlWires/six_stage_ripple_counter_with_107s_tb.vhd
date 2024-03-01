library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity six_stage_ripple_counter_with_107s_tb is
end six_stage_ripple_counter_with_107s_tb;

architecture behavioral of six_stage_ripple_counter_with_107s_tb is
    signal clk : STD_LOGIC;
    signal clrbar : STD_LOGIC := '1';
    signal t1, t2, t3, t4, t5, t6 : STD_LOGIC;
begin
    test_clk : entity work.clock
        Port map (
            clk => clk
        );
    test_entity : entity work.six_stage_ripple_counter_with_107s
        Port map (
            clk => clk,
            clrbar => clrbar,
            t1 => t1,
            t2 => t2,
            t3 => t3,
            t4 => t4,
            t5 => t5,
            t6 => t6
        );
    test_process: process
    begin

        wait for 200 ns;

        clrbar <= '0';
        wait for 100 ns;

        clrbar <= '1';
        wait;
    end process;
end behavioral;


    
