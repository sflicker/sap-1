library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- DUal JK Flip-flops with clear
entity LS107 is
    Port (
        J1, K1 : in STD_LOGIC;      -- jk inputs to flip flop one
        CLK1    : in STD_LOGIC;     -- clock for flip flop one
        CLRBAR1 : in STD_LOGIC;     -- clear bar for flip flop one
        Q1, QBAR1 : out STD_LOGIC;   -- outputs for flip flop one
        J2, K2 : in STD_LOGIC;      -- jk inputs to flip flop two
        CLK2    : in STD_LOGIC;     -- clock for flip flop two
        CLRBAR2 : in STD_LOGIC;     -- clear bar for flip flop two
        Q2, QBAR2 : out STD_LOGIC   -- outputs for flip flop two
    );
end LS107;

architecture behavioral of LS107 is
begin
    jkff1 : entity work.JKMasterSlaveFlipFlopWithClear
    generic Map (
        ID => "FF1"
    )
    port map(
        J => j1,
        K => k1,
        CLK => CLK1,
        CLRBar => CLRBAR1,
        Q => Q1,
        Qbar => QBAR1
    );

    jkff2 : entity work.JKMasterSlaveFlipFlopWithClear
    generic map (
        ID => "FF2"
    )
    port map(
        J => j2,
        K => k2,
        CLK => CLK2,
        CLRBar => CLRBAR2,
        Q => Q2,
        Qbar => QBAR2
    );

end behavioral;