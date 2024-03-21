library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity proc_top is
    generic (
        SIMULATION_MODE : boolean := false
    );
    port( clk_in : in STD_LOGIC;  -- map to FPGA clock will be stepped down to 1HZ
                                -- for simulation TB should generate clk of 1HZ
          rst : in STD_LOGIC;   -- map to a button
          run_mode : in STD_LOGIC;  -- 0 - manual, 1 - automatic/run
          run_toggle : in STD_LOGIC; -- run toggles on rising edge
          running : out STD_LOGIC;
          pulse : in STD_LOGIC;
          hltbar : in STD_LOGIC;
        -- other switches and buttons  
          s7_anodes_out : out STD_LOGIC_VECTOR(3 downto 0);      -- maps to seven segment display
          s7_cathodes_out : out STD_LOGIC_VECTOR(6 downto 0)     -- maps to seven segment display
        );
end proc_top;

architecture behavior of proc_top is
    signal clk_1HZ_signal : std_logic;
    signal clk_1HZ_bar_signal : std_logic;
    signal clk_1KHZ_signal : std_logic;
    signal hltbar_signal : std_logic;
--    signal opcode_signal : std_logic_vector(3 downto 0);
    signal control_word_signal : std_logic_vector(3 downto 0);
    signal wbus_sel_signal : STD_LOGIC_VECTOR(2 downto 0);       
    signal Cp_signal : STD_LOGIC;
    signal LMBar_signal : STD_LOGIC;
    signal LIBAR_signal : STD_LOGIC;
    signal LABAR_signal : std_logic;
    signal Su_signal : std_logic;
    signal LBBar_signal : std_logic;
    signal LOBar_signal : std_logic;
    signal pc_data_signal : STD_LOGIC_VECTOR(3 downto 0);
    signal acc_data_signal : STD_LOGIC_VECTOR(7 downto 0);
    signal alu_data_signal : STD_LOGIC_VECTOR(7 downto 0);
    signal IR_operand_signal : STD_LOGIC_VECTOR(3 downto 0);
    signal IR_opcode_signal : STD_LOGIC_VECTOR(3 downto 0);
    signal RAM_data_out_signal : STD_LOGIC_VECTOR(7 downto 0);
    signal w_bus_data_signal : STD_LOGIC_VECTOR(7 downto 0);
    signal mar_addr_signal: STD_LOGIC_VECTOR(3 downto 0);
    signal ram_data_in_signal : STD_LOGIC_VECTOR(7 downto 0);
    signal b_data_signal : STD_LOGIC_VECTOR(7 downto 0);
    signal display_data : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin

    CLOCK_CTRL : entity work.clock_controller 
        generic map(
            SIMULATION_MODE => SIMULATION_MODE
        )
        port map (
            clk_in => clk_in,
            rst => rst,
            run_mode => run_mode,
            pulse => pulse,
            hltbar => hltbar_signal,
            clk_out_1HZ => clk_1HZ_signal,
            clk_out_1HZ_bar => clk_1HZ_bar_signal,
            clk_out_1KHZ => clk_1KHZ_signal
        );
    -- GENERATING_CLOCK_PROCESSOR:
    --     if SIMULATION_MODE
    --     generate
    --         passthrough_clock_converter : entity work.passthrough_clock_converter
    --             port map (
    --                 clk_in => clk_in,   -- simulation test bench should generate a 1HZ clock
    --                 clk_out => clk_1HZ_signal
    --             );
    --     else generate
    --         FPGA_clock_converter : entity work.clock_converter
    --             port map(
    --                 clk_in_100MHZ => clk_in,    -- clock from BASYS3 FPGA SYSTEM CLOCK. change if other different
    --                 rst => rst, 
    --                 clk_out_1HZ => clk_1HZ_signal,            -- slow clock for processor from development. may increase later
    --                 clk_out_1KHZ => clk_1KHZ_signal           -- clock for seven segment display on basys3 refresh  
    --             );
        
    --     end generate;
    

    w_bus : entity work.w_bus
        port map(
            sel => wbus_sel_signal,
            pc_data_in => pc_data_signal,
            acc_data_in => acc_data_signal,
            alu_data_in => alu_data_signal,
            IR_data_in => IR_operand_signal,
            RAM_data_in => ram_data_out_signal,
            data_out => w_bus_data_signal
        );

    PC : entity work.PC
        port map(
            clk => clk_1HZ_signal,
            rst => rst,
            Cp => Cp_signal,
            pc_out => pc_data_signal
            );

    MAR : entity work.MAR
        port map(
            clk => clk_1HZ_signal,
            clr => rst,
            LMBar => LMBar_signal,
            mar_in => w_bus_data_signal(3 downto 0),
            mar_out => mar_addr_signal
            );
            
    IR : entity work.IR
        port map(
            clk => clk_1HZ_signal,
            LIBar => LIBar_signal,
            ir_in => w_bus_data_signal,
            opcode_out=> IR_opcode_signal,
            operand_out => IR_operand_signal
        
        );

    ram_bank : entity work.ram_bank
        port map(
            clk => clk_1HZ_signal,
            addr => mar_addr_signal,
            ram_data_in => ram_data_in_signal,
            LBar => LBBar_signal,
            ram_data_out => ram_data_out_signal
        );

    proc_controller : entity work.proc_controller
        port map(
            clk => not clk_1hz_signal,
            rst => rst,
            run_mode => run_mode,
            run_toggle => run_toggle,
            opcode => IR_opcode_signal,
--            control_word => control_word_signal,
            wbus_sel => wbus_sel_signal,
            Cp => Cp_signal,
            LMBar => LMBar_signal,
            LIBar => LIBar_signal,
            LABar => LABar_signal,
            Su => Su_signal,
            LBBar => LBBar_signal,
            LOBar => LOBar_signal,
            hltbar => hltbar_signal,
            running => running
        );

    -- control_rom : entity work.controller_rom
    --     port map(
    --         control_word => control_word_signal,
    --         wbus_sel => wbus_sel_signal,
    --         Cp => Cp_signal,
    --         LMBar => LMBar_signal,
    --         LIBar => LIBar_signal,
    --         LABar => LABar_signal,
    --         Su => Su_signal,
    --         LBBar => LBBar_signal,
    --         LOBar => LOBar_signal
    --     );

        
      acc: entity work.accumulator
        Port map(
            clk => clk_1HZ_signal,
            LABar => LABar_signal,
            acc_in => w_bus_data_signal,
            acc_out => acc_data_signal
            ); 
        
      B : entity work.B
        port map (
            clk => clk_1HZ_signal,
            LBBar => LBBar_signal,
            b_in => w_bus_data_signal,
            b_out => b_data_signal
        );
        
      ALU : entity work.ALU
        port map (
            Su => Su_signal,
            a => acc_data_signal,
            b => b_data_signal,
            alu_out => alu_data_signal
            );

    OUTPUT_REG : entity work.output
            port map (
                clk => clk_1HZ_signal,
                LOBar => LOBar_signal,
                output_in => w_bus_data_signal,
                output_out => display_data(7 downto 0)
            );
        
      GENERATING_FPGA_OUTPUT : if SIMULATION_MODE = false
        generate  
            display_controller : entity work.display_controller
            port map(
                clk => clk_1KHZ_signal,
                rst => rst,
                data_in => display_data,
                anodes_out => s7_anodes_out,
                cathodes_out => s7_cathodes_out
            );
        end generate;
                              
    -- log:
    --     process(clk_in)
    --     begin
    --         if rising_edge(clk_in) then
    --             Report "Clock";
    --         end if;
    --     end process;


end behavior;
    
          