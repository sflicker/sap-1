library IEEE;
use IEEE.std_logic_1164.all;

entity program_counter_tb is
end program_counter_tb;

architecture behavioral of program_counter_tb is
signal clk : STD_LOGIC;
signal clrbar : STD_LOGIC;
signal cp : STD_LOGIC;
signal Ep : STD_LOGIC;
signal output : STD_LOGIC_VECTOR(3 downto 0);
begin
    clock1 : entity work.clock
        Port Map (
            clk => clk
        );

    PC : entity work.program_counter
        Port Map(
            CLK => CLK,
            CLRBAR => CLRBAR,
            Cp => Cp,
            Ep => Ep,
            output => output
        );

    th: process
    begin
        CLRBAR <= '0';
        wait for 100 ns;

        CLRBAR <= '1';
        Ep <= '1';
        Cp <= '1';

        wait for 1000 ns;
        CLRBAR <= '0';
        wait for 100 ns;

        CLRBAR <= '1';

        wait for 500 ns;
        Ep <= '0';
        wait for 1000 ns;
        Ep <= '1';

        wait for 500 ns;
        Cp <= '0';
        wait for 1000 ns;
        Cp <= '1';

        wait;
    end process;
end behavioral;