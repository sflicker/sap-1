library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package mytypes is
type memory_type is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
function format_reg_contents(reg : std_logic_vector) return string;

end mytypes;

package body mytypes is
    function format_reg_contents(reg : std_logic_vector) return string is
--        variable str : string(1 to reg'length*2);
    begin
        -- for i in reg'length downto 1 loop
        --     str(reg'length*2-2*i+1) := std_logic'image(reg(i-1))(2);
        --     str(reg'length*2-2*i+1) := ' ';
        -- end loop;
        -- return str;
        return to_string(reg);
    end function;
    
end package body mytypes;