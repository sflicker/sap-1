library IEEE;
use IEEE.std_logic_1164.all;

-- 16x4 bit static ram

entity LS189 is
    Port (
        CSBar : in STD_LOGIC; -- chip select. active low
        WEBar : in STD_LOGIC; -- write enable. active low
        Addr : in STD_LOGIC_VECTOR(3 downto 0);   -- address bits
        D : in STD_LOGIC_VECTOR(3 downto 0);    -- data input bits
        OBar : out STD_LOGIC_VECTOR(3 downto 0); -- inverted data output bits
    );
end LS189;

architecture behavioral of LS189 is
    signal internal_data : array (0 to 15) of STD_LOGIC_VECTOR(3 downto 0);
begin
    internal_data(to_integer(unsigned(Addr))) <= D when CSBar = '0 and WEBar = '0';    
    OBar <= not internal_data(to_integer(unsigned(Addr))) <= D when CSBar = '0 and WEBar = '1';
end architecture behavioral;

