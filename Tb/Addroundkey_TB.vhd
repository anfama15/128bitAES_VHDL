----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/08/2024 03:31:08 AM
-- Design Name: 
-- Module Name: Addroundkey_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Addroundkey_TB is
--  Port ( );
end Addroundkey_TB;

architecture Behavioral of Addroundkey_TB is
signal        input_key   :    std_logic_vector(127 downto 0);
signal        state_array :    std_logic_vector(127 downto 0);
signal        output      :    std_logic_vector(127 downto 0);
begin
uut : entity work.AddRoundKeys(Behavioral) port map (input_key => input_key, state_array => state_array, output => output);

stimulus : process
begin 
        input_key <=x"a0fafe1788542cb123a339392a6c7605" ;
        state_array <= x"046681e5e0cb199a48f8d37a2806264c";
        
        wait for 20ns;
end process;

end Behavioral;
