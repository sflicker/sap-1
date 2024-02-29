library IEEE;
use IEEE.std_logic_1164.all;

-- hex inverter

entity LS04 is
    Port (
    A1, A2, A3, A4, A5, A6 : in STD_LOGIC;
    Y1, Y2, Y3, Y4, Y5, Y6 : out STD_LOGIC
    );
end LS04;

architecture behavioral of LS04 is
begin
    Y1 <= not A1;
    Y2 <= not A2;
    Y3 <= not A3;
    Y4 <= not A4;
    Y5 <= not A5;
    Y6 <= not A6;
end architecture;