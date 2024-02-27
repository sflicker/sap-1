library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--library work;
--use work.Utils.all;

entity register_4bit is
	Generic (
		ID : string := ""	-- adding an identifier
	);
    Port (
        clk          : in STD_LOGIC;         -- clock
        clr          : in STD_LOGIC;		 -- clear
        enable_write : in STD_LOGIC;
		enable_read	 : in STD_LOGIC;
		data_in      : in STD_LOGIC_VECTOR(3 downto 0);
        data_out     : out STD_LOGIC_VECTOR(3 downto 0)
	);
end DataRegister;

architecture Behavioral of register_4bit is
	signal register : STD_LOGIC_VECTOR(3 downto 0);
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
		data_out <= register when enable_read = '1' else (others => 'Z');
	end process;
end Behavioral;
	
