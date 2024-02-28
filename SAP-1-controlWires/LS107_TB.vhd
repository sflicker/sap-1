library IEEE;
use IEEE.std_logic_1164.all;

entity LS107_tb is
end;

architecture behavioral of LS107_TB is
    signal J1, K1 : STD_LOGIC;
    signal Q1, QBAR1 : STD_LOGIC;
    signal J2, K2 : STD_LOGIC;
    signal Q2, QBAR2 : STD_LOGIC;
    signal CLK1 : STD_LOGIC;
    signal CLRBAR1 : STD_LOGIC := '1';
    signal CLK2 : STD_LOGIC;
    signal CLRBAR2 : STD_LOGIC := '1';
begin
    clock1 : entity work.clock
        Generic map(
            HighDuration => 50 ns,
            LowDuration => 50 ns
        )
        Port Map (
            CLK => CLK1
        );

        clock2 : entity work.clock
        Generic map(
            HighDuration => 50 ns,
            LowDuration => 50 ns
        )
        Port Map (
            CLK => CLK2
        );

    LS107_UT : entity work.LS107
        Port Map (
            J1 => J1,
            K1 => K1,
            Q1 => Q1,
            CLK1 => CLK1,
            CLRBAR1 => CLRBAR1,
            QBAR1 => QBAR1,
            J2 => J2,
            K2 => K2,
            Q2 => Q2,
            QBAR2 => QBAR2,
            CLK2 => CLK2,
            CLRBAR2 => CLRBAR2
        );

    tb : process
    begin

        CLRBAR1 <= '0';
        CLRBAR2 <= '0';

        wait for 100 ns;
    
        CLRBAR1 <= '1';
        CLRBAR2 <= '1';

        j1 <= '0';
        k1 <= '0';
        j2 <= '0';
        k2 <= '0';

        wait for 100 ns;

        report "Phase1: J1=" & std_logic'image(J1) & ", K1=" & std_logic'image(K1) & 
            ", Q1=" & std_logic'image(Q1) & ", QBAR1=" & std_logic'image(QBAR1);

        k1 <= '0';
        j1 <= '1';
        k2 <= '0';
        j2 <= '1';

        wait for 110 ns;

        report "Phase2: j1=" & std_logic'image(j1) & ", k1=" & std_logic'image(k1) & 
            ", q1=" & std_logic'image(q1) & ", qbar1=" & std_logic'image(qbar1);

        k1 <= '1';
        j1 <= '0';
        k2 <= '1';
        j2 <= '0';
        wait for 110 ns;

        report "Phase3: j1=" & std_logic'image(j1) & ", k1=" & std_logic'image(k1) & 
            ", q1=" & std_logic'image(q1) & ", qbar1=" & std_logic'image(qbar1);

        k1 <= '0';
        j1 <= '0';
        k2 <= '1';
        j2 <= '0';

        wait for 110 ns;

        report "Phase4: j1=" & std_logic'image(j1) & ", k1=" & std_logic'image(k1) & 
            ", q1=" & std_logic'image(q1) & ", qbar1=" & std_logic'image(qbar1);

        k1 <= '1';
        j1 <= '1';
        k2 <= '1';
        j2 <= '0';

        wait for 110 ns;

        report "Phase5: j1=" & std_logic'image(j1) & ", k1=" & std_logic'image(k1) & 
            ", q1=" & std_logic'image(q1) & ", qbar1=" & std_logic'image(qbar1);

        k1 <= '0';
        j1 <= '0';
        k2 <= '0';
        j2 <= '0';
        wait for 110 ns;

        report "Phase6: j1=" & std_logic'image(j1) & ", k1=" & std_logic'image(k1) & 
            ", q1=" & std_logic'image(q1) & ", qbar1=" & std_logic'image(qbar1);

        wait for 110 ns;

    end process;
end behavioral;
