library IEEE;
use IEEE.std_logic_1164.all;

entity LS20_TB is
end;

architecture behavioral of LS20_TB is
    signal A1 : STD_LOGIC;
    signal B1 : STD_LOGIC;
    signal C1 : STD_LOGIC;
    signal D1 : STD_LOGIC;
    signal A2 : STD_LOGIC;
    signal B2 : STD_LOGIC;
    signal C2 : STD_LOGIC;
    signal D2 : STD_LOGIC;
    signal Y1 : STD_LOGIC;
    signal Y2 : std_logic;
    begin

    ls20Inst : entity work.LS20
            port map (
                A1 => A1,
                B1 => B1,
                C1 => C1,
                D1 => D1,
                Y1 => Y1,
                A2 => A2,
                B2 => B2,
                C2 => C2,
                D2 => D2,
                Y2 => Y2
            );

    th: process
    begin

        A1 <= '1';
        B1 <= '1';
        C1 <= '1';
        D1 <= '1';

        wait for 100 ns;

        assert Y1 = '0' 
            report "Assertion Violation." 
            severity FAILURE;
        Report "Test Passed";

        A1 <= '0';
        B1 <= '0';
        C1 <= '0';
        D1 <= '0';

        wait for 100 ns;
        Report "Asserting Correct value";
        assert Y1 = '1' 
            report "Assertion Violation." 
            severity FAILURE;
        Report "Test Passed";


        A2 <= '1';
        B2 <= '1';
        C2 <= '1';
        D2 <= '1';

        wait for 100 ns;
        Report "Asserting Correct value";
        assert Y2 = '0' 
            report "Assertion Violation." 
            severity FAILURE;
        Report "Test Passed";

        A2 <= '0';
        B2 <= '0';
        C2 <= '0';
        D2 <= '0';

        wait for 100 ns;
        Report "Asserting Correct value";
        assert Y2 = '1' 
            report "Assertion Violation." 
            severity FAILURE;
        Report "Test Passed";

        wait;
    end process;
end behavioral;

