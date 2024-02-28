library IEEE;
use IEEE.std_logic_1164.all;

-- quad tri state buffer

entity LS126 is
    PORT (
        A1, A2, A3, A4 : in STD_LOGIC;
        C1, C2, C3, C4 : in STD_LOGIC;
        Y1, Y2, Y3, Y4 : out STD_LOGIC
    );
end LS126;

architecture behavioral of LS126 is
begin
    tsb1 : entity work.tristatebuffer
    port map(
        A => A1,
        C => C1,
        Y => Y1
    );

    tsb2 : entity work.tristatebuffer
    port map(
        A => A2,
        C => C2,
        Y => Y2
    );

    tsb3 : entity work.tristatebuffer
    port map(
        A => A3,
        C => C3,
        Y => Y3
    );

    tsb4 : entity work.tristatebuffer
    port map(
        A => A4,
        C => C4,
        Y => Y4
    );
    end behavioral;
    