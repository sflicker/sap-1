library IEEE;
use IEEE.std_logic_1164.all;

-- quad 2 input XOR gates

entity LS86 is
    port (
        A1, A2, A3, A4 : IN STD_LOGIC;
        B1, B2, B3, B4 : in STD_LOGIC;
        Y1, Y2, Y3, Y4 : out STD_LOGIC;
    );
end LS86;

architecture behavioral of LS86 is
begin
    Y1 <= A1 XOR B1;
    Y2 <= A2 XOR B2;
    Y3 <= A3 XOR B3;
    Y4 <= A4 XOR B4;
end behavioral;