library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAR is
    Port (
        clk : in STD_LOGIC;
        clr : in STD_LOGIC;
        LMBar : in STD_LOGIC;
        mar_in : in STD_LOGIC_VECTOR(3 downto 0);
        mar_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
end MAR;

architecture behavior of MAR is 
    signal internal_data : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(clr)
    begin
        if clr = '1' then
            internal_data <= (others => '0');
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) and LMBar = '0' then
            internal_data <= mar_in;
        end if;
    end process;
    
    mar_out <= internal_data;
end behavior;    
    
    