library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- JKMasterSlaveFlipFlopWithClear.

entity JKMasterSlaveFlipFlopWithClear is
    Generic(
        ID  : String := ""
    );
    Port(
        J, K        : in STD_LOGIC;  -- J and K data inputs
        CLK, CLRbar : in STD_LOGIC;  -- CLK and CLR inputs
        Q, Qbar     : out STD_LOGIC  -- Q and Qbar outputs            
    );
end JKMasterSlaveFlipFlopWithClear;

architecture  behavioral of JKMasterSlaveFlipFlopWithClear is
    signal master_q, master_qbar : STD_LOGIC;
    signal slave_q, slave_qbar   : STD_LOGIC;
begin
process(CLK, CLRBar)
begin

    Report "Current Port Settings: J: " & to_string(J) & ", K: " & to_string(K) & ", Q: " & to_string(Q) & ", Qbar: " & to_string(QBAR);

    if CLRBar = '0' then
        Report "ID: " & ID & ", Clear Set";
        master_q <= '0';
        master_qbar <= '1';
    elsif rising_edge(CLK) then                
        if J = '1' and K = '0' then         -- set to 1
            master_q <= '1';
            master_qbar <= '0';
        elsif J = '0' and K = '1' then      -- set to 0
            master_q <= '0';
            master_qbar <= '1';
        elsif J = '1' and K = '1' then      -- toggle
            master_q <= not master_q;
            master_qbar <= not master_qbar;
        elsif J = '0' and K= '0' then      -- hold
            master_q <= master_q;
            master_qbar <= master_qbar;
        end if;
        Report "Rising Edge Process - ID: " & ID & ", master_q: " & to_string(master_q) & ", master_qbar: " & to_string(master_qbar);
    end if;
end process;

process(CLK, CLRBar)
begin
    if CLRBAR = '0' then
        Report "ID: " & ID & ", Clear Set";
        slave_q <= '0'; -- asynchronous clear
        slave_qbar <= '1';
    elsif falling_edge(CLK) then
        slave_q <= master_q;
        slave_qbar <= master_qbar;
        Report "Falling Edge Process - ID: " & ID & ", master_q: " & to_string(master_q) & ", master_qbar: " & to_string(master_qbar) & 
            ", slave_q: " & to_string(slave_q) & ", slave_qbar: " & to_string(slave_qbar);
    end if;
end process;

q <= slave_q;
qbar <= slave_qbar;
    
end behavioral;    
