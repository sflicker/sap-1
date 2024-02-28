library IEEE;
use IEEE.std_logic_1164.all;

-- 4 bit register

entity LS173 is 
    Port (
        input_data : in STD_LOGIC_VECTOR(3 downto 0);    -- input pins. controlled by clock and G1,G2
        output_data : out STD_LOGIC_VECTOR(3 downto 0);  -- output pins. controlled by M and N. not controlled by clock.
        clk : in STD_LOGIC_VECTOR(3 downto 0);  -- clock. inputs load on positive clock edge if enabled.
        clr : in STD_LOGIC_VECTOR(3 downto 0);  -- clear. if high all bits are set to zero. not controlled by clock
        g1, g2 : in STD_LOGIC;         -- input loading. both must be low for input.
        m, n : in STD_LOGIC;            -- output control. both must be for output otherwise Z.
    );

architecture behavioral of LS173 is
    signal internal_data : STD_LOGIC_VECTOR(3 downto 0);
begin

    process(clr)  -- asynchronous clear
    begin
        if clr = '1' then
            internal_data <= (others => '0')
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) and g1 = '0' and g2 = '0' then
            internal_data <= input_data;
        end if;
    end process;

    output_data <= internal_data when M = '0' and N = '0' else (others => 'Z');
end behavioral;

