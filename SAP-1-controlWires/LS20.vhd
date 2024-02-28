library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- model of a Dual 4 input NAND gate chip.
-- the 74LS20 is specifically used in the SAP-1 text book computer example

entity LS20 is
    Port (
        A1, B1, C1, D1 : in STD_LOGIC;
        A2, B2, C2, D2 : in STD_LOGIC;
        Y1, Y2 : out STD_LOGIC
    );
end LS20;

architecture behavioral of LS20 is
begin
    -- FIRST NAND GATE
    Y1 <= not (A1 and B1 and C1 and D1);

    -- SECOND NAND GATE
    Y2 <= not (A2 and B2 and C2 and D2);
end behavioral;