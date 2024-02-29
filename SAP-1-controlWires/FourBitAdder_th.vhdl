library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FourBitAdder_th is
	-- testbench has no ports
end FourBitAdder_th;

architecture behavior of FourBitAdder_th is
	component FourBitAdder
		Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
		       b : in STD_LOGIC_VECTOR (3 downto 0);
		       carryin : in STD_LOGIC;
		       sum : out STD_LOGIC_VECTOR (3 downto 0);
		       carryout : out STD_LOGIC);
	end component;

	-- inputs
	signal a,b : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
	signal carryin : STD_LOGIC := '0';

	-- outputs
	signal sum : STD_LOGIC_VECTOR (3 downto 0);
	signal carryout : STD_LOGIC;

	type std_logic_array is array (natural range <>) of std_logic;

begin
	-- instantiate the unit under test
	uut: FourBitAdder Port Map (a => a, b => b, carryin => carryin, sum => sum, carryout => carryout);

	-- testbench process
	tb: process
		--	variable i, j : integer range 0 to 15; -- for 4-bit inputs
		variable carry_values: std_logic_array(0 to 1) := ('0', '1');
	begin
	-- testing loop for all input combinations

		for i in 0 to 15 loop
			for j in 0 to 15 loop
				for k in 0 to 1 loop
					a <= std_logic_vector(to_unsigned(i, 4));
					b <= std_logic_vector(to_unsigned(j, 4));
					carryin <= carry_values(k);

					wait for 10 ns;  -- wait for the circuit to process

					-- Optional: report the result

				--report "a=" & std_logic_vector'image(a) & ", b=" & std_logic_vector'image(b) & ", sum=" & std_logic_vector'image(sum) & ", carryout=" & std_logic'image(carryout);
					report "a=" & to_string(a) & ", b=" & to_string(b) & ", carryin=" & to_string(carryin) & ", sum=" & to_string(sum) & ", carryout=" & std_logic'image(carryout)  ;

				end loop;
			end loop;
		end loop;

		wait;
	end process;
end behavior;

	
