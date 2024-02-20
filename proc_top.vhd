library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mytypes.all;

entity proc_top is
    Port (
        clk             : in STD_LOGIC;                 -- clk
        rst             : in STD_LOGIC;                 -- rst
        manual_toggle   : in STD_LOGIC;                 -- toggle to enter setup mode. also disables run mode
        run_toggle      : in STD_LOGIC;
        addr            : in STD_LOGIC_VECTOR(3 downto 0);     -- addr for manual data io 
        data_in         : in STD_LOGIC_VECTOR(7 downto 0);  -- d        Report "Memory " & result.g
        io_mode         : in STD_LOGIC;
        mem_toggle      : in STD_LOGIC
    );
end proc_top;

architecture Behavioral of proc_top is



    -- 4 bit registers
    signal MAR  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal PC   : STD_LOGIC_VECTOR(3 downto 0) := "0000";

    -- 8 bit registers
    signal IR   : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal ACC  : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal B    : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    -- define a memory type

    -- memory
    signal MEMORY : memory_type := (others => (others => '0'));

    -- 6 bit counter
--    signal counter : STD_LOGIC_VECTOR(5 downto 0) := "000000";



--    signal temp_PC : std_logic_vector(3 downto 0);

--    signal counter_reset : std_logic := '0';   
    signal reset_active : std_logic := '0';

    signal run_mode : std_logic := '0';

    procedure report_registers is
    begin
        Report "Registers - PC: [" & to_string(PC) & "]" &
        ", MAR: [" & to_string(MAR) & "]" &
        ", IR: [" & to_string(IR) & "]";

    end procedure report_registers;

    function getOp(op : std_logic_vector(3 downto 0)) return string is
    begin
        if op = "0000" then 
            return "LDA";
        elsif op = "0001" then
            return "ADD";
        elsif op = "0010" then
            return "SUB";
        elsif op = "1110" then
            return "OUT";
        elsif op = "1111" then
            return "HLT";
        else 
            return "???";
        end if;
    end function;

    function getOperand(op : std_logic_vector(3 downto 0); operand: std_logic_vector(3 downto 0)) return string is
    begin
        if op = "0000" or op = "0001" or op = "0010" then
            return to_hstring(operand) & "H";
        else 
            return "";
        end if;
    end function;
    

    procedure report_memory is
        variable opcode : std_logic_vector(3 downto 0);
        variable operand : std_logic_vector(3 downto 0);
        variable value : std_logic_vector(7 downto 0);
    begin
        for i in 0 to 15 loop
            value := MEMORY(i);
            opcode := value(7 downto 4);
            operand := value(3 downto 0);
            
            Report to_hstring(to_unsigned(i, 4)) & ":  " & to_hstring(value) & "  " & 
                getOp(opcode) & " " & getOperand(opcode, operand);
        end loop;
    end procedure;


begin

    -- initialize_ram_port : process
    -- begin
    --     ram_debug_out <= MEMORY;      
    --     wait;  
    -- end process;

    -- ring_counter_6bit : entity work.ring_counter_6bit
    -- port map
    --     (clk => clk, rst => counter_reset, count => counter);

    reset: process(rst, clk)
    begin
        Report "Reset Process - rst: " & to_string(rst) & ", run_mode: " 
            & to_string(run_mode) & ", reset active: " & to_string(reset_active);
        if rising_edge(clk) then
            if rst = '1' and reset_active = '0' then
 
                Report "Clearing Registers";
                -- clear all registers
  --              PC <= "0000";
                --MAR <= "0000";
                --IR <= "00000000"; 
                --ACC <= "00000000";
                --B <= "00000000";
                reset_active <= '1';
--                counter_reset <= '1';                
            elsif reset_active = '1' then
                reset_active <= '0';
