library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mytypes.all;

entity proc_top_tb is
end proc_top_tb;

architecture Behavioral of proc_top_tb is
--    signal clk :  STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
--    signal run_mode : STD_LOGIC := '0';
    signal manual_toggle : STD_LOGIC := '0';
    signal io_mode : STD_LOGIC := '0';
    signal mem_toggle : STD_LOGIC := '0';
    signal run_toggle : STD_LOGIC := '0';
    signal addr : STD_LOGIC_VECTOR(3 downto 0);
    signal data_in : STD_LOGIC_VECTOR(7 downto 0);
    signal pulse_toggle : STD_LOGIC := '0';

    type mem_array_type is array (natural range <>) of std_logic_vector(7 downto 0);
    constant init_mem : mem_array_type := (
        b"00001001", b"00011010", b"00011011", b"00101100",
        b"11100000", b"11110000", b"10101010", b"10101010", 
        b"10101010", b"00010000", b"00010100", b"00011000",
        b"00100000", b"10101010", b"10101010", b"10101010");
begin

    proc : entity work.proc_top
    port map(
--        clk => clk, 
        rst => rst, 
        manual_toggle => manual_toggle,
        pulse_toggle => pulse_toggle,
        run_toggle => run_toggle,
        addr => addr,
        data_in => data_in,
        io_mode => io_mode,
        mem_toggle => mem_toggle
    );

    -- clk_process : entity work.clock 
    --     port map(
    --         clk => clk
    --     );

    -- process
    -- begin
    --     clk <= '0';
    --     wait for 50 ns;
    --     clk <= '1';
    --     wait for 50 ns;
    -- end process;

    th:
        process
        begin

          --  run_mode <= '0';
            manual_toggle <= '1';
            io_mode <= '1';
            wait for 100 ns;

            Report "Loading Memory Contents";
            for i in init_mem'range loop

            -- manually set program in memory
                mem_toggle <= '0'; wait for 10 ns;
                addr <= std_logic_vector(to_unsigned(i, addr'length)); wait for 10 ns;
                data_in <= init_mem(i); wait for 10 ns;
                mem_toggle <= '1'; wait for 10 ns;
            end loop;

            Report "Finsihed Loading Memory";
            Report "Resetting";
            rst <= '1'; wait for 100 ns;
            
            rst <= '0';
            wait for 100 ns;
            run_toggle <= '1'; 

            -- Report "String Run Mode";
            -- run_mode <= '1';
            -- wait for 50 ns;

            wait;
        end process;
end Behavioral;


