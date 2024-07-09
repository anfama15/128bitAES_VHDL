library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RotWord is
Port ( 
           key_in   :   IN  std_logic_vector    (31 downto 0);
           data_out :   OUT std_logic_vector    (31 downto 0)
           );
end RotWord;

architecture Behavioral of RotWord is

begin
    process(key_in)
    begin

      
            data_out(31 downto 0)   <= key_in(23  downto 0)  & key_in(31  downto 24);
            
            
    end process;
	


end Behavioral;
