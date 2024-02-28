library IEEE;
use IEEE.std_logic_1164.all;

-- 4 bit program counter
-- CLR resets to zero
-- Cp increments by one
-- CLK clock input
-- Ep enanbles read

entity program_counter is
    Port (
        CLK : in STD_LOGIC; 
        CLRBAR : in STD_LOGIC;
        Cp : in STD_LOGIC;
        Ep : in STD_LOGIC;
        output : out STD_LOGIC_VECTOR(3 downto 0)
    );
end program_counter;

architecture behavioral of program_counter is
signal signalQ1 : STD_LOGIC;
signal signalQ2 : STD_LOGIC;
signal signalQ3 : STD_LOGIC;
signal signalQ4 : STD_LOGIC;
signal signalY1, signalY2, signalY3, signalY4 :  STD_LOGIC;
begin
    C2 : entity work.LS107
    Port map (
        J1 => Cp,
        K1 => Cp,
        J2 => Cp,
        K2 => Cp,
        CLK1 => CLK,
        CLRBAR1 => CLRBAR,
        Q1 => signalQ1,
        CLK2 => signalQ1,
        CLRBAR2 => CLRBAR,
        Q2 => signalQ2
    );

    C1 : entity work.LS107
    Port map (
        J1 => Cp,
        K1 => Cp,
        J2 => Cp,
        K2 => Cp,
        CLK1 => signalQ2,
        CLRBAR1 => CLRBAR,
        Q1 => signalQ3,
        CLK2 => signalQ3,
        CLRBAR2 => CLRBAR,
        Q2 => signalQ4
    );

    PC_buffer : entity work.LS126
    Port Map (
        A1 => signalQ1,
        A2 => signalQ2,
        A3 => signalQ3,
        A4 => signalQ4,
        C1 => Ep,
        C2 => Ep,
        C3 => Ep,
        C4 => Ep,
        Y1 => signalY1,
        Y2 => signalY2,
        Y3 => signalY3,
        Y4 => signalY4
    );

    output(0) <= signalY1;
    output(1) <= signalY2;
    output(2) <= signalY3;
    output(3) <= signalY4;

end behavioral;
