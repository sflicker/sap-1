library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

library work;
use work.Utils.all;

entity Memory is
	Generic (
		ID : string 	-- adding an identifier
	);
	Port (
		clk				: in STD_LOGIC;
		addr			: in STD_LOGIC_VECTOR(7 downto 0); 	-- 8-bit-address
		data_in 		: in STD_LOGIC_VECTOR(7 downto 0); 	-- 8-bit- data input
		enable_write 	: in STD_LOGIC;   --enable write
		data_out		: out STD_LOGIC_VECTOR(7 downto 0)  -- 8 bit data output
		);
end Memory;

architecture Behavioral of Memory is
	type RAM_Type is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);   -- define the memory type
	signal RAM: RAM_type := (others => (others => '0'));				-- Initialize the memory with zeros

begin
	-- Memory read process
	process(clk)
	begin
		if rising_edge(clk) then 
			if enable_write = '1' then
				--report "Memory Writing to addr: " & to_hex_string(addr);
				--report "Memory Writing from addr: " & integer'image(to_integer(unsigned(addr))) & " value " & std_logic_vector'image(RAM(to_integer(unsigned(addr))));

				RAM(to_integer(unsigned(addr))) <= data_in;
			end if;
		--	report "Memory Writing";
			--report "Memory writing from addr: " & unsigned(addr) & " value " & RAM(to_integer(unsigned(addr)));
			data_out <= RAM(to_integer(unsigned(addr)));
		end if;
	end process;
end Behavioral;
