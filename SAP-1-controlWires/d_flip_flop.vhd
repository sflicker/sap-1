library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop is
    Generic (
		ID : string 	-- adding an identifier
	);
    Port (
        D : in STD_LOGIC;
        RST : in STD_LOGIC;
        CLK : in STD_LOGIC;
        Q : OUT STD_LOGIC;
        Q_bar : out STD_LOGIC
        );
end d_flip_flop; 

architecture behavioral of d_flip_flop is
begin
    process (CLK)
    begin
        if rising_edge(CLK) then 
            Q <= D;
            Q_Bar <= not D;
        end if;
        -- if RST = '1' then
        --     Q <= '0';
        --     Q_bar <= '1'; 
        -- elsif rising_edge(CLK) then
        --     Q <= D;
        --     Q_Bar <= not D;
        -- end if;
        -- report "FlipFlop - " & ID & ", D=" & STD_LOGIC'image(D) & ", Q=" & STD_LOGIC'image(Q) 
        --     & ", Q_bar=" & STD_LOGIC'image(Q_bar);
    end process;
end behavioral;