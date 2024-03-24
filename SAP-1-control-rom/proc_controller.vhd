----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2024 10:13:16 PM
-- Design Name: 
-- Module Name: proc_controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- CONTROL WORD
-- BITS 0-2    -- W BUS Selector
                -- 000 0H PC
                -- 001 1H Accumulator
                -- 010 2H ALU
                -- 011 3H IR
                -- 100 4H RAM
-- BIT 3        Cp - Program Counter increment. active high
-- BIT 4        LMBar - Load MAR from W bus. active Low
-- BIT 5        LIBar - Load IR from W Bus. active Low
-- BIT 6        LABar - Load Accumulator from W bus. active low
-- BIT 7        Su - ALU mode. 0 add, 1 sub
-- BIT 8        LBBar - Load B register from W bus. active low
-- BIT 9        LOBar - Load output register from W Bus. active Low




entity proc_controller is
  Port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    run_mode : in STD_LOGIC;
    run_toggle : in STD_LOGIC;
    opcode : in STD_LOGIC_VECTOR(3 downto 0);          -- 5 opcodes in model, 4 bits of instruction form the opcode
    --control_word : out STD_LOGIC_VECTOR(3 downto 0)    -- 4 bits control word
    wbus_sel : out STD_LOGIC_VECTOR(2 downto 0);
    Cp  : out STD_LOGIC;                          -- increment program counter by one
    ClrPC : out STD_LOGIC;
    LMBar : out STD_LOGIC;                        -- Load MAR register from WBus - enable low
    LIBar : out STD_LOGIC;                        -- LOAD IR register from WBus - enable low
    LABar : out STD_LOGIC;                        -- LOAD Accumulator register from WBus -- enable low
    Su : out STD_LOGIC;                           -- operation for ALU. 0 - ADD, 1 - Subtract
    LBBar : out STD_LOGIC;                        -- LOAD B register from WBus - eanble low
    LOBar : out STD_LOGIC;
    HLTBar : out STD_LOGIC;
    running : out STD_LOGIC
    );
end proc_controller;

architecture Behavioral of proc_controller is
    signal address_rom_out : STD_LOGIC_VECTOR(3 downto 0);
    signal clear_presettable_counter : STD_LOGIC;
    signal stage_counter : integer;
    signal control_word_index_signal : std_logic_vector(3 downto 0);
    signal control_word_signal : std_logic_vector(0 to 9);
    signal running_signal : STD_LOGIC := '0';

    type ADDRESS_ROM_TYPE is array(0 to 15) of std_logic_vector(3 downto 0);
    type CONTROL_ROM_TYPE is array(0 to 15) of STD_LOGIC_VECTOR(0 to 9);

    constant ADDRESS_ROM_CONTENTS : ADDRESS_ROM_TYPE := (
        0 => "0011",     -- LDA
        1 => "0110",     -- ADD
        2 => "1001",     -- SUB
        14 => "1100",     -- OUT
        15 => "0000",       -- HLT
        others => "0000"
    );

    constant CONTROL_ROM : CONTROL_ROM_TYPE := (
       -- FETCH
       0 =>  "0000011011",     -- Phase1:   PC -> MAR
       1 =>  "1111111011",     -- Phase2:   INC PC
       2 =>  "1000101011",     -- Phase3:   RAM -> IR
       -- LDA
       3 =>  "0110011011",     -- LDA Phase4: IR (operand portion) -> MAR
       4 =>  "1000110011",     -- LDA Phase5: RAM -> A
       5 =>  "1110111011",     -- LDA Phase6: NOP
       -- ADD
       6 =>  "0110011011",      -- ADD Phase4: IR(operand portion) -> MAR
       7 =>  "1000111001",      -- ADD Phase5: RAM -> B, SU -> 0
       8 =>  "0100110011",      -- ADD Phase6: ALU -> A
       -- SUB
       9 =>  "0110011011",      -- SUB Phase4: IR(operand portion) -> MAR
       10 => "1000111101",      -- SUB Phase5: RAM -> B, SU => 1
       11 => "0100110011",      -- --SUB phase6: ALU => A
       -- OUT
       12 => "0010111010",      -- OUT phase 4  A => OUT
       13 => "1110111011",      -- OUT phase 5 NOP
       14 => "1110111011",      -- OUT phase 5 NOP
       -- unused
       15 => "1110111011"       --NOP
       
       );

begin

    running <= running_signal;

    run_mode_process:
        process(clk, rst, run_mode, opcode)
            variable stage : integer := 1;
            variable control_word_index : std_logic_vector(3 downto 0);
            variable control_word : std_logic_vector(0 to 9);
        begin
            if rst = '1' then
                Report "Handling Reset Logic - Setting hltbar high";
                hltbar <= '1';
            else
                if opcode = "1111" then
                    Report "Halting Run - Setting HLTBAR low";
                    HLTBAR <= '0';
                    running_signal <= '0';
                elsif run_mode = '1' and running_signal = '0' and rising_edge(run_toggle) then
                    running_signal <= '1';
                    Report "Starting Program Execution";               
                elsif run_mode = '1' and running_signal = '1' and rising_edge(clk) then
                    if stage = 1 then
                        control_word_index := "0000";
                    elsif stage = 4 then
                        control_word_index := ADDRESS_ROM_CONTENTS(to_integer(unsigned(opcode)));
                    else 
                        control_word_index := std_logic_vector(unsigned(control_word_index) + 1);
                    end if;
    
                    control_word := CONTROL_ROM(to_integer(unsigned(control_word_index)));
    
                    Report "Stage: " & to_string(stage) 
                        & ", control_word_index: " & to_string(control_word_index) 
                        & ", control_word: " & to_string(control_word) & ", opcode: " & to_string(opcode);
    
                    control_word_signal <= control_word;
                    control_word_index_signal <= control_word_index;
                    wbus_sel <= control_word(0 to 2);
                    Cp <= control_word(3);
                    LMBar <= control_word(4);
                    LIBar <= control_word(5);
                    LABar <= control_word(6);
                    Su <= control_word(7);
                    LBBar <= control_word(8);
                    LOBar <= control_word(9);
    
                    stage_counter <= stage;
        
    
                    if stage >= 6 then
                        stage := 1;
                    else 
                        stage := stage + 1;
                    end if;
    
                end if;
            end if;
        end process;

--    stage_counter_inst : entity work.ring_counter_6bit
--         port map(
--             clk => clk,
--             rst => rst,
--             count => stage_counter--,
-- --            clk_out_1HZ => open,
-- --            anodes => open,
-- --            cathodes => open
--          );
   
    -- addr_rom : entity work.address_rom
    --     port map(
    --         addr_in => opcode,
    --         data_out => address_rom_out
    --         );
            
    -- preset_counter : entity work.presettable_counter
    --     port map( clk => clk,
    --             load => stage_counter(2),
    --             clr => stage_counter(0),
    --             control_word_base_addr => address_rom_out,
    --             control_word_addr => control_word_signal
    --            );
                

    -- control_rom : entity work.controller_rom
    --     port map(
    --         control_word => control_word_signal,
    --         wbus_sel => wbus_sel,
    --         Cp => Cp,
    --         LMBar => LMBar,
    --         LIBar => LIBar,
    --         LABar => LABar,
    --         Su => Su,
    --         LBBar => LBBar,
    --         LOBar => LOBar
    --            );
       

end Behavioral;
