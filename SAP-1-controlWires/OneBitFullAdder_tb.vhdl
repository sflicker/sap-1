library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OneBitFullAdder_tb is
-- This is a testbench entity so it has no ports
end OneBitFullAdder_tb;

architecture behavior of OneBitFullAdder_tb is 
    -- Component Declaration for the Unit Under Test (UUT)
    component OneBitFullAdder
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           carryin : in STD_LOGIC;
           sum : out STD_LOGIC;
           carryout : out STD_LOGIC);
    end component;

   --Inputs
   signal a : STD_LOGIC := '0';
   signal b : STD_LOGIC := '0';
   signal carryin : STD_LOGIC := '0';

   --Outputs
   signal sum : STD_LOGIC;
   signal carryout : STD_LOGIC;

begin
    -- Instantiate the Unit Under Test (UUT)
   uut: OneBitFullAdder Port Map (a => a, b => b, carryin => carryin, sum => sum, carryout => carryout);

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        a <= '0';
        b <= '0';
        carryin <= '0';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);

        a <= '0';
        b <= '0';
        carryin <= '1';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);
        
	a <= '0';
        b <= '1';
        carryin <= '0';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);

        a <= '0';
        b <= '1';
        carryin <= '1';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);

        a <= '1';
        b <= '0';
        carryin <= '0';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);

        a <= '1';
        b <= '0';
        carryin <= '1';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);

        a <= '1';
        b <= '1';
        carryin <= '0';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);

        a <= '1';
        b <= '1';
        carryin <= '1';
        wait for 100 ns;
        report "TC1: a=" & std_logic'image(a) & " b=" & std_logic'image(b) & " carryin=" & std_logic'image(carryin) & 
                " => sum=" & std_logic'image(sum) & " carryout=" & std_logic'image(carryout);


        -- Complete the simulation
        wait;
    end process;
end behavior;

