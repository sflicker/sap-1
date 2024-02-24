library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ring_counter_6bit is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        count : out STD_LOGIC_VECTOR(5 downto 0)
    );
end ring_counter_6bit;

architecture Behavioral of ring_counter_6bit is
    signal ff_inputs : STD_LOGIC_VECTOR(5 downto 0);
    signal ff_outputs : STD_LOGIC_VECTOR(5 downto 0);

begin

    -- when reset (rst='1')
    -- the first ff's input is set to 1. the other ff's inputs are set to zero.
    -- for non reset (rst='0')
    -- the first ff's input is set to the last ff output.
    -- the other ff's input is set to the previous ff's output.
    ff_inputs(0) <= '1' when rst = '1' else ff_outputs(5);
    ff_inputs(5 downto 1) <= ff_outputs(4 downto 0) when rst = '0' else (others => '0');

    -- generate the ffs

    gen_ffs: for i in 0 to 5 generate
        DFF:
            entity work.d_flip_flop
                generic Map (
                    ID =>  to_string(i)
                )
                port Map (
                    clk => clk,
                    rst => rst,
                    d => ff_inputs(i),
                    q => ff_outputs(i),
                    q_bar => open
                );
    end generate gen_ffs;

    count <= ff_outputs;
end behavioral;

