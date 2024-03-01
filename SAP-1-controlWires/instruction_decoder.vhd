library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- instruction decoder SAP-1 simple CPU model
-- this component will input the 4 bit of the instruct code
-- and set the proper output bit for the instruction.
-- in this model following the textbook there are 5 possible
-- instructions. LDA, ADD, SUB, OUT and HLTBar. each one
-- will have an output.

entity instruction_decoder is
    Port (
        i1  : in STD_LOGIC;
        i2  : in STD_LOGIC;
        i3  : in STD_LOGIC;
        i4  : in STD_LOGIC;
        opLDA : out STD_LOGIC;
        opADD : out STD_LOGIC;
        opSUB : out STD_LOGIC;
        opOUT : out STD_LOGIC;
        opHLTBar : out STD_LOGIC 
    );
end instruction_decoder;

architecture behavioral of instruction_decoder is
    signal iBus1 : STD_LOGIC;
    signal iBus2 : STD_LOGIC;
    signal iBus3 : STD_LOGIC;
    signal iBus4 : STD_LOGIC;
    signal iBus5 : STD_LOGIC;
    signal iBus6 : STD_LOGIC;
    signal iBus7 : STD_LOGIC;
    signal iBus8 : STD_LOGIC;
    signal w1 : STD_LOGIC;
    signal w2 : STD_LOGIC;
    signal w3 : STD_LOGIC;
    signal w4 : STD_LOGIC;
begin
    iBus2 <= i1;
    iBus4 <= i2;
    iBus6 <= i3;
    iBus8 <= i4;
    hinv1 : entity work.LS04
        Port map(
            A1 => iBus2,
            Y1 => iBus1,
            A2 => iBus4,
            Y2 => iBus3,
            A3 => iBus6,
            Y3 => iBus5,
            A4 => iBus8,
            Y4 => iBus7,
            A5 => '0',          -- unused pins
            Y5 => open,
            A6 => '0',
            Y6 => open
        );

    d4nand1 : entity work.LS20
        port map(
            A1 => iBus7,  -- LDA matches 0000
            B1 => iBus5,
            C1 => iBus3,
            D1 => iBus1,
            Y1 => w1,
            A2 => iBus7,   -- ADD matches 0001
            B2 => iBus5,
            C2 => iBus3,
            D2 => iBus2,
            Y2 => w2
        );

    d4nand2 : entity work.LS20
        port map(
            A1 => iBus7,    -- SUB matches 0010
            B1 => iBus5,
            C1 => iBus4,
            D1 => iBus1,
            Y1 => w3,
            A2 => ibus8,    -- OUT
            B2 => ibus6,
            C2 => iBus4,
            D2 => iBus1,
            Y2 => w4
        );

    d4nand3 : entity work.LS20
        port map (
            A1 => iBus8,    -- HLT
            B1 => iBus6,
            C1 => iBus4,
            D1 => iBus2,
            Y1 => opHLTBar,
            A2 => '0',      -- unused pins
            B2 => '0',
            C2 => '0',
            D2 => '0',
            Y2 => open
        );

    hinv2 : entity work.LS04
        port map (
            A1 => w1,
            Y1 => opLDA,
            A2 => w2,
            Y2 => opADD,
            A3 => w3,
            Y3 => opSUB,
            A4 => w4,
            Y4 => opOUT,
            A5 => '0',      -- unused pins
            Y5 => open,
            A6 => '0',
            Y6 => open
        );
    
    
    
end architecture behavioral;
