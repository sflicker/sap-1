library IEEE;
use IEEE.std_logic_1164.all;

-- quad 2 input nand gates

entity LS00 is
    Port (
    A1, A2, A3, A4 : in STD_LOGIC;
    B1, B2, B3, B4 : in STD_LOGIC;
    Y1, Y2, Y3, Y4 : in STD_LOGIC
    );
end LS00;

architecture behavioral of LS00 is
begin
    Y1 <= not (A1 and B1);
    Y2 <= not (A2 and B2);
    Y3 <= not (A3 and B3);
    Y4 <= not (A4 and B4);
end behavioral;