library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity Declaration
entity OneBitFullAdder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           carryin : in STD_LOGIC;
           sum : out STD_LOGIC;
           carryout : out STD_LOGIC);
end OneBitFullAdder;

-- Architecture Body
architecture Behavioral of OneBitFullAdder is
begin
    -- Sum and Carry-out logic
    sum <= a xor b xor carryin;
    carryout <= (a and b) or (a and carryin) or (b and carryin);
end Behavioral;

