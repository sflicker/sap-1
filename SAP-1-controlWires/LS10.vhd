library IEEE;
use IEEE.std_logic_1164.all;

-- triple 3 input NAND Gates

entity LS10 is
    Port (
    A1, A2, A3 : in STD_LOGIC;
    B1, B2, B3 : in STD_LOGIC;
    C1, C2, C3 : in STD_LOGIC;
    Y1, Y2, Y3 : in STD_LOGIC
    );
end LS10;

architecture behavioral of LS10 is
    
begin
    Y1 <= not (A1 and B1 and C1);
    Y2 <= not (A2 and B2 and C2);
    Y3 <= not (A3 and B3 and C3);
end architecture behavioral;