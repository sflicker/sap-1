library IEEE;
use IEEE.std_logic_1164.all;

entity tristatebuffer is
    Port (
        A : in STD_LOGIC;
        C : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end tristatebuffer;

architecture behavioral of tristatebuffer is
begin
    Y <= A when C = '1' else 'Z';
end behavioral;
