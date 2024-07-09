
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity AddRoundKeys is
port(
        input_key   : IN    std_logic_vector(127 downto 0);
        state_array : IN    std_logic_vector(127 downto 0);
        output      : out   std_logic_vector(127 downto 0)

);
end AddRoundKeys;

architecture Behavioral of AddRoundKeys is

begin
output <= input_key xor state_array;

end Behavioral;
