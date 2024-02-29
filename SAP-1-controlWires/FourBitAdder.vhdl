library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FourBitAdder is
	Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
	       b : in STD_LOGIC_VECTOR (3 downto 0);
	       carryin : in STD_LOGIC;
	       sum : out STD_LOGIC_VECTOR (3 downto 0);
	       carryout : out STD_LOGIC
	     );
end FourBitAdder;

architecture Behavioral of FourBitAdder is
	component OneBitFullAdder
    		Port ( a : in STD_LOGIC;
           		b : in STD_LOGIC;
           		carryin : in STD_LOGIC;
           		sum : out STD_LOGIC;
           		carryout : out STD_LOGIC);
	end component;

	signal carry_intermediate: STD_LOGIC_VECTOR (2 downto 0); -- intermediate carry

	begin
		-- 1bitadder 0
		Addr0: OneBitFullAdder Port Map (
			a => a(0),
			b => b(0),
			carryin => carryin,
			sum => sum(0),
			carryout => carry_intermediate(0)
		);

		-- 1bitadder 1
		Addr1: OneBitFullAdder Port Map (
			a => a(1),
			b => b(1),
			carryin => carry_intermediate(0),
			sum => sum(1),
			carryout => carry_intermediate(1)
		);

		-- 1bitadder 2
		Addr2: OneBitFullAdder Port Map (
			a => a(2),
			b => b(2),
			carryin => carry_intermediate(1),
			sum => sum(2),
			carryout => carry_intermediate(2)
		);

		-- 1bitadder 3
		Addr3: OneBitFullAdder Port Map (
			a => a(3),
			b => b(3),
			carryin => carry_intermediate(2),
			sum => sum(3),
			carryout => carryout
		);

end Behavioral;


