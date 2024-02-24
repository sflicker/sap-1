library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--library work;
--use work.Utils.all;

entity register_8bit is
	Generic (
		ID : string 	-- adding an identifier
	);
    Port (
		data_in      : in STD_LOGIC_VECTOR(7 downto 0);
        clk          : in STD_LOGIC;
        rst          : in STD_LOGIC;
        enable_write : in STD_LOGIC;
		enable_read  : in STD_LOGIC;
        data_out     : out STD_LOGIC_VECTOR(7 downto 0)
	);
end DataRegister;

architecture Behavioral of register_8bit is
	signal register : STD_LOGIC_VECTOR(7 downto 0);
begin
	process(clk, rst)
	begin
		if rst = '1' then
			report "DataRegister instance " & ID & " Reset";
			register <= (others => '0');
			
		elsif rising_edge(clk) then
			if enable_write = '1' then
				register <= data_in;
				report "DataRegister instance " & ID & " write enabled. data_in=" & to_hex_string(data_in) & ", data_out=" & to_hex_string(data_out);
			end if;
		end if;
	end process;
	data_out <= register when enable_read = '1' else (others => 'Z');
end Behavioral;
	
