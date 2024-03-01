library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- six stage ripple counter. this will use JK flip flops in the LS107 entity.

entity six_stage_ripple_counter_with_107s is 
    Port (
        clk : in STD_LOGIC;
        clrbar : in STD_LOGIC;
        t1, t2, t3, t4, t5, t6 : out STD_LOGIC
    );
end six_stage_ripple_counter_with_107s;

architecture behavioral of six_stage_ripple_counter_with_107s is
    signal s1, s2, s3, s4, s5, s6 : STD_LOGIC;
    signal s7, s8, s9, s10, s11, s12 : STD_LOGIC;
begin
    LS107_1 : entity work.LS107
    Port map (                                       
        J1 => s12,
        K1 => s11, 
        Q1 => s2,
        QBAR1 => s1,
        CLK1 => clk,
        CLRBAR1 => clrbar,
        J2 => s1,
        K2 => s2,
        CLK2 => clk,
        CLRBAR2 => clrbar,
        Q2 => s3,
        QBAR2 => s4
    );

    LS107_2 : entity work.LS107
    Port map (                                       
        J1 => s3,
        K1 => s4, 
        Q1 => s5,
        QBAR1 => s6,
        CLK1 => clk,
        CLRBAR1 => clrbar,
        J2 => s5,
        K2 => s6,
        CLK2 => clk,
        CLRBAR2 => clrbar,
        Q2 => s7,
        QBAR2 => s8
    );

    LS107_3 : entity work.LS107
    Port map (                                       
        J1 => s7,
        K1 => s8, 
        Q1 => s9,
        QBAR1 => s10,
        CLK1 => clk,
        CLRBAR1 => clrbar,
        J2 => s9,
        K2 => s10,
        CLK2 => clk,
        CLRBAR2 => clrbar,
        Q2 => s11,
        QBAR2 => s12
    );

    T1 <= s1;
    T2 <= s3;
    T3 <= s5;
    T4 <= s7;
    T5 <= s9;
    T6 <= s11;

end behavioral;
