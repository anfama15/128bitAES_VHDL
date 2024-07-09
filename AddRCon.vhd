library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Use for arithmetic operations with vectors

entity AddRCon is
    Port (
        i_state : in std_logic_vector(31 downto 0);
        i_state0 : in std_logic_vector(31 downto 0);

        round   : in INTEGER range 1 to 10;  -- Change input type to integer for round number
        rcon    : out std_logic_vector(31 downto 0);
                rot_check    : out std_logic_vector(31 downto 0);

                sub_check    : out std_logic_vector(31 downto 0)

    );
end AddRCon;

architecture Behavioral of AddRCon is

    component SubWord is
        Port (
            i_state : in std_logic_vector(31 downto 0);
            o_state : out std_logic_vector(31 downto 0);
                    rot_check : out std_logic_vector(31 downto 0)

        );
    end component;
    
    signal s_out : std_logic_vector(31 downto 0);
    type RconArray is array (1 to 10) of std_logic_vector(31 downto 0);  -- Adjust index range
    constant RconValues: RconArray := (
        x"01000000", x"02000000", x"04000000", x"08000000",
        x"10000000", x"20000000", x"40000000", x"80000000",
        x"1b000000", x"36000000"
    );

begin

    s1 : SubWord
        Port map (
            i_state => i_state, 
            o_state => s_out,
            rot_check =>rot_check
        );
sub_check <= s_out;
    process(round, s_out)
    begin
        if round >= 1 and round <= 10 then
            rcon <= i_state0 xor s_out xor RconValues(round);
        else
            rcon <= (others => '0');  -- Default value if round number is out of range
        end if;
    end process;
end Behavioral;