--                counter_reset <= '0';
--                run_mode <= '1';
                Report "After Reset setting run mode to 1 - PC: " & to_string(PC) & ", IR: " & to_string(IR) & ", MAR: " & to_string(MAR);
            end if;
        end if;

    end process;

    normal_run_mode: 
    process(clk, rst, run_mode)
        variable temp_PC : std_logic_vector(3 downto 0) := "0000";
        variable temp_IR : std_logic_vector(7 downto 0) := "00000000";
        variable opcode : std_logic_vector(3 downto 0) := "0000";
        variable operand : std_logic_vector(3 downto 0) := "0000";
        variable stage : integer := 0;
    begin
         Report "Run Mode Clk process - stage: " & to_string(stage);
         report_registers;

        -- if rst = '1' then
        --     Report "Clearing Registers";
        --     -- clear all registers
        --     PC <= "0000";
        --     IR <= "00000000"; 
        --     ACC <= "00000000";
        --     MAR <= "0000";
        --     B <= "00000000";
--        elsif run_mode = '1' then 
        if run_mode = '1' and rst = '0' and rising_edge(clk) then 

            Report "Processing with PC: " & to_string(PC) & 
            ", temp_PC: " & to_string(temp_PC) &
        --    ", counter: " & to_string(counter) &
            ", Stage: " & to_string(stage) &
            ", IR: " & to_string(IR) &
            ", MAR: " & to_string(MAR) &
            ", OPCODE: " & to_string(opcode) &
            ", OPERAND: " & to_string(operand) &
            ", MEM[0]: " & to_string(MEMORY(0)) & 
            ", MEM[1]: " & to_string(MEMORY(1));
--                case counter is
            case stage is
--                    when "000001" => 
                when 0 => 
                                report "Stage 1 - Assigning PC to MAR";
                                MAR <= PC;
                                report "MAR after set from PC during stage 1. " & to_string(MAR);
--                    when "000010" => 
                when 1 => 
                                report "Stage 2 - Incrementing PC - current value of PC: " & to_string(PC);
                                temp_PC := STD_LOGIC_VECTOR(unsigned(PC) + 1);
                                PC <= temp_PC;
                                report "PC after increment during stage 2: " & to_string(temp_PC) & ", " & to_string(PC);
--                   when "000100" => 
                when 2 => 
                                report "Stage 3 - loading IR from memory - MAR: " & to_string(MAR) & ", MEM(0): " & to_string(MEMORY(to_integer(unsigned(MAR))));
                                temp_IR := MEMORY(to_integer(unsigned(MAR)));
                                IR <= temp_IR;
                                opcode := temp_IR(7 downto 4);
                                operand := temp_IR(3 downto 0);
                                report "IR after loading from memory during stage 3: temp_IR: " & to_string(temp_IR) & 
                                    ", opcode=" & to_string(opcode) & ", operand=" & to_string(operand);
                when others => null;

            end case;
            -- update stage
            stage := stage + 1;
            if stage >= 6 then
                stage := 0;
            end if;
        end if;
    end process;

    manual_toggle_process:
    process(manual_toggle)
    begin
        Report "Manual_Toggle_Process";
        if rising_edge(manual_toggle) then
            Report "Manual Toggle Process - setting run mode to 0";
  --          run_mode <= '0';
        end if;
    end process;

    run_toggle_process:
    process(run_toggle)
    begin
        Report "Run Toggle";
        if rising_edge(run_toggle) then
            Report "Run Toggle Process - setting run mode to 1";
            run_mode <= '1';
            report_memory;
        end if;
    end process;

    mem_toggle_process:
    process(run_mode, mem_toggle) 
    begin
        Report "mem_toggle Process" & ", run_mode: " & to_string(run_mode);
        if run_mode = '0' and rising_edge(mem_toggle) then
            Report "Handling Mem Toggle";
            if io_mode = '0' then   -- read mode
                Report "Reading Data from Memory";
        --          data <= MEMORY(to_integer(unsigned(addr)));
            elsif io_mode = '1' then   -- write mode
                Report "Writing Data " & format_reg_contents(data_in) & 
                    " to Memory [" & format_reg_contents(addr) & "]";
                MEMORY(to_integer(unsigned(addr))) <= data_in;
            end if;
        end if;
    end process;
end architecture;


